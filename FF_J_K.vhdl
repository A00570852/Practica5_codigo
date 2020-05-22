library ieee;
use ieee.std_logic_1164.all;

entity FF_J_K is
  port (J, K: in std_logic;
        CLR : in std_logic;
        CLK : in std_logic;
        Q : out std_logic);
end entity;

architecture ecuacion of FF_J_K is
  signal Qs: std_logic;

begin
  Qs <= '0';
  process(CLR,CLK)
  begin
    if CLR = '1' then Q <= '0';
    elsif CLK = '1' and CLK'event then
      Q  <= (J and not Qs) or (not K and Qs);
    else null;
    end if;
  end process;
end ecuacion;
