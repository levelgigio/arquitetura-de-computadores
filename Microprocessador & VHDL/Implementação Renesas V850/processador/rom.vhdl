LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY rom IS
	PORT
	(
		clk  			: IN std_logic;
		addr 			: IN unsigned(6 DOWNTO 0);
		instruction  : OUT unsigned(13 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE a_rom OF rom IS
	TYPE mem IS ARRAY (0 TO 127) OF unsigned (13 DOWNTO 0);
	CONSTANT content : mem := (
	--=BEGIN_AUTOMATION

		-- ADDI R1 0	
		0 => "00100010000000",
		-- ADDI R2 1
		1 => "00100100000001",
		-- ADDI R3 32
		2 => "00100110100000",
		others => (others=>'0')

	--=END_AUTOMATION
	);
BEGIN
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			instruction <= content(to_integer(addr));
		END IF;
	END PROCESS;
END ARCHITECTURE;