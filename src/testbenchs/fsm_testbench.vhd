library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_testbench is
 -- Port ( );
end fsm_testbench;

architecture Behavioral of fsm_testbench is
     signal ROM_en      :  std_logic;
     signal PC_clr      :  std_logic;
     signal PC_inc      :  std_logic;
     signal clk         :  std_logic := '0';
     signal rst         :  std_logic := '0';
     signal IR_data     :  std_logic_vector(15 downto 0) ;--:= (others => '0');
     signal IR_load     :   std_logic;
     signal Immed       :   std_logic_vector(15 downto 0);
     signal RAM_sel     :   std_logic;
     signal RAM_we      :   std_logic;
     signal Rf_sel      :   std_logic_vector(1 downto 0);
     signal Rd_sel      :   std_logic_vector(2 downto 0);
     signal Rd_wr       :   std_logic;
     signal Rm_sel      :   std_logic_vector(2 downto 0);
     signal Rn_sel      :   std_logic_vector(2 downto 0);
     signal ula_op      :   std_logic_vector(3 downto 0);
     constant clk_period : time := 100 ns;
begin

    DUT1: entity work.fsm
            generic map(N => 16)
            port map(
                 ROM_en     =>         ROM_en      ,
                 PC_clr     =>         PC_clr      ,
                 PC_inc     =>         PC_inc      ,
                 clk        =>         clk         ,
                 rst        =>         rst         ,
                 IR_data    =>         IR_data     ,
                 IR_load    =>         IR_load     ,
                 Immed      =>         Immed       ,
                 RAM_sel    =>         RAM_sel     ,
                 RAM_we     =>         RAM_we      ,
                 Rf_sel     =>         Rf_sel      ,
                 Rd_sel     =>         Rd_sel      ,
                 Rd_wr      =>         Rd_wr       ,
                 Rm_sel     =>         Rm_sel      ,
                 Rn_sel     =>         Rn_sel      ,
                 ula_op     =>         ula_op      
            );
        
clk_process : process           -- clock process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;
    
    reset:process
    begin
        rst <= '1';
        wait for 2*5 ns;
        rst <= '0';
        wait;
    end process;
    
    stimulus_process : process      -- stimulus process
    begin
        wait until rst = '0';
        wait for 5 ns; 
        
        wait until PC_inc = '1';
        -- TEST 1 :
        IR_data <= "0001100000000010"; --MOV R0, 0x02
        --wait for 10 ns;
        wait until PC_inc = '1';
        -- TEST 2 :
        
        IR_data <= "0011000100000000"; --LDR R1, [R0]
        --wait for 10 ns;
        wait until PC_inc = '1';
        
        -- TEST 3 :
        
        IR_data <= "0001100000000100"; --MOV R0, 0x04
        --wait for 10 ns;
        wait until PC_inc ='1';
        
        -- TEST 4 :
        
        IR_data <= "0011001000000000"; --LDR R2, [R0]
        --wait for 10 ns;
        wait until PC_inc = '1';
        
        -- TEST 5 :
        
        IR_data <= "0100000100101000"; --ADD R1, R1, R2
        --wait for 10 ns;
        wait until PC_Inc ='1';
        
        -- TEST 6 :
        
        IR_data <= "0001100000000110"; --MOV R0, 0X06
        --wait for 10 ns;
        wait until PC_inc = '1';
        
        -- TEST 7 :
        
        IR_data <= "0010000000000100"; --STR [R0], R1
        --wait for 10 ns;
        wait until PC_inc = '1';
        
        -- TEST 8 :
        
        IR_data <= "1111111111111111"; --HALT
        --wait for 10 ns;
        
        -- END SIMULATION
        wait;
    end process;
    
end Behavioral;
