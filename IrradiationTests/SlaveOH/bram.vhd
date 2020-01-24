library ieee;
use ieee.std_logic_1164.all;

library work;

entity bram is
generic(
    DEBUG       : boolean := FALSE
);
port(
    clk_i       : in std_logic;
    sbiterr_o   : out std_logic_vector(9 downto 0);
    dbiterr_o   : out std_logic_vector(9 downto 0);
    db_serr_i   : in std_logic;
    db_derr_i   : in std_logic
);
end bram;

architecture behavioral of bram is
begin

    bram_loop : for I in 0 to 9 generate
    begin

        bram_slice_inst : entity work.bram_slice
        generic map(
            DEBUG       => DEBUG
        )
        port map(
            clk_i       => clk_i,
            sbiterr_o   => sbiterr_o(I),
            dbiterr_o   => dbiterr_o(I),
            db_serr_i   => db_serr_i,
            db_derr_i   => db_derr_i
        );
        
    end generate;

end behavioral;
