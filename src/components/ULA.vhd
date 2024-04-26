library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ULA is
    generic(N : integer := 16);
    Port ( 
           A     :  in std_logic_vector(N-1 downto 0);
           B     :  in std_logic_vector(N-1 downto 0);
           op    :  in std_logic_vector(3 downto 0);
           Q     :  out std_logic_vector(N-1 downto 0)
           );
end ULA;

architecture Behavioral of ULA is
    signal mux_result: std_logic_vector(2*N - 1 downto 0);
begin
    mux_result <= A * B;
    process(op)
    begin
        case(op) is
            when "0100" => Q <= A + B;
            when "0101" => Q <= A - B;
            when "0110" => Q <= mux_result(N-1 downto 0);
            when "0111" => Q <= A and B;
            when "1000" => Q <= A or B;
            when "1001" => Q <= not A;
            when "1010" => Q <= A xor B;
            when others => Q <= (others => '0');
        end case;
    end process;

end Behavioral;
