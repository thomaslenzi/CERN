library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;

entity clb_level1 is
port(
    clk_i   : in std_logic;
    din_i   : in std_logic_vector(31 downto 0);
    dout_o  : out std_logic_vector(31 downto 0);
    err_o   : out std_logic
);
end clb_level1;

architecture Behavioral of clb_level1 is

    type array32 is array (integer range <>) of std_logic_vector(31 downto 0);
    signal dout : array32(2 downto 0);
    
    signal err  : std_logic_vector(31 downto 0);

begin    

    --================--
    --== Comparator ==--
    --================--
    
    comp_gen : for I in 0 to 31 generate
    
        signal tmp  : std_logic_vector(2 downto 0);
    
    begin
    
        tmp <= dout(0)(I) & dout(1)(I) & dout(2)(I);        
        
        with tmp select err(I) <= '0' when "000" | "111", 
                                  '1' when others;
        
        with tmp select dout_o(I) <= '0' when "001" | "010" | "100",
                                     '1' when others;
    
    end generate;

    --===========--
    --== Error ==--
    --===========--
    
    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            -- Global Error
            if (err /= x"00000000") then
                err_o <= '1';
            else
                err_o <= '0';
            end if;
        end if;
    end process;
    
    --===============--
    --== Algorithm ==--
    --===============--

    clk_algo_loop : for I in 0 to 2 generate
    begin

        clb_algo_inst : entity work.clb_algo
        port map(
            clk_i   => clk_i,
            din_i   => din_i,
            dout_o  => dout(I)
        );
        
    end generate;


end Behavioral;

