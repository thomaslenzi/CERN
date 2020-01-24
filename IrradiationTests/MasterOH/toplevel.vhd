library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity toplevel is
port(   
    qpll_reset_o                : out std_logic;
    qpll_locked_i               : in std_logic;
    qpll_clk_p_i                : in std_logic;
    qpll_clk_n_i                : in std_logic;
    
    hdmi                        : in std_logic_vector(7 downto 0) 
);
end toplevel;

architecture behavioral of toplevel is

    signal qpll                 : std_logic;
    signal clk                  : std_logic;
    signal pll_locked           : std_logic;

    signal bram_sbiterr         : std_logic;
    signal bram_dbiterr         : std_logic;
    
    signal dsp_err              : std_logic;
    signal dsp_serr             : std_logic;
    signal dsp_derr             : std_logic;
    signal dsp_terr             : std_logic;
    
    signal clb_err              : std_logic;
    signal clb_serr             : std_logic;
    
    signal sem_observation      : std_logic;
    signal sem_correction       : std_logic;
    signal sem_essential        : std_logic;
    signal sem_uncorrectable    : std_logic;
    
    signal cnt_timer            : std_logic_vector(63 downto 0);
    signal en_timer             : std_logic;
    signal rst_timer            : std_logic;
    
    signal cnt_bram_sbiterr     : std_logic_vector(31 downto 0);
    signal cnt_bram_dbiterr     : std_logic_vector(31 downto 0);
    signal cnt_dsp_err          : std_logic_vector(31 downto 0);
    signal cnt_dsp_serr         : std_logic_vector(31 downto 0);
    signal cnt_dsp_derr         : std_logic_vector(31 downto 0);
    signal cnt_dsp_terr         : std_logic_vector(31 downto 0);
    signal cnt_clb_err          : std_logic_vector(31 downto 0);
    signal cnt_clb_serr         : std_logic_vector(31 downto 0);
    signal cnt_sem              : std_logic_vector(31 downto 0);
    
    signal rst_bram_sbiterr     : std_logic;
    signal rst_bram_dbiterr     : std_logic;
    signal rst_dsp_err          : std_logic;
    signal rst_dsp_serr         : std_logic;
    signal rst_dsp_derr         : std_logic;
    signal rst_dsp_terr         : std_logic;
    signal rst_clb_err          : std_logic;
    signal rst_clb_serr         : std_logic;
    signal rst_sem              : std_logic;
    
    signal control0             : std_logic_vector(35 downto 0);
    signal control1             : std_logic_vector(35 downto 0);
    signal async_in             : std_logic_vector(95 downto 0);
    signal sync_in              : std_logic_vector(255 downto 0);
    signal sync_out             : std_logic_vector(10 downto 0);
    signal ila                  : std_logic_vector(15 downto 0);    
    
begin

    --==========--
    --== QPLL ==--
    --==========--
    
    pll_inst : entity work.pll
    port map(
        clk_in1_p   => qpll_clk_p_i,
        clk_in1_n   => qpll_clk_n_i,
        clk_out1    => qpll,
        clk_out2    => clk,
        locked      => pll_locked
    );
    
    qpll_reset_o <= '0';  
    
    --==============--
    --== Counters ==--
    --==============--
    
    timer_inst : entity work.timer port map(clk_i => clk, reset_i => rst_timer, en_i => en_timer, data_o => cnt_timer);
    bram_sbiterr_inst : entity work.counter port map(clk_i => clk, reset_i => rst_bram_sbiterr, en_i => bram_sbiterr and en_timer, data_o => cnt_bram_sbiterr);
    bram_dbiterr_inst : entity work.counter port map(clk_i => clk, reset_i => rst_bram_dbiterr, en_i => bram_dbiterr and en_timer, data_o => cnt_bram_dbiterr);
    dsp_err_inst : entity work.counter port map(clk_i => clk, reset_i => rst_dsp_err, en_i => (dsp_err or dsp_serr or dsp_derr or dsp_terr) and en_timer, data_o => cnt_dsp_err);
    dsp_serr_inst : entity work.counter port map(clk_i => clk, reset_i => rst_dsp_serr, en_i => dsp_serr and en_timer, data_o => cnt_dsp_serr);
    dsp_derr_inst : entity work.counter port map(clk_i => clk, reset_i => rst_dsp_derr, en_i => dsp_derr and en_timer, data_o => cnt_dsp_derr);
    dsp_terr_inst : entity work.counter port map(clk_i => clk, reset_i => rst_dsp_terr, en_i => dsp_terr and en_timer, data_o => cnt_dsp_terr);
    clb_err_inst : entity work.counter port map(clk_i => clk, reset_i => rst_clb_err, en_i => clb_err and en_timer, data_o => cnt_clb_err);
    clb_serr_inst : entity work.counter port map(clk_i => clk, reset_i => rst_clb_serr, en_i => clb_serr and en_timer, data_o => cnt_clb_serr);
    sem_inst : entity work.counter_edge port map(clk_i => clk, reset_i => rst_sem, en_i => sem_correction and en_timer, data_o => cnt_sem);

    --=============--
    --== Control ==--
    --=============--
    
    chipscope_icon_inst : entity work.chipscope_icon
    port map(
        control0    => control0,
        control1    => control1
    );
    
    chipscope_vio_inst : entity work.chipscope_vio
    port map(
        control     => control0,
        clk         => clk,
        async_in    => async_in,
        sync_in     => sync_in,
        sync_out    => sync_out
    );
    
    chipscope_ila_inst : entity work.chipscope_ila
    port map(
        control => control1,
        clk     => clk,
        trig0   => ila
    );    
    
    sync_in(31 downto 0) <= cnt_bram_sbiterr;
    sync_in(63 downto 32) <= cnt_bram_dbiterr;
    sync_in(95 downto 64) <= cnt_dsp_err;
    sync_in(127 downto 96) <= cnt_dsp_serr;
    sync_in(159 downto 128) <= cnt_dsp_derr;
    sync_in(191 downto 160) <= cnt_dsp_terr;
    sync_in(223 downto 192) <= cnt_clb_err;
    sync_in(255 downto 224) <= cnt_clb_serr;
    
    async_in(63 downto 0) <= cnt_timer;
    async_in(95 downto 64) <= cnt_sem;
    
    en_timer <= sync_out(0);
    rst_timer <= sync_out(1); 
    rst_bram_sbiterr <= sync_out(2);
    rst_bram_dbiterr <= sync_out(3);
    rst_dsp_err <= sync_out(4);
    rst_dsp_serr <= sync_out(5);
    rst_dsp_derr <= sync_out(6);
    rst_dsp_terr <= sync_out(7);
    rst_clb_err <= sync_out(8);
    rst_clb_serr <= sync_out(9);
    rst_sem <= sync_out(10);
    
    ila(3 downto 0) <= hdmi(3 downto 0);
    ila(4) <= bram_sbiterr;
    ila(5) <= bram_dbiterr;    
    ila(6) <= dsp_err;
    ila(7) <= dsp_serr;
    ila(8) <= dsp_derr;
    ila(9) <= dsp_terr;    
    ila(10) <= clb_err;
    ila(11) <= clb_serr;    
    ila(12) <= sem_observation;
    ila(13) <= sem_correction;
    ila(14) <= sem_essential;
    ila(15) <= sem_uncorrectable;   

    --================--
    --== Microblaze ==--
    --================--    
    
	microblaze_inst : entity work.microblaze 
    port map(
		reset                   => '0',
		clk                     => qpll,
		axi_gpio_0_gpio_io_pin  => cnt_timer(31 downto 0),
		axi_gpio_0_gpio2_io_pin => cnt_timer(63 downto 32),
		axi_gpio_1_gpio_io_pin  => cnt_bram_sbiterr,
		axi_gpio_1_gpio2_io_pin => cnt_bram_dbiterr,
		axi_gpio_2_gpio_io_pin  => cnt_dsp_err,
		axi_gpio_2_gpio2_io_pin => cnt_dsp_serr,
		axi_gpio_3_gpio_io_pin  => cnt_dsp_derr,
		axi_gpio_3_gpio2_io_pin => cnt_dsp_terr,
		axi_gpio_4_gpio_io_pin  => cnt_clb_err,
		axi_gpio_4_gpio2_io_pin => cnt_clb_serr
	);		

    --==========--
    --== HDMI ==--
    --==========--    
  
    hdmi_inst : entity work.hdmi
    port map(
        clk_i               => clk,
        hdmi_i              => hdmi,
        bram_sbiterr_o      => bram_sbiterr,
        bram_dbiterr_o      => bram_dbiterr,    
        dsp_err_o           => dsp_err,
        dsp_serr_o          => dsp_serr,
        dsp_derr_o          => dsp_derr,
        dsp_terr_o          => dsp_terr,    
        clb_err_o           => clb_err,
        clb_serr_o          => clb_serr,
        sem_observation_o   => sem_observation,
        sem_correction_o    => sem_correction,
        sem_essential_o     => sem_essential,
        sem_uncorrectable_o => sem_uncorrectable  
    );      
    
    -- BRAM Single Error    0110
    -- BRAM Double Error    0011
    -- DSP Global Error     1110
    -- DSP Single Error     1011
    -- DSP Double Error     1100
    -- DSP Triple Error     1001
    -- CLB Level1 Error     0100
    -- CLB Level2 Error     0001

end behavioral;