library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath is
    generic (N : integer := 16);
    Port ( 
--            Rm        : out std_logic_vector(N-1 downto 0);
            RAM_dout  : in std_logic_vector(N-1 downto 0);
            Immed     : in std_logic_vector(N-1 downto 0);
            Rf_sel    : in std_logic_vector(1 downto 0);
            Rd_sel    : in std_logic_vector(2 downto 0);
            Rd_wr     : in std_logic;
            Rm_sel    : in std_logic_vector(2 downto 0);    
            Rn_sel    : in std_logic_vector(2 downto 0);
            ula_op    : in std_logic_vector(3 downto 0);
            RAM_addr  : out std_logic_vector(N-1 downto 0);
            RAM_din   : out std_logic_vector(N-1 downto 0);
            RAM_sel   : in std_logic;
 --           Rn        : out std_logic_vector(N-1 downto 0);
            clk       : in std_logic;
            rst       : in std_logic
            );
end datapath;

architecture Behavioral of datapath is
            signal Rm_s, Rn_s, Q_s, Rd_s : std_logic_vector(N-1 downto 0);
begin
    RAM_addr <= Rm_s;
    RAM_din <= Rn_s when RAM_sel = '0' else
               Immed;
    Rd_s <= Rm_s     when Rf_sel = "00" else
            RAM_dout when RF_sel = "01" else    
            Immed    when RF_sel = "10" else
            Q_s ;
                                      
    ULA: entity work.ULA
            generic map (N => N)
            port map(
                A   => Rm_s,  
                B   => Rn_s,  
                op  => ula_op,
                Q   => Q_s
            );
    
    Register_file: entity work.register_file
                    generic map(N => N)
                    port map(
                        Rd     => Rd_s,
                        Rm     => Rm_s,
                        Rn     => Rn_s,
                        Rd_sel => Rd_sel,
                        Rm_sel => Rm_sel,
                        Rn_sel => Rn_sel,
                        Rd_wr  => Rd_wr,
                        clk    => clk,
                        rst    => rst             
                    );        

end Behavioral;
