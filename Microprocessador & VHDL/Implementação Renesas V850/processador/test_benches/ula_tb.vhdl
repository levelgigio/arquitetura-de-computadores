library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is end entity;

architecture a_ula_tb of ula_tb is
    component ula is
        port(
            sel: in unsigned(1 downto 0);
            in0, in1: in unsigned(7 downto 0);
            saida: out unsigned(7 downto 0)
        );
end component;

signal sig0, sig1: unsigned(7 downto 0);
signal selsig: unsigned(1 downto 0);

begin
    uut: ula port map(in0=>sig0, in1=>sig1, sel=>selsig); 
    process
    begin
        selsig <= "00";
        sig0 <= "00000001";
        sig1 <= "00000101";
        wait for 50 ns; 
        selsig <= "01";
        sig0 <= "00000001";
        sig1 <= "00000101";
        wait for 50 ns; 
        selsig <= "10";
        sig0 <= "00000001";
        sig1 <= "00000101";
        wait for 50 ns; 
        selsig <= "10";
        sig0 <= "00000101";
        sig1 <= "00000001";
        wait for 50 ns; 
        selsig <= "11";
        sig0 <= "00000011";
        sig1 <= "00000101";
        wait for 50 ns;
end process; 
end architecture;