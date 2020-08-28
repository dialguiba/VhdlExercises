library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity driver is 
  port(clk: in std_logic;
        SH,SV: out std_logic;
        fila,columna: buffer std_logic_vector(9 downto 0);
        end_rgb,ena_rgb2: BUFFER std_logic);
end driver;

architecture solucion of driver is
  signal x: std_logic;
begin
  process(clk)
  begin
    if rising_edge(clk) then
      x<=not x;
    end if;
  end process;
  
  process(x)
  begin
    if rising_edge(x) then
      COLUMNA <= COLUMNA +1;
      if COLUMNA = 799 then
        COLUMNA <= (OTHERS=>'0');
      end if;
      if COLUMNA < 640 then
        ena_rgb<='1';
      else 
        ena_rgb<='0';
      end if;
      if COLUMNA>661 and COLUMNA<756 then
        SH<='0';
      else
        SH<='1';
      end if;
    end if;
 end process;
 
 process(ena_rgb)
 begin
  if rising_edge(ena_rgb) then
    FILA <= FILA+1;
    if FILA =523 then
      FILA =< (OTHERS=>'0');
    end if;
    if FILA > 491 and FILA < 494 then
      SV <= '0';
    else
      SV <= '1';
    end if;
    if FILA < 480 then
      ena_rgb2 <= '1';
    else 
      ena_rgb <= '0';
    end if;
  end if;
end process;
end solucion;
