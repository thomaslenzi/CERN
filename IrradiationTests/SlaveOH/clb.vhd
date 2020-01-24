library ieee;
use ieee.std_logic_1164.all;

library work;

entity clb is
generic(
    DEBUG       : boolean := FALSE;
    N           : integer := 2
);
port(
    clk_i       : in std_logic;
    err_o       : out std_logic_vector(9 downto 0);
    serr_o      : out std_logic_vector(9 downto 0);
    db_err_i    : in std_logic;
    db_serr_i   : in std_logic
);
end clb;

architecture behavioral of clb is
begin

    clb_loop : for I in 0 to 9 generate
    begin

        clb_slice_inst : entity work.clb_slice
        generic map(
            DEBUG       => DEBUG,
            N           => N
        )
        port map(
            clk_i       => clk_i,
            err_o       => err_o(I),
            serr_o      => serr_o(I),
            db_err_i    => db_err_i,
            db_serr_i   => db_serr_i
        );
        
    end generate;

end behavioral;
