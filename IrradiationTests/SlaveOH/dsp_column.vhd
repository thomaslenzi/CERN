library ieee;
use ieee.std_logic_1164.all;

library work;

entity dsp_column is
port(
    clk_i       : in std_logic;
    din_i       : in std_logic_vector(31 downto 0);
    dout_o      : out std_logic_vector(31 downto 0)
);
end dsp_column;

architecture behavioral of dsp_column is

    signal d0   : std_logic_vector(31 downto 0);
    signal d1   : std_logic_vector(31 downto 0);
    signal d2   : std_logic_vector(31 downto 0);
    signal d3   : std_logic_vector(31 downto 0);
    signal d4   : std_logic_vector(31 downto 0);
    signal d5   : std_logic_vector(31 downto 0);
    signal d6   : std_logic_vector(31 downto 0);

begin

    addsub_0_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => din_i,
        b   => x"00100101",
        s   => d0
    );

    addsub_1_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => d0,
        b   => x"00001000",
        s   => d1
    );

    addsub_2_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => d1,
        b   => x"00010100",
        s   => d2
    );

    addsub_3_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => d2,
        b   => x"00000001",
        s   => d3
    );

    addsub_4_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => d3,
        b   => x"00000011",
        s   => d4
    );

    addsub_5_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => d4,
        b   => x"00000010",
        s   => d5
    );

    addsub_6_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => d5,
        b   => x"00000010",
        s   => d6
    );

    addsub_7_inst : entity work.addsub
    port map(
        clk => clk_i,
        a   => d6,
        b   => x"00000111",
        s   => dout_o
    );

end behavioral;

