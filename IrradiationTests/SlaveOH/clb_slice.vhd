library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;

entity clb_slice is
generic(
    DEBUG       : boolean := FALSE;
    N           : integer := 2
);
port(
    clk_i       : in std_logic;
    err_o       : out std_logic;
    serr_o      : out std_logic;
    db_err_i    : in std_logic;
    db_serr_i   : in std_logic
);
end clb_slice;

architecture Behavioral of clb_slice is

    signal din      : std_logic_vector(31 downto 0) := x"01234567";
    signal err      : std_logic_vector(N - 1 downto 0);
    signal serr     : std_logic_vector(N - 1 downto 0);
    signal empty    : std_logic_vector(N - 1 downto 0);

begin

    --===========--
    --== DEBUG ==--
    --===========--
    
    debug_gen: if DEBUG = TRUE generate    
    begin
    
        process(clk_i)
        begin
            if (rising_edge(clk_i)) then
                -- Level1 Error
                if (err /= empty) then
                    err_o <= '1';
                elsif (db_err_i = '1') then
                    err_o <= '1';
                else
                    err_o <= '0';
                end if;
                -- Level2 Error
                if (serr /= empty) then
                    serr_o <= '1';
                elsif (db_serr_i = '1') then
                    serr_o <= '1';
                else
                    serr_o <= '0';
                end if;
            end if;
        end process;
        
    end generate;

    --==============--
    --== NO DEBUG ==--
    --==============--

    nodebug_gen : if DEBUG = FALSE generate
    begin
    
        empty <= (others => '0');
        
        process(clk_i)
        begin
            if (rising_edge(clk_i)) then
                -- Level1 Error
                if (err /= empty) then
                    err_o <= '1';
                else
                    err_o <= '0';
                end if;
                -- Level2 Error
                if (serr /= empty) then
                    serr_o <= '1';
                else
                    serr_o <= '0';
                end if;
            end if;
        end process;

    end generate;

    --====================--
    --== Data generator ==--
    --====================--

    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            din(31 downto 1) <= din(30 downto 0);
            din(0) <= din(31);
        end if;
    end process;

    --================--
    --== Algorithms ==--
    --================--
    
    clb_level2_gen : for I in 0 to N - 1 generate
    begin
    
        clb_level2_inst : entity work.clb_level2
        port map(
            clk_i   => clk_i,
            din_i   => din,
            err_o   => err(I),
            serr_o  => serr(I)
        );
    
    end generate;

end Behavioral;

