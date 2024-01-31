LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pc IS
	PORT
	(
		clk       		: IN std_logic;
		wr_en 				: IN std_logic;
		jump_en      : IN std_logic;
		data_in	: IN unsigned(6 DOWNTO 0);
		data_out					: OUT unsigned(6 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE a_pc OF pc IS
	COMPONENT register_7_bits IS
	PORT
	(
		clk      : IN std_logic;
		rst      : IN std_logic;
		wr_en    : IN std_logic;
		data_in  : IN unsigned(6 DOWNTO 0);
		data_out : OUT unsigned(6 DOWNTO 0)
	);
	END COMPONENT;
	SIGNAL data_out_i : unsigned(6 DOWNTO 0);
	SIGNAL data_in_i  : unsigned(6 DOWNTO 0) := "0000000";
BEGIN
	reg0 : register_7_bits
	PORT MAP
	(
		clk      => clk,
		rst      => '0',
		wr_en    => wr_en,
		data_in  => data_in_i,
		data_out => data_out_i
	);
	data_in_i <= data_out_i + 1 WHEN jump_en = '0' ELSE
	                    data_in;
	data_out <= data_out_i;
END ARCHITECTURE;