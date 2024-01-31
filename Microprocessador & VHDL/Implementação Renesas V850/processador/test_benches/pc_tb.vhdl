library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity;
architecture apc_tb of pc_tb is
 component pc is
  port(
    pc_clk : in std_logic;
    pc_wr_en : in std_logic;
    pc_jump_en: in std_logic;
    pc_jump_control: in unsigned(6 downto 0);
    pc_data_out : out unsigned(6 downto 0)
  );
 end component;

  signal clk,wr_en,jump_en : std_logic;
  signal jump_c ,data_out : unsigned(6 downto 0);

begin
  uut: pc port map(
    pc_clk=>clk,
    pc_wr_en=>wr_en,
    pc_jump_en=>jump_en,
    pc_jump_control=>jump_c,
    pc_data_out=>data_out);

  process -- sinal de clock
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;
  end process;

  process -- sinais dos casos de teste
    begin
      jump_en <= '0'; 
      wr_en <= '1';
      wait for 400 ns;
      wr_en <= '0';
      wait for 400 ns;
      wr_en <= '1';
      wait for 100 ns;
      jump_en <= '1';
      jump_c <= "0000010";
      wait for 100 ns;
      jump_en <= '0';
      wait;
  end process;
end architecture;
