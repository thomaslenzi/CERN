--=================================================================================================--
--##################################   Module Information   #######################################--
--=================================================================================================--
--                                                                                         
-- Company:               CERN (PH-ESE-BE)                                                         
-- Engineer:              Manoel Barros Marin (manoel.barros.marin@cern.ch) (m.barros.marin@ieee.org)
--                                                                                                 
-- Project Name:          GBT-FPGA                                                                
-- Module Name:           GBT TX gearbox          
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
-- Versions history:      DATE         VERSION   AUTHOR            DESCRIPTION
--                                                                  
--                        04/11/2013   3.0       M. Barros Marin   First .vhd module definition. 
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
use work.gbt_banks_user_setup.all;

--=================================================================================================--
--#######################################   Entity   ##############################################--
--=================================================================================================--

entity gbt_tx_gearbox is
   generic (   
      GBT_BANK_ID                               : integer := 1   
   );
   port (
      
      --================--
      -- Reset & Clocks --
      --================--    
      
      -- Reset:
      ---------
      
      TX_RESET_I                                : in  std_logic;
      
      -- Clocks:
      ----------
      
      TX_FRAMECLK_I                             : in  std_logic; 
      TX_WORDCLK_I                              : in  std_logic;
      
      --==============--
      -- Frame & Word --
      --==============--
      
      TX_FRAME_I                                : in  std_logic_vector(119 downto 0);
      TX_WORD_O                                 : out std_logic_vector(WORD_WIDTH-1 downto 0)
      
   );
end gbt_tx_gearbox;

--=================================================================================================--
--####################################   Architecture   ###########################################-- 
--=================================================================================================--

architecture structural of gbt_tx_gearbox is  

--=================================================================================================--
begin                 --========####   Architecture Body   ####========-- 
--=================================================================================================--  

   --==================================== User Logic =====================================--
   
   --==========--
   -- Standard --
   --==========--
   
   txGearboxStd_gen: if GBT_BANKS_USER_SETUP(GBT_BANK_ID).TX_OPTIMIZATION = STANDARD generate
   
      txGearboxStd: entity work.gbt_tx_gearbox_std
         port map (
            TX_RESET_I                          => TX_RESET_I,   
            TX_FRAMECLK_I                       => TX_FRAMECLK_I,      
            TX_WORDCLK_I                        => TX_WORDCLK_I,   
            ------------------------------------
            TX_FRAME_I                          => TX_FRAME_I,    
            TX_WORD_O                           => TX_WORD_O      
         );
   
   end generate;
   
   --===================--
   -- Latency-optimized --
   --===================--
   
   txGearboxLatOpt_gen: if GBT_BANKS_USER_SETUP(GBT_BANK_ID).TX_OPTIMIZATION = LATENCY_OPTIMIZED generate   
   
      txGearboxLatOpt: entity work.gbt_tx_gearbox_latopt
         port map (
            TX_RESET_I                          => TX_RESET_I,   
            TX_FRAMECLK_I                       => TX_FRAMECLK_I,      
            TX_WORDCLK_I                        => TX_WORDCLK_I,   
            ------------------------------------
            TX_FRAME_I                          => TX_FRAME_I,    
            TX_WORD_O                           => TX_WORD_O      
         );
   
   end generate;  
   
   --=====================================================================================--     
end structural;
--=================================================================================================--
--#################################################################################################--
--=================================================================================================--