library ieee;
use ieee.std_logic_1164.all;

entity clock12 is
  port (CLK: in std_logic;
        CLR: in std_logic;
        segundos:  out std_logic_vector(7 downto 0);
        minutos:   out std_logic_vector(7 downto 0);
        horas:     out std_logic_vector(7 downto 0));
end clock12;

architecture arch of clock12 is

  component div_fr is
    port (Enable:     in std_logic;
          clock_60Hz: in std_logic;
          CLR:        in std_logic;
          fr_1hz:     out std_logic;
          segundos: out std_logic_vector(7 downto 0));
  end component;

  component FF_J_K is
    port (J, K: in std_logic;
          CLR : in std_logic;
          CLK : in std_logic;
          Q : out std_logic);
  end component;

  component contSync is
    port (Enable, CLK, CLR: in std_logic;
          Qv: out std_logic_vector(3 downto 0));
  end component;

  component contHoras is
    port (Enable:     in std_logic;
          CLK:        in std_logic;
          CLR:        in std_logic;
          horas: out std_logic_vector(7 downto 0));
  end component;

  signal fr_segundos: std_logic;
  signal fr_minutos : std_logic;
  signal fr_horas:    std_logic;
  signal sVector: std_logic_vector(7 downto 0);

  begin
    div_fr0: div_fr port map ('1', CLK, CLR, fr_segundos, sVector);
    div_fr1: div_fr port map (fr_segundos, CLK, CLR, fr_minutos, segundos);
    div_fr2: div_fr port map (fr_minutos,  CLK, CLR, fr_horas, minutos);
    horas_0: contHoras port map (fr_horas, CLK, CLR, horas);

end arch;
