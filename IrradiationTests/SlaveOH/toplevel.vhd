library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity toplevel is
generic(
    DEBUG                       : boolean := TRUE;
    N                           : integer := 2
);
port(
    x0y12_rx_p_ipad             : in std_logic;
    x0y12_rx_n_ipad             : in std_logic;
    x0y13_rx_p_ipad             : in std_logic;
    x0y13_rx_n_ipad             : in std_logic;
    x0y14_rx_p_ipad             : in std_logic;
    x0y14_rx_n_ipad             : in std_logic;
    x0y15_rx_p_ipad             : in std_logic;
    x0y15_rx_n_ipad             : in std_logic;
    x0y16_rx_p_ipad             : in std_logic;
    x0y16_rx_n_ipad             : in std_logic;
    x0y17_rx_p_ipad             : in std_logic;
    x0y17_rx_n_ipad             : in std_logic;
    x0y18_rx_p_ipad             : in std_logic;
    x0y18_rx_n_ipad             : in std_logic;
    x0y19_rx_p_ipad             : in std_logic;
    x0y19_rx_n_ipad             : in std_logic;
    
    x0y12_tx_p_opad             : out std_logic;
    x0y12_tx_n_opad             : out std_logic;
    x0y13_tx_p_opad             : out std_logic;
    x0y13_tx_n_opad             : out std_logic;
    x0y14_tx_p_opad             : out std_logic;
    x0y14_tx_n_opad             : out std_logic;
    x0y15_tx_p_opad             : out std_logic;
    x0y15_tx_n_opad             : out std_logic;
    x0y16_tx_p_opad             : out std_logic;
    x0y16_tx_n_opad             : out std_logic;
    x0y17_tx_p_opad             : out std_logic;
    x0y17_tx_n_opad             : out std_logic;
    x0y18_tx_p_opad             : out std_logic;
    x0y18_tx_n_opad             : out std_logic;
    x0y19_tx_p_opad             : out std_logic;
    x0y19_tx_n_opad             : out std_logic;
    
    q4_clk1_mgtrefclk_p_ipad    : in std_logic;
    q4_clk1_mgtrefclk_n_ipad    : in std_logic;
    
    qpll_reset_o                : out std_logic;
    qpll_locked_i               : in std_logic;
    qpll_clk_p_i                : in std_logic;
    qpll_clk_n_i                : in std_logic;
    
    hdmi                        : out std_logic_vector(7 downto 0) 
);
end toplevel;

architecture behavioral of toplevel is

    signal qpll                 : std_logic;

    signal bram_sbiterr         : std_logic_vector(9 downto 0);
    signal bram_dbiterr         : std_logic_vector(9 downto 0);
    
    signal dsp_err              : std_logic_vector(9 downto 0);
    signal dsp_serr             : std_logic_vector(9 downto 0);
    signal dsp_derr             : std_logic_vector(9 downto 0);
    signal dsp_terr             : std_logic_vector(9 downto 0);
    
    signal clb_err              : std_logic_vector(9 downto 0);
    signal clb_serr             : std_logic_vector(9 downto 0);
    
    signal sem_heartbeat        : std_logic;
    signal sem_initialization   : std_logic;
    signal sem_observation      : std_logic;
    signal sem_correction       : std_logic;
    signal sem_classification   : std_logic;
    signal sem_injection        : std_logic;
    signal sem_essential        : std_logic;
    signal sem_uncorrectable    : std_logic;

    signal control0             : std_logic_vector(35 downto 0);
    signal control1             : std_logic_vector(35 downto 0);
    signal sync_out             : std_logic_vector(63 downto 0);
    signal sync_in              : std_logic_vector(31 downto 0);
    signal ila0                 : std_logic_vector(127 downto 0);
    signal ila1                 : std_logic_vector(31 downto 0);
    
    signal db_bram_serr         : std_logic;
    signal db_bram_derr         : std_logic;
    signal db_dsp_serr          : std_logic;
    signal db_dsp_derr          : std_logic;
    signal db_dsp_terr          : std_logic;
    signal db_clb_err           : std_logic;
    signal db_clb_serr          : std_logic;
    signal db_sem_txfull        : std_logic;
    signal db_sem_txwrite       : std_logic;
    signal db_sem_txdata        : std_logic_vector(7 downto 0);
    signal db_sem_rxempty       : std_logic;
    signal db_sem_rxread        : std_logic;
    signal db_sem_rxdata        : std_logic_vector(7 downto 0);
    signal db_sem_injstrobe     : std_logic;
    signal db_sem_injaddr       : std_logic_vector(35 downto 0);     
    
begin

    --==========--
    --== QPLL ==--
    --==========--
    
    qpll_ibufgds : ibufgds 
    port map(
        i   => qpll_clk_p_i,
        ib  => qpll_clk_n_i,
        o   => qpll
    );
    
    qpll_reset_o <= '0';

    --===========--
    --== IBERT ==--
    --===========--

    ibert_inst : entity work.ibert
    port map(
        x0y12_rx_p_ipad             => x0y12_rx_p_ipad,
        x0y12_rx_n_ipad             => x0y12_rx_n_ipad,
        x0y13_rx_p_ipad             => x0y13_rx_p_ipad,
        x0y13_rx_n_ipad             => x0y13_rx_n_ipad,
        x0y14_rx_p_ipad             => x0y14_rx_p_ipad,
        x0y14_rx_n_ipad             => x0y14_rx_n_ipad,
        x0y15_rx_p_ipad             => x0y15_rx_p_ipad,
        x0y15_rx_n_ipad             => x0y15_rx_n_ipad,
        x0y16_rx_p_ipad             => x0y16_rx_p_ipad,
        x0y16_rx_n_ipad             => x0y16_rx_n_ipad,
        x0y17_rx_p_ipad             => x0y17_rx_p_ipad,
        x0y17_rx_n_ipad             => x0y17_rx_n_ipad,
        x0y18_rx_p_ipad             => x0y18_rx_p_ipad,
        x0y18_rx_n_ipad             => x0y18_rx_n_ipad,
        x0y19_rx_p_ipad             => x0y19_rx_p_ipad,
        x0y19_rx_n_ipad             => x0y19_rx_n_ipad,
        q4_clk1_mgtrefclk_p_ipad    => q4_clk1_mgtrefclk_p_ipad,
        q4_clk1_mgtrefclk_n_ipad    => q4_clk1_mgtrefclk_n_ipad,
        x0y12_tx_p_opad             => x0y12_tx_p_opad,
        x0y12_tx_n_opad             => x0y12_tx_n_opad,
        x0y13_tx_p_opad             => x0y13_tx_p_opad,
        x0y13_tx_n_opad             => x0y13_tx_n_opad,
        x0y14_tx_p_opad             => x0y14_tx_p_opad,
        x0y14_tx_n_opad             => x0y14_tx_n_opad,
        x0y15_tx_p_opad             => x0y15_tx_p_opad,
        x0y15_tx_n_opad             => x0y15_tx_n_opad,
        x0y16_tx_p_opad             => x0y16_tx_p_opad,
        x0y16_tx_n_opad             => x0y16_tx_n_opad,
        x0y17_tx_p_opad             => x0y17_tx_p_opad,
        x0y17_tx_n_opad             => x0y17_tx_n_opad,
        x0y18_tx_p_opad             => x0y18_tx_p_opad,
        x0y18_tx_n_opad             => x0y18_tx_n_opad,
        x0y19_tx_p_opad             => x0y19_tx_p_opad,
        x0y19_tx_n_opad             => x0y19_tx_n_opad
    );
    
    --==========--
    --== BRAM ==--
    --==========--
    
    bram_inst : entity work.bram
    generic map(
        DEBUG       => DEBUG
    )
    port map(
        clk_i       => qpll,
        sbiterr_o   => bram_sbiterr,
        dbiterr_o   => bram_dbiterr,
        db_serr_i   => db_bram_serr,
        db_derr_i   => db_bram_derr
    );
    
    --=========--
    --== DSP ==--
    --=========--
    
    dsp_inst : entity work.dsp        
    generic map(
        DEBUG       => DEBUG
    )
    port map(
        clk_i       => qpll,
        err_o       => dsp_err,
        serr_o      => dsp_serr,
        derr_o      => dsp_derr,
        terr_o      => dsp_terr,
        db_serr_i   => db_dsp_serr,
        db_derr_i   => db_dsp_derr,
        db_terr_i   => db_dsp_terr
    );

    --=========--
    --== CLB ==--
    --=========--
    
    clb_inst : entity work.clb
    generic map(
        DEBUG       => DEBUG,
        N           => N
    )
    port map(
        clk_i       => qpll,
        err_o       => clb_err,
        serr_o      => clb_serr,        
        db_err_i    => db_clb_err,
        db_serr_i   => db_clb_serr
    );    
    
    --=========--
    --== SEM ==--
    --=========--
        
    sem_inst : entity work.sem
    generic map(
        DEBUG               => DEBUG
    )
    port map(
        clk_i               => qpll,    
        heartbeat_o         => sem_heartbeat, 
        initialization_o    => sem_initialization, 
        observation_o       => sem_observation, 
        correction_o        => sem_correction, 
        classification_o    => sem_classification, 
        injection_o         => sem_injection, 
        essential_o         => sem_essential, 
        uncorrectable_o     => sem_uncorrectable,
        db_txfull_i         => db_sem_txfull,
        db_txwrite_o        => db_sem_txwrite,
        db_txdata_o         => db_sem_txdata,
        db_rxempty_i        => db_sem_rxempty,
        db_rxread_o         => db_sem_rxread,
        db_rxdata_i         => db_sem_rxdata,
        db_injstrobe_i      => db_sem_injstrobe,
        db_injaddr_i        => db_sem_injaddr
    );      
    
    --===========--
    --== DEBUG ==--
    --===========--
    
    debug_gen: if DEBUG = TRUE generate
    begin
    
        chipscope_icon_inst : entity work.chipscope_icon
        port map(
            control0 => control0,
            control1 => control1
        );
        
        chipscope_vio_inst : entity work.chipscope_vio
        port map(
            control     => control0,
            clk         => qpll,
            sync_out    => sync_out,
            sync_in     => sync_in
        ); 
        
        chipscope_ila_inst : entity work.chipscope_ila
        port map(
            control => control1,
            clk     => qpll,
            trig0   => ila0,
            trig1   => ila1
        );        
        
        db_bram_serr <= sync_out(0);
        db_bram_derr <= sync_out(1);
        db_dsp_serr <= sync_out(2);
        db_dsp_derr <= sync_out(3);
        db_dsp_terr <= sync_out(4);
        db_clb_err <= sync_out(5);
        db_clb_serr <= sync_out(6);        

        db_sem_txfull <= not sync_out(7);
        db_sem_rxempty <= not sync_out(8);
        db_sem_rxdata <= sync_out(16 downto 9);
        db_sem_injstrobe <= sync_out(17);
        db_sem_injaddr <= sync_out(53 downto 18);
        
        sync_in(0) <= db_sem_txwrite;
        sync_in(8 downto 1) <= db_sem_txdata;
        sync_in(9) <= db_sem_rxread;  
        
        ila0(9 downto 0) <= bram_sbiterr;
        ila0(19 downto 10) <= bram_dbiterr;        
        ila0(29 downto 20) <= dsp_err;
        ila0(39 downto 30) <= dsp_serr;
        ila0(49 downto 40) <= dsp_derr;
        ila0(59 downto 50) <= dsp_terr;        
        ila0(69 downto 60) <= clb_err;
        ila0(79 downto 70) <= clb_serr;
        
        ila0(80) <= sem_heartbeat;
        ila0(81) <= sem_initialization;
        ila0(82) <= sem_observation;
        ila0(83) <= sem_correction;
        ila0(84) <= sem_classification;
        ila0(85) <= sem_injection;
        ila0(86) <= sem_essential;
        ila0(87) <= sem_uncorrectable;
        
        ila1(0) <= sync_out(0);
        ila1(1) <= sync_out(1);
        ila1(2) <= sync_out(2);
        ila1(3) <= sync_out(3);
        ila1(4) <= sync_out(4);
        ila1(5) <= sync_out(5);
        ila1(6) <= sync_out(6);            
        
    end generate; 

    --==============--
    --== NO DEBUG ==--
    --==============--

    nodebug_gen : if DEBUG = FALSE generate
    begin
    
        db_bram_serr <= '0';
        db_bram_derr <= '0';
        db_dsp_serr <= '0';
        db_dsp_derr <= '0';
        db_dsp_terr <= '0';
        db_clb_err <= '0';
        db_clb_serr <= '0'; 
        
        db_sem_txfull <= '0';
        db_sem_rxempty <= '1';
        db_sem_rxdata <= (others => '0');
        db_sem_injstrobe <= '0';
        db_sem_injaddr <= (others => '0');
    
    end generate;    

    --==========--
    --== HDMI ==--
    --==========--    
  
    hdmi_inst : entity work.hdmi
    port map(
        clk_i                   => qpll,
        bram_sbiterr_i          => bram_sbiterr,
        bram_dbiterr_i          => bram_dbiterr,    
        dsp_err_i               => dsp_err,
        dsp_serr_i              => dsp_serr,
        dsp_derr_i              => dsp_derr,
        dsp_terr_i              => dsp_terr,    
        clb_err_i               => clb_err,
        clb_serr_i              => clb_serr,
        sem_heartbeat_i         => sem_heartbeat,
        sem_initialization_i    => sem_initialization,
        sem_observation_i       => sem_observation,
        sem_correction_i        => sem_correction,
        sem_classification_i    => sem_classification,
        sem_injection_i         => sem_injection,
        sem_essential_i         => sem_essential,
        sem_uncorrectable_i     => sem_uncorrectable,    
        hdmi_o                  => hdmi
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