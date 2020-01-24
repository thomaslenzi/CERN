library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.user_package.all;

entity tracking_concentrator is
port(

    vfat2_clk_i         : in std_logic;
    reset_i             : in std_logic;
    
    en_i                : in std_logic_vector(23 downto 0);
    data_i              : in array192(23 downto 0);
    
    fifo_read_o         : out std_logic;
    fifo_valid_i        : in std_logic;
    fifo_underflow_i    : in std_logic;
    fifo_data_i         : in std_logic_vector(31 downto 0);
    
    en_0_o              : out std_logic;
    data_0_o            : out std_logic_vector(223 downto 0);    
    en_1_o              : out std_logic;
    data_1_o            : out std_logic_vector(223 downto 0);    
    en_2_o              : out std_logic;
    data_2_o            : out std_logic_vector(223 downto 0)
    
);
end tracking_concentrator;

architecture Behavioral of tracking_concentrator is

    type state_t is (LOOPING, BX_REQ, BX_ACK);
    
    signal state    : state_t;    
    signal vfat_cnt : integer range 0 to 23;

    signal bx_time  : integer range 0 to 255;
    signal last_bx  : std_logic_vector(31 downto 0);
    
    signal data     : array192(23 downto 0);
    signal data_stb : std_logic_vector(23 downto 0);
    signal data_ack : std_logic_vector(23 downto 0);
    
begin

    process(vfat2_clk_i)
    begin
        if (rising_edge(vfat2_clk_i)) then        
            if (reset_i = '1') then
                data <= (others => (others => '0'));
                data_stb <= (others => '0');
            else
                for I in 0 to 23 loop
                    -- Free to receive data
                    if (data_stb(I) = '0' and data_ack(I) = '0') then
                        if (en_i(I) = '1') then
                            data(I) <= data_i(I);
                            data_stb(I) <= '1';
                        end if;
                    -- Reset the strobe when seen
                    elsif (data_stb(I) = '1' and data_ack(I) = '1') then
                        data_stb(I) <= '0';
                    end if;
                end loop;
            end if;
        end if;
    end process;
    
    process(vfat2_clk_i)
    begin
    
        if (rising_edge(vfat2_clk_i)) then        
            if (reset_i = '1') then            
                fifo_read_o <= '0'; 
                en_0_o <= '0';
                en_1_o <= '0';
                en_2_o <= '0';
                data_0_o <= (others => '0');
                data_1_o <= (others => '0');
                data_2_o <= (others => '0');
                state <= LOOPING;          
                vfat_cnt <= 0;          
                bx_time <= 0;          
                last_bx <= (others => '0');          
                data_ack <= (others => '0');          
            else
                case state is
                    when LOOPING =>
                        fifo_read_o <= '0';
                        -- Loop over VFAT2s
                        if (vfat_cnt = 23) then
                            vfat_cnt <= 0;
                        else
                            vfat_cnt <= vfat_cnt + 1;
                        end if;
                        -- Increment the last BX counter
                        if (bx_time = 40) then
                            bx_time <= bx_time;
                        else
                            bx_time <= bx_time + 1;
                        end if;
                        -- Check the strobe
                        if (data_stb(vfat_cnt) = '1' and data_ack(vfat_cnt) = '0') then
                            -- Check last time a packet arrived
                            if (bx_time = 40) then
                                -- Too long ago, update BX
                                state <= BX_REQ;
                                -- Reset the strobe
                                en_0_o <= '0';
                                en_1_o <= '0';
                                en_2_o <= '0';
                            else
                                -- Still good, save data
                                if (vfat_cnt < 8) then                                
                                    en_0_o <= '1';
                                    en_1_o <= '0';
                                    en_2_o <= '0';
                                    data_0_o <= last_bx & data(vfat_cnt);
                                elsif (vfat_cnt < 16) then                             
                                    en_0_o <= '0';
                                    en_1_o <= '1';
                                    en_2_o <= '0';
                                    data_1_o <= last_bx & data(vfat_cnt);
                                else                                        
                                    en_0_o <= '0';
                                    en_1_o <= '0';
                                    en_2_o <= '1';
                                    data_2_o <= last_bx & data(vfat_cnt);
                                end if;
                                data_ack(vfat_cnt) <= '1';
                            end if;
                        elsif (data_stb(vfat_cnt) = '0' and data_ack(vfat_cnt) = '1') then
                            data_ack(vfat_cnt) <= '0';
                            -- Reset the strobe
                            en_0_o <= '0';
                            en_1_o <= '0';
                            en_2_o <= '0';
                        else
                            -- Reset the strobe
                            en_0_o <= '0';
                            en_1_o <= '0';
                            en_2_o <= '0';
                        end if; 
                    when BX_REQ =>
                        fifo_read_o <= '1';
                        state <= BX_ACK;
                    when BX_ACK =>      
                        bx_time <= 0;  
                        fifo_read_o <= '0';   
                        if (fifo_valid_i = '1') then
                            last_bx <= fifo_data_i;
                            state <= LOOPING;
                        elsif (fifo_underflow_i = '1') then
                            last_bx <= (others => '0');
                            state <= LOOPING;
                        end if;
                    when others =>                 
                        fifo_read_o <= '0';            
                        en_0_o <= '0';
                        en_1_o <= '0';
                        en_2_o <= '0';
                        data_0_o <= (others => '0');
                        data_1_o <= (others => '0');
                        data_2_o <= (others => '0');
                        state <= LOOPING;          
                        vfat_cnt <= 0;          
                        bx_time <= 0;          
                        last_bx <= (others => '0');          
                        data_ack <= (others => '0');   
                end case;                
            end if;        
        end if;    
    end process; 
    
end Behavioral;

