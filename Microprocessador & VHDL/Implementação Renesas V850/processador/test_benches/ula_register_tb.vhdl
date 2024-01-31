library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_register_tb is end entity;

architecture a_register_tb of ula_register_tb is
    component ula_register is
        port(
            sel_t: in unsigned(1 downto 0);
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            sel_reg_wr : in std_logic; -- seleciona o reg para colocar no data write
            data1_sel : in unsigned(2 downto 0); -- select which reg is read in data1
            data2_sel : in unsigned(2 downto 0);
            data_reg_wr_t: in unsigned(2 downto 0); -- which reg data is written
            data_wr_t : in unsigned(7 downto 0); -- data to be written
            data2_in : in unsigned(7 downto 0);
            register2_out : out unsigned(7 downto 0);
            saida_ula : out unsigned(7 downto 0)
        );
    end component;

    signal clk, rst, wr_en_s, mux_reg_wr : std_logic;
    signal sel : unsigned(1 downto 0);
    signal data1_sel, data2_sel : unsigned(2 downto 0);
    signal data_reg_wr : unsigned(2 downto 0);
    signal data_wr, constante : unsigned(7 downto 0);
    signal juncao : unsigned(7 downto 0);

    begin
        uut: ula_register port map(sel_t=>sel, clk=>clk, rst=>rst,wr_en=>wr_en_s, 
            sel_reg_wr=>mux_reg_wr, data1_sel=>data1_sel, data2_sel=>data2_sel,
            data_reg_wr_t=>data_reg_wr, data_wr_t=>constante, data2_in=>juncao, register2_out=>juncao, saida_ula=>data_wr);

        process -- sinal de clock
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end process;

        process 
        begin
            rst <= '1';
            wait for 100 ns;
            rst <= '0';
            mux_reg_wr <= '1';
            wr_en_s <= '1';
            constante <= "00000010";
            data_reg_wr <= "001";
            wait for 100 ns;
            wr_en_s <= '1';
            constante <= "00000011";
            data_reg_wr <= "010";
            wait for 100 ns;
            sel <= "00";
            wr_en_s <= '0';
            constante <= data_wr;
            data1_sel <= "001";
            data2_sel <= "010";
            data_reg_wr <= "001";
            wait for 300 ns;
            sel <= "00";
            mux_reg_wr <= '0';
            wr_en_s <= '1';
            constante <= data_wr;
            data1_sel <= "001";
            data2_sel <= "010";
            data_reg_wr <= "001";
            wait for 100 ns;
            wait;
        end process;




end architecture;