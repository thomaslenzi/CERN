library ieee;
use ieee.std_logic_1164.all;

entity hdmi is
port(
    clk_i                   : in std_logic;
    bram_sbiterr_i          : in std_logic_vector(9 downto 0);
    bram_dbiterr_i          : in std_logic_vector(9 downto 0);    
    dsp_err_i               : in std_logic_vector(9 downto 0);
    dsp_serr_i              : in std_logic_vector(9 downto 0);
    dsp_derr_i              : in std_logic_vector(9 downto 0);
    dsp_terr_i              : in std_logic_vector(9 downto 0);    
    clb_err_i               : in std_logic_vector(9 downto 0);
    clb_serr_i              : in std_logic_vector(9 downto 0);
    sem_heartbeat_i         : in std_logic;
    sem_initialization_i    : in std_logic;
    sem_observation_i       : in std_logic;
    sem_correction_i        : in std_logic;
    sem_classification_i    : in std_logic;
    sem_injection_i         : in std_logic;
    sem_essential_i         : in std_logic;
    sem_uncorrectable_i     : in std_logic;    
    hdmi_o                  : out std_logic_vector(7 downto 0)
);    
end hdmi;

architecture Behavioral of hdmi is

    signal bram_sbiterr : std_logic_vector(2 downto 0);
    signal bram_dbiterr : std_logic_vector(2 downto 0);
    
    signal dsp_err      : std_logic_vector(2 downto 0);
    signal dsp_serr     : std_logic_vector(2 downto 0);
    signal dsp_derr     : std_logic_vector(2 downto 0);
    signal dsp_terr     : std_logic_vector(2 downto 0);
    
    signal clb_err      : std_logic_vector(2 downto 0);   
    signal clb_serr     : std_logic_vector(2 downto 0);
    
    signal state        : std_logic_vector(2 downto 0);
    signal err_bit      : std_logic_vector(11 downto 0);
    
begin

    hdmi_o(4) <= sem_heartbeat_i xor sem_observation_i;
    hdmi_o(5) <= sem_correction_i;
    hdmi_o(6) <= sem_essential_i;
    hdmi_o(7) <= sem_uncorrectable_i;        

    --=====================--
    --== Triplicated ORs ==--
    --=====================--

    or_loop : for I in 0 to 2 generate
    begin
    
        bram_sbiterr(I) <= bram_sbiterr_i(0) or bram_sbiterr_i(1) or bram_sbiterr_i(2) or bram_sbiterr_i(3) or bram_sbiterr_i(4) or bram_sbiterr_i(5) or bram_sbiterr_i(6) or bram_sbiterr_i(7) or bram_sbiterr_i(8) or bram_sbiterr_i(9);
        bram_dbiterr(I) <= bram_dbiterr_i(0) or bram_dbiterr_i(1) or bram_dbiterr_i(2) or bram_dbiterr_i(3) or bram_dbiterr_i(4) or bram_dbiterr_i(5) or bram_dbiterr_i(6) or bram_dbiterr_i(7) or bram_dbiterr_i(8) or bram_dbiterr_i(9);
        dsp_err(I) <= dsp_err_i(0) or dsp_err_i(1) or dsp_err_i(2) or dsp_err_i(3) or dsp_err_i(4) or dsp_err_i(5) or dsp_err_i(6) or dsp_err_i(7) or dsp_err_i(8) or dsp_err_i(9);
        dsp_serr(I) <= dsp_serr_i(0) or dsp_serr_i(1) or dsp_serr_i(2) or dsp_serr_i(3) or dsp_serr_i(4) or dsp_serr_i(5) or dsp_serr_i(6) or dsp_serr_i(7) or dsp_serr_i(8) or dsp_serr_i(9);
        dsp_derr(I) <= dsp_derr_i(0) or dsp_derr_i(1) or dsp_derr_i(2) or dsp_derr_i(3) or dsp_derr_i(4) or dsp_derr_i(5) or dsp_derr_i(6) or dsp_derr_i(7) or dsp_derr_i(8) or dsp_derr_i(9);
        dsp_terr(I) <= dsp_terr_i(0) or dsp_terr_i(1) or dsp_terr_i(2) or dsp_terr_i(3) or dsp_terr_i(4) or dsp_terr_i(5) or dsp_terr_i(6) or dsp_terr_i(7) or dsp_terr_i(8) or dsp_terr_i(9);
        clb_err(I) <= clb_err_i(0) or clb_err_i(1) or clb_err_i(2) or clb_err_i(3) or clb_err_i(4) or clb_err_i(5) or clb_err_i(6) or clb_err_i(7) or clb_err_i(8) or clb_err_i(9);
        clb_serr(I) <= clb_serr_i(0) or clb_serr_i(1) or clb_serr_i(2) or clb_serr_i(3) or clb_serr_i(4) or clb_serr_i(5) or clb_serr_i(6) or clb_serr_i(7) or clb_serr_i(8) or clb_serr_i(9);    
    
    end generate;
    
    --==========--
    --== Send ==--
    --==========--
    
    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            case state is
                when "000" | "100" | "010" | "001" => 
                    -- CLB Level2 Error
                    if (clb_serr = "111" or clb_serr = "110" or clb_serr = "101" or clb_serr = "011") then
                        err_bit <= "000000000111";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- CLB Level1 Error
                    elsif (clb_err = "111" or clb_err = "110" or clb_err = "101" or clb_err = "011") then
                        err_bit <= "000111000000";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- BRAM Double Error
                    elsif (bram_dbiterr = "111" or bram_dbiterr = "110" or bram_dbiterr = "101" or bram_dbiterr = "011") then
                        err_bit <= "000000111111";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- BRAM Single Error
                    elsif (bram_sbiterr = "111" or bram_sbiterr = "110" or bram_sbiterr = "101" or bram_sbiterr = "011") then
                        err_bit <= "000111111000";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- DSP Triple Error
                    elsif (dsp_terr = "111" or dsp_terr = "110" or dsp_terr = "101" or dsp_terr = "011") then
                        err_bit <= "111000000111";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- DSP Double Error
                    elsif (dsp_derr = "111" or dsp_derr = "110" or dsp_derr = "101" or dsp_derr = "011") then
                        err_bit <= "111111000000";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- DSP Single Error
                    elsif (dsp_serr = "111" or dsp_serr = "110" or dsp_serr = "101" or dsp_serr = "011") then
                        err_bit <= "111000111111";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- DSP Error
                    elsif (dsp_err = "111" or dsp_err = "110" or dsp_err = "101" or dsp_err = "011") then
                        err_bit <= "111111111000";
                        state <= "111";
                        hdmi_o(3 downto 0) <= "1111";
                    -- No Error
                    else
                        state <= "000";
                        hdmi_o(3 downto 0) <= "0000";
                    end if;
                when others => 
                    state <= "000";
                    for I in 0 to 3 loop
                        case err_bit(((I + 1) * 3 - 1) downto (I * 3)) is
                            when "000" | "100" | "010" | "001" => hdmi_o(I) <= '0';
                            when others => hdmi_o(I) <= '1';
                        end case;
                    end loop;        
            end case;        
        end if;
    end process;

end Behavioral;

