library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc_tb is end entity;

architecture a_rom_pc_tb of rom_pc_tb is
    component rom_pc is
      port(
        clk_all : in std_logic;
        pc_en: in std_logic;
        jump_en : in std_logic;
        data_out : out unsigned(13 downto 0);
        pc_out : out unsigned(6 downto 0)
    );
    end component;

  signal clk, pc_wr_en, jp_en : std_logic;
  signal dado : unsigned(13 downto 0);

begin
    uut: rom_pc port map(
      clk_all=>clk,
      pc_en=>pc_wr_en,
      jump_en=>jp_en,
      data_out=>dado
    );

    process -- sinal de clock
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process -- sinais dos casos de teste
        begin
        pc_wr_en <= '1';
        jp_en <= '0';
        wait for 500 ns;
        pc_wr_en <= '0';
        wait for 500 ns;
        pc_wr_en <= '1';
        wait for 300 ns;
        jp_en <= '1';
        wait for 100 ns;
        jp_en <= '0';
        wait;
    end process;

end architecture;
