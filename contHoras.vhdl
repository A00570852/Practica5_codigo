library ieee;
use ieee.std_logic_1164.all;

entity contHoras is
  port (Enable:     in std_logic;
        CLK:        in std_logic;
        CLR:        in std_logic;
        horas: out std_logic_vector(7 downto 0));
end entity;

architecture arch of contHoras is
  component contSync is
    port (Enable, CLK, CLR: in std_logic;
          Qv: out std_logic_vector(3 downto 0));
  end component;

  component FF_J_K is
    port (J, K: in std_logic;
          CLR : in std_logic;
          CLK : in std_logic;
          Q : out std_logic);
  end component;

  signal sJ: std_logic;
  signal sK: std_logic;
  signal sQ: std_logic;
  signal sJ1: std_logic;
  signal sEnable:  std_logic;
  signal sQvector: std_logic_vector(3 downto 0);
  signal sRestante: std_logic_vector(2 downto 0);

  begin
    sEnable <= (sQvector(1) nand sQ);
    sK      <= not(sEnable);
    sJ1     <= (sQvector(3) nand sQvector(0));
    sJ      <= not sJ;
    sRestante <= "000";
    C_UNIDADES: contSync port map (sEnable, CLK, CLR, sQvector);
    C_DECENAS : FF_J_K   port map (sJ, sK, CLR, CLK, sQ);

    horas <= (sRestante & sQ & sQvector);

end arch;
