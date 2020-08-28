library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity probando is
  port(clk: in std_logic;
       sh,sv,buzzer:out std_logic;
       leds: out std_logic_vector(7 downto 0);
       R,G,B: out std_logic_vector(2 downto 0));
end probando;

architecture solucion of probando is
signal fila:std_logic_vector(9 downto 0);
signal columna: std_logic_vector(9 downto 0);
signal ena_rgb,ena_rgb2: std_logic;
signal cuenta3: std_logic_vector(24 downto 0);
signal clk2: std_logic;
signal CU: std_logic_vector(1 downto 0);

component driver
port(clk: in std_logic;
      SH,SV: out std_logic;
      ena_rgb,ena_rgb2: BUFFER std_logic;
      fila,columna: buffer std_logic_vetor(9 downto 0));
end component

begin
buzzer <= '1';

processs(fila,columna)
  begin
  -------------CUADRADOS PINTADOS-----------
  if((columna>7 and columna<78) or (columna>560 and columna<631)) and (fila>203 and fila<274) and CU="00" AND ena_rgb='1' and ena_rgb2='1' then 
  R<="000";G<="000";B<="111";
  elsif((columna>86 and columna<157) or (columna>481 and columna<552)) and (fila>203 and fila<274) and CU="01" AND ena_rgb='1' and ena_rgb2='1' then 
  R<="000";G<="000";B<="111";
  elsif((columna>165 and columna<236) or (columna>402 and columna<473)) and (fila>203 and fila<274) and CU="10" AND ena_rgb='1' and ena_rgb2='1' then 
  R<="000";G<="000";B<="111";
  elsif((columna>244 and columna<315) or (columna>323 and columna<394)) and (fila>203 and fila<274) and CU="11" AND ena_rgb='1' and ena_rgb2='1' then 
  R<="000";G<="000";B<="111";
  else
  R<="000";G<="000";B<="000";
  end if;
end process;

process(clk)
  begin
    if rising_edge(clk) then
      cuenta3 <= cuenta3 + 1;
      if cuenta3=25000000 then
        cuenta3<=(others=>'0');
        clk2<=NOT clk2;
      end if;
   end if;
end process;

process(clk2)
begin
if rising_edge(clk2) then
  CU<CU+1;
  
  case CU is
  when "00"=>leds<="10111101";
  when "01"=>leds<="11011011";
  when "10"=>leds<="11100111";
  when others=>leds<="01111110";
  end case;
end if;
end process;

U0: driver PORT MAP(clk,sh,sv,ena_rgb,ena_rgb2,fila,columna);
end solucion;
