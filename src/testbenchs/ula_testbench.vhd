library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula_testbench is
--  Port ( );
end ula_testbench;

architecture Behavioral of ula_testbench is
    signal A : std_logic_vector(15 downto 0);
    signal B : std_logic_vector(15 downto 0);
    signal op : std_logic_vector(3 downto 0);
    signal Q : std_logic_vector(15 downto 0);
    signal Immed : std_logic_vector(4 downto 0) := b"00011";
    signal Z     : std_logic;                
    signal C     : std_logic;                 
    constant clock_period :time := 100 ns;
begin
     DUT1: entity work.ULA
            generic map(N => 16)
            port map(
                    A => A,
                    B => B,
                    op => op,
                    Q => Q,
                    Immed =>  Immed,
                    Z     =>  Z    ,
                    C     =>  C    
                    );
    process
    begin
    op <= "0001";
    A <= x"0000";
    B <= x"0000";
    wait for clock_period;
    
    A <= x"0001";
    B <= x"0000";
    wait for clock_period;
    
    A <= x"0000";
    B <= x"0001";
    wait for clock_period;
    
--    op <=  "0000";
--    wait for clock_period;
--    op <=  "0100" ;
--    wait for clock_period;
--    op <=  "0101" ;
--    wait for clock_period;
--    op <=  "0110";
--    wait for clock_period;   
--    op <=  "0111";
--    wait for clock_period;
--    op <=  "1000";
--    wait for clock_period;
--    op <=  "1001";
--    wait for clock_period;
--    op <=  "1010";
--    wait for clock_period;
--    op <=  "1011";
--    wait for clock_period;
--    op <=  "1100";
--    wait for clock_period;
--    op <=  "1101";
--    wait for clock_period;
--    op <=  "1110";
--    wait for clock_period;

    end process;
end Behavioral;
