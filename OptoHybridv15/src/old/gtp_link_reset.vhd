library ieee;
use ieee.std_logic_1164.all;

entity gtp_link_reset is
port(

    fpga_clk_i      : in std_logic;
    reset_o         : out std_logic

);
end gtp_link_reset;

architecture Behavioral of gtp_link_reset is
begin

    process(fpga_clk_i)
    
        variable state      : integer range 0 to 1 := 0;
        variable counter    : integer range 0 to 1024 := 0;
    
    begin
        if (rising_edge(fpga_clk_i)) then
            
            if (state = 0) then
            
                reset_o <= '1';
                
                if (counter = 1023) then
                    
                    state := 1;
                    
                else
                
                    counter := counter + 1;
                    
                end if;
                
            elsif (state = 1) then
            
                reset_o <= '0';
                
            else
            
                reset_o <= '0';
                
            end if;
                
        end if;
        
    end process;

end Behavioral;

