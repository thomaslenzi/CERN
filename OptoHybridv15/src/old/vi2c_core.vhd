library ieee;
use ieee.std_logic_1164.all;

library work;
use work.user_package.all;

entity vi2c_core is
port(

    fabric_clk_i    : in std_logic;
    reset_i         : in std_logic;
    
    rx_en_i         : in std_logic;
    rx_data_i       : in std_logic_vector(31 downto 0);
    
    tx_ready_o      : out std_logic;
    tx_done_i       : in std_logic;
    tx_data_o       : out std_logic_vector(31 downto 0);
    
    sda_i           : in std_logic_vector;
    sda_o           : out std_logic_vector;
    sda_t           : out std_logic_vector;
    scl_o           : out std_logic_vector
    
);
end vi2c_core;

architecture Behavioral of vi2c_core is

    signal exec             : std_logic := '0';
    signal chip_select      : std_logic_vector(2 downto 0) := (others => '0');
    signal register_select  : std_logic_vector(7 downto 0) := (others => '0');
    signal read_write_n     : std_logic := '0';
    signal din              : std_logic_vector(7 downto 0) := (others => '0');
    signal valid            : std_logic := '0';
    signal status           : std_logic := '0';
    signal dout             : std_logic_vector(7 downto 0) := (others => '0');
    
    signal selected_iic     : integer range 0 to 1 := 0;

begin    

    process(fabric_clk_i)
    
        variable state          : integer range 0 to 7 := 0;
        
        variable chip_byte      : std_logic_vector(7 downto 0) := (others => '0');
        variable register_byte  : std_logic_vector(7 downto 0) := (others => '0');
        variable data_byte      : std_logic_vector(7 downto 0) := (others => '0');
        variable crc_byte       : std_logic_vector(7 downto 0) := (others => '0');
        variable crc_check      : std_logic_vector(7 downto 0) := (others => '0');
    
    begin
    
        if (rising_edge(fabric_clk_i)) then
        
            if (reset_i = '1') then
                
                tx_ready_o <= '0';
                
                exec <= '0';
            
                state := 0;
            
            else
            
                -- Waiting state
                if (state = 0) then
                    
                    -- Incoming data
                    if (rx_en_i = '1') then
                    
                        -- Register the data
                        chip_byte := rx_data_i(31 downto 24);
                        register_byte := rx_data_i(23 downto 16);
                        data_byte := rx_data_i(15 downto 8);
                        crc_byte := rx_data_i(7 downto 0);
                        crc_check := def_gtp_vi2c xor rx_data_i(31 downto 24) xor rx_data_i(23 downto 16) xor rx_data_i(15 downto 8);
                    
                        state := 1;
                        
                    end if;
                    
                -- Prepare the request and check CRC
                elsif (state = 1) then

                    -- Convert the chip select to the chip ID
                    case chip_byte(4 downto 0) is
                        when "00000" => chip_select <= "110"; -- Fiber 0
                        when "00001" => chip_select <= "101"; -- 1
                        when "00010" => chip_select <= "100"; -- 2
                        when "00011" => chip_select <= "011"; -- 3
                        when "00100" => chip_select <= "110"; -- 4
                        when "00101" => chip_select <= "101"; -- 5
                        when "00110" => chip_select <= "100"; -- 6
                        when "00111" => chip_select <= "011"; -- 7
                        when "01000" => chip_select <= "110"; -- Fiber 1
                        when "01001" => chip_select <= "101"; -- 9
                        when "01010" => chip_select <= "100"; -- 10
                        when "01011" => chip_select <= "011"; -- 11
                        when "01100" => chip_select <= "110"; -- 12
                        when "01101" => chip_select <= "101"; -- 13
                        when "01110" => chip_select <= "100"; -- 14
                        when "01111" => chip_select <= "011"; -- 15
                        when "10000" => chip_select <= "110"; -- Fiber 2
                        when "10001" => chip_select <= "101"; -- 17
                        when "10010" => chip_select <= "100"; -- 18
                        when "10011" => chip_select <= "011"; -- 19
                        when "10100" => chip_select <= "110"; -- 20
                        when "10101" => chip_select <= "101"; -- 21
                        when "10110" => chip_select <= "100"; -- 22
                        when "10111" => chip_select <= "011"; -- 23
                        when others => chip_select <= "000"; 
                    end case;
                        
                    -- Extract the information from the data packet
                    register_select <= register_byte;
                    read_write_n <= chip_byte(5);
                    din <= data_byte;

                    -- Select the IIC line according to the chip select (GEB V1)
                    case chip_byte(4 downto 0) is
                        when "00000" | "00001" | "00010" | "00011"  => selected_iic <= 0; -- Fiber 0, IIC 0
                        when "00100" | "00101" | "00110" | "00111"  => selected_iic <= 1; -- Fiber 0, IIC 1
                        when "01000" | "01001" | "01010" | "01011"  => selected_iic <= 0; -- Fiber 1, IIC 0
                        when "01100" | "01101" | "01110" | "01111"  => selected_iic <= 1; -- Fiber 1, IIC 1
                        when "10000" | "10001" | "10010" | "10011"  => selected_iic <= 0; -- Fiber 2, IIC 0
                        when "10100" | "10101" | "10110" | "10111"  => selected_iic <= 1; -- Fiber 2, IIC 1
                        when others => selected_iic <= 0;
                    end case; 

                    if (crc_check = crc_byte) then
                        
                        state := 2;
                        
                    else 
                    
                        state := 0;
                        
                    end if;
                    
                -- Send request
                elsif (state = 2) then
                
                    exec <= '1';
                    
                    state := 3;
                    
                -- Waiting for response from IIC
                elsif (state = 3) then
                        
                    exec <= '0';
                
                    if (valid = '1') then
                    
                        -- Update values
                        chip_byte(7) := not status;
                        chip_byte(6) := status;
                        data_byte := dout;
                        
                        state := 4;  
                        
                    end if;
                    
                -- Compute CRC
                elsif (state = 4) then
                
                    crc_byte := def_gtp_vi2c 
                                xor chip_byte 
                                xor register_byte 
                                xor data_byte;
                    
                    state := 5;
                    
                -- Sending back ready signal
                elsif (state = 5) then
                    
                    tx_data_o <= chip_byte & register_byte & data_byte & crc_byte;
                    
                    tx_ready_o <= '1';
                    
                    state := 6;
                    
                -- Wait for done
                elsif (state = 6) then
                
                    if (tx_done_i = '1') then
                    
                        tx_ready_o <= '0';
                        
                        state := 0;
                        
                    end if;
                    
                else
                    
                    tx_ready_o <= '0';
                    
                    exec <= '0';
                
                    state := 0;
                
                end if;
            
            end if;
        
        end if;
    
    end process;
    
    
    vi2c_wrapper_inst : entity work.vi2c_wrapper
    port map(
        fabric_clk_i        => fabric_clk_i,
        reset_i             => reset_i,
        en_i                => exec,
        chip_select_i       => chip_select,
        register_select_i   => register_select,
        read_write_n_i      => read_write_n,
        data_i              => din,
        en_o                => valid,
        status_o            => status,
        data_o              => dout,
        selected_iic_i      => selected_iic,
        sda_i               => sda_i,
        sda_o               => sda_o,
        sda_t               => sda_t,
        scl_o               => scl_o
    );
    
end Behavioral;