library ieee;
use ieee.std_logic_1164.all;

entity clb_algo is
port(
    clk_i   : in std_logic;
    din_i   : in std_logic_vector(31 downto 0);
    dout_o  : out std_logic_vector(31 downto 0)
);
end clb_algo;

architecture behavioral of clb_algo is
begin

    process(clk_i)
    
        variable tmp    : std_logic_vector(31 downto 0);
        variable tmp2   : std_logic_vector(7 downto 0);
    
    begin
        if (rising_edge(clk_i)) then
        
            tmp2 := (din_i(31) xor din_i(30)) & (din_i(27) xor din_i(26)) & (din_i(23) xor din_i(22)) & (din_i(19) xor din_i(18)) & 
                    (din_i(15) xor din_i(14)) & (din_i(11) xor din_i(10)) & (din_i(7) xor din_i(6)) & (din_i(3) xor din_i(2));
            tmp(31 downto 24) := din_i(31 downto 24) or din_i(23 downto 16) or din_i(15 downto 8) or din_i(7 downto 0);
            tmp(23 downto 16) := din_i(31 downto 24) xor din_i(23 downto 16) xor din_i(15 downto 8) xor din_i(7 downto 0);
            tmp(15 downto 8) := din_i(31 downto 24) and din_i(7 downto 0);
            tmp(7 downto 0) := tmp(15 downto 8) xor tmp2;
            dout_o <= tmp;
        
        end if;
    end process;

end behavioral;

