library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity sfp_gtx_top is
port(

    mgt_refclk_n_i  : in std_logic;
    mgt_refclk_p_i  : in std_logic;   
    
    reset_i         : in std_logic;
    
    tx_kchar_i      : in std_logic_vector(7 downto 0);
    tx_data_i       : in std_logic_vector(63 downto 0);
    
    rx_kchar_o      : out std_logic_vector(7 downto 0);
    rx_data_o       : out std_logic_vector(63 downto 0);
    rx_error_o      : out std_logic_vector(3 downto 0);
 
    usr_clk_o       : out std_logic;

    rx_n_i          : in std_logic_vector(3 downto 0);
    rx_p_i          : in std_logic_vector(3 downto 0);
    tx_n_o          : out std_logic_vector(3 downto 0);
    tx_p_o          : out std_logic_vector(3 downto 0)
    
);
end sfp_gtx_top;
    
architecture RTL of sfp_gtx_top is

    constant DLY : time := 1 ns;

    signal mgtref_clk               : std_logic;
    signal mgtref_clk_bufg          : std_logic;

    signal gtx_txoutclk             : std_logic_vector(3 downto 0);
    signal gtx_txusrclk2            : std_logic;

    signal gtx_rxrecclk             : std_logic_vector(3 downto 0);
    signal gtx_rxusrclk2            : std_logic_vector(3 downto 0);

    signal gtx_txreset              : std_logic_vector(3 downto 0);
    signal gtx_rxplllkdet           : std_logic_vector(3 downto 0);

    signal gtx_rxreset              : std_logic_vector(3 downto 0);

    signal gtx_rxresetdone          : std_logic_vector(3 downto 0);
    signal gtx_rxresetdone_r        : std_logic_vector(3 downto 0);
    signal gtx_rxresetdone_r2       : std_logic_vector(3 downto 0);
    signal gtx_rxresetdone_r3       : std_logic_vector(3 downto 0);
    signal gtx_rxresetdone_r4       : std_logic_vector(3 downto 0);

    signal gtx_txresetdone          : std_logic_vector(3 downto 0);
    signal gtx_txresetdone_r        : std_logic_vector(3 downto 0);
    signal gtx_txresetdone_r2       : std_logic_vector(3 downto 0);

    signal gtx_reset_txsync         : std_logic_vector(3 downto 0);

    signal gtx_txenpmaphasealign    : std_logic_vector(3 downto 0);
    signal gtx_txpmasetphase        : std_logic_vector(3 downto 0);
    signal gtx_txdlyaligndisable    : std_logic_vector(3 downto 0);
    signal gtx_txdlyalignreset      : std_logic_vector(3 downto 0);
    signal gtx_tx_sync_done         : std_logic_vector(3 downto 0);   

    signal gtx_rx_disperr           : std_logic_vector(7 downto 0); 
    signal gtx_rx_notintable        : std_logic_vector(7 downto 0);
    signal gtx_rx_lossofsync        : std_logic_vector(7 downto 0);
    signal gtx_rx_slide             : std_logic_vector(3 downto 0);

    signal rx_kchar                 : std_logic_vector(7 downto 0);
    signal rx_data                  : std_logic_vector(63 downto 0);
    
    signal tx_kchar                 : std_logic_vector(7 downto 0);
    signal tx_data                  : std_logic_vector(63 downto 0);

    signal gtx_link_init            : std_logic_vector(3 downto 0);
    signal gtx_link_fixed           : std_logic_vector(3 downto 0);

begin

    mgtref_clk_ibufds : ibufds_gtxe1
    port map(
        o       => mgtref_clk,
        odiv2   => open,
        ceb     => '0',
        i       => mgt_refclk_p_i,
        ib      => mgt_refclk_n_i
    );

    mgtef_clk_bufg : bufg
    port map(        
        i   => mgtref_clk,
        o   => mgtref_clk_bufg
    );

    txoutclk_bufg0_i : bufg
    port map(
        i   => gtx_txoutclk(0),
        o   => gtx_txusrclk2
    );

    rx_kchar_o <= rx_kchar;
    rx_data_o <= rx_data;
    usr_clk_o <= gtx_txusrclk2;

    gtx_loop : for I in 0 to 3 generate
    begin

        -- GTX

        gtx_sfp_gtx_i : entity work.sfp_gtx_gtx
        generic map(
            GTX_SIM_GTXRESET_SPEEDUP    => 0,
            GTX_TX_CLK_SOURCE           => "RXPLL",
            GTX_POWER_SAVE              => "0000110100"
        )
        port map(
            ----------------------- Receive Ports - 8b10b Decoder ----------------------
            RXCHARISK_OUT               => rx_kchar((2 * I + 1) downto (2 * I)),
            RXDISPERR_OUT               => gtx_rx_disperr((2 * I + 1) downto (2 * I)),
            RXNOTINTABLE_OUT            => gtx_rx_notintable((2 * I + 1) downto (2 * I)),
            --------------- Receive Ports - Comma Detection and Alignment --------------
            RXSLIDE_IN                  => gtx_rx_slide(I),
            ------------------- Receive Ports - RX Data Path interface -----------------
            RXDATA_OUT                  => rx_data((16 * I + 15) downto (16 * I)),
            RXRECCLK_OUT                => gtx_rxrecclk(I),
            RXRESET_IN                  => gtx_rxreset(I),
            RXUSRCLK2_IN                => gtx_rxusrclk2(I),
            ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
            RXN_IN                      => rx_n_i(I),
            RXP_IN                      => rx_p_i(I),
            --------------- Receive Ports - RX Loss-of-sync State Machine --------------
            RXLOSSOFSYNC_OUT            => gtx_rx_lossofsync((2 * I + 1) downto (2 * I)),
            ------------------------ Receive Ports - RX PLL Ports ----------------------
            GTXRXRESET_IN               => reset_i,
            MGTREFCLKRX_IN              => ('0' & mgtref_clk_bufg),
            PLLRXRESET_IN               => reset_i,
            RXPLLLKDET_OUT              => gtx_rxplllkdet(I),
            RXRESETDONE_OUT             => gtx_rxresetdone(I),
            ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
            TXCHARISK_IN                => tx_kchar((2 * I + 1) downto (2 * I)),
            ------------------ Transmit Ports - TX Data Path interface -----------------
            TXDATA_IN                   => tx_data((16 * I + 15) downto (16 * I)),
            TXOUTCLK_OUT                => gtx_txoutclk(I),
            TXRESET_IN                  => gtx_txreset(I),
            TXUSRCLK2_IN                => gtx_txusrclk2,
            ---------------- Transmit Ports - TX Driver and OOB signaling --------------
            TXN_OUT                     => tx_n_o(I),
            TXP_OUT                     => tx_p_o(I),
            -------- Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
            TXDLYALIGNDISABLE_IN        => gtx_txdlyaligndisable(I),
            TXDLYALIGNMONENB_IN         => '0',
            TXDLYALIGNMONITOR_OUT       => open,
            TXDLYALIGNRESET_IN          => gtx_txdlyalignreset(I),
            TXENPMAPHASEALIGN_IN        => gtx_txenpmaphasealign(I),
            TXPMASETPHASE_IN            => gtx_txpmasetphase(I),
            ----------------------- Transmit Ports - TX PLL Ports ----------------------
            GTXTXRESET_IN               => reset_i,
            MGTREFCLKTX_IN              => ('0' & mgtref_clk_bufg),
            PLLTXRESET_IN               => '0',
            TXPLLLKDET_OUT              => open,
            TXRESETDONE_OUT             => gtx_txresetdone(I)
        );

        -- Error

        rx_error_o(I) <= gtx_rx_disperr(2 * I) or gtx_rx_disperr(2 * I + 1) or gtx_rx_notintable(2 * I) or gtx_rx_notintable(2 * I + 1);

        -- Clocks

        rxrecclk_bufg : bufg
        port map(
            I   => gtx_rxrecclk(I),
            O   => gtx_rxusrclk2(I)
        );

        -- Resets
    
        gtx_txreset(I) <= not(gtx_rxplllkdet(I) and gtx_rxplllkdet(0));

        gtx_rxreset(I) <= not gtx_rxplllkdet(I);

        -- Resets done

        process(gtx_rxusrclk2(I))
        begin
             if (rising_edge(gtx_rxusrclk2(I))) then
                gtx_rxresetdone_r(I) <= gtx_rxresetdone(I) after DLY;
             end if; 
        end process; 

        process(gtx_rxusrclk2(I), gtx_rxresetdone_r(I))
        begin
            if (gtx_rxresetdone_r(I) = '0') then
                gtx_rxresetdone_r2(I) <= '0' after DLY;
                gtx_rxresetdone_r3(I) <= '0' after DLY;
            elsif (rising_edge(gtx_rxusrclk2(I))) then
                gtx_rxresetdone_r2(I) <= gtx_rxresetdone_r(I) after DLY;
                gtx_rxresetdone_r3(I) <= gtx_rxresetdone_r2(I) after DLY;
            end if;
        end process;

        process(gtx_rxusrclk2(I))
        begin
             if (rising_edge(gtx_rxusrclk2(I))) then
                gtx_rxresetdone_r4(I) <= gtx_rxresetdone_r3(I) after DLY;
             end if; 
        end process; 

        process(gtx_txusrclk2, gtx_txresetdone(I))
            begin
            if (gtx_txresetdone(I) = '0') then
                gtx_txresetdone_r(I)  <= '0' after DLY;
                gtx_txresetdone_r2(I) <= '0' after DLY;
            elsif (rising_edge(gtx_txusrclk2)) then
                gtx_txresetdone_r(I)  <= gtx_txresetdone(I) after DLY;
                gtx_txresetdone_r2(I) <= gtx_txresetdone_r(I) after DLY;
            end if;
        end process; 

        -- TX Sync

        gtx_reset_txsync(I)  <=  not gtx_txresetdone_r2(I);  
     
        gtx0_txsync_i : entity work.sfp_gtx_tx_sync
        generic map(
            SIM_TXPMASETPHASE_SPEEDUP   => 0
        )
        port map(
            TXENPMAPHASEALIGN           => gtx_txenpmaphasealign(I),
            TXPMASETPHASE               => gtx_txpmasetphase(I),
            TXDLYALIGNDISABLE           => gtx_txdlyaligndisable(I),
            TXDLYALIGNRESET             => gtx_txdlyalignreset(I),
            SYNC_DONE                   => gtx_tx_sync_done(I),
            USER_CLK                    => gtx_txusrclk2,
            RESET                       => gtx_reset_txsync(I)
        );

        -- Link monitor
        
        link_monitor_inst : entity work.link_monitor 
        port map(
            local_clk_lock  => '1',
            rx_reset_done   => gtx_rxresetdone_r4(I),
            sync_fsm        => gtx_rx_lossofsync(2 * I + 1),
            rxdata          => rx_data((16 * I + 15) downto (16 * I)),
            rxk             => rx_kchar((2 * I + 1) downto (2 * I)),
            rxusrclk2       => gtx_rxusrclk2(I),
            link_initial    => gtx_link_init(I),
            rxslide         => gtx_rx_slide(I),
            prealigned      => open,
            link_fixed      => gtx_link_fixed(I),
            comma_found     => open,
            recclk          => open,
            status          => open
        ); 
        
        tx_data((16 * I + 15) downto (16 * I)) <= tx_data_i((16 * I + 15) downto (16 * I)) when cs_async_out(I) = '1' else x"00BC";
        tx_kchar((2 * I + 1) downto (2 * I)) <= tx_kchar_i((2 * I + 1) downto (2 * I)) when cs_async_out(I) = '1' else "01";
    
    end generate;

end RTL;


