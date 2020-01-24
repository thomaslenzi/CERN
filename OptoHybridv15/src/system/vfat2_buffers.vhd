----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:15:06 03/13/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_buffers - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:    This entity adds differential input buffers to all VFAT2 Sbits and DataOut signals
--                 and packes them inside an array.
--                  This file is generated automatically by tools/gen_vfat2_vhdl.py
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.vfat2_pkg.all;

entity vfat2_buffers is
port(

    --== VFAT2s raw control ==--

    vfat2_mclk_p_o          : out std_logic_vector(2 downto 0);
    vfat2_mclk_n_o          : out std_logic_vector(2 downto 0);

    vfat2_resb_o            : out std_logic_vector(2 downto 0);
    vfat2_resh_o            : out std_logic_vector(2 downto 0);

    vfat2_t1_p_o            : out std_logic_vector(2 downto 0);
    vfat2_t1_n_o            : out std_logic_vector(2 downto 0);

    vfat2_scl_o             : out std_logic_vector(5 downto 0);
    vfat2_sda_io            : inout std_logic_vector(5 downto 0);

    vfat2_data_valid_p_i    : in std_logic_vector(5 downto 0);
    vfat2_data_valid_n_i    : in std_logic_vector(5 downto 0);

    --== VFAT2s packed control ==--

    vfat2_mclk_i            : in std_logic;

    vfat2_reset_i           : in std_logic;

    vfat2_t1_i              : in std_logic;

    vfat2_scl_i             : in std_logic_vector(5 downto 0);
    vfat2_sda_i             : in std_logic_vector(5 downto 0);
    vfat2_sda_o             : out std_logic_vector(5 downto 0);
    vfat2_sda_t             : in std_logic_vector(5 downto 0);

    vfat2_data_valid_o      : out std_logic_vector(5 downto 0);

    --== VFAT2s raw data ==--

    vfat2_0_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_0_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_0_data_out_p_i    : in std_logic;
    vfat2_0_data_out_n_i    : in std_logic;

    vfat2_1_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_1_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_1_data_out_p_i    : in std_logic;
    vfat2_1_data_out_n_i    : in std_logic;

    vfat2_2_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_2_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_2_data_out_p_i    : in std_logic;
    vfat2_2_data_out_n_i    : in std_logic;

    vfat2_3_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_3_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_3_data_out_p_i    : in std_logic;
    vfat2_3_data_out_n_i    : in std_logic;

    vfat2_4_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_4_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_4_data_out_p_i    : in std_logic;
    vfat2_4_data_out_n_i    : in std_logic;

    vfat2_5_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_5_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_5_data_out_p_i    : in std_logic;
    vfat2_5_data_out_n_i    : in std_logic;

    vfat2_6_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_6_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_6_data_out_p_i    : in std_logic;
    vfat2_6_data_out_n_i    : in std_logic;

    vfat2_7_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_7_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_7_data_out_p_i    : in std_logic;
    vfat2_7_data_out_n_i    : in std_logic;

    vfat2_8_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_8_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_8_data_out_p_i    : in std_logic;
    vfat2_8_data_out_n_i    : in std_logic;

    vfat2_9_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_9_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_9_data_out_p_i    : in std_logic;
    vfat2_9_data_out_n_i    : in std_logic;

    vfat2_10_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_10_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_10_data_out_p_i   : in std_logic;
    vfat2_10_data_out_n_i   : in std_logic;

    vfat2_11_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_11_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_11_data_out_p_i   : in std_logic;
    vfat2_11_data_out_n_i   : in std_logic;

    vfat2_12_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_12_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_12_data_out_p_i   : in std_logic;
    vfat2_12_data_out_n_i   : in std_logic;

    vfat2_13_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_13_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_13_data_out_p_i   : in std_logic;
    vfat2_13_data_out_n_i   : in std_logic;

    vfat2_14_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_14_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_14_data_out_p_i   : in std_logic;
    vfat2_14_data_out_n_i   : in std_logic;

    vfat2_15_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_15_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_15_data_out_p_i   : in std_logic;
    vfat2_15_data_out_n_i   : in std_logic;

    vfat2_16_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_16_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_16_data_out_p_i   : in std_logic;
    vfat2_16_data_out_n_i   : in std_logic;

    vfat2_17_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_17_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_17_data_out_p_i   : in std_logic;
    vfat2_17_data_out_n_i   : in std_logic;

    vfat2_18_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_18_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_18_data_out_p_i   : in std_logic;
    vfat2_18_data_out_n_i   : in std_logic;

    vfat2_19_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_19_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_19_data_out_p_i   : in std_logic;
    vfat2_19_data_out_n_i   : in std_logic;

    vfat2_20_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_20_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_20_data_out_p_i   : in std_logic;
    vfat2_20_data_out_n_i   : in std_logic;

    vfat2_21_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_21_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_21_data_out_p_i   : in std_logic;
    vfat2_21_data_out_n_i   : in std_logic;

    vfat2_22_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_22_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_22_data_out_p_i   : in std_logic;
    vfat2_22_data_out_n_i   : in std_logic;

    vfat2_23_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_23_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_23_data_out_p_i   : in std_logic;
    vfat2_23_data_out_n_i   : in std_logic;

    --== VFAT2s packed data ==--

    vfat2s_data_o           : out vfat2s_data_t(23 downto 0)

);
end vfat2_buffers;

architecture Behavioral of vfat2_buffers is

    signal vfat2_t1             : std_logic_vector(2 downto 0); 
    signal vfat2_mclk           : std_logic_vector(2 downto 0); 
    signal vfat2_data_valid     : std_logic_vector(5 downto 0); 

    signal vfat2_0_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_0_data_out     : std_logic;

    signal vfat2_1_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_1_data_out     : std_logic;

    signal vfat2_2_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_2_data_out     : std_logic;

    signal vfat2_3_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_3_data_out     : std_logic;

    signal vfat2_4_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_4_data_out     : std_logic;

    signal vfat2_5_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_5_data_out     : std_logic;

    signal vfat2_6_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_6_data_out     : std_logic;

    signal vfat2_7_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_7_data_out     : std_logic;

    signal vfat2_8_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_8_data_out     : std_logic;

    signal vfat2_9_sbits        : std_logic_vector(7 downto 0);
    signal vfat2_9_data_out     : std_logic;

    signal vfat2_10_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_10_data_out    : std_logic;

    signal vfat2_11_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_11_data_out    : std_logic;

    signal vfat2_12_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_12_data_out    : std_logic;

    signal vfat2_13_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_13_data_out    : std_logic;

    signal vfat2_14_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_14_data_out    : std_logic;

    signal vfat2_15_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_15_data_out    : std_logic;

    signal vfat2_16_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_16_data_out    : std_logic;

    signal vfat2_17_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_17_data_out    : std_logic;

    signal vfat2_18_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_18_data_out    : std_logic;

    signal vfat2_19_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_19_data_out    : std_logic;

    signal vfat2_20_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_20_data_out    : std_logic;

    signal vfat2_21_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_21_data_out    : std_logic;

    signal vfat2_22_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_22_data_out    : std_logic;

    signal vfat2_23_sbits       : std_logic_vector(7 downto 0);
    signal vfat2_23_data_out    : std_logic;

begin

    --== MCLK signals ==--

    vfat2_mclk_2_oddr_inst : oddr
    generic map(
        ddr_clk_edge => "opposite_edge",
        init => '0',
        srtype => "sync"
    )
    port map (
        q   => vfat2_mclk(2),
        c   => vfat2_mclk_i,
        ce  => '1',
        d1  => '1',
        d2  => '0',
        r   => '0',
        s   => '0'
    );

    vfat2_mclk_2_obufds_inst : obufds
    generic map(
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_mclk(2),
        o   => vfat2_mclk_p_o(2),
        ob  => vfat2_mclk_n_o(2)
    );


    vfat2_mclk_0_oddr_inst : oddr
    generic map(
        ddr_clk_edge => "opposite_edge",
        init => '0',
        srtype => "sync"
    )
    port map (
        q   => vfat2_mclk(0),
        c   => vfat2_mclk_i,
        ce  => '1',
        d1  => '0',
        d2  => '1',
        r   => '0',
        s   => '0'
    );

    vfat2_mclk_0_obufds_inst : obufds
    generic map(
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_mclk(0),
        o   => vfat2_mclk_p_o(0),
        ob  => vfat2_mclk_n_o(0)
    );


    vfat2_mclk_1_oddr_inst : oddr
    generic map(
        ddr_clk_edge => "opposite_edge",
        init => '0',
        srtype => "sync"
    )
    port map (
        q   => vfat2_mclk(1),
        c   => vfat2_mclk_i,
        ce  => '1',
        d1  => '0',
        d2  => '1',
        r   => '0',
        s   => '0'
    );

    vfat2_mclk_1_obufds_inst : obufds
    generic map(
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_mclk(1),
        o   => vfat2_mclk_p_o(1),
        ob  => vfat2_mclk_n_o(1)
    );


    --== Reset signals ==--

    vfat2_resb_2_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_resb_o(2),
        i => not vfat2_reset_i
    );

    vfat2_resh_2_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_resh_o(2),
        i => not vfat2_reset_i
    );


    vfat2_resb_0_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_resb_o(0),
        i => not vfat2_reset_i
    );

    vfat2_resh_0_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_resh_o(0),
        i => not vfat2_reset_i
    );


    vfat2_resb_1_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_resb_o(1),
        i => not vfat2_reset_i
    );

    vfat2_resh_1_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_resh_o(1),
        i => not vfat2_reset_i
    );


    --== T1 signals ==--

    vfat2_t1_2_obufds_inst : obufds
    generic map(
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_t1(2),
        o   => vfat2_t1_p_o(2),
        ob   => vfat2_t1_n_o(2)
    );

    vfat2_t1(2) <= not vfat2_t1_i;


    vfat2_t1_0_obufds_inst : obufds
    generic map(
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_t1(0),
        o   => vfat2_t1_p_o(0),
        ob   => vfat2_t1_n_o(0)
    );

    vfat2_t1(0) <= not vfat2_t1_i;


    vfat2_t1_1_obufds_inst : obufds
    generic map(
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_t1(1),
        o   => vfat2_t1_p_o(1),
        ob   => vfat2_t1_n_o(1)
    );

    vfat2_t1(1) <= not vfat2_t1_i;


    --== I2C signals ==--

    vfat2_sda_5_iobuf_inst : iobuf
    generic map (
        drive => 12,
        slew => "slow"
    )
    port map (
        o => vfat2_sda_o(5),
        io => vfat2_sda_io(5),
        i => vfat2_sda_i(5),
        t => vfat2_sda_t(5)
    );

    vfat2_scl_5_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_scl_o(5),
        i => vfat2_scl_i(5)
    );


    vfat2_sda_4_iobuf_inst : iobuf
    generic map (
        drive => 12,
        slew => "slow"
    )
    port map (
        o => vfat2_sda_o(4),
        io => vfat2_sda_io(4),
        i => vfat2_sda_i(4),
        t => vfat2_sda_t(4)
    );

    vfat2_scl_4_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_scl_o(4),
        i => vfat2_scl_i(4)
    );


    vfat2_sda_1_iobuf_inst : iobuf
    generic map (
        drive => 12,
        slew => "slow"
    )
    port map (
        o => vfat2_sda_o(1),
        io => vfat2_sda_io(1),
        i => vfat2_sda_i(1),
        t => vfat2_sda_t(1)
    );

    vfat2_scl_1_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_scl_o(1),
        i => vfat2_scl_i(1)
    );


    vfat2_sda_2_iobuf_inst : iobuf
    generic map (
        drive => 12,
        slew => "slow"
    )
    port map (
        o => vfat2_sda_o(2),
        io => vfat2_sda_io(2),
        i => vfat2_sda_i(2),
        t => vfat2_sda_t(2)
    );

    vfat2_scl_2_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_scl_o(2),
        i => vfat2_scl_i(2)
    );


    vfat2_sda_3_iobuf_inst : iobuf
    generic map (
        drive => 12,
        slew => "slow"
    )
    port map (
        o => vfat2_sda_o(3),
        io => vfat2_sda_io(3),
        i => vfat2_sda_i(3),
        t => vfat2_sda_t(3)
    );

    vfat2_scl_3_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_scl_o(3),
        i => vfat2_scl_i(3)
    );


    vfat2_sda_0_iobuf_inst : iobuf
    generic map (
        drive => 12,
        slew => "slow"
    )
    port map (
        o => vfat2_sda_o(0),
        io => vfat2_sda_io(0),
        i => vfat2_sda_i(0),
        t => vfat2_sda_t(0)
    );

    vfat2_scl_0_obuf_inst : obuf
    generic map(
        drive => 12,
        iostandard => "lvcmos25",
        slew => "slow"
    )
    port map(
        o => vfat2_scl_o(0),
        i => vfat2_scl_i(0)
    );


    --== Data valid signals ==--

    vfat2_data_valid_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_data_valid_p_i(5),
        ib  => vfat2_data_valid_n_i(5),
        o   => vfat2_data_valid(5)
    );

    vfat2_data_valid_o(5) <= not vfat2_data_valid(5);


    vfat2_data_valid_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_data_valid_p_i(4),
        ib  => vfat2_data_valid_n_i(4),
        o   => vfat2_data_valid(4)
    );

    vfat2_data_valid_o(4) <= not vfat2_data_valid(4);


    vfat2_data_valid_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_data_valid_p_i(1),
        ib  => vfat2_data_valid_n_i(1),
        o   => vfat2_data_valid(1)
    );

    vfat2_data_valid_o(1) <= not vfat2_data_valid(1);


    vfat2_data_valid_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_data_valid_p_i(2),
        ib  => vfat2_data_valid_n_i(2),
        o   => vfat2_data_valid(2)
    );

    vfat2_data_valid_o(2) <= not vfat2_data_valid(2);


    vfat2_data_valid_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_data_valid_p_i(3),
        ib  => vfat2_data_valid_n_i(3),
        o   => vfat2_data_valid(3)
    );

    vfat2_data_valid_o(3) <= vfat2_data_valid(3);


    vfat2_data_valid_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_data_valid_p_i(0),
        ib  => vfat2_data_valid_n_i(0),
        o   => vfat2_data_valid(0)
    );

    vfat2_data_valid_o(0) <= vfat2_data_valid(0);


    --== VFAT2 20 signals ==--

    vfat2_20_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(0),
        ib  => vfat2_20_sbits_n_i(0),
        o   => vfat2_20_sbits(0)
    );

    vfat2s_data_o(20).sbits(0) <= vfat2_20_sbits(0);


    vfat2_20_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(1),
        ib  => vfat2_20_sbits_n_i(1),
        o   => vfat2_20_sbits(1)
    );

    vfat2s_data_o(20).sbits(1) <= vfat2_20_sbits(1);


    vfat2_20_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(2),
        ib  => vfat2_20_sbits_n_i(2),
        o   => vfat2_20_sbits(2)
    );

    vfat2s_data_o(20).sbits(2) <= not vfat2_20_sbits(2);


    vfat2_20_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(3),
        ib  => vfat2_20_sbits_n_i(3),
        o   => vfat2_20_sbits(3)
    );

    vfat2s_data_o(20).sbits(3) <= vfat2_20_sbits(3);


    vfat2_20_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(4),
        ib  => vfat2_20_sbits_n_i(4),
        o   => vfat2_20_sbits(4)
    );

    vfat2s_data_o(20).sbits(4) <= vfat2_20_sbits(4);


    vfat2_20_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(5),
        ib  => vfat2_20_sbits_n_i(5),
        o   => vfat2_20_sbits(5)
    );

    vfat2s_data_o(20).sbits(5) <= not vfat2_20_sbits(5);


    vfat2_20_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(6),
        ib  => vfat2_20_sbits_n_i(6),
        o   => vfat2_20_sbits(6)
    );

    vfat2s_data_o(20).sbits(6) <= not vfat2_20_sbits(6);


    vfat2_20_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_sbits_p_i(7),
        ib  => vfat2_20_sbits_n_i(7),
        o   => vfat2_20_sbits(7)
    );

    vfat2s_data_o(20).sbits(7) <= not vfat2_20_sbits(7);


    vfat2_20_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_20_data_out_p_i,
        ib  => vfat2_20_data_out_n_i,
        o   => vfat2_20_data_out
    );

    vfat2s_data_o(20).data_out <= not vfat2_20_data_out;


    --== VFAT2 21 signals ==--

    vfat2_21_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(0),
        ib  => vfat2_21_sbits_n_i(0),
        o   => vfat2_21_sbits(0)
    );

    vfat2s_data_o(21).sbits(0) <= not vfat2_21_sbits(0);


    vfat2_21_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(1),
        ib  => vfat2_21_sbits_n_i(1),
        o   => vfat2_21_sbits(1)
    );

    vfat2s_data_o(21).sbits(1) <= vfat2_21_sbits(1);


    vfat2_21_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(2),
        ib  => vfat2_21_sbits_n_i(2),
        o   => vfat2_21_sbits(2)
    );

    vfat2s_data_o(21).sbits(2) <= vfat2_21_sbits(2);


    vfat2_21_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(3),
        ib  => vfat2_21_sbits_n_i(3),
        o   => vfat2_21_sbits(3)
    );

    vfat2s_data_o(21).sbits(3) <= vfat2_21_sbits(3);


    vfat2_21_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(4),
        ib  => vfat2_21_sbits_n_i(4),
        o   => vfat2_21_sbits(4)
    );

    vfat2s_data_o(21).sbits(4) <= vfat2_21_sbits(4);


    vfat2_21_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(5),
        ib  => vfat2_21_sbits_n_i(5),
        o   => vfat2_21_sbits(5)
    );

    vfat2s_data_o(21).sbits(5) <= vfat2_21_sbits(5);


    vfat2_21_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(6),
        ib  => vfat2_21_sbits_n_i(6),
        o   => vfat2_21_sbits(6)
    );

    vfat2s_data_o(21).sbits(6) <= not vfat2_21_sbits(6);


    vfat2_21_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_sbits_p_i(7),
        ib  => vfat2_21_sbits_n_i(7),
        o   => vfat2_21_sbits(7)
    );

    vfat2s_data_o(21).sbits(7) <= vfat2_21_sbits(7);


    vfat2_21_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_21_data_out_p_i,
        ib  => vfat2_21_data_out_n_i,
        o   => vfat2_21_data_out
    );

    vfat2s_data_o(21).data_out <= not vfat2_21_data_out;


    --== VFAT2 22 signals ==--

    vfat2_22_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(0),
        ib  => vfat2_22_sbits_n_i(0),
        o   => vfat2_22_sbits(0)
    );

    vfat2s_data_o(22).sbits(0) <= not vfat2_22_sbits(0);


    vfat2_22_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(1),
        ib  => vfat2_22_sbits_n_i(1),
        o   => vfat2_22_sbits(1)
    );

    vfat2s_data_o(22).sbits(1) <= vfat2_22_sbits(1);


    vfat2_22_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(2),
        ib  => vfat2_22_sbits_n_i(2),
        o   => vfat2_22_sbits(2)
    );

    vfat2s_data_o(22).sbits(2) <= vfat2_22_sbits(2);


    vfat2_22_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(3),
        ib  => vfat2_22_sbits_n_i(3),
        o   => vfat2_22_sbits(3)
    );

    vfat2s_data_o(22).sbits(3) <= vfat2_22_sbits(3);


    vfat2_22_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(4),
        ib  => vfat2_22_sbits_n_i(4),
        o   => vfat2_22_sbits(4)
    );

    vfat2s_data_o(22).sbits(4) <= vfat2_22_sbits(4);


    vfat2_22_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(5),
        ib  => vfat2_22_sbits_n_i(5),
        o   => vfat2_22_sbits(5)
    );

    vfat2s_data_o(22).sbits(5) <= vfat2_22_sbits(5);


    vfat2_22_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(6),
        ib  => vfat2_22_sbits_n_i(6),
        o   => vfat2_22_sbits(6)
    );

    vfat2s_data_o(22).sbits(6) <= vfat2_22_sbits(6);


    vfat2_22_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_sbits_p_i(7),
        ib  => vfat2_22_sbits_n_i(7),
        o   => vfat2_22_sbits(7)
    );

    vfat2s_data_o(22).sbits(7) <= vfat2_22_sbits(7);


    vfat2_22_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_22_data_out_p_i,
        ib  => vfat2_22_data_out_n_i,
        o   => vfat2_22_data_out
    );

    vfat2s_data_o(22).data_out <= vfat2_22_data_out;


    --== VFAT2 23 signals ==--

    vfat2_23_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(0),
        ib  => vfat2_23_sbits_n_i(0),
        o   => vfat2_23_sbits(0)
    );

    vfat2s_data_o(23).sbits(0) <= vfat2_23_sbits(0);


    vfat2_23_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(1),
        ib  => vfat2_23_sbits_n_i(1),
        o   => vfat2_23_sbits(1)
    );

    vfat2s_data_o(23).sbits(1) <= not vfat2_23_sbits(1);


    vfat2_23_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(2),
        ib  => vfat2_23_sbits_n_i(2),
        o   => vfat2_23_sbits(2)
    );

    vfat2s_data_o(23).sbits(2) <= not vfat2_23_sbits(2);


    vfat2_23_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(3),
        ib  => vfat2_23_sbits_n_i(3),
        o   => vfat2_23_sbits(3)
    );

    vfat2s_data_o(23).sbits(3) <= vfat2_23_sbits(3);


    vfat2_23_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(4),
        ib  => vfat2_23_sbits_n_i(4),
        o   => vfat2_23_sbits(4)
    );

    vfat2s_data_o(23).sbits(4) <= vfat2_23_sbits(4);


    vfat2_23_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(5),
        ib  => vfat2_23_sbits_n_i(5),
        o   => vfat2_23_sbits(5)
    );

    vfat2s_data_o(23).sbits(5) <= not vfat2_23_sbits(5);


    vfat2_23_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(6),
        ib  => vfat2_23_sbits_n_i(6),
        o   => vfat2_23_sbits(6)
    );

    vfat2s_data_o(23).sbits(6) <= vfat2_23_sbits(6);


    vfat2_23_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_sbits_p_i(7),
        ib  => vfat2_23_sbits_n_i(7),
        o   => vfat2_23_sbits(7)
    );

    vfat2s_data_o(23).sbits(7) <= not vfat2_23_sbits(7);


    vfat2_23_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_23_data_out_p_i,
        ib  => vfat2_23_data_out_n_i,
        o   => vfat2_23_data_out
    );

    vfat2s_data_o(23).data_out <= not vfat2_23_data_out;


    --== VFAT2 19 signals ==--

    vfat2_19_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(0),
        ib  => vfat2_19_sbits_n_i(0),
        o   => vfat2_19_sbits(0)
    );

    vfat2s_data_o(19).sbits(0) <= vfat2_19_sbits(0);


    vfat2_19_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(1),
        ib  => vfat2_19_sbits_n_i(1),
        o   => vfat2_19_sbits(1)
    );

    vfat2s_data_o(19).sbits(1) <= vfat2_19_sbits(1);


    vfat2_19_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(2),
        ib  => vfat2_19_sbits_n_i(2),
        o   => vfat2_19_sbits(2)
    );

    vfat2s_data_o(19).sbits(2) <= not vfat2_19_sbits(2);


    vfat2_19_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(3),
        ib  => vfat2_19_sbits_n_i(3),
        o   => vfat2_19_sbits(3)
    );

    vfat2s_data_o(19).sbits(3) <= vfat2_19_sbits(3);


    vfat2_19_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(4),
        ib  => vfat2_19_sbits_n_i(4),
        o   => vfat2_19_sbits(4)
    );

    vfat2s_data_o(19).sbits(4) <= vfat2_19_sbits(4);


    vfat2_19_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(5),
        ib  => vfat2_19_sbits_n_i(5),
        o   => vfat2_19_sbits(5)
    );

    vfat2s_data_o(19).sbits(5) <= vfat2_19_sbits(5);


    vfat2_19_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(6),
        ib  => vfat2_19_sbits_n_i(6),
        o   => vfat2_19_sbits(6)
    );

    vfat2s_data_o(19).sbits(6) <= not vfat2_19_sbits(6);


    vfat2_19_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_sbits_p_i(7),
        ib  => vfat2_19_sbits_n_i(7),
        o   => vfat2_19_sbits(7)
    );

    vfat2s_data_o(19).sbits(7) <= not vfat2_19_sbits(7);


    vfat2_19_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_19_data_out_p_i,
        ib  => vfat2_19_data_out_n_i,
        o   => vfat2_19_data_out
    );

    vfat2s_data_o(19).data_out <= vfat2_19_data_out;


    --== VFAT2 18 signals ==--

    vfat2_18_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(0),
        ib  => vfat2_18_sbits_n_i(0),
        o   => vfat2_18_sbits(0)
    );

    vfat2s_data_o(18).sbits(0) <= not vfat2_18_sbits(0);


    vfat2_18_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(1),
        ib  => vfat2_18_sbits_n_i(1),
        o   => vfat2_18_sbits(1)
    );

    vfat2s_data_o(18).sbits(1) <= vfat2_18_sbits(1);


    vfat2_18_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(2),
        ib  => vfat2_18_sbits_n_i(2),
        o   => vfat2_18_sbits(2)
    );

    vfat2s_data_o(18).sbits(2) <= vfat2_18_sbits(2);


    vfat2_18_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(3),
        ib  => vfat2_18_sbits_n_i(3),
        o   => vfat2_18_sbits(3)
    );

    vfat2s_data_o(18).sbits(3) <= not vfat2_18_sbits(3);


    vfat2_18_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(4),
        ib  => vfat2_18_sbits_n_i(4),
        o   => vfat2_18_sbits(4)
    );

    vfat2s_data_o(18).sbits(4) <= not vfat2_18_sbits(4);


    vfat2_18_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(5),
        ib  => vfat2_18_sbits_n_i(5),
        o   => vfat2_18_sbits(5)
    );

    vfat2s_data_o(18).sbits(5) <= vfat2_18_sbits(5);


    vfat2_18_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(6),
        ib  => vfat2_18_sbits_n_i(6),
        o   => vfat2_18_sbits(6)
    );

    vfat2s_data_o(18).sbits(6) <= not vfat2_18_sbits(6);


    vfat2_18_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_sbits_p_i(7),
        ib  => vfat2_18_sbits_n_i(7),
        o   => vfat2_18_sbits(7)
    );

    vfat2s_data_o(18).sbits(7) <= not vfat2_18_sbits(7);


    vfat2_18_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_18_data_out_p_i,
        ib  => vfat2_18_data_out_n_i,
        o   => vfat2_18_data_out
    );

    vfat2s_data_o(18).data_out <= not vfat2_18_data_out;


    --== VFAT2 17 signals ==--

    vfat2_17_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(0),
        ib  => vfat2_17_sbits_n_i(0),
        o   => vfat2_17_sbits(0)
    );

    vfat2s_data_o(17).sbits(0) <= not vfat2_17_sbits(0);


    vfat2_17_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(1),
        ib  => vfat2_17_sbits_n_i(1),
        o   => vfat2_17_sbits(1)
    );

    vfat2s_data_o(17).sbits(1) <= not vfat2_17_sbits(1);


    vfat2_17_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(2),
        ib  => vfat2_17_sbits_n_i(2),
        o   => vfat2_17_sbits(2)
    );

    vfat2s_data_o(17).sbits(2) <= vfat2_17_sbits(2);


    vfat2_17_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(3),
        ib  => vfat2_17_sbits_n_i(3),
        o   => vfat2_17_sbits(3)
    );

    vfat2s_data_o(17).sbits(3) <= vfat2_17_sbits(3);


    vfat2_17_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(4),
        ib  => vfat2_17_sbits_n_i(4),
        o   => vfat2_17_sbits(4)
    );

    vfat2s_data_o(17).sbits(4) <= vfat2_17_sbits(4);


    vfat2_17_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(5),
        ib  => vfat2_17_sbits_n_i(5),
        o   => vfat2_17_sbits(5)
    );

    vfat2s_data_o(17).sbits(5) <= not vfat2_17_sbits(5);


    vfat2_17_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(6),
        ib  => vfat2_17_sbits_n_i(6),
        o   => vfat2_17_sbits(6)
    );

    vfat2s_data_o(17).sbits(6) <= not vfat2_17_sbits(6);


    vfat2_17_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_sbits_p_i(7),
        ib  => vfat2_17_sbits_n_i(7),
        o   => vfat2_17_sbits(7)
    );

    vfat2s_data_o(17).sbits(7) <= not vfat2_17_sbits(7);


    vfat2_17_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_17_data_out_p_i,
        ib  => vfat2_17_data_out_n_i,
        o   => vfat2_17_data_out
    );

    vfat2s_data_o(17).data_out <= not vfat2_17_data_out;


    --== VFAT2 16 signals ==--

    vfat2_16_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(0),
        ib  => vfat2_16_sbits_n_i(0),
        o   => vfat2_16_sbits(0)
    );

    vfat2s_data_o(16).sbits(0) <= vfat2_16_sbits(0);


    vfat2_16_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(1),
        ib  => vfat2_16_sbits_n_i(1),
        o   => vfat2_16_sbits(1)
    );

    vfat2s_data_o(16).sbits(1) <= vfat2_16_sbits(1);


    vfat2_16_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(2),
        ib  => vfat2_16_sbits_n_i(2),
        o   => vfat2_16_sbits(2)
    );

    vfat2s_data_o(16).sbits(2) <= vfat2_16_sbits(2);


    vfat2_16_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(3),
        ib  => vfat2_16_sbits_n_i(3),
        o   => vfat2_16_sbits(3)
    );

    vfat2s_data_o(16).sbits(3) <= not vfat2_16_sbits(3);


    vfat2_16_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(4),
        ib  => vfat2_16_sbits_n_i(4),
        o   => vfat2_16_sbits(4)
    );

    vfat2s_data_o(16).sbits(4) <= not vfat2_16_sbits(4);


    vfat2_16_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(5),
        ib  => vfat2_16_sbits_n_i(5),
        o   => vfat2_16_sbits(5)
    );

    vfat2s_data_o(16).sbits(5) <= vfat2_16_sbits(5);


    vfat2_16_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(6),
        ib  => vfat2_16_sbits_n_i(6),
        o   => vfat2_16_sbits(6)
    );

    vfat2s_data_o(16).sbits(6) <= vfat2_16_sbits(6);


    vfat2_16_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_sbits_p_i(7),
        ib  => vfat2_16_sbits_n_i(7),
        o   => vfat2_16_sbits(7)
    );

    vfat2s_data_o(16).sbits(7) <= not vfat2_16_sbits(7);


    vfat2_16_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_16_data_out_p_i,
        ib  => vfat2_16_data_out_n_i,
        o   => vfat2_16_data_out
    );

    vfat2s_data_o(16).data_out <= vfat2_16_data_out;


    --== VFAT2 11 signals ==--

    vfat2_11_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(0),
        ib  => vfat2_11_sbits_n_i(0),
        o   => vfat2_11_sbits(0)
    );

    vfat2s_data_o(11).sbits(0) <= not vfat2_11_sbits(0);


    vfat2_11_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(1),
        ib  => vfat2_11_sbits_n_i(1),
        o   => vfat2_11_sbits(1)
    );

    vfat2s_data_o(11).sbits(1) <= vfat2_11_sbits(1);


    vfat2_11_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(2),
        ib  => vfat2_11_sbits_n_i(2),
        o   => vfat2_11_sbits(2)
    );

    vfat2s_data_o(11).sbits(2) <= vfat2_11_sbits(2);


    vfat2_11_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(3),
        ib  => vfat2_11_sbits_n_i(3),
        o   => vfat2_11_sbits(3)
    );

    vfat2s_data_o(11).sbits(3) <= not vfat2_11_sbits(3);


    vfat2_11_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(4),
        ib  => vfat2_11_sbits_n_i(4),
        o   => vfat2_11_sbits(4)
    );

    vfat2s_data_o(11).sbits(4) <= vfat2_11_sbits(4);


    vfat2_11_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(5),
        ib  => vfat2_11_sbits_n_i(5),
        o   => vfat2_11_sbits(5)
    );

    vfat2s_data_o(11).sbits(5) <= vfat2_11_sbits(5);


    vfat2_11_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(6),
        ib  => vfat2_11_sbits_n_i(6),
        o   => vfat2_11_sbits(6)
    );

    vfat2s_data_o(11).sbits(6) <= not vfat2_11_sbits(6);


    vfat2_11_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_sbits_p_i(7),
        ib  => vfat2_11_sbits_n_i(7),
        o   => vfat2_11_sbits(7)
    );

    vfat2s_data_o(11).sbits(7) <= vfat2_11_sbits(7);


    vfat2_11_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_11_data_out_p_i,
        ib  => vfat2_11_data_out_n_i,
        o   => vfat2_11_data_out
    );

    vfat2s_data_o(11).data_out <= vfat2_11_data_out;


    --== VFAT2 12 signals ==--

    vfat2_12_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(0),
        ib  => vfat2_12_sbits_n_i(0),
        o   => vfat2_12_sbits(0)
    );

    vfat2s_data_o(12).sbits(0) <= not vfat2_12_sbits(0);


    vfat2_12_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(1),
        ib  => vfat2_12_sbits_n_i(1),
        o   => vfat2_12_sbits(1)
    );

    vfat2s_data_o(12).sbits(1) <= vfat2_12_sbits(1);


    vfat2_12_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(2),
        ib  => vfat2_12_sbits_n_i(2),
        o   => vfat2_12_sbits(2)
    );

    vfat2s_data_o(12).sbits(2) <= not vfat2_12_sbits(2);


    vfat2_12_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(3),
        ib  => vfat2_12_sbits_n_i(3),
        o   => vfat2_12_sbits(3)
    );

    vfat2s_data_o(12).sbits(3) <= not vfat2_12_sbits(3);


    vfat2_12_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(4),
        ib  => vfat2_12_sbits_n_i(4),
        o   => vfat2_12_sbits(4)
    );

    vfat2s_data_o(12).sbits(4) <= not vfat2_12_sbits(4);


    vfat2_12_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(5),
        ib  => vfat2_12_sbits_n_i(5),
        o   => vfat2_12_sbits(5)
    );

    vfat2s_data_o(12).sbits(5) <= vfat2_12_sbits(5);


    vfat2_12_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(6),
        ib  => vfat2_12_sbits_n_i(6),
        o   => vfat2_12_sbits(6)
    );

    vfat2s_data_o(12).sbits(6) <= vfat2_12_sbits(6);


    vfat2_12_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_sbits_p_i(7),
        ib  => vfat2_12_sbits_n_i(7),
        o   => vfat2_12_sbits(7)
    );

    vfat2s_data_o(12).sbits(7) <= vfat2_12_sbits(7);


    vfat2_12_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_12_data_out_p_i,
        ib  => vfat2_12_data_out_n_i,
        o   => vfat2_12_data_out
    );

    vfat2s_data_o(12).data_out <= vfat2_12_data_out;


    --== VFAT2 10 signals ==--

    vfat2_10_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(0),
        ib  => vfat2_10_sbits_n_i(0),
        o   => vfat2_10_sbits(0)
    );

    vfat2s_data_o(10).sbits(0) <= not vfat2_10_sbits(0);


    vfat2_10_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(1),
        ib  => vfat2_10_sbits_n_i(1),
        o   => vfat2_10_sbits(1)
    );

    vfat2s_data_o(10).sbits(1) <= vfat2_10_sbits(1);


    vfat2_10_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(2),
        ib  => vfat2_10_sbits_n_i(2),
        o   => vfat2_10_sbits(2)
    );

    vfat2s_data_o(10).sbits(2) <= vfat2_10_sbits(2);


    vfat2_10_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(3),
        ib  => vfat2_10_sbits_n_i(3),
        o   => vfat2_10_sbits(3)
    );

    vfat2s_data_o(10).sbits(3) <= not vfat2_10_sbits(3);


    vfat2_10_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(4),
        ib  => vfat2_10_sbits_n_i(4),
        o   => vfat2_10_sbits(4)
    );

    vfat2s_data_o(10).sbits(4) <= vfat2_10_sbits(4);


    vfat2_10_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(5),
        ib  => vfat2_10_sbits_n_i(5),
        o   => vfat2_10_sbits(5)
    );

    vfat2s_data_o(10).sbits(5) <= vfat2_10_sbits(5);


    vfat2_10_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(6),
        ib  => vfat2_10_sbits_n_i(6),
        o   => vfat2_10_sbits(6)
    );

    vfat2s_data_o(10).sbits(6) <= not vfat2_10_sbits(6);


    vfat2_10_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_sbits_p_i(7),
        ib  => vfat2_10_sbits_n_i(7),
        o   => vfat2_10_sbits(7)
    );

    vfat2s_data_o(10).sbits(7) <= vfat2_10_sbits(7);


    vfat2_10_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_10_data_out_p_i,
        ib  => vfat2_10_data_out_n_i,
        o   => vfat2_10_data_out
    );

    vfat2s_data_o(10).data_out <= not vfat2_10_data_out;


    --== VFAT2 13 signals ==--

    vfat2_13_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(0),
        ib  => vfat2_13_sbits_n_i(0),
        o   => vfat2_13_sbits(0)
    );

    vfat2s_data_o(13).sbits(0) <= not vfat2_13_sbits(0);


    vfat2_13_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(1),
        ib  => vfat2_13_sbits_n_i(1),
        o   => vfat2_13_sbits(1)
    );

    vfat2s_data_o(13).sbits(1) <= vfat2_13_sbits(1);


    vfat2_13_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(2),
        ib  => vfat2_13_sbits_n_i(2),
        o   => vfat2_13_sbits(2)
    );

    vfat2s_data_o(13).sbits(2) <= not vfat2_13_sbits(2);


    vfat2_13_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(3),
        ib  => vfat2_13_sbits_n_i(3),
        o   => vfat2_13_sbits(3)
    );

    vfat2s_data_o(13).sbits(3) <= vfat2_13_sbits(3);


    vfat2_13_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(4),
        ib  => vfat2_13_sbits_n_i(4),
        o   => vfat2_13_sbits(4)
    );

    vfat2s_data_o(13).sbits(4) <= not vfat2_13_sbits(4);


    vfat2_13_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(5),
        ib  => vfat2_13_sbits_n_i(5),
        o   => vfat2_13_sbits(5)
    );

    vfat2s_data_o(13).sbits(5) <= not vfat2_13_sbits(5);


    vfat2_13_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(6),
        ib  => vfat2_13_sbits_n_i(6),
        o   => vfat2_13_sbits(6)
    );

    vfat2s_data_o(13).sbits(6) <= not vfat2_13_sbits(6);


    vfat2_13_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_sbits_p_i(7),
        ib  => vfat2_13_sbits_n_i(7),
        o   => vfat2_13_sbits(7)
    );

    vfat2s_data_o(13).sbits(7) <= not vfat2_13_sbits(7);


    vfat2_13_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_13_data_out_p_i,
        ib  => vfat2_13_data_out_n_i,
        o   => vfat2_13_data_out
    );

    vfat2s_data_o(13).data_out <= not vfat2_13_data_out;


    --== VFAT2 9 signals ==--

    vfat2_9_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(0),
        ib  => vfat2_9_sbits_n_i(0),
        o   => vfat2_9_sbits(0)
    );

    vfat2s_data_o(9).sbits(0) <= vfat2_9_sbits(0);


    vfat2_9_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(1),
        ib  => vfat2_9_sbits_n_i(1),
        o   => vfat2_9_sbits(1)
    );

    vfat2s_data_o(9).sbits(1) <= vfat2_9_sbits(1);


    vfat2_9_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(2),
        ib  => vfat2_9_sbits_n_i(2),
        o   => vfat2_9_sbits(2)
    );

    vfat2s_data_o(9).sbits(2) <= not vfat2_9_sbits(2);


    vfat2_9_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(3),
        ib  => vfat2_9_sbits_n_i(3),
        o   => vfat2_9_sbits(3)
    );

    vfat2s_data_o(9).sbits(3) <= not vfat2_9_sbits(3);


    vfat2_9_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(4),
        ib  => vfat2_9_sbits_n_i(4),
        o   => vfat2_9_sbits(4)
    );

    vfat2s_data_o(9).sbits(4) <= not vfat2_9_sbits(4);


    vfat2_9_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(5),
        ib  => vfat2_9_sbits_n_i(5),
        o   => vfat2_9_sbits(5)
    );

    vfat2s_data_o(9).sbits(5) <= vfat2_9_sbits(5);


    vfat2_9_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(6),
        ib  => vfat2_9_sbits_n_i(6),
        o   => vfat2_9_sbits(6)
    );

    vfat2s_data_o(9).sbits(6) <= not vfat2_9_sbits(6);


    vfat2_9_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_sbits_p_i(7),
        ib  => vfat2_9_sbits_n_i(7),
        o   => vfat2_9_sbits(7)
    );

    vfat2s_data_o(9).sbits(7) <= not vfat2_9_sbits(7);


    vfat2_9_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_9_data_out_p_i,
        ib  => vfat2_9_data_out_n_i,
        o   => vfat2_9_data_out
    );

    vfat2s_data_o(9).data_out <= not vfat2_9_data_out;


    --== VFAT2 14 signals ==--

    vfat2_14_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(0),
        ib  => vfat2_14_sbits_n_i(0),
        o   => vfat2_14_sbits(0)
    );

    vfat2s_data_o(14).sbits(0) <= not vfat2_14_sbits(0);


    vfat2_14_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(1),
        ib  => vfat2_14_sbits_n_i(1),
        o   => vfat2_14_sbits(1)
    );

    vfat2s_data_o(14).sbits(1) <= vfat2_14_sbits(1);


    vfat2_14_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(2),
        ib  => vfat2_14_sbits_n_i(2),
        o   => vfat2_14_sbits(2)
    );

    vfat2s_data_o(14).sbits(2) <= not vfat2_14_sbits(2);


    vfat2_14_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(3),
        ib  => vfat2_14_sbits_n_i(3),
        o   => vfat2_14_sbits(3)
    );

    vfat2s_data_o(14).sbits(3) <= not vfat2_14_sbits(3);


    vfat2_14_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(4),
        ib  => vfat2_14_sbits_n_i(4),
        o   => vfat2_14_sbits(4)
    );

    vfat2s_data_o(14).sbits(4) <= not vfat2_14_sbits(4);


    vfat2_14_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(5),
        ib  => vfat2_14_sbits_n_i(5),
        o   => vfat2_14_sbits(5)
    );

    vfat2s_data_o(14).sbits(5) <= vfat2_14_sbits(5);


    vfat2_14_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(6),
        ib  => vfat2_14_sbits_n_i(6),
        o   => vfat2_14_sbits(6)
    );

    vfat2s_data_o(14).sbits(6) <= not vfat2_14_sbits(6);


    vfat2_14_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_sbits_p_i(7),
        ib  => vfat2_14_sbits_n_i(7),
        o   => vfat2_14_sbits(7)
    );

    vfat2s_data_o(14).sbits(7) <= not vfat2_14_sbits(7);


    vfat2_14_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_14_data_out_p_i,
        ib  => vfat2_14_data_out_n_i,
        o   => vfat2_14_data_out
    );

    vfat2s_data_o(14).data_out <= not vfat2_14_data_out;


    --== VFAT2 8 signals ==--

    vfat2_8_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(0),
        ib  => vfat2_8_sbits_n_i(0),
        o   => vfat2_8_sbits(0)
    );

    vfat2s_data_o(8).sbits(0) <= vfat2_8_sbits(0);


    vfat2_8_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(1),
        ib  => vfat2_8_sbits_n_i(1),
        o   => vfat2_8_sbits(1)
    );

    vfat2s_data_o(8).sbits(1) <= vfat2_8_sbits(1);


    vfat2_8_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(2),
        ib  => vfat2_8_sbits_n_i(2),
        o   => vfat2_8_sbits(2)
    );

    vfat2s_data_o(8).sbits(2) <= not vfat2_8_sbits(2);


    vfat2_8_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(3),
        ib  => vfat2_8_sbits_n_i(3),
        o   => vfat2_8_sbits(3)
    );

    vfat2s_data_o(8).sbits(3) <= not vfat2_8_sbits(3);


    vfat2_8_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(4),
        ib  => vfat2_8_sbits_n_i(4),
        o   => vfat2_8_sbits(4)
    );

    vfat2s_data_o(8).sbits(4) <= vfat2_8_sbits(4);


    vfat2_8_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(5),
        ib  => vfat2_8_sbits_n_i(5),
        o   => vfat2_8_sbits(5)
    );

    vfat2s_data_o(8).sbits(5) <= vfat2_8_sbits(5);


    vfat2_8_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(6),
        ib  => vfat2_8_sbits_n_i(6),
        o   => vfat2_8_sbits(6)
    );

    vfat2s_data_o(8).sbits(6) <= not vfat2_8_sbits(6);


    vfat2_8_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_sbits_p_i(7),
        ib  => vfat2_8_sbits_n_i(7),
        o   => vfat2_8_sbits(7)
    );

    vfat2s_data_o(8).sbits(7) <= not vfat2_8_sbits(7);


    vfat2_8_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_8_data_out_p_i,
        ib  => vfat2_8_data_out_n_i,
        o   => vfat2_8_data_out
    );

    vfat2s_data_o(8).data_out <= vfat2_8_data_out;


    --== VFAT2 15 signals ==--

    vfat2_15_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(0),
        ib  => vfat2_15_sbits_n_i(0),
        o   => vfat2_15_sbits(0)
    );

    vfat2s_data_o(15).sbits(0) <= vfat2_15_sbits(0);


    vfat2_15_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(1),
        ib  => vfat2_15_sbits_n_i(1),
        o   => vfat2_15_sbits(1)
    );

    vfat2s_data_o(15).sbits(1) <= vfat2_15_sbits(1);


    vfat2_15_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(2),
        ib  => vfat2_15_sbits_n_i(2),
        o   => vfat2_15_sbits(2)
    );

    vfat2s_data_o(15).sbits(2) <= not vfat2_15_sbits(2);


    vfat2_15_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(3),
        ib  => vfat2_15_sbits_n_i(3),
        o   => vfat2_15_sbits(3)
    );

    vfat2s_data_o(15).sbits(3) <= vfat2_15_sbits(3);


    vfat2_15_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(4),
        ib  => vfat2_15_sbits_n_i(4),
        o   => vfat2_15_sbits(4)
    );

    vfat2s_data_o(15).sbits(4) <= not vfat2_15_sbits(4);


    vfat2_15_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(5),
        ib  => vfat2_15_sbits_n_i(5),
        o   => vfat2_15_sbits(5)
    );

    vfat2s_data_o(15).sbits(5) <= not vfat2_15_sbits(5);


    vfat2_15_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(6),
        ib  => vfat2_15_sbits_n_i(6),
        o   => vfat2_15_sbits(6)
    );

    vfat2s_data_o(15).sbits(6) <= not vfat2_15_sbits(6);


    vfat2_15_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_sbits_p_i(7),
        ib  => vfat2_15_sbits_n_i(7),
        o   => vfat2_15_sbits(7)
    );

    vfat2s_data_o(15).sbits(7) <= vfat2_15_sbits(7);


    vfat2_15_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_15_data_out_p_i,
        ib  => vfat2_15_data_out_n_i,
        o   => vfat2_15_data_out
    );

    vfat2s_data_o(15).data_out <= not vfat2_15_data_out;


    --== VFAT2 7 signals ==--

    vfat2_7_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(0),
        ib  => vfat2_7_sbits_n_i(0),
        o   => vfat2_7_sbits(0)
    );

    vfat2s_data_o(7).sbits(0) <= not vfat2_7_sbits(0);


    vfat2_7_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(1),
        ib  => vfat2_7_sbits_n_i(1),
        o   => vfat2_7_sbits(1)
    );

    vfat2s_data_o(7).sbits(1) <= vfat2_7_sbits(1);


    vfat2_7_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(2),
        ib  => vfat2_7_sbits_n_i(2),
        o   => vfat2_7_sbits(2)
    );

    vfat2s_data_o(7).sbits(2) <= not vfat2_7_sbits(2);


    vfat2_7_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(3),
        ib  => vfat2_7_sbits_n_i(3),
        o   => vfat2_7_sbits(3)
    );

    vfat2s_data_o(7).sbits(3) <= not vfat2_7_sbits(3);


    vfat2_7_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(4),
        ib  => vfat2_7_sbits_n_i(4),
        o   => vfat2_7_sbits(4)
    );

    vfat2s_data_o(7).sbits(4) <= vfat2_7_sbits(4);


    vfat2_7_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(5),
        ib  => vfat2_7_sbits_n_i(5),
        o   => vfat2_7_sbits(5)
    );

    vfat2s_data_o(7).sbits(5) <= not vfat2_7_sbits(5);


    vfat2_7_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(6),
        ib  => vfat2_7_sbits_n_i(6),
        o   => vfat2_7_sbits(6)
    );

    vfat2s_data_o(7).sbits(6) <= not vfat2_7_sbits(6);


    vfat2_7_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_sbits_p_i(7),
        ib  => vfat2_7_sbits_n_i(7),
        o   => vfat2_7_sbits(7)
    );

    vfat2s_data_o(7).sbits(7) <= vfat2_7_sbits(7);


    vfat2_7_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_7_data_out_p_i,
        ib  => vfat2_7_data_out_n_i,
        o   => vfat2_7_data_out
    );

    vfat2s_data_o(7).data_out <= not vfat2_7_data_out;


    --== VFAT2 6 signals ==--

    vfat2_6_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(0),
        ib  => vfat2_6_sbits_n_i(0),
        o   => vfat2_6_sbits(0)
    );

    vfat2s_data_o(6).sbits(0) <= vfat2_6_sbits(0);


    vfat2_6_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(1),
        ib  => vfat2_6_sbits_n_i(1),
        o   => vfat2_6_sbits(1)
    );

    vfat2s_data_o(6).sbits(1) <= not vfat2_6_sbits(1);


    vfat2_6_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(2),
        ib  => vfat2_6_sbits_n_i(2),
        o   => vfat2_6_sbits(2)
    );

    vfat2s_data_o(6).sbits(2) <= not vfat2_6_sbits(2);


    vfat2_6_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(3),
        ib  => vfat2_6_sbits_n_i(3),
        o   => vfat2_6_sbits(3)
    );

    vfat2s_data_o(6).sbits(3) <= not vfat2_6_sbits(3);


    vfat2_6_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(4),
        ib  => vfat2_6_sbits_n_i(4),
        o   => vfat2_6_sbits(4)
    );

    vfat2s_data_o(6).sbits(4) <= vfat2_6_sbits(4);


    vfat2_6_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(5),
        ib  => vfat2_6_sbits_n_i(5),
        o   => vfat2_6_sbits(5)
    );

    vfat2s_data_o(6).sbits(5) <= vfat2_6_sbits(5);


    vfat2_6_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(6),
        ib  => vfat2_6_sbits_n_i(6),
        o   => vfat2_6_sbits(6)
    );

    vfat2s_data_o(6).sbits(6) <= not vfat2_6_sbits(6);


    vfat2_6_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_sbits_p_i(7),
        ib  => vfat2_6_sbits_n_i(7),
        o   => vfat2_6_sbits(7)
    );

    vfat2s_data_o(6).sbits(7) <= not vfat2_6_sbits(7);


    vfat2_6_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_6_data_out_p_i,
        ib  => vfat2_6_data_out_n_i,
        o   => vfat2_6_data_out
    );

    vfat2s_data_o(6).data_out <= not vfat2_6_data_out;


    --== VFAT2 5 signals ==--

    vfat2_5_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(0),
        ib  => vfat2_5_sbits_n_i(0),
        o   => vfat2_5_sbits(0)
    );

    vfat2s_data_o(5).sbits(0) <= vfat2_5_sbits(0);


    vfat2_5_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(1),
        ib  => vfat2_5_sbits_n_i(1),
        o   => vfat2_5_sbits(1)
    );

    vfat2s_data_o(5).sbits(1) <= not vfat2_5_sbits(1);


    vfat2_5_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(2),
        ib  => vfat2_5_sbits_n_i(2),
        o   => vfat2_5_sbits(2)
    );

    vfat2s_data_o(5).sbits(2) <= not vfat2_5_sbits(2);


    vfat2_5_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(3),
        ib  => vfat2_5_sbits_n_i(3),
        o   => vfat2_5_sbits(3)
    );

    vfat2s_data_o(5).sbits(3) <= not vfat2_5_sbits(3);


    vfat2_5_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(4),
        ib  => vfat2_5_sbits_n_i(4),
        o   => vfat2_5_sbits(4)
    );

    vfat2s_data_o(5).sbits(4) <= vfat2_5_sbits(4);


    vfat2_5_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(5),
        ib  => vfat2_5_sbits_n_i(5),
        o   => vfat2_5_sbits(5)
    );

    vfat2s_data_o(5).sbits(5) <= not vfat2_5_sbits(5);


    vfat2_5_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(6),
        ib  => vfat2_5_sbits_n_i(6),
        o   => vfat2_5_sbits(6)
    );

    vfat2s_data_o(5).sbits(6) <= not vfat2_5_sbits(6);


    vfat2_5_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_sbits_p_i(7),
        ib  => vfat2_5_sbits_n_i(7),
        o   => vfat2_5_sbits(7)
    );

    vfat2s_data_o(5).sbits(7) <= vfat2_5_sbits(7);


    vfat2_5_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_5_data_out_p_i,
        ib  => vfat2_5_data_out_n_i,
        o   => vfat2_5_data_out
    );

    vfat2s_data_o(5).data_out <= not vfat2_5_data_out;


    --== VFAT2 4 signals ==--

    vfat2_4_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(0),
        ib  => vfat2_4_sbits_n_i(0),
        o   => vfat2_4_sbits(0)
    );

    vfat2s_data_o(4).sbits(0) <= vfat2_4_sbits(0);


    vfat2_4_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(1),
        ib  => vfat2_4_sbits_n_i(1),
        o   => vfat2_4_sbits(1)
    );

    vfat2s_data_o(4).sbits(1) <= vfat2_4_sbits(1);


    vfat2_4_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(2),
        ib  => vfat2_4_sbits_n_i(2),
        o   => vfat2_4_sbits(2)
    );

    vfat2s_data_o(4).sbits(2) <= not vfat2_4_sbits(2);


    vfat2_4_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(3),
        ib  => vfat2_4_sbits_n_i(3),
        o   => vfat2_4_sbits(3)
    );

    vfat2s_data_o(4).sbits(3) <= vfat2_4_sbits(3);


    vfat2_4_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(4),
        ib  => vfat2_4_sbits_n_i(4),
        o   => vfat2_4_sbits(4)
    );

    vfat2s_data_o(4).sbits(4) <= vfat2_4_sbits(4);


    vfat2_4_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(5),
        ib  => vfat2_4_sbits_n_i(5),
        o   => vfat2_4_sbits(5)
    );

    vfat2s_data_o(4).sbits(5) <= not vfat2_4_sbits(5);


    vfat2_4_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(6),
        ib  => vfat2_4_sbits_n_i(6),
        o   => vfat2_4_sbits(6)
    );

    vfat2s_data_o(4).sbits(6) <= vfat2_4_sbits(6);


    vfat2_4_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_sbits_p_i(7),
        ib  => vfat2_4_sbits_n_i(7),
        o   => vfat2_4_sbits(7)
    );

    vfat2s_data_o(4).sbits(7) <= not vfat2_4_sbits(7);


    vfat2_4_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_4_data_out_p_i,
        ib  => vfat2_4_data_out_n_i,
        o   => vfat2_4_data_out
    );

    vfat2s_data_o(4).data_out <= vfat2_4_data_out;


    --== VFAT2 3 signals ==--

    vfat2_3_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(0),
        ib  => vfat2_3_sbits_n_i(0),
        o   => vfat2_3_sbits(0)
    );

    vfat2s_data_o(3).sbits(0) <= vfat2_3_sbits(0);


    vfat2_3_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(1),
        ib  => vfat2_3_sbits_n_i(1),
        o   => vfat2_3_sbits(1)
    );

    vfat2s_data_o(3).sbits(1) <= vfat2_3_sbits(1);


    vfat2_3_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(2),
        ib  => vfat2_3_sbits_n_i(2),
        o   => vfat2_3_sbits(2)
    );

    vfat2s_data_o(3).sbits(2) <= not vfat2_3_sbits(2);


    vfat2_3_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(3),
        ib  => vfat2_3_sbits_n_i(3),
        o   => vfat2_3_sbits(3)
    );

    vfat2s_data_o(3).sbits(3) <= vfat2_3_sbits(3);


    vfat2_3_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(4),
        ib  => vfat2_3_sbits_n_i(4),
        o   => vfat2_3_sbits(4)
    );

    vfat2s_data_o(3).sbits(4) <= vfat2_3_sbits(4);


    vfat2_3_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(5),
        ib  => vfat2_3_sbits_n_i(5),
        o   => vfat2_3_sbits(5)
    );

    vfat2s_data_o(3).sbits(5) <= vfat2_3_sbits(5);


    vfat2_3_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(6),
        ib  => vfat2_3_sbits_n_i(6),
        o   => vfat2_3_sbits(6)
    );

    vfat2s_data_o(3).sbits(6) <= not vfat2_3_sbits(6);


    vfat2_3_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_sbits_p_i(7),
        ib  => vfat2_3_sbits_n_i(7),
        o   => vfat2_3_sbits(7)
    );

    vfat2s_data_o(3).sbits(7) <= not vfat2_3_sbits(7);


    vfat2_3_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_3_data_out_p_i,
        ib  => vfat2_3_data_out_n_i,
        o   => vfat2_3_data_out
    );

    vfat2s_data_o(3).data_out <= vfat2_3_data_out;


    --== VFAT2 2 signals ==--

    vfat2_2_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(0),
        ib  => vfat2_2_sbits_n_i(0),
        o   => vfat2_2_sbits(0)
    );

    vfat2s_data_o(2).sbits(0) <= not vfat2_2_sbits(0);


    vfat2_2_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(1),
        ib  => vfat2_2_sbits_n_i(1),
        o   => vfat2_2_sbits(1)
    );

    vfat2s_data_o(2).sbits(1) <= vfat2_2_sbits(1);


    vfat2_2_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(2),
        ib  => vfat2_2_sbits_n_i(2),
        o   => vfat2_2_sbits(2)
    );

    vfat2s_data_o(2).sbits(2) <= not vfat2_2_sbits(2);


    vfat2_2_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(3),
        ib  => vfat2_2_sbits_n_i(3),
        o   => vfat2_2_sbits(3)
    );

    vfat2s_data_o(2).sbits(3) <= vfat2_2_sbits(3);


    vfat2_2_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(4),
        ib  => vfat2_2_sbits_n_i(4),
        o   => vfat2_2_sbits(4)
    );

    vfat2s_data_o(2).sbits(4) <= vfat2_2_sbits(4);


    vfat2_2_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(5),
        ib  => vfat2_2_sbits_n_i(5),
        o   => vfat2_2_sbits(5)
    );

    vfat2s_data_o(2).sbits(5) <= not vfat2_2_sbits(5);


    vfat2_2_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(6),
        ib  => vfat2_2_sbits_n_i(6),
        o   => vfat2_2_sbits(6)
    );

    vfat2s_data_o(2).sbits(6) <= vfat2_2_sbits(6);


    vfat2_2_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_sbits_p_i(7),
        ib  => vfat2_2_sbits_n_i(7),
        o   => vfat2_2_sbits(7)
    );

    vfat2s_data_o(2).sbits(7) <= vfat2_2_sbits(7);


    vfat2_2_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_2_data_out_p_i,
        ib  => vfat2_2_data_out_n_i,
        o   => vfat2_2_data_out
    );

    vfat2s_data_o(2).data_out <= vfat2_2_data_out;


    --== VFAT2 1 signals ==--

    vfat2_1_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(0),
        ib  => vfat2_1_sbits_n_i(0),
        o   => vfat2_1_sbits(0)
    );

    vfat2s_data_o(1).sbits(0) <= not vfat2_1_sbits(0);


    vfat2_1_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(1),
        ib  => vfat2_1_sbits_n_i(1),
        o   => vfat2_1_sbits(1)
    );

    vfat2s_data_o(1).sbits(1) <= not vfat2_1_sbits(1);


    vfat2_1_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(2),
        ib  => vfat2_1_sbits_n_i(2),
        o   => vfat2_1_sbits(2)
    );

    vfat2s_data_o(1).sbits(2) <= not vfat2_1_sbits(2);


    vfat2_1_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(3),
        ib  => vfat2_1_sbits_n_i(3),
        o   => vfat2_1_sbits(3)
    );

    vfat2s_data_o(1).sbits(3) <= vfat2_1_sbits(3);


    vfat2_1_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(4),
        ib  => vfat2_1_sbits_n_i(4),
        o   => vfat2_1_sbits(4)
    );

    vfat2s_data_o(1).sbits(4) <= not vfat2_1_sbits(4);


    vfat2_1_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(5),
        ib  => vfat2_1_sbits_n_i(5),
        o   => vfat2_1_sbits(5)
    );

    vfat2s_data_o(1).sbits(5) <= vfat2_1_sbits(5);


    vfat2_1_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(6),
        ib  => vfat2_1_sbits_n_i(6),
        o   => vfat2_1_sbits(6)
    );

    vfat2s_data_o(1).sbits(6) <= vfat2_1_sbits(6);


    vfat2_1_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_sbits_p_i(7),
        ib  => vfat2_1_sbits_n_i(7),
        o   => vfat2_1_sbits(7)
    );

    vfat2s_data_o(1).sbits(7) <= vfat2_1_sbits(7);


    vfat2_1_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_1_data_out_p_i,
        ib  => vfat2_1_data_out_n_i,
        o   => vfat2_1_data_out
    );

    vfat2s_data_o(1).data_out <= vfat2_1_data_out;


    --== VFAT2 0 signals ==--

    vfat2_0_sbit_0_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(0),
        ib  => vfat2_0_sbits_n_i(0),
        o   => vfat2_0_sbits(0)
    );

    vfat2s_data_o(0).sbits(0) <= not vfat2_0_sbits(0);


    vfat2_0_sbit_1_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(1),
        ib  => vfat2_0_sbits_n_i(1),
        o   => vfat2_0_sbits(1)
    );

    vfat2s_data_o(0).sbits(1) <= not vfat2_0_sbits(1);


    vfat2_0_sbit_2_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(2),
        ib  => vfat2_0_sbits_n_i(2),
        o   => vfat2_0_sbits(2)
    );

    vfat2s_data_o(0).sbits(2) <= vfat2_0_sbits(2);


    vfat2_0_sbit_3_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(3),
        ib  => vfat2_0_sbits_n_i(3),
        o   => vfat2_0_sbits(3)
    );

    vfat2s_data_o(0).sbits(3) <= vfat2_0_sbits(3);


    vfat2_0_sbit_4_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(4),
        ib  => vfat2_0_sbits_n_i(4),
        o   => vfat2_0_sbits(4)
    );

    vfat2s_data_o(0).sbits(4) <= not vfat2_0_sbits(4);


    vfat2_0_sbit_5_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(5),
        ib  => vfat2_0_sbits_n_i(5),
        o   => vfat2_0_sbits(5)
    );

    vfat2s_data_o(0).sbits(5) <= not vfat2_0_sbits(5);


    vfat2_0_sbit_6_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(6),
        ib  => vfat2_0_sbits_n_i(6),
        o   => vfat2_0_sbits(6)
    );

    vfat2s_data_o(0).sbits(6) <= not vfat2_0_sbits(6);


    vfat2_0_sbit_7_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_sbits_p_i(7),
        ib  => vfat2_0_sbits_n_i(7),
        o   => vfat2_0_sbits(7)
    );

    vfat2s_data_o(0).sbits(7) <= not vfat2_0_sbits(7);


    vfat2_0_data_out_ibufds_inst : ibufds
    generic map(
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map(
        i   => vfat2_0_data_out_p_i,
        ib  => vfat2_0_data_out_n_i,
        o   => vfat2_0_data_out
    );

    vfat2s_data_o(0).data_out <= vfat2_0_data_out;


end Behavioral;
