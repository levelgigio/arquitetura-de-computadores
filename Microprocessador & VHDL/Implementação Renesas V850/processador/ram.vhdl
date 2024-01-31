LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ram IS
	PORT
	(
		clk      : IN std_logic;
		addr     : IN unsigned(6 DOWNTO 0);
		wr_en    : IN std_logic;
		data_in  : IN unsigned(7 DOWNTO 0);
		data_out : OUT unsigned(7 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE a_ram OF ram IS
	TYPE mem IS ARRAY (0 TO 127) OF unsigned(7 DOWNTO 0);
	SIGNAL content : mem;
BEGIN
	PROCESS (clk, wr_en)
	BEGIN
		IF rising_edge(clk) THEN
			IF wr_en = '1' THEN
				content(to_integer(addr)) <= data_in;
			END IF;
		END IF;
	END PROCESS;
	data_out <= content(to_integer(addr));
END ARCHITECTURE;