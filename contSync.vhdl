library ieee;
use ieee.std_logic_1164.all;

entity contSync is
  port (Enable, CLK, CLR: in std_logic;
        Qv: out std_logic_vector(3 downto 0));
end entity;


architecture arch of contSync is
  component FF_J_K is
    port (J, K: in std_logic;
          CLR : in std_logic;
          CLK : in std_logic;
          Q : out std_logic);
  end component;

  signal sQvector: std_logic_vector (3 downto 0) := "0000";
  signal sAnd0: std_logic;
  signal sAnd1: std_logic;
  signal sAnd2: std_logic;
  signal sAnd3: std_logic;
  signal sOr:   std_logic;

  begin
    Q3: FF_J_K port map ('1', '1', CLR, CLK, sQvector(3));
    sAnd0 <= (sQvector(3) and not sQvector(0));
    Q2: FF_J_K port map (sAnd0, sAnd0, CLR, CLK, sQvector(2));
    sAnd1 <= (sQvector(2) and sQvector(3));
    Q1: FF_J_K port map (sAnd1, sAnd1, CLR, CLK, sQvector(1));
    sAnd2 <= (sQvector(1) and sAnd1);
    sAnd3 <= (sQvector(0) and sQvector(3));
    sOr <= (sAnd2 or sAnd3);
    Q0: FF_J_K port map (sOr, sOr, CLR, CLK, sQvector(0));

    Qv <= (sQvector(0), sQvector(1), sQvector(2), sQvector(3));

end arch;
