library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is end entity;

architecture a_processor_tb of processor_tb is
    component processor is
        port (
            clk : in std_logic;
            rst : in std_logic
        );
    end component;

    signal clk_i, rst_i : std_logic;

    begin
        uut: processor port map(
            clk=>clk_i, 
            rst=>rst_i
        );

        process -- sinal de clock
        begin
            clk_i <= '0';
            wait for 50 ns;
            clk_i <= '1';
            wait for 50 ns;
        end process;

        process
        begin
            rst_i <= '1';
            wait for 50 ns;
            rst_i <= '0';
            wait;
        end process;

end architecture;