LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY state_machine IS
	PORT
	(
		clk       : IN std_logic;
		toggle_en : IN std_logic;
		rst       : IN std_logic;
		state     : OUT std_logic
	);
END ENTITY;
ARCHITECTURE a_state_machine OF state_machine IS
	SIGNAL state_i : std_logic := '0';
BEGIN
	state <= state_i WHEN rst = '0' ELSE '0';
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk) AND toggle_en = '1') THEN
			state_i <= NOT state_i;
		END IF;
	END PROCESS;
END ARCHITECTURE;