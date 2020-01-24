library ieee;
use ieee.std_logic_1164.all;

library work;

entity bram_slice is
generic(
    DEBUG       : boolean := FALSE
);
port(
    clk_i       : in std_logic;
    sbiterr_o   : out std_logic;
    dbiterr_o   : out std_logic;    
    db_serr_i   : in std_logic;
    db_derr_i   : in std_logic
);
end bram_slice;

architecture Behavioral of bram_slice is

    signal data     : std_logic_vector(71 downto 0) := x"0123456789ABCDEF01";
    signal sbiterr  : std_logic_vector(2 downto 0);
    signal dbiterr  : std_logic_vector(2 downto 0);
    
    signal isbiterr : std_logic;
    signal idbiterr : std_logic;

begin

    --===========--
    --== DEBUG ==--
    --===========--
    
    debug_gen: if DEBUG = TRUE generate    
    begin
    
        isbiterr <= db_serr_i;
        idbiterr <= db_derr_i;
        
    end generate;

    --==============--
    --== NO DEBUG ==--
    --==============--

    nodebug_gen : if DEBUG = FALSE generate
    begin
    
        isbiterr <= '0';
        idbiterr <= '0';
        
    end generate;

    --====================--
    --== Data generator ==--
    --====================--

    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            data(71 downto 1) <= data(70 downto 0);
            data(0) <= data(71);
        end if;
    end process;
    
    --========--
    --== OR ==--
    --========--
    
    sbiterr_o <= sbiterr(0) or sbiterr(1) or sbiterr(2);
    dbiterr_o <= dbiterr(0) or dbiterr(1) or dbiterr(2);
    
    --===========--
    --== BRAMs ==--
    --===========--

    bram36_loop : for I in 0 to 2 generate
    begin

        bram36_inst : entity work.bram36
        port map(
            clk             => clk_i,
            rst             => '0',
            din             => data,
            wr_en           => '1',
            rd_en           => '1',
            injectdbiterr   => idbiterr,
            injectsbiterr   => isbiterr,
            dout            => open,
            full            => open,
            empty           => open,
            sbiterr         => sbiterr(I),
            dbiterr         => dbiterr(I)
        );
        
    end generate;

end Behavioral;