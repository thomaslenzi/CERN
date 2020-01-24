--=================================================================================================--
--##################################   Package Information   ######################################--
--=================================================================================================--
--                                                                                         
-- Company:               CERN (PH-ESE-BE)                                                         
-- Engineer:              Manoel Barros Marin (manoel.barros.marin@cern.ch) (m.barros.marin@ieee.org)
--                                                                                                 
-- Project Name:          GBT-FPGA                                                                
-- Module Name:           Xilinx Virtex 6 - Multi Gigabit Transceivers standard
--                                                                                                 
-- Language:              VHDL'93                                                                 
--                                                                                                   
-- Target Device:         Xilinx Virtex 6                                                         
-- Tool version:          ISE 14.5                                                               
--                                                                                                   
-- Revision:              3.0                                                                      
--
-- Description:           
--
-- Versions history:      DATE         VERSION   AUTHOR            DESCRIPTION
--
--                        20/06/2013   3.0       M. Barros Marin   First .vhd module definition           
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

-- Xilinx devices library:
library unisim;
use unisim.vcomponents.all;

-- Custom libraries and packages:
use work.gbt_bank_package.all;
use work.vendor_specific_gbt_bank_package.all;
use work.gbt_banks_user_setup.all;

--=================================================================================================--
--#######################################   Entity   ##############################################--
--=================================================================================================--

entity mgt_std is  
   generic (   
      GBT_BANK_ID                               : integer := 1   
   );
   port (
   
      --===============--
      -- Clocks scheme --
      --===============--      
      
      MGT_CLKS_I                                : in  gbtBankMgtClks_i_R;         
      MGT_CLKS_O                                : out gbtBankMgtClks_o_R;        
        
      --=========--
      -- MGT I/O --
      --=========--
      
      MGT_I                                     : in  mgt_i_R;
      MGT_O                                     : out mgt_o_R;
      
      --=============--
      -- GBT Control --
      --=============--
      
      GBT_RX_MGT_RDY_O                          : out std_logic_vector    (1 to GBT_BANKS_USER_SETUP(GBT_BANK_ID).NUM_LINKS);
      GBT_RX_RXWORDCLK_READY_O                  : out std_logic_vector    (1 to GBT_BANKS_USER_SETUP(GBT_BANK_ID).NUM_LINKS);
    
      --=======-- 
      -- Words -- 
      --=======-- 
      
      GBT_TX_WORD_I                             : in  word_mxnbit_A       (1 to GBT_BANKS_USER_SETUP(GBT_BANK_ID).NUM_LINKS);     
      GBT_RX_WORD_O                             : out word_mxnbit_A       (1 to GBT_BANKS_USER_SETUP(GBT_BANK_ID).NUM_LINKS)     

   );
end mgt_std;

--=================================================================================================--
--####################################   Architecture   ###########################################-- 
--=================================================================================================--

architecture structural of mgt_std is    
   
   --================================ Signal Declarations ================================--   
   
   --=================--                                                 
   -- GTX transceiver --                                                 
   --=================--                                                 

   signal resetDoneTx_from_stdGtx               : std_logic_vector       (1 to GBT_BANKS_USER_SETUP(GBT_BANK_ID).NUM_LINKS); 
   signal resetDoneRx_from_stdGtx               : std_logic_vector       (1 to GBT_BANKS_USER_SETUP(GBT_BANK_ID).NUM_LINKS);    
 
   --=====================================================================================--      

--=================================================================================================--
begin                 --========####   Architecture Body   ####========-- 
--=================================================================================================--
  
   --==================================== User Logic =====================================--
   
   gtxStd_gen: for i in 1 to GBT_BANKS_USER_SETUP(GBT_BANK_ID).NUM_LINKS generate
   
      --=============--
      -- Assignments --
      --=============--
      
      -- Comment: Note!! The standard version of the GTX does not align the phase of the  
      --                  RX_RECCLK (RX_WORDCLK) with respect to the TX_OUTCLK (TX_WORDCLK).
      
      MGT_O.mgtLink(i).rxWordClkReady           <= '0';
      GBT_RX_RXWORDCLK_READY_O(i)               <= '0';      
      MGT_O.mgtLink(i).tx_resetDone             <= resetDoneTx_from_stdGtx(i);
      MGT_O.mgtLink(i).rx_resetDone             <= resetDoneRx_from_stdGtx(i);
      MGT_O.mgtLink(i).ready                    <= resetDoneTx_from_stdGtx(i) and resetDoneRx_from_stdGtx(i);
      GBT_RX_MGT_RDY_O(i)                       <= resetDoneRx_from_stdGtx(i);         
   
      --=======================================--
      -- Multi-Gigabit Transceivers (standard) --
      --=======================================--
      
      gtxStd: entity work.xlx_v6_gtx_std
         generic map (
            GBT_BANK_ID                         => GBT_BANK_ID)
         port map (  
            ------------------------------------                                                   
            LOOPBACK_IN                         => MGT_I.mgtLink(i).loopBack,
            ------------------------------------                                                   
            PRBSCNTRESET_IN                     => MGT_I.mgtLink(i).prbs_errCntRst,                              
            RXENPRBSTST_IN                      => MGT_I.mgtLink(i).prbs_rxEn,                              
            RXPRBSERR_OUT                       => MGT_O.mgtLink(i).prbs_rxErr,                                
            ------------------------------------                                                   
            RXDATA_OUT                          => GBT_RX_WORD_O(i),                                   
            RXRECCLK_OUT                        => MGT_CLKS_O.rx_wordClk_noBuff(i),                               
            RXUSRCLK2_IN                        => MGT_CLKS_I.rx_wordclk(i),                                 
            ------------------------------------                                                   
            RXEQMIX_IN                          => MGT_I.mgtLink(i).conf_eqMix,                                  
            RXN_IN                              => MGT_I.mgtLink(i).rx_n,                                      
            RXP_IN                              => MGT_I.mgtLink(i).rx_p,                                      
            ------------------------------------                                                   
            GTXRXRESET_IN                       => MGT_I.mgtLink(i).rx_reset,                                  
            MGTREFCLKRX_IN                      => ('0' & MGT_CLKS_I.rx_refClk),                     
            PLLRXRESET_IN                       => '0',                              
            RXPLLLKDET_OUT                      => MGT_O.mgtLink(i).rx_pllLkDet,                               
            RXRESETDONE_OUT                     => resetDoneRx_from_stdGtx(i),                              
            ------------------------------------                                                   
            RXPOLARITY_IN                       => MGT_I.mgtLink(i).conf_rxPol,                               
            ------------------------------------                                                   
            DADDR_IN                            => MGT_I.mgtLink(i).drp_dAddr,                                     
            DCLK_IN                             => MGT_I.mgtLink(i).drp_dClk,                                    
            DEN_IN                              => MGT_I.mgtLink(i).drp_dEn,                                       
            DI_IN                               => MGT_I.mgtLink(i).drp_dI,                                        
            DRDY_OUT                            => MGT_O.mgtLink(i).drp_dRdy,                                      
            DRPDO_OUT                           => MGT_O.mgtLink(i).drp_dRpDo,                                     
            DWE_IN                              => MGT_I.mgtLink(i).drp_dWe,                                       
            ------------------------------------                                                   
            TXDATA_IN                           => GBT_TX_WORD_I(i),                                  
            TXOUTCLK_OUT                        => MGT_CLKS_O.tx_wordClk_noBuff(i),                               
            TXUSRCLK2_IN                        => MGT_CLKS_I.tx_wordclk(i),                                 
            ------------------------------------                                                   
            TXDIFFCTRL_IN                       => MGT_I.mgtLink(i).conf_diff,                               
            TXN_OUT                             => MGT_O.mgtLink(i).tx_n,                                      
            TXP_OUT                             => MGT_O.mgtLink(i).tx_P,                                      
            TXPOSTEMPHASIS_IN                   => MGT_I.mgtLink(i).conf_pstEmph,                           
            ------------------------------------                                                   
            TXPREEMPHASIS_IN                    => MGT_I.mgtLink(i).conf_preEmph,                            
            ------------------------------------                                                   
            GTXTXRESET_IN                       => MGT_I.mgtLink(i).tx_reset,                                  
            MGTREFCLKTX_IN                      => ('0' & MGT_CLKS_I.tx_refClk),                     
            PLLTXRESET_IN                       => '0',                              
            TXPLLLKDET_OUT                      => MGT_O.mgtLink(i).tx_pllLkDet,                               
            TXRESETDONE_OUT                     => resetDoneTx_from_stdGtx(i),                              
            ------------------------------------                                                   
            TXENPRBSTST_IN                      => MGT_I.mgtLink(i).prbs_txEn,                              
            TXPRBSFORCEERR_IN                   => MGT_I.mgtLink(i).prbs_forcErr,                           
            ------------------------------------                                                   
            TXPOLARITY_IN                       => MGT_I.mgtLink(i).conf_txPol     
         ); 

   end generate;
   
   --=====================================================================================--   
end structural;
--=================================================================================================--
--#################################################################################################--
--=================================================================================================--