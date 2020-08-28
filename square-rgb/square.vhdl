library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity probando is
  port(clk: in std_logic;
      sh,sv,buzer:out std_logic;
      pulsador1,pulsador2,pulsador3,pulsador4: in std_logic;
      R,G,B:out std_logic_vector(2 downto 0));
end probando;

architecture solucion of probando is
signal fila: std_logic_vector(9 downto 0);
signal columna: std_logic_vector(9 downto 0);
signal ena_rgb,ena_rgb2: std_logic;
signal contador: std_logic_vector(20 downto 0);
signal salida1,salida2,salida3,salida4: std_logic;
type estados is (S0,S1,S2,S3);
type estados_2 is (S0_2,S1_2,S2_2,S3_2);
type estados_3 is (S0_3,S1_3,S2_3,S3_3);
type estados_2 is (S0_4,S1_4,S2_4,S3_4);
signal EA: estados;
signal EA_2: estados_2;
signal EA_3: estados_3;
signal EA_4: estados_4;
signal clk_2: std_logic;
signal a,n,c,d: std_logic_vector(9 downto 0);

component driver
port(clk: in std_logic;
      SH,SV: out std_logic;
      ena_rgb,ena_rgb2: BUFFER std_logic;
      fila,columna: buffer std_logic_vector(9 downto 0));
end component;

begin
buzzer <= '1';

  process(salida1)
  begin
  if salida1='1' then
    a<=a+"0000010100";
  end if;
  end process;
  
  process(salida4)
  begin
  if salida4='1' then
    n<=n+"0000010100";
  end if;
  end process;
  
  process(salida2)
  begin
  if salida2='1' then
    c<=c+"0000010100";
  end if;
  end process;
  
  process(salida3)
  begin
  if salida3='1' then
    d<=d+"0000010100";
  end if;
  end process;
  
process(FILA,COLUMNA,a,n,c,d)
  begin
    if FILA<=249-a+c and FILA>=229-a+c AND COLUMNA <=329+n-d AND COLUMNA>=309+n-d AND ena_rgb='1' and ena_rgb2='1' then
      R<="111";
      G<="111";
      B<="000";
    else
      R<="000";
      G<="000";
      B<="000";
    end if;
end process;

process(clk)
  begin
    if rising_edge(clk) then
      contador <= contador+1;
    end if;
end process;

clk_2 <= contador(20);

process(clk_2)
begin
  if rising_edge(clk_2) then
  case EA is 
    when S0=>salida1<='0';
    if pulsador1='0' then EA<= S0;
    else EA<=S1; end if;
    when S1=>salida1<='0';
    if pulsador1='0' then EA<= S0;
    else EA<=S2; end if;
    when S2=>salida1<='1';
    if pulsador1='0' then EA<= S3;
    else EA<=S2; end if;
    when S3=>salida1<='1';
    if pulsador1='0' then EA<= S0;
    else EA<=S2; end if;
  case EA_2 is 
    when S0_2=>salida2<='0';
    if pulsador2='0' then EA_2<= S0_2;
    else EA_2<=S1_2; end if;
    when S1_2=>salida2<='0';
    if pulsador2='0' then EA_2<= S0_2;
    else EA_2<=S2; end if;
    when S2_2=>salida2<='1';
    if pulsador2='0' then EA_2<= S3_2;
    else EA_2<=S2_2; end if;
    when S3_2=>salida2<='1';
    if pulsador2='0' then EA_2<= S0_2;
    else EA_2<=S2_2; end if;
  case EA_3 is 
    when S0_3=>salida3<='0';
    if pulsador3='0' then EA_3<= S0_3;
    else EA_3<=S1_3; end if;
    when S1_3=>salida3<='0';
    if pulsador3='0' then EA_3<= S0_3;
    else EA_3<=S2_3; end if;
    when S2_3=>salida3<='1';
    if pulsador3='0' then EA_3<= S3_3;
    else EA_3<=S2_3; end if;
    when S3_3=>salida3<='1';
    if pulsador3='0' then EA_3<= S0_3;
    else EA_3<=S2_3; end if;
  case EA_4 is 
    when S0_4=>salida4<='0';
    if pulsador4='0' then EA_4<= S0_4;
    else EA_4<=S1_4; end if;
    when S1_4=>salida4<='0';
    if pulsador4='0' then EA_4<= S0_4;
    else EA_4<=S2_4; end if;
    when S2_4=>salida4<='1';
    if pulsador4='0' then EA_4<= S3_4;
    else EA_4<=S2_4; end if;
    when S3_4=>salida4<='1';
    if pulsador4='0' then EA_4<= S0_4;
    else EA_4<=S2_4; end if;
  end case;
end if;
end process;

U0: driver PORT MAP(clk,sh,sv,ena_rgb,ena_rgb2,fila,columna);

end solucion;
