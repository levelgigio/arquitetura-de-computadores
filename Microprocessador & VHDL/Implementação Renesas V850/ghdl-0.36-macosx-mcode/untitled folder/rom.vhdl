library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk : in std_logic;
        endereco : in unsigned(6 downto 0);
        dado : out unsigned(11 downto 0)
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned (11 downto 0);
    constant conteudo_rom : mem := (
        0 => "000000000001",
        1 => "000000000010",
        2 => "000000000011",
        3 => "000000000100",
        4 => "000000000101",
        others => (others=>'0')
    );

begin 
    process(clk)
    begin
        if(rising_edge(clk)) then
            dado <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;

