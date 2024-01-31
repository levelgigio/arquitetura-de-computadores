LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ula IS
  PORT 
	(
		-- ULA Select Operation | +(00) | -(01) | >=(10) | *(11) |
		op_sel               : IN unsigned(1 DOWNTO 0);
		data_0_in, data_1_in : IN unsigned(7 DOWNTO 0);
		result               : OUT unsigned(7 DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE a_ula OF ula IS
  	SIGNAL greater_than, sum, minus : unsigned(7 DOWNTO 0);
  	SIGNAL multiplication           : unsigned(15 DOWNTO 0);
BEGIN
  	multiplication <= data_0_in * data_1_in;
  	greater_than   <= "00000001" WHEN data_0_in >= data_1_in AND data_0_in(7) = data_1_in(7) ELSE
											"00000001" WHEN data_0_in(7) < data_1_in(7) ELSE
											"00000000";
  	sum            <= data_0_in + data_1_in;
  	minus          <= data_1_in - data_0_in;

  	result <= sum WHEN op_sel = "00" ELSE
							minus WHEN op_sel = "01" ELSE
							greater_than WHEN op_sel = "10" ELSE
							multiplication(7 DOWNTO 0) WHEN op_sel = "11" ELSE
							"00000000";
END ARCHITECTURE;