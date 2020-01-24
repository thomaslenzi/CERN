library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_edge is
port(
    clk_i   : in std_logic;
    reset_i : in std_logic;    
    en_i    : in std_logic;    
    data_o  : out std_logic_vector(31 downto 0)    
);
end counter_edge;

architecture Behavioral of counter_edge is

    signal data : unsigned(31 downto 0);
    signal last : std_logic;

begin

    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            if (reset_i = '1') then
                data_o <= (others => '0');
                data <= (others => '0');
                last <= '0';
            else
                if (en_i = '1' and last = '0') then
                    data <= data + 1;
                end if;
                data_o <= std_logic_vector(data);
                last <= en_i;
            end if;
        end if;
    end process;

end Behavioral;