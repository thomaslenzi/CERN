library ieee;
use ieee.std_logic_1164.all;

library work;

entity dsp_slice is
generic(
    DEBUG       : boolean := FALSE
);
port(
    clk_i       : in std_logic;
    err_o       : out std_logic;
    serr_o      : out std_logic;
    derr_o      : out std_logic;
    terr_o      : out std_logic;
    db_serr_i   : in std_logic;
    db_derr_i   : in std_logic;
    db_terr_i   : in std_logic
);
end dsp_slice;

architecture Behavioral of dsp_slice is

    signal din  : std_logic_vector(31 downto 0) := x"01234567";
    
    type array32 is array (integer range <>) of std_logic_vector(31 downto 0);
    signal dout : array32(5 downto 0);
    
    signal err  : std_logic_vector(31 downto 0);
    signal serr : std_logic_vector(31 downto 0);
    signal derr : std_logic_vector(31 downto 0);
    signal terr : std_logic_vector(31 downto 0);
    
begin

    --===========--
    --== DEBUG ==--
    --===========--
    
    debug_gen: if DEBUG = TRUE generate    
    begin
    
        process(clk_i)
        begin
            if (rising_edge(clk_i)) then                
                -- Global Error
                if (err /= x"00000000") then
                    err_o <= '1';
                elsif (db_serr_i = '1' or db_derr_i = '1' or db_terr_i = '1') then
                    err_o <= '1';
                else
                    err_o <= '0';
                end if;
                -- Single Error
                if (serr /= x"00000000") then
                    serr_o <= '1';
                elsif (db_serr_i = '1') then
                    serr_o <= '1';
                else
                    serr_o <= '0';
                end if;            
                -- Double Error
                if (derr /= x"00000000") then
                    derr_o <= '1';
                elsif (db_derr_i = '1') then
                    derr_o <= '1';
                else
                    derr_o <= '0';
                end if;            
                -- Triple Error
                if (terr /= x"00000000") then
                    terr_o <= '1';
                elsif (db_terr_i = '1') then
                    terr_o <= '1';
                else
                    terr_o <= '0';
                end if;
            end if;
        end process;
        
    end generate;

    --==============--
    --== NO DEBUG ==--
    --==============--

    nodebug_gen : if DEBUG = FALSE generate
    begin
    
        process(clk_i)
        begin
            if (rising_edge(clk_i)) then
                -- Global Error
                if (err /= x"00000000") then
                    err_o <= '1';
                else
                    err_o <= '0';
                end if;
                -- Single Error
                if (serr /= x"00000000") then
                    serr_o <= '1';
                else
                    serr_o <= '0';
                end if;            
                -- Double Error
                if (derr /= x"00000000") then
                    derr_o <= '1';
                else
                    derr_o <= '0';
                end if;            
                -- Triple Error
                if (terr /= x"00000000") then
                    terr_o <= '1';
                else
                    terr_o <= '0';
                end if;
            end if;
        end process;

    end generate;

    --====================--
    --== Data generator ==--
    --====================--

    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
            din(31 downto 1) <= din(30 downto 0);
            din(0) <= din(31);
        end if;
    end process;
    
    --================--
    --== Comparator ==--
    --================--
    
    comp_gen : for I in 0 to 31 generate
    
        signal tmp  : std_logic_vector(5 downto 0);
    
    begin
    
        tmp <= dout(0)(I) & dout(1)(I) & dout(2)(I) & dout(3)(I) & dout(4)(I) & dout(5)(I);        
        
        with tmp select err(I) <= '0' when "000000" | "111111", 
                                  '1' when others;
        
        with tmp select serr(I) <= '1' when "000001" | "000010" | "000100" | "001000" | "010000" | "100000",
                                   '1' when "111110" | "111101" | "111011" | "110111" | "101111" | "011111", 
                                   '0' when others;
        
        with tmp select derr(I) <= '1' when "100001" | "100010" | "100100" | "101000" | "110000",
                                   '1' when "011110" | "011101" | "011011" | "010111" | "001111",
                                   '1' when "010001" | "010010" | "010100" | "011000",
                                   '1' when "101110" | "101101" | "101011" | "100111",
                                   '1' when "001001" | "001010" | "001100",
                                   '1' when "110110" | "110101" | "110011",
                                   '1' when "000101" | "000110",
                                   '1' when "111010" | "111001",
                                   '1' when "000011",
                                   '1' when "111100",
                                   '0' when others;
        
        with tmp select terr(I) <= '1' when "110001" | "110010" | "110100" | "111000",
                                   '1' when "001110" | "001101" | "001011" | "000111",                                   
                                   '1' when "101001" | "101010" | "101100",
                                   '1' when "010110" | "010101" | "010011",                                   
                                   '1' when "100101" | "100110",
                                   '1' when "011010" | "011001",                                   
                                   '1' when "100011",
                                   '1' when "011100",                    
                                   '0' when others;    
    
    end generate;
        
    --==========--
    --== DSPs ==--
    --==========--

    dsp48_loop : for I in 0 to 5 generate
    begin
    
        dsp_column_inst : entity work.dsp_column
        port map(
            clk_i   => clk_i,
            din_i   => din,
            dout_o  => dout(I)
        );
        
    end generate;

end Behavioral;