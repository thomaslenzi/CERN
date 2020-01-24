--=================================================================================================--
--##################################   Module Information   #######################################--
--=================================================================================================--
--                                                                                         
-- Company:               CERN (PH-ESE-BE)                                                         
-- Engineer:              Manoel Barros Marin (manoel.barros.marin@cern.ch) (m.barros.marin@ieee.org)
--                                                                                                 
-- Project Name:          GBT-FPGA                                                                
-- Module Name:           GBT TX gearbox latency-optimized
--                                                                                                 
-- Language:              VHDL'93                                                              
--                                                                                                   
-- Target Device:         Vendor agnostic                                                
-- Tool version:                                                                        
--                                                                                                   
-- Version:               3.0                                                                      
--
-- Description:            
--
-- Versions history:      DATE         VERSION   AUTHOR                               DESCRIPTION
--    
--                        10/05/2009   0.1       F. Marin (CPPM)                      First .bdf entity definition.           
--                                                                   
--                        08/07/2009   0.2       S. Baron (CERN)                      Translate from .bdf to .vhd.
--
--                        02/11/2010   0.3       S. Muschter (Stockholm University)   Optimization to low latency.
--
--                        26/11/2013   3.0       M. Barros Marin                      - Cosmetic and minor modifications.   
--                                                                                    - Support for 20bit and 40bit words. 
--
-- Additional Comments:  
--
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!                                                                                           !!
-- !! * The different parameters of the GBT Bank are set through:                               !!  
-- !!   (Note!! These parameters are vendor specific)                                           !!                    
-- !!                                                                                           !!
-- !!   - The MGT control ports of the GBT Bank module (these ports are listed in the records   !!
-- !!     of the file "<vendor>_<device>_gbt_bank_package.vhd").                                !! 
-- !!     (e.g. xlx_v6_gbt_bank_package.vhd)                                                    !!
-- !!                                                                                           !!  
-- !!   - By modifying the content of the file "<vendor>_<device>_gbt_bank_user_setup.vhd".     !!
-- !!     (e.g. xlx_v6_gbt_bank_user_setup.vhd)                                                 !! 
-- !!                                                                                           !! 
-- !! * The "<vendor>_<device>_gbt_bank_user_setup.vhd" is the only file of the GBT Bank that   !!
-- !!   may be modified by the user. The rest of the files MUST be used as is.                  !!
-- !!                                                                                           !!  
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--                                                                                                   
--=================================================================================================--
--#################################################################################################--
--=================================================================================================--

-- IEEE VHDL standard library:
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Custom libraries and packages:
use work.vendor_specific_gbt_bank_package.all;

--=================================================================================================--
--#######################################   Entity   ##############################################--
--=================================================================================================--

entity gbt_tx_gearbox_latopt is
   port (
  
      --================--
      -- Reset & Clocks --
      --================--    
      
      -- Reset:
      ---------
      
      TX_RESET_I                                : in  std_logic;
  
      -- Clocks:
      ----------
      
      TX_WORDCLK_I                              : in  std_logic;
      TX_FRAMECLK_I                             : in  std_logic;
      
      --==============--
      -- Frame & Word --
      --==============--
      
      TX_FRAME_I                                : in  std_logic_vector(119 downto 0);
      TX_WORD_O                                 : out std_logic_vector(WORD_WIDTH-1 downto 0)
   
   );
end gbt_tx_gearbox_latopt;

--=================================================================================================--
--####################################   Architecture   ###########################################-- 
--=================================================================================================--

architecture behavioral of gbt_tx_gearbox_latopt is

   --================================ Signal Declarations ================================--

   signal txFrame_from_frameInverter            : std_logic_vector (119 downto 0);
   signal gearboxSyncReset                      : std_logic;  
  
   --=====================================================================================--  

--=================================================================================================--
begin                 --========####   Architecture Body   ####========-- 
--=================================================================================================--  
   
   --==================================== User Logic =====================================--   
   
   --==============--
   -- Common logic --
   --==============--
   
   -- Comment: Bits are inverted to transmit the MSB first on the MGT.
   
   frameInverter: for i in 119 downto 0 generate
      txFrame_from_frameInverter(i)             <= TX_FRAME_I(119-i);
   end generate;
   
   -- Comment: Note!! The reset of the gearbox is synchronous to TX_FRAMECLK in order to align the address 0 
   --                 of the gearbox with the rising edge of TX_FRAMECLK after reset.
   
   syncReset: process(TX_RESET_I, TX_FRAMECLK_I)
   begin
      if TX_RESET_I = '1' then
         gearboxSyncReset                       <= '1';
      elsif rising_edge(TX_FRAMECLK_I) then
         gearboxSyncReset                       <= '0';
      end if;
   end process;
   
   --=====================--
   -- Word width (20 Bit) --
   --=====================--
   
   gbLatOpt20b_gen: if WORD_WIDTH = 20 generate   

      gbLatOpt20b: process(gearboxSyncReset, TX_WORDCLK_I)
         variable address                       : integer range 0 to 5;
      begin
         if gearboxSyncReset = '1' then
            TX_WORD_O                           <= (others => '0');
            address                             := 0;
         elsif rising_edge(TX_WORDCLK_I) then
            case address is
               when 0 =>
                  TX_WORD_O                     <= txFrame_from_frameInverter( 19 downto   0);
                  address                       := 1;
               when 1 => 
                  TX_WORD_O                     <= txFrame_from_frameInverter( 39 downto  20);
                  address                       := 2;
               when 2 =>                 
                  TX_WORD_O                     <= txFrame_from_frameInverter( 59 downto  40);
                  address                       := 3;
               when 3 =>                 
                  TX_WORD_O                     <= txFrame_from_frameInverter( 79 downto  60);
                  address                       := 4;
               when 4 =>                 
                  TX_WORD_O                     <= txFrame_from_frameInverter( 99 downto  80);
                  address                       := 5;
               when 5 =>                 
                  TX_WORD_O                     <= txFrame_from_frameInverter(119 downto 100);
                  address                       := 0;
               when others =>
                  null;
            end case;
         end if;
      end process;

   end generate;  
  
   --=====================--
   -- Word width (40 Bit) --
   --=====================--
   
   gbLatOpt40b_gen: if WORD_WIDTH = 40 generate   

      gbLatOpt40b: process(gearboxSyncReset, TX_WORDCLK_I)
         variable address                       : integer range 0 to 2;
      begin
         if gearboxSyncReset = '1' then
            TX_WORD_O                           <= (others => '0');
            address                             := 0;
         elsif rising_edge(TX_WORDCLK_I) then
            case address is
               when 0 =>
                  TX_WORD_O                     <= txFrame_from_frameInverter( 39 downto   0);
                  address                       := 1;
               when 1 => 
                  TX_WORD_O                     <= txFrame_from_frameInverter( 79 downto  40);
                  address                       :=2;
               when 2 =>                 
                  TX_WORD_O                     <= txFrame_from_frameInverter(119 downto  80);
                  address                       := 0;              
               when others =>
                  null;
            end case;
         end if;
      end process;

   end generate;  
   
   --=====================================================================================--
end behavioral;
--=================================================================================================--
--#################################################################################################--
--=================================================================================================--