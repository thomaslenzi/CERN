library ieee;
use ieee.std_logic_1164.all;

entity tracking_decoder is
port(

    vfat2_clk_i     : in std_logic;
    reset_i         : in std_logic;
    
    data_i          : in std_logic;
    
    en_o            : out std_logic;
    data_o          : out std_logic_vector(191 downto 0)
    
);
end tracking_decoder;

architecture Behavioral of tracking_decoder is

    signal data : std_logic_vector(194 downto 0); -- The data packet is 192 bits wide but we include the two IDLE bits in front of each packet 
                                                  -- and the computation time for the algorithm (the data will be shifted while computing)

begin

    --=======================--
    --== Data deserializer ==--
    --=======================--

    process(vfat2_clk_i)    
    begin
        if (rising_edge(vfat2_clk_i)) then
            if (reset_i = '1') then
                data <= (others => '0');
            else
                data(194 downto 1) <= data(193 downto 0);
                data(0) <= data_i;
            end if;
        end if;
    end process;
    
    --================--
    --== Validation ==--
    --================--
    
    process(vfat2_clk_i)
        -- Holds the results of the tests    
        variable tests  : std_logic_vector(3 downto 0);
        -- Hold the computed CRC
        variable crc    : std_logic_vector(15 downto 0); 
    begin
        if (rising_edge(vfat2_clk_i)) then
            if (reset_i = '1') then
                en_o <= '0';
                data_o <= (others => '0');
                tests := (others => '0');
            else
                -- 6 fixed bits 
                case data(193 downto 188) is
                    when "001010" => tests(0) := '1';
                    when others => tests(0) := '0';
                end case;
                -- 4 next fixed bits
                case data(175 downto 172) is
                    when "1100" => tests(1) := '1';
                    when others => tests(1) := '0';
                end case;
                -- 4 next fixed bits
                case data(159 downto 156) is
                    when "1110" => tests(2) := '1';
                    when others => tests(2) := '0';
                end case;
                -- Compute CRC
                crc := x"FFFF";
                for I in 11 downto 1 loop
                    for J in 0 to 15 loop
                        if (data((I * 16) + J) = crc(0)) then
                            crc := '0' & crc(15 downto 1);
                        else
                            crc := '0' & crc(15 downto 1);
                            crc := crc xor x"8408";
                        end if;
                    end loop;
                end loop; 
                -- Check CRC
                if (crc = data(15 downto 0)) then
                    tests(3) := '1';
                else
                    tests(3) := '0';
                end if;                
                -- Verification
                case tests is
                    when "1111" =>      
                        en_o <= '1';
                        data_o <= data(191 downto 0);
                    when others =>  
                        en_o <= '0';
                end case;                
            end if;
        end if;
    end process;
    
end Behavioral;