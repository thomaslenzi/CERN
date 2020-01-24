library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity buffers is
port(

    --== Raw ==--

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
    usb_sclk_o              : out std_logic;
    
    --== Buffered ==--
    
    clk_40MHz_o             : out std_logic;
    
    leds_i                  : in std_logic_vector(3 downto 0);
    sws_o                   : out std_logic_vector(1 downto 0);
    
    dac_sync_i              : in std_logic;
    dac_sclk_i              : in std_logic;
    dac_data_i              : in std_logic;
    
    adc_scl_i               : in std_logic;
    adc_sda_miso_o          : out std_logic;
    adc_sda_mosi_i          : in std_logic;
    adc_sda_tri_i           : in std_logic;
    adc_rdy_o               : out std_logic;
    
    fpga_o                  : out std_logic_vector(20 downto 0);
    
    vfat2_sbits_o           : out std_logic_vector(7 downto 0);
    vfat2_data_out_o        : out std_logic;
    vfat2_data_valid_o      : out std_logic;
    vfat2_t1_o              : out std_logic;
    vfat2_mclk_o            : out std_logic;
    vfat2_rehb_o            : out std_logic;
    vfat2_resb_o            : out std_logic;
    vfat2_sda_o             : out std_logic;
    vfat2_scl_o             : out std_logic;
    vfat2_chipaddr_o        : out std_logic_vector(2 downto 0);
    
    usb_miso_o              : out std_logic;
    usb_mosi_i              : in std_logic;
    usb_miosi_i             : in std_logic_vector(2 downto 0);
    usb_csb_i               : in std_logic;
    usb_sclk_i              : in std_logic    

);
end buffers;

architecture Behavioral of buffers is
begin

    clk_40MHz_ibufg : ibufg port map(i => clk_40MHz_i, o => clk_40MHz_o);
    
    leds_0_obuf : obuf port map(i => leds_i(0), o => leds_o(0));
    leds_1_obuf : obuf port map(i => leds_i(1), o => leds_o(1));
    leds_2_obuf : obuf port map(i => leds_i(2), o => leds_o(2));
    leds_3_obuf : obuf port map(i => leds_i(3), o => leds_o(3));
    
    sws_0_ibuf : ibuf port map(i => sws_i(0), o => sws_o(0));
    sws_1_ibuf : ibuf port map(i => sws_i(1), o => sws_o(1));
    
    dac_sync_obuf : obuf port map(i => dac_sync_i, o => dac_sync_o);
    dac_sclk_obuf : obuf port map(i => dac_sclk_i, o => dac_sclk_o);    
    dac_data_obuf : obuf port map(i => dac_data_i, o => dac_data_o);

    adc_scl_obuf : obuf port map(i => adc_scl_i, o => adc_scl_o);    
    adc_sda_iobuf : iobuf port map (o => adc_sda_miso_o, io => adc_sda_io, i => adc_sda_mosi_i, t => adc_sda_tri_i);
    adc_rdy_ibuf : ibuf port map(i => adc_rdy_i, o => adc_rdy_o);

    fpga_ibuf_gen : for I in 0 to 20 generate
    begin
        fpga_ibuf : ibuf port map(i => fpga_io(I), o => fpga_o(I));
    end generate;
    
    vfat2_sbits_ibufds_gen : for I in 0 to 7 generate
    begin
        vfat2_sbits_ibufds : ibufds port map(i => vfat2_sbits_p_i(I), ib => vfat2_sbits_n_i(I), o => vfat2_sbits_o(I));
    end generate;    
    
    vfat2_data_out_ibufds : ibufds port map(i => vfat2_data_out_p_i, ib => vfat2_data_out_n_i, o => vfat2_data_out_o);
    vfat2_data_valid_ibufds : ibufds port map(i => vfat2_data_valid_p_i, ib => vfat2_data_valid_n_i, o => vfat2_data_valid_o);
    vfat2_t1_ibufds : ibufds port map(i => vfat2_t1_p_i, ib => vfat2_t1_n_i, o => vfat2_t1_o);
    vfat2_mclk_ibufgds : ibufgds port map(i => vfat2_mclk_p_i, ib => vfat2_mclk_n_i, o => vfat2_mclk_o);
    vfat2_rehb_ibuf : ibuf port map(i => vfat2_rehb_i, o => vfat2_rehb_o);
    vfat2_resb_ibuf : ibuf port map(i => vfat2_resb_i, o => vfat2_resb_o);
    vfat2_sda_ibuf : ibuf port map(i => vfat2_sda_i, o => vfat2_sda_o);
    vfat2_scl_ibuf : ibuf port map(i => vfat2_scl_i, o => vfat2_scl_o);
    vfat2_chipaddr_0_ibuf : ibuf port map(i => vfat2_chipaddr_i(0), o => vfat2_chipaddr_o(0));
    vfat2_chipaddr_1_ibuf : ibuf port map(i => vfat2_chipaddr_i(1), o => vfat2_chipaddr_o(1));
    vfat2_chipaddr_2_ibuf : ibuf port map(i => vfat2_chipaddr_i(2), o => vfat2_chipaddr_o(2));
      
    usb_miso_ibuf : ibuf port map(i => usb_miso_i, o => usb_miso_o);
    usb_mosi_obuf : obuf port map(i => usb_mosi_i, o => usb_mosi_o);      
    usb_miosi_0_obuf : obuf port map(i => usb_miosi_i(0), o => usb_miosi_o(0));      
    usb_miosi_1_obuf : obuf port map(i => usb_miosi_i(1), o => usb_miosi_o(1));      
    usb_miosi_2_obuf : obuf port map(i => usb_miosi_i(2), o => usb_miosi_o(2));      
    usb_csb_obuf : obuf port map(i => usb_csb_i, o => usb_csb_o); 
    usb_sclk_obuf : obuf port map(i => usb_sclk_i, o => usb_sclk_o);   

end Behavioral;
