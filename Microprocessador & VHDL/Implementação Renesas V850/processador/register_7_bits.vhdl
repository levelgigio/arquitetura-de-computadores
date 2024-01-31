LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY register_7_bits IS
	PORT
	(
		clk      : IN std_logic;
		rst      : IN std_logic;
		wr_en    : IN std_logic;
		data_in  : IN unsigned(6 DOWNTO 0);
		data_out : OUT unsigned(6 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE a_register_7_bits OF register_7_bits IS
	SIGNAL stored : unsigned(6 DOWNTO 0) := "0000000";
BEGIN
	PROCESS (clk, rst, wr_en)
	BEGIN
		IF rst = '1' THEN
			stored <= "0000000";
		ELSIF wr_en = '1' THEN
			IF rising_edge(clk) THEN
				stored <= data_in;
			END IF;
		END IF;
	END PROCESS;
	data_out <= stored; -- hard wire connection, out of process
END ARCHITECTURE;