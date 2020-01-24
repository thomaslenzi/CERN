library ieee;
use ieee.std_logic_1164.all;

library work;

entity dsp is
generic(
    DEBUG       : boolean := FALSE
);
port(
    clk_i       : in std_logic;
    err_o       : out std_logic_vector(9 downto 0);
    serr_o      : out std_logic_vector(9 downto 0);
    derr_o      : out std_logic_vector(9 downto 0);
    terr_o      : out std_logic_vector(9 downto 0);
    db_serr_i   : in std_logic;
    db_derr_i   : in std_logic;
    db_terr_i   : in std_logic
);
end dsp;

architecture behavioral of dsp is
begin

    dsp_loop : for I in 0 to 9 generate
    begin

        dsp_slice_inst : entity work.dsp_slice
        generic map(
            DEBUG       => DEBUG
        )
        port map(
            clk_i       => clk_i,
            err_o       => err_o(I),
            serr_o      => serr_o(I),
            derr_o      => derr_o(I),
            terr_o      => terr_o(I),
            db_serr_i   => db_serr_i,
            db_derr_i   => db_derr_i,
            db_terr_i   => db_terr_i
        );
        
    end generate;

end behavioral;
