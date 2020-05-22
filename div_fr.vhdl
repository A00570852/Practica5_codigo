library ieee;
use ieee.std_logic_1164.all;


entity div_fr is
  port (Enable:     in std_logic;
        clock_60Hz: in std_logic;
        CLR:        in std_logic;
        fr_1hz:     out std_logic;
        segundos:   out std_logic_vector(7 downto 0));
end entity;


architecture arch of div_fr is

  component contSync is
    port (Enable, CLK, CLR: in std_logic;
          Qv: out std_logic_vector(3 downto 0));
  end component;

  signal sAnd0: std_logic;
  signal sAnd1: std_logic;
  signal sQvector:  std_logic_vector(3 downto 0);
  signal sQvector1: std_logic_vector(3 downto 0);

  begin
    C0: contSync port map (Enable, clock_60Hz, CLR, sQvector);
    sAnd0 <= (sQvector(0) and sQvector(3));
    C1: contSync port map (sAnd0, clock_60Hz, sAnd1, sQvector1);
    sAnd1 <= (sQvector1(1) and sQvector1(2));

    fr_1hz <= sAnd1; --segundos hasta 0-59

    segundos <= (sQvector1 & sQvector);

end arch;
