library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;

entity clb_level2 is
port(
    clk_i   : in std_logic;
    din_i   : in std_logic_vector(31 downto 0);
    err_o   : out std_logic;
    serr_o  : out std_logic
);
end clb_level2;

architecture Behavioral of clb_level2 is

    type array32 is array (integer range <>) of std_logic_vector(31 downto 0);
    signal dout : array32(2 downto 0);
    
    signal err  : std_logic_vector(2 downto 0);
    signal serr : std_logic_vector(31 downto 0);

begin    

    --================--
    --== Comparator ==--
    --================--
    
    comp_gen : for I in 0 to 31 generate
    
        signal tmp  : std_logic_vector(2 downto 0);
    
    begin
    
        tmp <= dout(0)(I) & dout(1)(I) & dout(2)(I);        
        
        with tmp select serr(I) <= '0' when "000" | "111", 
                                  '1' when others;
    
    end generate;

    --===========--
    --== Error ==--
    --===========--
    
    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            if (serr /= x"00000000") then
                serr_o <= '1';
            else
                serr_o <= '0';
            end if;
        end if;
    end process;
    
    err_o <= err(0) or err(1) or err(2);
    
    --===============--
    --== Algorithm ==--
    --===============--

    clk_level1_loop : for I in 0 to 2 generate
    begin

        clb_level1_inst : entity work.clb_level1
        port map(
            clk_i   => clk_i,
            din_i   => din_i,
            dout_o  => dout(I),
            err_o   => err(I)
        );
        
    end generate;


end Behavioral;

