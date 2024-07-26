library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.ALL;

entity rom is
generic(N : integer := 16);
  Port (
        addr    :  in  std_logic_vector(N-1 downto 0);
        dout    :  out std_logic_vector(N-1 downto 0);  
        en      :  in  std_logic;
        clk     :  in  std_logic
   );
end rom;

architecture Behavioral of rom is   
    type memory is array(0 to (2**N - 1)) of std_logic_vector(N-1 downto 0);
    signal rom_memory : memory :=
            (   
--                0  =>        "0001100000000010"   ,    --MOV R0, 0x02   
--                2  =>        "0011000100000000"   ,    --LDR R1, [R0]
--                4  =>        "0001100000000100"   ,    --MOV R0, 0x04
--                6  =>        "0011001000000000"   ,    --LDR R2, [R0]  
--                8  =>        "0100000100101000"   ,    --ADD R1, R1, R2               
--                10 =>        "0001100000000110"   ,    --MOV R0, 0X06                                   
--                12 =>        "0010000000000100"   ,    --STR [R0], R1
--                14 =>        "0000100011010100"   ,    --JMP #0x35
--                16 =>        "0000000010010111",       --CMP 0x4, 0x5
--                18 =>        "0000100000111101",       --JEQ 0xf
--                20 =>        "0000100000111110",       --JLT 0xf
--                22 =>        "0000100000111111",       --JLT 0xf
--                24 =>        "1111111111111111"   ,    -- HALT
                  0  =>        "0001100000000010"   ,    --MOV R0, 0x02   
                  2  =>        "0011000100000000"   ,    --LDR R1, [R0]
                  4  =>        "0001100000000100"   ,    --MOV R0, 0x04
                  6  =>        "0011001000000000"   ,    --LDR R2, [R0]  
                  8 =>         "0000000000100011",       --CMP R1, R0
                  10 =>        "0000100000111110",       --JLT 0xf
                  12 =>        "0000100000111111",       --JGT 0xf
                  14 =>        "1111111111111111"   ,    -- HALT
                others =>   "0000000000000000"
            );
    signal aux: std_logic_vector(N-1 downto 0) := (others => '0');                                         
begin                                                     
    process(clk)                                                          
    begin
        --if(rising_edge(clk)) then
            if(en = '1') then
                aux <= rom_memory(conv_integer(addr));
            end if;                                    
        --end if;                                             
    end process;
    dout <= aux; 
end Behavioral;

                                                       

                                                        





                                                        





                                                        
