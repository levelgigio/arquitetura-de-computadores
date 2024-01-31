library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg8bits_tb is
end entity;
architecture areg8bits_tb of reg8bits_tb is
 component reg8bits is
  port( clk : in std_logic;
  rst : in std_logic;
  wr_en : in std_logic;
  data_in : in unsigned(7 downto 0);
  data_out : out unsigned(7 downto 0)
  );
 end component;

  signal clk,rst,wr_en : std_logic;
  signal data_in, data_out : unsigned(7 downto 0);

begin
  uut: reg8bits port map(clk=>clk,rst=>rst,wr_en=>wr_en,data_in=>data_in,
  data_out=>data_out);
  process -- sinal de clock
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;
  end process;

  process -- sinal de reset
  begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait for 600 ns;
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait;
  end process;

  process -- sinais dos casos de teste
    begin
    wait for 200 ns;
    wr_en <= '1';
    data_in <= "11111111";
    wait for 100 ns;
    data_in <= "10001010";
    wait;
  end process;
end architecture;
