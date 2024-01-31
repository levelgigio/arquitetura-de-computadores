LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY mux_4x1_8_bits IS
  PORT 
	(
    sel : in unsigned(1 downto 0);
		data_0_in : in unsigned(7 downto 0);
    data_1_in : in unsigned(7 downto 0);
    data_2_in : in unsigned(7 downto 0);
    data_3_in : in unsigned(7 downto 0);
    data_out : out unsigned(7 downto 0)
  );
END ENTITY;
ARCHITECTURE a_mux_4x1_8_bits OF mux_4x1_8_bits IS
BEGIN
  	data_out <= data_0_in when sel = "00" else
                data_1_in when sel = "01" else
                data_2_in when sel = "10" else
                data_3_in when sel = "11" else
                "00000000";
END ARCHITECTURE;