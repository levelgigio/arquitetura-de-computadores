LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY mux_2x1_3_bits IS
  PORT 
	(
    sel : in std_logic;
		data_0_in : in unsigned(2 downto 0);
    data_1_in : in unsigned(2 downto 0);
    data_out : out unsigned(2 downto 0)
  );
END ENTITY;
ARCHITECTURE a_mux_2x1_3_bits OF mux_2x1_3_bits IS
BEGIN
  	data_out <= data_0_in when sel = '0' else
                data_1_in when sel = '1' else
                "000";
END ARCHITECTURE;