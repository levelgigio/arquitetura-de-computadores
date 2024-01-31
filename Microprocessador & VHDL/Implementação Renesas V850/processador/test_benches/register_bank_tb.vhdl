library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_bank_tb is
  end entity;
  architecture aregister_bank_tb of register_bank_tb is

    component register_bank is
      port( clk_r : in std_logic;
      rst_r : in std_logic;
      wr_en_r : in std_logic;
      data1_reg : in unsigned(2 downto 0); -- select which reg is read in data1
      data2_reg : in unsigned(2 downto 0);
      data_reg_wr: in unsigned(2 downto 0); -- which reg data is written
      data_wr : in unsigned(7 downto 0); -- data to be written
      data1_out : out unsigned(7 downto 0);
      data2_out : out unsigned(7 downto 0)
      );
    end component;

    signal clk,rst,wr_en : std_logic;
    signal reg2read1, reg2read2 : unsigned(2 downto 0);
    signal reg2write : unsigned(2 downto 0);
    signal data_in, data1_out, data2_out : unsigned(7 downto 0);

    begin
      uut: register_bank port map(
        clk_r=>clk, rst_r=>rst, wr_en_r=>wr_en,
        data1_reg=>reg2read1, data2_reg=>reg2read2,
        data_reg_wr=>reg2write, data_wr=>data_in,
        data1_out=>data1_out, data2_out=>data2_out
      );

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
        wait for 2 us;
      end process;

      process -- sinal write enable
      begin
        wr_en <= '1';
        wait for 1 us;
        wr_en <= '0';
        wait;
      end process;

      process -- sinais dos casos de teste
        begin
        reg2write <= "111";
        reg2read1 <= "000";
        reg2read2 <= "000";
        data_in <= "00001000";
        wait for 100 ns;
        reg2write <= "000";
        data_in <= "00001010";
        wait for 100 ns;
        reg2write <= "001";
        data_in <= "00011010";
        wait for 100 ns;
        reg2write <= "010";
        data_in <= "00111001";
        wait for 100 ns;
        reg2write <= "011";
        data_in <= "11101000";
        wait for 100 ns;
        reg2write <= "100";
        data_in <= "01111000";
        wait for 100 ns;
        reg2write <= "101";
        data_in <= "00001110";
        wait for 100 ns;
        reg2write <= "110";
        data_in <= "00111100";
        wait for 100 ns;
        reg2write <= "111";
        data_in <= "00101000";
        wait for 300 ns;
        reg2read1 <= "000";
        reg2read2 <= "001";
        wait for 100 ns;
        reg2read1 <= "010";
        reg2read2 <= "011";
        wait for 100 ns;
        reg2read1 <= "100";
        reg2read2 <= "101";
        wait for 100 ns;
        reg2read1 <= "110";
        reg2read2 <= "111";
        wait;
      end process;

end architecture;

      