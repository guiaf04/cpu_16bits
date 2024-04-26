library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity control_unit is
  generic(N : integer := 16);
  Port
    (
       ROM_en   : out std_logic;
       clk      : in std_logic;
       rst      : in std_logic;
       Immed    : out std_logic_vector(N-1 downto 0);
       RAM_sel  : out std_logic;
       RAM_we   : out std_logic;
       RF_sel   : out std_logic_vector(1 downto 0);
       Rd_sel   : out std_logic_vector(2 downto 0);
       Rd_wr    : out std_logic;
       Rm_sel   : out std_logic_vector(2 downto 0);
       Rn_sel   : out std_logic_vector(2 downto 0);
       ula_op   : out std_logic_vector(3 downto 0);
       ROM_dout : in  std_logic_vector(N-1 downto 0);
       ROM_addr : out std_logic_vector(N-1 downto 0)     
    );
end control_unit;

architecture Behavioral of control_unit is
        signal PC_clr, PC_inc : std_logic;
        signal IR_data  : std_logic_vector(N-1 downto 0);
        signal IR_load  : std_logic;
        signal PC_D, PC_Q : std_logic_vector(N-1 downto 0) := (others => '0');

begin

    FSM: entity work.fsm
            generic map(N => N)
            port map(
              PC_clr => PC_clr ,
              PC_inc => PC_inc ,
              ROM_en => ROM_en ,
              clk    => clk    ,
              rst    => rst    ,
              IR_load=> IR_load,
              IR_data=> IR_data,
              Immed  => Immed  ,
              RAM_sel=> RAM_sel,
              RAM_we => RAM_we ,
              RF_sel => RF_sel ,
              Rd_sel => Rd_sel ,
              Rd_wr  => Rd_wr  ,
              Rm_sel => Rm_sel ,
              Rn_sel => Rn_sel ,
              ula_op => ula_op 
            );
            
    IR: entity work.registrador
                generic map(N => N)
                port map(
                    D     => ROM_dout,
                    ld    => IR_load,
                    clk   => clk,          
                    rst   => rst,
                    Q     => IR_data
                );
                
    PC: entity work.registrador
                generic map(N => N)
                port map(
                    D    => PC_D,
                    ld   => PC_inc,
                    clk  => clk,
                    rst  => PC_clr,
                    Q    => PC_Q
                );
    PC_D <= PC_Q + 2;
    ROM_addr <= PC_Q;                                 
end Behavioral;
