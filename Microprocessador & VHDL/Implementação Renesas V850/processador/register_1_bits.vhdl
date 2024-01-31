LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY register_1_bits IS
	PORT
	(
		clk      : IN std_logic;
		rst      : IN std_logic;
		wr_en    : IN std_logic;
		data_in  : IN std_logic;
		data_out : OUT std_logic
	);
END ENTITY;
ARCHITECTURE a_register_1_bits OF register_1_bits IS
	SIGNAL stored : std_logic := '0';
BEGIN
	PROCESS (clk, rst, wr_en)
	BEGIN
		IF rst = '1' THEN
			stored <= '0';
		ELSIF wr_en = '1' THEN
			IF rising_edge(clk) THEN
				stored <= data_in;
			END IF;
		END IF;
	END PROCESS;
	data_out <= stored; -- hard wire connection, out of process
END ARCHITECTURE;