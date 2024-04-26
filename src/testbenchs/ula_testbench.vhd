library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula_testbench is
--  Port ( );
end ula_testbench;

architecture Behavioral of ula_testbench is
    signal A : std_logic_vector(15 downto 0) := x"05A3";
    signal B : std_logic_vector(15 downto 0) := x"03BC";
    signal op : std_logic_vector(3 downto 0);
    signal Q : std_logic_vector(15 downto 0);
    constant clock_period :time := 100 ns;
begin
     DUT1: entity work.ULA
            generic map(N => 16)
            port map(
                    A => A,
                    B => B,
                    op => op,
                    Q => Q
                    );
    process
    begin
    
    op <=  "0100" ;
    wait for clock_period;
    op <=  "0101" ;
    wait for clock_period;
    op <=  "0110";
    wait for clock_period;   
    op <=  "0111";
    wait for clock_period;
    op <=  "1000";
    wait for clock_period;
    op <=  "1001";
    wait for clock_period;
    op <=  "1010";
    wait for clock_period;
    
    end process;
end Behavioral;
