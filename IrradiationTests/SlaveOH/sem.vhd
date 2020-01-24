library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity sem is
generic(
    DEBUG               : boolean := FALSE
);
port(
    clk_i               : in std_logic;
    heartbeat_o         : out std_logic;
    initialization_o    : out std_logic;
    observation_o       : out std_logic;
    correction_o        : out std_logic;
    classification_o    : out std_logic;
    injection_o         : out std_logic;
    essential_o         : out std_logic;
    uncorrectable_o     : out std_logic;
    db_txfull_i         : in std_logic;
    db_txwrite_o        : out std_logic;
    db_txdata_o         : out std_logic_vector(7 downto 0);
    db_rxempty_i        : in std_logic;
    db_rxread_o         : out std_logic;
    db_rxdata_i         : in std_logic_vector(7 downto 0);
    db_injstrobe_i      : in std_logic;
    db_injaddr_i        : in std_logic_vector(35 downto 0)
);
end sem;

architecture behavioral of sem is

    -- Not working without...
    component sem_core
    port(
        status_heartbeat        : out std_logic;
        status_initialization   : out std_logic;
        status_observation      : out std_logic;
        status_correction       : out std_logic;
        status_classification   : out std_logic;
        status_injection        : out std_logic;
        status_essential        : out std_logic;
        status_uncorrectable    : out std_logic;
        monitor_txdata          : out std_logic_vector(7 downto 0);
        monitor_txwrite         : out std_logic;
        monitor_txfull          : in std_logic;
        monitor_rxdata          : in std_logic_vector(7 downto 0);
        monitor_rxread          : out std_logic;
        monitor_rxempty         : in std_logic;
        inject_strobe           : in std_logic;
        inject_address          : in std_logic_vector(35 downto 0);
        icap_busy               : in std_logic;
        icap_o                  : in std_logic_vector(31 downto 0);
        icap_csb                : out std_logic;
        icap_rdwrb              : out std_logic;
        icap_i                  : out std_logic_vector(31 downto 0);
        icap_clk                : in std_logic;
        icap_request            : out std_logic;
        icap_grant              : in std_logic;
        fecc_crcerr             : in std_logic;
        fecc_eccerr             : in std_logic;
        fecc_eccerrsingle       : in std_logic;
        fecc_syndromevalid      : in std_logic;
        fecc_syndrome           : in std_logic_vector(12 downto 0);
        fecc_far                : in std_logic_vector(23 downto 0);
        fecc_synbit             : in std_logic_vector(4 downto 0);
        fecc_synword            : in std_logic_vector(6 downto 0)
    );
    end component;
    
    signal status_heartbeat         : std_logic;
    signal status_initialization    : std_logic;
    signal status_observation       : std_logic;
    signal status_correction        : std_logic;
    signal status_classification    : std_logic;
    signal status_injection         : std_logic;
    signal status_essential         : std_logic;
    signal status_uncorrectable     : std_logic;    

    signal monitor_txdata           : std_logic_vector(7 downto 0);   
    signal monitor_txwrite          : std_logic;
    signal monitor_txfull           : std_logic;
    signal monitor_rxdata           : std_logic_vector(7 downto 0);
    signal monitor_rxread           : std_logic;
    signal monitor_rxempty          : std_logic;

    signal inject_strobe            : std_logic;
    signal inject_address           : std_logic_vector(35 downto 0);

    signal fecc_crcerr              : std_logic;
    signal fecc_eccerr              : std_logic;
    signal fecc_eccerrsingle        : std_logic;
    signal fecc_syndromevalid       : std_logic;
    signal fecc_syndrome            : std_logic_vector(12 downto 0);
    signal fecc_far                 : std_logic_vector(23 downto 0);
    signal fecc_synbit              : std_logic_vector(4 downto 0);
    signal fecc_synword             : std_logic_vector(6 downto 0);

    signal icap_o                   : std_logic_vector(31 downto 0);
    signal icap_i                   : std_logic_vector(31 downto 0);
    signal icap_busy                : std_logic;
    signal icap_csb                 : std_logic;
    signal icap_rdwrb               : std_logic;
  
begin

    --=========--
    --== sem ==--
    --=========--

    sem_core_inst : sem_core
    port map(
        status_heartbeat        => status_heartbeat,
        status_initialization   => status_initialization,
        status_observation      => status_observation,
        status_correction       => status_correction,
        status_classification   => status_classification,
        status_injection        => status_injection,
        status_essential        => status_essential,
        status_uncorrectable    => status_uncorrectable,
        monitor_txdata          => monitor_txdata,
        monitor_txwrite         => monitor_txwrite,
        monitor_txfull          => monitor_txfull,
        monitor_rxdata          => monitor_rxdata,
        monitor_rxread          => monitor_rxread,
        monitor_rxempty         => monitor_rxempty,
        inject_strobe           => inject_strobe,
        inject_address          => inject_address,
        fecc_crcerr             => fecc_crcerr,
        fecc_eccerr             => fecc_eccerr,
        fecc_eccerrsingle       => fecc_eccerrsingle,
        fecc_syndromevalid      => fecc_syndromevalid,
        fecc_syndrome           => fecc_syndrome,
        fecc_far                => fecc_far,
        fecc_synbit             => fecc_synbit,
        fecc_synword            => fecc_synword,
        icap_o                  => icap_o,
        icap_i                  => icap_i,
        icap_busy               => icap_busy,
        icap_csb                => icap_csb,
        icap_rdwrb              => icap_rdwrb,
        icap_clk                => clk_i,
        icap_request            => open,
        icap_grant              => '1'
    );

    heartbeat_o <= status_heartbeat;
    initialization_o <= status_initialization;
    observation_o <= status_observation;
    correction_o <= status_correction;
    classification_o <= status_classification;
    injection_o <= status_injection;
    essential_o <= status_essential;
    uncorrectable_o <= status_uncorrectable;    
    
    --==========--
    --== fecc ==--
    --==========--
    
    frame_ecc_inst : frame_ecc_virtex6
    generic map (
        frame_rbt_in_filename   => "none",
        farsrc                  => "efar"
    )
    port map (
        crcerror                => fecc_crcerr,
        eccerror                => fecc_eccerr,
        eccerrorsingle          => fecc_eccerrsingle,
        far                     => fecc_far,
        synbit                  => fecc_synbit,
        syndrome                => fecc_syndrome,
        syndromevalid           => fecc_syndromevalid,
        synword                 => fecc_synword
    );
    
    --==========--
    --== ICAP ==--
    --==========--

    icap_inst : icap_virtex6
    generic map (
        sim_cfg_file_name   => "none",
        device_id           => x"ffffffff",
        icap_width          => "x32"
    )
    port map (
        busy                => icap_busy,
        o                   => icap_o,
        clk                 => clk_i,
        csb                 => icap_csb,
        i                   => icap_i,
        rdwrb               => icap_rdwrb
    );   
    
    --===========--
    --== DEBUG ==--
    --===========--
    
    debug_gen: if DEBUG = TRUE generate
    begin

        monitor_rxdata <= db_rxdata_i;
        inject_strobe <= db_injstrobe_i;
        inject_address <= db_injaddr_i;
        
        db_txwrite_o <= monitor_txwrite;
        db_rxread_o <= monitor_rxread;
    
        process(clk_i)
            variable i : integer range 0 to 15;
        begin
            if (rising_edge(clk_i)) then
                if (db_txfull_i = '0') then
                    i := 15;                  
                end if;
                if (i /= 0) then
                    monitor_txfull <= '0';
                    i := i - 1;
                else
                    monitor_txfull <= '1';
                end if;
            end if;
        end process;
    
        process(clk_i)
            variable i : integer range 0 to 31;
        begin
            if (rising_edge(clk_i)) then
                if (db_rxempty_i = '0') then
                    i := 31;                  
                end if;
                if (i /= 0) then
                    monitor_rxempty <= '0';
                    i := i - 1;
                else
                    monitor_rxempty <= '1';
                end if;
            end if;
        end process;
    
        process(clk_i)
        begin
            if (rising_edge(clk_i)) then
                if (monitor_txwrite = '1') then
                    db_txdata_o <= monitor_txdata;
                end if;
            end if;
        end process;
        
    end generate;  
    
    --==============--
    --== NO DEBUG ==--
    --==============--

    nodebug_gen : if DEBUG = FALSE generate
    begin
    
        monitor_txfull <= '0';
        monitor_rxdata <= (others => '0');
        monitor_rxempty <= '1';
        inject_strobe <= '0';
        inject_address <= (others => '0');
    
    end generate;  

end behavioral;
