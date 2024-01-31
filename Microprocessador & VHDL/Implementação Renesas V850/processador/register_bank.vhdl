LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY register_bank IS
	PORT
	(
		clk        : IN std_logic;
		rst        : IN std_logic;
		wr_en      : IN std_logic;
		data_0_sel : IN unsigned(2 DOWNTO 0); -- select which reg is read in data1
		data_1_sel : IN unsigned(2 DOWNTO 0);
		wr_sel     : IN unsigned(2 DOWNTO 0); -- which reg data is written
		data_in    : IN unsigned(7 DOWNTO 0); -- data to be written
		data_0_out : OUT unsigned(7 DOWNTO 0);
		data_1_out : OUT unsigned(7 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE a_register_bank OF register_bank IS
	COMPONENT register_8_bits IS
		PORT
    (
      clk      : IN std_logic;
      rst      : IN std_logic;
      wr_en    : IN std_logic;
      data_in  : IN unsigned(7 DOWNTO 0);
      data_out : OUT unsigned(7 DOWNTO 0)
    );
	END COMPONENT;
	SIGNAL reg1_wr_en, reg2_wr_en, reg3_wr_en, reg4_wr_en, reg5_wr_en, reg6_wr_en, reg7_wr_en                                     : std_logic;
	SIGNAL data_in_i                                                                                                     : unsigned(7 DOWNTO 0);
	SIGNAL reg0_data_out, reg1_data_out, reg2_data_out, reg3_data_out, reg4_data_out, reg5_data_out, reg6_data_out, reg7_data_out : unsigned(7 DOWNTO 0);
BEGIN
	--registers mapping
	reg0 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => '0',
		wr_en => '1', 
    data_in => "00000000", 
    data_out => reg0_data_out
	);
	reg1 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => rst,
		wr_en => reg1_wr_en, 
    data_in => data_in_i, 
    data_out => reg1_data_out
	);
	reg2 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => rst,
		wr_en => reg2_wr_en, 
    data_in => data_in_i, 
    data_out => reg2_data_out
	);
	reg3 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => rst,
		wr_en => reg3_wr_en, 
    data_in => data_in_i, 
    data_out => reg3_data_out
	);
	reg4 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => rst,
		wr_en => reg4_wr_en, 
    data_in => data_in_i, 
    data_out => reg4_data_out
	);
	reg5 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => rst,
		wr_en => reg5_wr_en, 
    data_in => data_in_i, 
    data_out => reg5_data_out
	);
	reg6 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => rst,
		wr_en => reg6_wr_en, 
    data_in => data_in_i, 
    data_out => reg6_data_out
	);
	reg7 : register_8_bits
	PORT MAP
	(
		clk => clk, 
    rst => rst,
		wr_en => reg7_wr_en, 
    data_in => data_in_i, 
    data_out => reg7_data_out
	);
	data_in_i <= data_in;
	reg1_wr_en <= '1' WHEN wr_sel = "001" AND wr_en = '1' ELSE '0';
	reg2_wr_en <= '1' WHEN wr_sel = "010" AND wr_en = '1' ELSE '0';
	reg3_wr_en <= '1' WHEN wr_sel = "011" AND wr_en = '1' ELSE '0';
	reg4_wr_en <= '1' WHEN wr_sel = "100" AND wr_en = '1' ELSE '0';
	reg5_wr_en <= '1' WHEN wr_sel = "101" AND wr_en = '1' ELSE '0';
	reg6_wr_en <= '1' WHEN wr_sel = "110" AND wr_en = '1' ELSE '0';
	reg7_wr_en <= '1' WHEN wr_sel = "111" AND wr_en = '1' ELSE '0';
	data_0_out <= reg0_data_out WHEN data_0_sel = "000" ELSE
	                       reg1_data_out WHEN data_0_sel = "001" ELSE
	                       reg2_data_out WHEN data_0_sel = "010" ELSE
	                       reg3_data_out WHEN data_0_sel = "011" ELSE
	                       reg4_data_out WHEN data_0_sel = "100" ELSE
	                       reg5_data_out WHEN data_0_sel = "101" ELSE
	                       reg6_data_out WHEN data_0_sel = "110" ELSE
	                       reg7_data_out WHEN data_0_sel = "111" ELSE
	                       "00000000";
	data_1_out <= reg0_data_out WHEN data_1_sel = "000" ELSE
	                       reg1_data_out WHEN data_1_sel = "001" ELSE
	                       reg2_data_out WHEN data_1_sel = "010" ELSE
	                       reg3_data_out WHEN data_1_sel = "011" ELSE
	                       reg4_data_out WHEN data_1_sel = "100" ELSE
	                       reg5_data_out WHEN data_1_sel = "101" ELSE
	                       reg6_data_out WHEN data_1_sel = "110" ELSE
	                       reg7_data_out WHEN data_1_sel = "111" ELSE
	                       "00000000";
END ARCHITECTURE;