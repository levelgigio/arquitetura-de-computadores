library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc_ula_register_tb is end entity;

architecture a_rom_pc_ula_register_tb of rom_pc_ula_register_tb is
    component rom_pc_ula_register is
        port(
            clk_t : in std_logic;
            sel_ula_op: in unsigned(1 downto 0); -- operacao da ula
            rst_t : in std_logic; -- reset de todos os registradores do banco
            wr_en_t : in std_logic; -- write enable do banco de registradores
            pc_en_t : in std_logic;
            sel_reg_wr_t : in std_logic;
            jump_en_t : in std_logic;
            mux2_control : in unsigned(1 downto 0);
            rom_out : out unsigned(13 downto 0);
            ula_out_t : out unsigned(7 downto 0)
        );
    end component;

    signal clk, pc_en, jump_en, rst, wr_en : std_logic;
    signal ula_op : unsigned(1 downto 0);

    begin
        uut: rom_pc_ula_register port map(
            clk_t=>clk, 
            sel_ula_op=>ula_op, 
            rst_t=>rst, 
            wr_en_t=>wr_en, 
            pc_en_t=>pc_en, 
            jump_en_t=>jump_en
        );

        process -- sinal de clock
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end process;

        process
        begin 
            pc_en <= '0';
            wait for 100 ns;
            pc_en <= '1';
            wait for 100 ns;
        end process;

        process
        begin 
            rst <= '1';
            wait for 100 ns;
            rst <= '0';
            ula_op <= "00"; 
            wr_en <= '1'; 
            wait for 600 ns;
            wait;
        end process;

end architecture;