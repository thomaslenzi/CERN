library ieee;
use ieee.std_logic_1164.all;

library work;
use work.user_package.all;

entity tracking_core is
port(

    gtp_clk_i           : in std_logic;
    vfat2_clk_i         : in std_logic;
    reset_i             : in std_logic;
    
    lv1a_sent_i         : in std_logic;
    bx_counter_i        : in std_logic_vector(31 downto 0);
    
    vfat2_data_0_i      : in std_logic;
    vfat2_data_1_i      : in std_logic;
    vfat2_data_2_i      : in std_logic;
    vfat2_data_3_i      : in std_logic;
    vfat2_data_4_i      : in std_logic;
    vfat2_data_5_i      : in std_logic;
    vfat2_data_6_i      : in std_logic;
    vfat2_data_7_i      : in std_logic;
    vfat2_data_8_i      : in std_logic;
    vfat2_data_9_i      : in std_logic;
    vfat2_data_10_i     : in std_logic;
    vfat2_data_11_i     : in std_logic;
    vfat2_data_12_i     : in std_logic;
    vfat2_data_13_i     : in std_logic;
    vfat2_data_14_i     : in std_logic;
    vfat2_data_15_i     : in std_logic;
    vfat2_data_16_i     : in std_logic;
    vfat2_data_17_i     : in std_logic;
    vfat2_data_18_i     : in std_logic;
    vfat2_data_19_i     : in std_logic;
    vfat2_data_20_i     : in std_logic;
    vfat2_data_21_i     : in std_logic;
    vfat2_data_22_i     : in std_logic;
    vfat2_data_23_i     : in std_logic;

    track_tx_ready_0_o  : out std_logic;
    track_tx_done_0_i   : in std_logic;
    track_tx_data_0_o   : out std_logic_vector(223 downto 0);
    
    track_tx_ready_1_o  : out std_logic;
    track_tx_done_1_i   : in std_logic;
    track_tx_data_1_o   : out std_logic_vector(223 downto 0);
    
    track_tx_ready_2_o  : out std_logic;
    track_tx_done_2_i   : in std_logic;
    track_tx_data_2_o   : out std_logic_vector(223 downto 0)
    
);
end tracking_core;

architecture Behavioral of tracking_core is

    signal track_en                 : std_logic_vector(23 downto 0) := (others => '0');
    signal track_data               : array192(23 downto 0);
    
    signal data_fifo_wr_0           : std_logic := '0';
    signal data_fifo_din_0          : std_logic_vector(223 downto 0) := (others => '0');
    signal data_fifo_rd_0           : std_logic := '0';
    signal data_fifo_valid_0        : std_logic := '0';
    signal data_fifo_underflow_0    : std_logic := '0';
    signal data_fifo_dout_0         : std_logic_vector(223 downto 0) := (others => '0');
    
    signal data_fifo_wr_1           : std_logic := '0';
    signal data_fifo_din_1          : std_logic_vector(223 downto 0) := (others => '0');
    signal data_fifo_rd_1           : std_logic := '0';
    signal data_fifo_valid_1        : std_logic := '0';
    signal data_fifo_underflow_1    : std_logic := '0';
    signal data_fifo_dout_1         : std_logic_vector(223 downto 0) := (others => '0');
    
    signal data_fifo_wr_2           : std_logic := '0';
    signal data_fifo_din_2          : std_logic_vector(223 downto 0) := (others => '0');
    signal data_fifo_rd_2           : std_logic := '0';
    signal data_fifo_valid_2        : std_logic := '0';
    signal data_fifo_underflow_2    : std_logic := '0';
    signal data_fifo_dout_2         : std_logic_vector(223 downto 0) := (others => '0');
    
    signal trigger_fifo_rd          : std_logic := '0';
    signal trigger_fifo_valid       : std_logic := '0';
    signal trigger_fifo_underflow   : std_logic := '0';
    signal trigger_fifo_dout        : std_logic_vector(31 downto 0) := (others => '0');

begin  

    --================================--
    -- BX accepted FIFO
    --================================--  
    
    tracking_bx_fifo_inst : entity work.tracking_bx_fifo
    port map(
        rst         => reset_i,
        wr_clk      => gtp_clk_i,
        wr_en       => lv1a_sent_i,
        din         => bx_counter_i,
        rd_clk      => vfat2_clk_i,
        rd_en       => trigger_fifo_rd,
        valid       => trigger_fifo_valid,
        underflow   => trigger_fifo_underflow,
        dout        => trigger_fifo_dout,
        empty       => open,
        full        => open
    );
    
    --================================--
    -- Tracking decoder
    --================================--  

    track_0_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_0_i, en_o => track_en(0), data_o => track_data(0));
    track_1_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_1_i, en_o => track_en(1), data_o => track_data(1));
    track_2_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_2_i, en_o => track_en(2), data_o => track_data(2));
    track_3_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_3_i, en_o => track_en(3), data_o => track_data(3));
    track_4_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_4_i, en_o => track_en(4), data_o => track_data(4)); 
    track_5_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_5_i, en_o => track_en(5), data_o => track_data(5));
    track_6_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_6_i, en_o => track_en(6), data_o => track_data(6));
    track_7_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_7_i, en_o => track_en(7), data_o => track_data(7));
    track_8_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_8_i, en_o => track_en(8), data_o => track_data(8));
    track_9_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_9_i, en_o => track_en(9), data_o => track_data(9));
    track_10_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_10_i, en_o => track_en(10), data_o => track_data(10));
    track_11_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_11_i, en_o => track_en(11), data_o => track_data(11));
    track_12_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_12_i, en_o => track_en(12), data_o => track_data(12));
    track_13_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_13_i, en_o => track_en(13), data_o => track_data(13));
    track_14_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_14_i, en_o => track_en(14), data_o => track_data(14));
    track_15_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_15_i, en_o => track_en(15), data_o => track_data(15));
    track_16_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_16_i, en_o => track_en(16), data_o => track_data(16));
    track_17_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_17_i, en_o => track_en(17), data_o => track_data(17));
    track_18_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_18_i, en_o => track_en(18), data_o => track_data(18));
    track_19_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_19_i, en_o => track_en(19), data_o => track_data(19));
    track_20_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_20_i, en_o => track_en(20), data_o => track_data(20));
    track_21_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_21_i, en_o => track_en(21), data_o => track_data(21));
    track_22_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_22_i, en_o => track_en(22), data_o => track_data(22));
    track_23_inst : entity work.tracking_decoder port map(vfat2_clk_i => vfat2_clk_i, reset_i => reset_i, data_i => vfat2_data_23_i, en_o => track_en(23), data_o => track_data(23));

    --================================--
    -- Concentrator
    --================================--  
    
    tracking_concentrator_inst : entity work.tracking_concentrator
    port map(
        vfat2_clk_i         => vfat2_clk_i,
        reset_i             => reset_i,
        en_i                => track_en,
        data_i              => track_data,
        fifo_read_o         => trigger_fifo_rd,
        fifo_valid_i        => trigger_fifo_valid,
        fifo_underflow_i    => trigger_fifo_underflow,
        fifo_data_i         => trigger_fifo_dout,
        en_0_o              => data_fifo_wr_0,
        data_0_o            => data_fifo_din_0,
        en_1_o              => data_fifo_wr_1,
        data_1_o            => data_fifo_din_1,
        en_2_o              => data_fifo_wr_2,
        data_2_o            => data_fifo_din_2
    );
    
    --================================--
    -- Tracking data FIFO
    --================================--  
   
    tracking_data_fifo_0_inst : entity work.tracking_data_fifo
    port map(
        rst         => reset_i,
        wr_clk      => vfat2_clk_i,
        wr_en       => data_fifo_wr_0,
        din         => data_fifo_din_0,
        rd_clk      => gtp_clk_i,
        rd_en       => data_fifo_rd_0,
        valid       => data_fifo_valid_0,
        underflow   => data_fifo_underflow_0,
        dout        => data_fifo_dout_0,
        empty       => open,
        full        => open
    );
   
    tracking_data_fifo_1_inst : entity work.tracking_data_fifo
    port map(
        rst         => reset_i,
        wr_clk      => vfat2_clk_i,
        wr_en       => data_fifo_wr_1,
        din         => data_fifo_din_1,
        rd_clk      => gtp_clk_i,
        rd_en       => data_fifo_rd_1,
        valid       => data_fifo_valid_1,
        underflow   => data_fifo_underflow_1,
        dout        => data_fifo_dout_1,
        empty       => open,
        full        => open
    );
   
    tracking_data_fifo_2_inst : entity work.tracking_data_fifo
    port map(
        rst         => reset_i,
        wr_clk      => vfat2_clk_i,
        wr_en       => data_fifo_wr_2,
        din         => data_fifo_din_2,
        rd_clk      => gtp_clk_i,
        rd_en       => data_fifo_rd_2,
        valid       => data_fifo_valid_2,
        underflow   => data_fifo_underflow_2,
        dout        => data_fifo_dout_2,
        empty       => open,
        full        => open
    );
    
    --================================--
    -- Data access
    --================================--  
    
    tracking_readout_0_inst : entity work.tracking_readout
    port map(
        gtp_clk_i           => gtp_clk_i,
        reset_i             => reset_i,
        fifo_read_o         => data_fifo_rd_0,
        fifo_valid_i        => data_fifo_valid_0,
        fifo_underflow_i    => data_fifo_underflow_0,
        fifo_data_i         => data_fifo_dout_0,
        tx_ready_o          => track_tx_ready_0_o,
        tx_done_i           => track_tx_done_0_i,
        tx_data_o           => track_tx_data_0_o
    ); 
    
    tracking_readout_1_inst : entity work.tracking_readout
    port map(
        gtp_clk_i           => gtp_clk_i,
        reset_i             => reset_i,
        fifo_read_o         => data_fifo_rd_1,
        fifo_valid_i        => data_fifo_valid_1,
        fifo_underflow_i    => data_fifo_underflow_1,
        fifo_data_i         => data_fifo_dout_1,
        tx_ready_o          => track_tx_ready_1_o,
        tx_done_i           => track_tx_done_1_i,
        tx_data_o           => track_tx_data_1_o
    ); 
    
    tracking_readout_2_inst : entity work.tracking_readout
    port map(
        gtp_clk_i           => gtp_clk_i,
        reset_i             => reset_i,
        fifo_read_o         => data_fifo_rd_2,
        fifo_valid_i        => data_fifo_valid_2,
        fifo_underflow_i    => data_fifo_underflow_2,
        fifo_data_i         => data_fifo_dout_2,
        tx_ready_o          => track_tx_ready_2_o,
        tx_done_i           => track_tx_done_2_i,
        tx_data_o           => track_tx_data_2_o
    );
    
end Behavioral;

