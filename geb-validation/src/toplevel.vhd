library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity toplevel is
port(

    clk_40MHz_i             : in std_logic;
    
    leds_o                  : out std_logic_vector(3 downto 0);
    sws_i                   : in std_logic_vector(1 downto 0);
    
    dac_sync_o              : out std_logic;
    dac_sclk_o              : out std_logic;
    dac_data_o              : out std_logic;
    
    adc_scl_o               : out std_logic;
    adc_sda_io              : inout std_logic;
    adc_rdy_i               : in std_logic;
    
    fpga_io                 : in std_logic_vector(20 downto 0);
    
    vfat2_sbits_p_i         : in std_logic_vector(7 downto 0);
    vfat2_sbits_n_i         : in std_logic_vector(7 downto 0);

    vfat2_data_out_p_i      : in std_logic;
    vfat2_data_out_n_i      : in std_logic;

    vfat2_data_valid_p_i    : in std_logic;
    vfat2_data_valid_n_i    : in std_logic;

    vfat2_t1_p_i            : in std_logic;
    vfat2_t1_n_i            : in std_logic;

    vfat2_mclk_p_i          : in std_logic;
    vfat2_mclk_n_i          : in std_logic;

    vfat2_rehb_i            : in std_logic;
    vfat2_resb_i            : in std_logic;

    vfat2_sda_i             : in std_logic;
    vfat2_scl_i             : in std_logic;

    vfat2_chipaddr_i        : in std_logic_vector(2 downto 0);
    
    usb_miso_i              : in std_logic;
    usb_mosi_o              : out std_logic;
    usb_miosi_o             : out std_logic_vector(2 downto 0);
    usb_csb_o               : out std_logic;
    usb_sclk_o              : out std_logic
    
);
end toplevel;

architecture Behavioral of toplevel is

    signal clk_40MHz        : std_logic;
    signal leds             : std_logic_vector(3 downto 0);
    signal sws              : std_logic_vector(1 downto 0);
    signal dac_sync         : std_logic;
    signal dac_sclk         : std_logic;
    signal dac_data         : std_logic;
    signal adc_scl          : std_logic;
    signal adc_sda_miso     : std_logic;
    signal adc_sda_mosi     : std_logic;
    signal adc_sda_tri      : std_logic;
    signal adc_rdy          : std_logic;
    signal fpga             : std_logic_vector(20 downto 0);
    signal vfat2_sbits      : std_logic_vector(7 downto 0);
    signal vfat2_data_out   : std_logic;
    signal vfat2_data_valid : std_logic;
    signal vfat2_t1         : std_logic;
    signal vfat2_mclk       : std_logic;
    signal vfat2_rehb       : std_logic;
    signal vfat2_resb       : std_logic;
    signal vfat2_sda        : std_logic;
    signal vfat2_scl        : std_logic;
    signal vfat2_chipaddr   : std_logic_vector(2 downto 0);
    signal usb_miso         : std_logic;
    signal usb_mosi         : std_logic;
    signal usb_miosi        : std_logic_vector(2 downto 0);
    signal usb_csb          : std_logic;
    signal usb_sclk         : std_logic;

begin

    process(clk_40MHz)
        variable cnt : integer range 0 to 40_000_000;
    begin
        if (rising_edge(clk_40MHz)) then
            if (cnt = 10_000_000) then
                leds <= "1000";
                cnt := cnt + 1;
            elsif (cnt = 20_000_000) then
                leds <= "0100";
                cnt := cnt + 1;
            elsif (cnt = 30_000_000) then
                leds <= "0010";
                cnt := cnt + 1;
            elsif (cnt = 40_000_000) then
                leds <= "0001";
                cnt := 0;
            else
                cnt := cnt + 1;
            end if;
        end if;
    end process;

    --===================--
    --== VFAT2 buffers ==--
    --===================--

	buffers_inst : entity work.buffers PORT MAP(
        --
		clk_40MHz_i             => clk_40MHz_i,
		leds_o                  => leds_o,
		sws_i                   => sws_i,
		dac_sync_o              => dac_sync_o,
		dac_sclk_o              => dac_sclk_o,
		dac_data_o              => dac_data_o,
		adc_scl_o               => adc_scl_o,
		adc_sda_io              => adc_sda_io,
		adc_rdy_i               => adc_rdy_i,
		fpga_io                 => fpga_io,
		vfat2_sbits_p_i         => vfat2_sbits_p_i,
		vfat2_sbits_n_i         => vfat2_sbits_n_i,
		vfat2_data_out_p_i      => vfat2_data_out_p_i,
		vfat2_data_out_n_i      => vfat2_data_out_n_i,
		vfat2_data_valid_p_i    => vfat2_data_valid_p_i,
		vfat2_data_valid_n_i    => vfat2_data_valid_n_i,
		vfat2_t1_p_i            => vfat2_t1_p_i,
		vfat2_t1_n_i            => vfat2_t1_n_i,
		vfat2_mclk_p_i          => vfat2_mclk_p_i,
		vfat2_mclk_n_i          => vfat2_mclk_n_i,
		vfat2_rehb_i            => vfat2_rehb_i,
		vfat2_resb_i            => vfat2_resb_i,
		vfat2_sda_i             => vfat2_sda_i,
		vfat2_scl_i             => vfat2_scl_i,
		vfat2_chipaddr_i        => vfat2_chipaddr_i,
		usb_miso_i              => usb_miso_i,
		usb_mosi_o              => usb_mosi_o,
        usb_miosi_o             => usb_miosi_o,
		usb_csb_o               => usb_csb_o,
		usb_sclk_o              => usb_sclk_o,
        --
		clk_40MHz_o             => clk_40MHz,
		leds_i                  => leds,
		sws_o                   => sws,
		dac_sync_i              => dac_sync,
		dac_sclk_i              => dac_sclk,
		dac_data_i              => dac_data,
		adc_scl_i               => adc_scl,
		adc_sda_miso_o          => adc_sda_miso,
		adc_sda_mosi_i          => adc_sda_mosi,
		adc_sda_tri_i           => adc_sda_tri,
		adc_rdy_o               => adc_rdy,
		fpga_o                  => fpga,
		vfat2_sbits_o           => vfat2_sbits,
		vfat2_data_out_o        => vfat2_data_out,
		vfat2_data_valid_o      => vfat2_data_valid,
		vfat2_t1_o              => vfat2_t1,
		vfat2_mclk_o            => vfat2_mclk,
		vfat2_rehb_o            => vfat2_rehb,
		vfat2_resb_o            => vfat2_resb,
		vfat2_sda_o             => vfat2_sda,
		vfat2_scl_o             => vfat2_scl,
		vfat2_chipaddr_o        => vfat2_chipaddr,
		usb_miso_o              => usb_miso,
		usb_mosi_i              => usb_mosi,
        usb_miosi_i             => usb_miosi,
		usb_csb_i               => usb_csb,
		usb_sclk_i              => usb_sclk 
	);
    
end Behavioral;

