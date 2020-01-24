library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_control is
port(

    clock_reset_i       : in std_logic;

    fpga_clk_i          : in std_logic;
    vfat2_clk_fpga_i    : in std_logic;
    vfat2_clk_ext_i     : in std_logic;
    
    fpga_pll_locked_i   : in std_logic;
    cdce_pll_locked_i   : in std_logic;
    
    vfat2_clk_o         : out std_logic;
    cdce_clk_o          : out std_logic;
   
    vfat2_src_select_i  : in std_logic;
    vfat2_fallback_i    : in std_logic;
    vfat2_reset_src_o   : out std_logic;
    
    cdce_src_select_i   : in std_logic_vector(1 downto 0);
    cdce_fallback_i     : in std_logic;
    cdce_reset_src_o    : out std_logic

);
end clock_control;

architecture Behavioral of clock_control is

    signal vfat2_reset_src  : std_logic := '0';
    signal cdce_reset_src   : std_logic := '0';

begin 

    --================================--
    -- Clock select
    --================================--

    vfat2_reset_src_o <= vfat2_reset_src;
    cdce_reset_src_o <= cdce_reset_src;
    
    vfat2_clk_o <= vfat2_clk_fpga_i when (vfat2_src_select_i = '1' and vfat2_reset_src = '1') else
                   vfat2_clk_ext_i when (vfat2_src_select_i = '1' and vfat2_reset_src = '0') else
                   vfat2_clk_ext_i;
    
    cdce_clk_o <= vfat2_clk_fpga_i when (cdce_src_select_i = "11" and cdce_reset_src = '0') else 
                  vfat2_clk_ext_i when (cdce_src_select_i = "01" and cdce_reset_src = '0') else 
                  vfat2_clk_ext_i;
                  
    --================================--
    -- VFAT2 fallback logic
    --================================--
    
    process(fpga_clk_i) 
    
        variable vfat2_count    : integer range 0 to 127 := 0;
        variable last_vfat2     : std_logic := '0';
    
    begin
    
        if (rising_edge(fpga_clk_i)) then
        
            if (clock_reset_i = '1') then
            
                vfat2_reset_src <= '1';
                
            else
        
                if (vfat2_fallback_i = '1') then
                
                    if (vfat2_src_select_i = '1') then
                        
                        if (vfat2_count = 127) then
                        
                            vfat2_reset_src <= '1';
                            
                        else
                        
                            vfat2_reset_src <= '0';
                            
                        end if;
                    
                        if (last_vfat2 = vfat2_clk_ext_i) then
                        
                            vfat2_count := vfat2_count + 1;
                            
                        else    
                            
                            vfat2_count := 0;
                            
                        end if;
                    
                    else
                    
                        vfat2_reset_src <= '0';
                        
                        vfat2_count := 0;
                    
                    end if;
                
                else
                
                    vfat2_reset_src <= '0';
                    
                    vfat2_count := 0;
                
                end if;
                
                last_vfat2 := vfat2_clk_ext_i;
            
            end if;
            
        end if;
    
    end process;
                  
    --================================--
    -- CDCE fallback logic
    --================================--
                  
    process(fpga_clk_i)
    
        variable cdce_count : integer range 0 to 4095 := 0;
       
    begin
    
        if (rising_edge(fpga_clk_i)) then
        
            if (clock_reset_i = '1') then
            
                cdce_reset_src <= '1';
                
            else
        
                if (cdce_fallback_i = '1') then
                
                    if (cdce_pll_locked_i = '0') then
                    
                        if (cdce_count = 4095) then
                        
                            cdce_count := 0; 
                        
                            cdce_reset_src <= '1';
                        
                        else
                        
                            cdce_count := cdce_count + 1;
                            
                            cdce_reset_src <= '0';
                        
                        end if;
                        
                    else
                    
                        cdce_reset_src <= '0';
                    
                        cdce_count := 0;
                        
                    end if;
                    
                else
                    
                    cdce_reset_src <= '0';
                
                    cdce_count := 0;
                    
                end if;
                
            end if;
        
        end if;
    
    end process;

end Behavioral;

