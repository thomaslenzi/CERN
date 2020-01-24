library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hdmi is
port(
    clk_i               : in std_logic;
    hdmi_i              : in std_logic_vector(7 downto 0);
    bram_sbiterr_o      : out std_logic;
    bram_dbiterr_o      : out std_logic;  
    dsp_err_o           : out std_logic;
    dsp_serr_o          : out std_logic;
    dsp_derr_o          : out std_logic;
    dsp_terr_o          : out std_logic;
    clb_err_o           : out std_logic;
    clb_serr_o          : out std_logic;
    sem_observation_o   : out std_logic;
    sem_correction_o    : out std_logic;
    sem_essential_o     : out std_logic;
    sem_uncorrectable_o : out std_logic 
);
end hdmi;

architecture Behavioral of hdmi is

    signal state        : std_logic;

begin

    sem_observation_o <= hdmi_i(4);
    sem_correction_o <= hdmi_i(5);
    sem_essential_o <= hdmi_i(6);
    sem_uncorrectable_o <= hdmi_i(7);
    
    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            case state is 
                when '0' => 
                    if (hdmi_i(3 downto 0) = "1111") then
                        state <= '1';
                    end if;
                    bram_sbiterr_o <= '0';
                    bram_dbiterr_o <= '0';
                    dsp_err_o <= '0';
                    dsp_serr_o <= '0';
                    dsp_derr_o <= '0';
                    dsp_terr_o <= '0';
                    clb_err_o <= '0';
                    clb_serr_o <= '0';
                when others => 
                    if (hdmi_i(3 downto 0) = "1111") then
                        state <= '1';
                    else 
                        state <= '0';
                    end if;
                    case hdmi_i(3 downto 0) is
                        when "0110" => bram_sbiterr_o <= '1';
                        when "0011" => bram_dbiterr_o <= '1';
                        when "1110" => dsp_err_o <= '1';
                        when "1011" => dsp_serr_o <= '1';
                        when "1100" => dsp_derr_o <= '1';
                        when "1001" => dsp_terr_o <= '1';
                        when "0100" => clb_err_o <= '1';
                        when "0001" => clb_serr_o <= '1';
                        when others => null;
                    end case;
            end case;
        end if;    
    end process; 
    
end Behavioral;

