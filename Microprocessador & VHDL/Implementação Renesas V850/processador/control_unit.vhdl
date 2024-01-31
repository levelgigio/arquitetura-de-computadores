LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY control_unit IS
	PORT
	(
		clk                 : IN std_logic;
		opcode              : IN unsigned(3 DOWNTO 0);
		s_flag              : IN std_logic; -- flag s do processador indicando negativo
		pc_wr_en            : OUT std_logic;
		pc_jump_en          : OUT std_logic;
		mux0_sel           	: OUT unsigned(1 DOWNTO 0); -- mux que ta na saida do data2 e entrada da ula
		mux1_sel           	: OUT unsigned(1 DOWNTO 0);
		mux2_sel						: OUT std_logic;
		register_bank_wr_en : OUT std_logic;
		ula_op_sel          : OUT unsigned(1 DOWNTO 0);
		cmp                 : OUT std_logic;
		ram_wr_en           : OUT std_logic -- when trying to store in a register. aka when doing STW
	);
END ENTITY;
ARCHITECTURE a_control_unit OF control_unit IS
	COMPONENT state_machine IS
		PORT
		(
			clk       : IN std_logic;
			toggle_en : IN std_logic;
			rst       : IN std_logic;
			state     : OUT std_logic
		);
	END COMPONENT;
	SIGNAL state_i : std_logic;
BEGIN
	state_machine0 : state_machine
	PORT MAP(clk => clk, toggle_en => '1', rst => '0', state => state_i);
	pc_wr_en   <= '1' WHEN state_i = '0' OR ((opcode = "0101" OR (opcode = "0111" AND s_flag = '1')) AND state_i = '1') ELSE '0';
	pc_jump_en <= '1' WHEN state_i = '1' AND (opcode = "0101" OR (opcode = "0111" AND s_flag = '1')) ELSE '0';
	mux0_sel  <= "00" WHEN state_i = '1' AND (opcode = "0001" OR opcode = "0011" OR opcode = "0110") ELSE
	              "01" WHEN state_i = '1' AND (opcode = "0010" OR opcode = "0110") ELSE
	              "10" WHEN state_i = '1' AND (opcode = "0100") ELSE 
                "00";
	mux1_sel <= "00" WHEN (state_i = '1' AND opcode = "0010") and NOT(state_i = '1' AND opcode = "1000") ELSE
							"01" WHEN NOT(state_i = '1' AND opcode = "0010") and NOT(state_i = '1' AND opcode = "1000") ELSE
							"10" WHEN state_i = '1' AND opcode = "1000" else
              "00";
	register_bank_wr_en <= '1' WHEN state_i = '1' AND (opcode = "0001" OR opcode = "0011" OR opcode = "0010" OR opcode = "0100" OR opcode = "1000") ELSE '0';
	ula_op_sel          <= "01" WHEN state_i = '1' AND (opcode = "0011" OR opcode = "0110") ELSE "00";
	mux2_sel         		<= '0' WHEN state_i = '1' AND opcode = "0010" ELSE '1';
	ram_wr_en           <= '1' WHEN state_i = '1' AND opcode = "1001" ELSE '0'; --STW
	cmp                 <= '1' WHEN state_i = '1' AND opcode = "0110" ELSE '0';
END ARCHITECTURE;