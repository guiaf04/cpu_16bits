library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu is
    generic (N : integer := 16);
    Port ( 
        clk: in std_logic;
        rst : in std_logic
    );
end cpu;

architecture Behavioral of cpu is
    signal ROM_addr : std_logic_vector(N-1 downto 0);
    signal ROM_dout : std_logic_vector(N-1 downto 0);
    signal ROM_en   : std_logic;
    
    signal RAM_din  : std_logic_vector(N-1 downto 0);  
    signal RAM_dout : std_logic_vector(N-1 downto 0);
    signal RAM_addr : std_logic_vector(N-1 downto 0); 
    signal RAM_we   : std_logic;
    
    
    signal Immed    : std_logic_vector(N-1 downto 0);
    signal RAM_sel  : std_logic;
    signal RF_sel   : std_logic_vector(1 downto 0);
    signal Rd_sel   : std_logic_vector(2 downto 0);
    signal Rd_wr    : std_logic; 
    signal Rm_sel   : std_logic_vector(2 downto 0);
    signal Rn_sel   : std_logic_vector(2 downto 0);
    signal ula_op   : std_logic_vector(3 downto 0);
    
begin
              
    datapath: entity work.datapath
                generic map(N => N)
                port map(
                    RAM_dout   => RAM_dout,
                    Immed      => Immed   ,
                    Rf_sel     => Rf_sel  ,
                    Rd_sel     => Rd_sel  ,
                    Rd_wr      => Rd_wr   ,
                    Rm_sel     => Rm_sel  ,
                    Rn_sel     => Rn_sel  ,
                    ula_op     => ula_op  ,
                    RAM_addr   => RAM_addr,
                    RAM_din    => RAM_din,
                    RAM_sel    => RAM_sel,
                    clk        => clk     ,
                    rst        => rst     
                 );
                     
control_unit: entity work.control_unit
                generic map(N => N)
                port map(
                  ROM_en      => ROM_en,
                  clk         => clk,
                  rst         => rst,
                  Immed       => Immed,
                  RAM_sel     => RAM_sel,
                  RAM_we      => RAM_we,
                  RF_sel      => RF_sel,
                  Rd_sel      => Rd_sel,
                  Rd_wr       => Rd_wr,
                  Rm_sel      => Rm_sel,
                  Rn_sel      => Rn_sel,
                  ula_op      => ula_op,
                  ROM_dout    => ROM_dout,
                  ROM_addr    => ROM_addr
                ); 
    rom:      entity work.rom
                generic map(N=>N)
                port map(
                    addr   =>   ROM_addr ,
                    dout   =>   ROM_dout ,
                    en     =>   ROM_en   ,
                    clk    =>   clk  
                );
 
     ram:     entity work.ram
                generic map(N=>N)
                port map(
                    din   => RAM_din,
                    addr  => RAM_addr,
                    dout  => RAM_dout,
                    we    => RAM_we,
                    clk   => clk
                );               
end Behavioral;
