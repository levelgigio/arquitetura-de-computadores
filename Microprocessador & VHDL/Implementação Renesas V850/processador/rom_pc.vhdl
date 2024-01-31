library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc is
    port(
        clk_all : in std_logic;
        pc_en: in std_logic;
        jump_en : in std_logic;
        data_out : out unsigned(13 downto 0);
        pc_out : out unsigned(6 downto 0)
    );
end entity;

architecture a_rom_pc of rom_pc is

  component rom is
    port(
      clk : in std_logic;
      endereco : in unsigned(6 downto 0);
      dado : out unsigned(13 downto 0)
    );
  end component;

  component pc is
    port(
      pc_clk : in std_logic;
      pc_wr_en : in std_logic;
      pc_jump_en: in std_logic;
      pc_jump_control: in unsigned(6 downto 0);
      pc_data_out : out unsigned(6 downto 0)
    );
  end component;

    signal saida_pc: unsigned(6 downto 0);
    signal saida_rom: unsigned(13 downto 0);
    signal pc_jump_control_sig: unsigned(6 downto 0);

    -- signal pc_wr : std_logic;
    -- signal toggle_en_sig : std_logic;
    -- signal reset_sig : std_logic;
    -- signal saida_state: std_logic;

  begin
    pc0: pc port map (
      pc_clk=>clk_all,
      pc_wr_en=>pc_en, 
      pc_jump_en=> jump_en,
      pc_jump_control => pc_jump_control_sig,
      pc_data_out=>saida_pc
    );

    rom0: rom port map (
      clk=>clk_all, 
      endereco=>saida_pc, 
      dado=>saida_rom
    );

    pc_out <= saida_pc;
    data_out <= saida_rom;

    pc_jump_control_sig <= saida_rom(9 downto 3) + saida_pc;

end architecture;
