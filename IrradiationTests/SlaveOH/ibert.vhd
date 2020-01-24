library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library chipscope_ibert_virtex6_gtx_v2_05_a;

library work;

entity ibert is
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
    q4_clk1_mgtrefclk_p_ipad    : in std_logic;
    q4_clk1_mgtrefclk_n_ipad    : in std_logic;
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
    x0y19_tx_n_opad             : out std_logic
);
end ibert;

architecture behavioral of ibert is

  signal mgtclk     : std_logic;
  signal control0   : std_logic_vector(35 downto 0);

begin

    --===========--
    --== IBERT ==--
    --===========--

    chipscope_ibert_inst : entity work.chipscope_ibert
    port map(
        x0y12_tx_p_opad     => x0y12_tx_p_opad,
        x0y12_tx_n_opad     => x0y12_tx_n_opad,
        x0y13_tx_p_opad     => x0y13_tx_p_opad,
        x0y13_tx_n_opad     => x0y13_tx_n_opad,
        x0y14_tx_p_opad     => x0y14_tx_p_opad,
        x0y14_tx_n_opad     => x0y14_tx_n_opad,
        x0y15_tx_p_opad     => x0y15_tx_p_opad,
        x0y15_tx_n_opad     => x0y15_tx_n_opad,
        x0y16_tx_p_opad     => x0y16_tx_p_opad,
        x0y16_tx_n_opad     => x0y16_tx_n_opad,
        x0y17_tx_p_opad     => x0y17_tx_p_opad,
        x0y17_tx_n_opad     => x0y17_tx_n_opad,
        x0y18_tx_p_opad     => x0y18_tx_p_opad,
        x0y18_tx_n_opad     => x0y18_tx_n_opad,
        x0y19_tx_p_opad     => x0y19_tx_p_opad,
        x0y19_tx_n_opad     => x0y19_tx_n_opad,    
        x1y24_tx_p_opad     => open,
        x1y24_tx_n_opad     => open,
        x1y25_tx_p_opad     => open,
        x1y25_tx_n_opad     => open,
        x1y26_tx_p_opad     => open,
        x1y26_tx_n_opad     => open,
        x1y27_tx_p_opad     => open,
        x1y27_tx_n_opad     => open,
        x1y28_tx_p_opad     => open,
        x1y28_tx_n_opad     => open,
        x1y29_tx_p_opad     => open,
        x1y29_tx_n_opad     => open,
        x1y30_tx_p_opad     => open,
        x1y30_tx_n_opad     => open,
        x1y31_tx_p_opad     => open,
        x1y31_tx_n_opad     => open,
        x1y32_tx_p_opad     => open,
        x1y32_tx_n_opad     => open,
        x1y33_tx_p_opad     => open,
        x1y33_tx_n_opad     => open,
        x1y34_tx_p_opad     => open,
        x1y34_tx_n_opad     => open,
        x1y35_tx_p_opad     => open,
        x1y35_tx_n_opad     => open,
        --
        x0y12_rxrecclk_o    => open,
        x1y24_rxrecclk_o    => open,
        x1y25_rxrecclk_o    => open,
        x1y26_rxrecclk_o    => open,
        x1y27_rxrecclk_o    => open,
        x1y28_rxrecclk_o    => open,
        x1y29_rxrecclk_o    => open,
        x1y30_rxrecclk_o    => open,
        x1y31_rxrecclk_o    => open,
        x1y32_rxrecclk_o    => open,
        x1y33_rxrecclk_o    => open,
        x1y34_rxrecclk_o    => open,
        x1y35_rxrecclk_o    => open,
        --
        x0y12_rx_p_ipad     => x0y12_rx_p_ipad,
        x0y12_rx_n_ipad     => x0y12_rx_n_ipad,
        x0y13_rx_p_ipad     => x0y13_rx_p_ipad,
        x0y13_rx_n_ipad     => x0y13_rx_n_ipad,
        x0y14_rx_p_ipad     => x0y14_rx_p_ipad,
        x0y14_rx_n_ipad     => x0y14_rx_n_ipad,
        x0y15_rx_p_ipad     => x0y15_rx_p_ipad,
        x0y15_rx_n_ipad     => x0y15_rx_n_ipad,
        x0y16_rx_p_ipad     => x0y16_rx_p_ipad,
        x0y16_rx_n_ipad     => x0y16_rx_n_ipad,
        x0y17_rx_p_ipad     => x0y17_rx_p_ipad,
        x0y17_rx_n_ipad     => x0y17_rx_n_ipad,
        x0y18_rx_p_ipad     => x0y18_rx_p_ipad,
        x0y18_rx_n_ipad     => x0y18_rx_n_ipad,
        x0y19_rx_p_ipad     => x0y19_rx_p_ipad,
        x0y19_rx_n_ipad     => x0y19_rx_n_ipad,
        x1y24_rx_p_ipad     => '1',
        x1y24_rx_n_ipad     => '0',
        x1y25_rx_p_ipad     => '1',
        x1y25_rx_n_ipad     => '0',
        x1y26_rx_p_ipad     => '1',
        x1y26_rx_n_ipad     => '0',
        x1y27_rx_p_ipad     => '1',
        x1y27_rx_n_ipad     => '0',
        x1y28_rx_p_ipad     => '1',
        x1y28_rx_n_ipad     => '0',
        x1y29_rx_p_ipad     => '1',
        x1y29_rx_n_ipad     => '0',
        x1y30_rx_p_ipad     => '1',
        x1y30_rx_n_ipad     => '0',
        x1y31_rx_p_ipad     => '1',
        x1y31_rx_n_ipad     => '0',
        x1y32_rx_p_ipad     => '1',
        x1y32_rx_n_ipad     => '0',
        x1y33_rx_p_ipad     => '1',
        x1y33_rx_n_ipad     => '0',
        x1y34_rx_p_ipad     => '1',
        x1y34_rx_n_ipad     => '0',
        x1y35_rx_p_ipad     => '1',
        x1y35_rx_n_ipad     => '0',
        --    
        q4_clk1_mgtrefclk_i => mgtclk,
        control             => control0,
        ibert_sysclock_i    => '0'
    );
    
    --===============--
    --== ChipScope ==--
    --===============--
    
    chipscope_icon_inst : entity work.chipscope_icon_1
    port map(
        control0 => control0
    );
    
    --===========--
    --== Clock ==--
    --===========--
    
    ibufds_gtxe1_inst : ibufds_gtxe1
    port map(
        o       => mgtclk,
        odiv2   => open,
        ceb     => '0',
        i       => q4_clk1_mgtrefclk_p_ipad,
        ib      => q4_clk1_mgtrefclk_n_ipad
    );

end behavioral;

