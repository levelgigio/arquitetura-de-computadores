library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_tb is end entity;

architecture a_state_machine_tb of state_machine_tb is
    component state_machine is
        port(
            clk : in std_logic;
            toggle_en : in std_logic;
            saida_q : out std_logic;
            saida_q_linha : out std_logic;
            reset : in std_logic
        );
    end component;

    signal clk, toggle_en, reset : std_logic;

    begin
    uut: state_machine port map(clk=>clk, reset=>reset, toggle_en=>toggle_en);

    process -- sinal de clock
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process -- sinal de clock
    begin
        toggle_en <= '0';
        wait for 300 ns;
        toggle_en <= '1';
        wait for 300 ns;
    end process;

    process -- sinal de reset
    begin
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 400 ns;
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait;
    end process;

end architecture;

