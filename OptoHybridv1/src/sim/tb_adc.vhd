library ieee;
use ieee.std_logic_1164.all;
 
library work; 
 
entity tb_adc is
end tb_adc;
 
architecture behavior of tb_adc is 

   signal fabric_clk_i          : std_logic := '0';
   signal uart_clk_i            : std_logic := '0';
   signal reset_i               : std_logic := '0';
   signal uart_rx_i             : std_logic := '0';
   signal voltage_o             : std_logic_vector(31 downto 0):= (others => '0');
   signal current_o             : std_logic_vector(31 downto 0):= (others => '0');
    
   constant fabric_clk_period   : time := 6.25 ns;
   constant uart_clk_period     : time := 0.10417 ms;
 
begin


    uut : entity work.adc_handler
    port map(
        fabric_clk_i    => fabric_clk_i,
        reset_i         => reset_i,
        uart_rx_i       => uart_rx_i,
        voltage_o       => voltage_o,
        current_o       => current_o
    );

    -- clock process definitions
    fabric_clk_process :process
    begin
        fabric_clk_i <= '0';
        wait for fabric_clk_period / 2;
        fabric_clk_i <= '1';
        wait for fabric_clk_period / 2;
    end process;

    -- clock process definitions
    uart_clk_process :process
    begin
        uart_clk_i <= '0';
        wait for uart_clk_period / 2;
        uart_clk_i <= '1';
        wait for uart_clk_period / 2;
    end process;
 
    -- stimulus process
    process(uart_clk_i)
    
        variable data   : std_logic_vector(39 downto 0) := ("1010000100" & "1001010100" & "1110000100" & "1101110110");
        variable count : integer range 0 to 1023;
    
    
    begin		
    
        if (rising_edge(uart_clk_i)) then
        
            if (count < 40) then
        
                uart_rx_i <= data(count);
                
            else
            
                uart_rx_i <= '1';
                
            end if;
        
            if (count = 1023) then
            
                count := 0;
                
            else
            
                count := count + 1;
                
            end if;
            
        
        end if;

    end process;

end;
