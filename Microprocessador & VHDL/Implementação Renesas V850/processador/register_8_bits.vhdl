LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY register_8_bits IS
	PORT
	(
		clk      : IN std_logic;
		rst      : IN std_logic;
		wr_en    : IN std_logic;
		data_in  : IN unsigned(7 DOWNTO 0);
		data_out : OUT unsigned(7 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE a_register_8_bits OF register_8_bits IS
	SIGNAL stored : unsigned(7 DOWNTO 0) := "00000000";
BEGIN
	PROCESS (clk, rst, wr_en)
	BEGIN
		IF rst = '1' THEN
			stored <= "00000000";
		ELSIF wr_en = '1' THEN
			IF rising_edge(clk) THEN
				stored <= data_in;
			END IF;
		END IF;
	END PROCESS;
	data_out <= stored; -- hard wire connection, out of process
END ARCHITECTURE;