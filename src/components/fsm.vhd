library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
    generic(N : integer := 16);
    Port ( 
       PC_clr   : out std_logic;
       PC_inc   : out std_logic;
       ROM_en   : out std_logic;
       clk      : in std_logic;
       rst      : in std_logic;
       IR_load  : out std_logic;
       IR_data  : in  std_logic_vector(N-1 downto 0);
       immed    : out std_logic_vector(N-1 downto 0);
       RAM_sel  : out std_logic;
       RAM_we   : out std_logic;
       RF_sel   : out std_logic_vector(1 downto 0);
       Rd_sel   : out std_logic_vector(2 downto 0);
       Rd_wr    : out std_logic;
       Rm_sel   : out std_logic_vector(2 downto 0);
       Rn_sel   : out std_logic_vector(2 downto 0);
       ula_op   : out std_logic_vector(3 downto 0)
    ); 
end fsm;

architecture Behavioral of fsm is
    type estados is (init, fetch, decode, exec_nop, exec_halt, exec_mov, exec_load, exec_store, exec_ula);
    signal next_state : estados;
    signal present_state: estados;
begin
   process(clk, rst)
   begin
        if(rst ='1') then
            present_state <= init;
        elsif(rising_edge(clk)) then
            present_state <= next_state;
        end if;
   end process;
   
   process(present_state, IR_data)
   begin
        case(present_state) is
            when init   => next_state <= fetch;
            when fetch  => next_state <= decode;
            when decode => 
                if(IR_data = x"0000") then
                    next_state <= exec_nop;
                elsif(IR_data = x"FFFF") then
                    next_state <= exec_halt;
                elsif(IR_data(15 downto 12) = "0001") then
                    next_state <= exec_mov;
                elsif(IR_data(15 downto 12) = "0010") then
                    next_state <= exec_store;
                elsif(IR_data(15 downto 12) = "0011") then
                    next_state <= exec_load;
                elsif(IR_data(15 downto 12) = "0000" and IR_data(1 downto 0) = "11") or -- CMP
                   IR_data(15 downto 12) = "0100" or     -- ADD
                   IR_data(15 downto 12) = "0101" or     -- SUB
                   IR_data(15 downto 12) = "0110" or     -- MUL
                   IR_data(15 downto 12) = "0111" or     -- AND
                   IR_data(15 downto 12) = "1000" or     -- ORR
                   IR_data(15 downto 12) = "1001" or     -- NOT
                   IR_data(15 downto 12) = "1010" then   -- XOR
                   
                    next_state <= exec_ula; 
                else
                    next_state <= exec_nop;                                  
                end if;
                
            when exec_nop   => next_state <= fetch;
            when exec_halt  => next_state <= exec_halt;
            when exec_mov   => next_state <= fetch;
            when exec_load  => next_state <= fetch;
            when exec_store => next_state <= fetch;
            when exec_ula   => next_state <= fetch;
        end case;   
   end process;
   
   process(present_state, IR_data)
   begin
        case(present_state) is
            when init   =>
                PC_clr    <= '1';
                PC_inc    <= '0';
                ROM_en    <= '0';
                IR_load   <= '0';
                immed     <= x"0000";
                RAM_sel   <= '0';
                RAM_we    <= '0';
                RF_sel    <= "00";
                Rd_sel    <= "000";
                Rd_wr     <= '0';
                Rm_sel    <= "000";
                Rn_sel    <= "000";
                ula_op    <= "0000";
            when fetch  =>
                PC_clr    <= '0';
                PC_inc    <= '1';
                ROM_en    <= '1';
                IR_load   <= '1';
                immed     <= x"0000";
                RAM_sel   <= '0';
                RAM_we    <= '0';
                RF_sel    <= "00";
                Rd_sel    <= "000";
                Rd_wr     <= '0';
                Rm_sel    <= "000";
                Rn_sel    <= "000";
                ula_op    <= "0000"; 
            when decode => 
                PC_inc    <= '0';
                ROM_en    <= '0';
                IR_load   <= '0';
                Rd_sel <= IR_data(10 downto 8);
                Rm_sel <= IR_data(7 downto 5);
                Rn_sel <= IR_data(4 downto 2);       
            when exec_mov   => 
                Rd_wr <= '1';
                if(IR_data(11) = '1') then
                    Immed  <= x"00" & IR_data(7 downto 0);
                    RF_sel <= "10";
                else
                    RF_sel <= "00";
                end if;
            when exec_store  =>  
                 Ram_we <= '1';
                 if(IR_data(11) = '1') then
                    Immed  <= x"00" & IR_data(10 downto 8) & IR_data(4 downto 0);
                    Ram_sel <= '1';
                else
                    Ram_sel <= '0';
                end if;
            when exec_load => 
                Rf_sel <= "01";
                Rd_wr  <= '1';      
                RAM_we <= '1';
            when exec_ula   => 
                Rf_sel <= "11";
                Rd_wr  <= '1';
                ula_op <= IR_data(15 downto 12);
            when others =>
               
        end case;   
   end process;

end Behavioral;
