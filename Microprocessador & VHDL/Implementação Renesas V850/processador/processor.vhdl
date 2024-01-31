LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY processor IS
	PORT (
		clk : IN std_logic;
		rst : IN std_logic
	);
END ENTITY;
ARCHITECTURE a_processor OF processor IS
	COMPONENT control_unit IS
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
	END COMPONENT;
	COMPONENT ram IS
		PORT (
			clk      : IN std_logic;
			addr     : IN unsigned(6 DOWNTO 0);
			wr_en    : IN std_logic;
			data_in  : IN unsigned(7 DOWNTO 0);
			data_out : OUT unsigned(7 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT rom IS
		PORT (
			clk      : IN std_logic;
			addr     : IN unsigned(6 DOWNTO 0);
			instruction : OUT unsigned(13 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT pc IS
		PORT (
			clk      : IN std_logic;
			wr_en    : IN std_logic;
			jump_en  : IN std_logic;
			data_in  : IN unsigned(6 DOWNTO 0);
			data_out : OUT unsigned(6 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT ula IS
		PORT (
			-- ULA Select Operation | +(00) | -(01) | >=(10) | *(11) |
			op_sel               : IN unsigned(1 DOWNTO 0);
			data_0_in, data_1_in : IN unsigned(7 DOWNTO 0);
			result               : OUT unsigned(7 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT register_bank IS
		PORT (
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
	END COMPONENT;
	COMPONENT register_1_bits IS
		PORT (
			clk      : IN std_logic;
			rst      : IN std_logic;
			wr_en    : IN std_logic;
			data_in  : IN std_logic;
			data_out : OUT std_logic
		);
	END COMPONENT;

	COMPONENT mux_4x1_8_bits IS
		PORT (
			sel       : IN unsigned(1 DOWNTO 0);
			data_0_in : IN unsigned(7 DOWNTO 0);
			data_1_in : IN unsigned(7 DOWNTO 0);
			data_2_in : IN unsigned(7 DOWNTO 0);
			data_3_in : IN unsigned(7 DOWNTO 0);
			data_out  : OUT unsigned(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux_2x1_3_bits IS
		PORT (
			sel       : IN std_logic;
			data_0_in : IN unsigned(2 DOWNTO 0);
			data_1_in : IN unsigned(2 DOWNTO 0);
			data_out  : OUT unsigned(2 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL s_flag_data_out, ctrl_pc_wr_en, ctrl_pc_jump_en : std_logic;
	SIGNAL ctrl_mux0_sel : unsigned (1 DOWNTO 0); -- poderia ser std_logic TODO arrumar isso
	SIGNAL ctrl_ula_op_sel, ctrl_mux1_sel : unsigned (1 DOWNTO 0);
	SIGNAL ctrl_register_bank_wr_en, ctrl_s_flag_wr_en, ctrl_mux2_sel : std_logic;
	SIGNAL ctrl_ram_wr_en : std_logic;
	SIGNAL ram_data_out, ula_result, register_bank_data_0_out, register_bank_data_1_out, mux0_data_out, mux1_data_out, mux0_data_1_in, mux1_data_1_in : unsigned(7 DOWNTO 0);
	SIGNAL rom_instruction : unsigned(13 DOWNTO 0);
	SIGNAL pc_data_in, pc_data_out : unsigned(6 DOWNTO 0);
	SIGNAL mux2_data_out : unsigned(2 DOWNTO 0);

BEGIN
	control_unit0 : control_unit
	PORT MAP(
		clk                 => clk,
		opcode              => rom_instruction(13 DOWNTO 10),
		s_flag              => s_flag_data_out,
		pc_wr_en            => ctrl_pc_wr_en,
		pc_jump_en          => ctrl_pc_jump_en,
		mux0_sel           	=> ctrl_mux0_sel,
		mux1_sel     		=> ctrl_mux1_sel,
		mux2_sel			=> ctrl_mux2_sel,
		register_bank_wr_en => ctrl_register_bank_wr_en,
		ula_op_sel          => ctrl_ula_op_sel,
		cmp                 => ctrl_s_flag_wr_en,
		ram_wr_en           => ctrl_ram_wr_en
	);
	ram0 : ram
	PORT MAP(
		clk => clk,
		addr => register_bank_data_0_out(6 DOWNTO 0),
		wr_en => ctrl_ram_wr_en,
		data_in => register_bank_data_1_out,
		data_out => ram_data_out
	);
	rom0 : rom
	PORT MAP(
		clk         => clk,
		addr        => pc_data_out,
		instruction => rom_instruction
	);
	pc0 : pc
	PORT MAP(
		clk      => clk,
		wr_en    => ctrl_pc_wr_en,
		jump_en  => ctrl_pc_jump_en,
		data_in  => pc_data_in,
		data_out => pc_data_out
	);
	ula0 : ula
	PORT MAP(
		op_sel    => ctrl_ula_op_sel,
		data_0_in => register_bank_data_0_out,
		data_1_in => mux0_data_out,
		result    => ula_result
	);
	register_bank0 : register_bank
	PORT MAP(
		clk        => clk,
		rst        => rst,
		wr_en      => ctrl_register_bank_wr_en,
		data_0_sel => rom_instruction(9 DOWNTO 7),
		data_1_sel => rom_instruction(6 DOWNTO 4),
		wr_sel     => mux2_data_out,
		data_in    => mux1_data_out,
		data_0_out => register_bank_data_0_out,
		data_1_out => register_bank_data_1_out
	);
	s_flag0 : register_1_bits
	PORT MAP(
		clk      => clk,
		rst      => rst,
		wr_en    => ctrl_s_flag_wr_en,
		data_in  => ula_result(7),
		data_out => s_flag_data_out
	);
	mux0 : mux_4x1_8_bits
	PORT MAP(
		sel 	  => ctrl_mux0_sel,
		data_0_in => register_bank_data_1_out,
		data_1_in => mux0_data_1_in,
		data_2_in => "00000000",
		data_3_in => "00000000",
		data_out  => mux0_data_out
	);
	mux1 : mux_4x1_8_bits
	PORT MAP(
		sel => ctrl_mux1_sel,
		data_0_in => ula_result,
		data_1_in => mux1_data_1_in,
		data_2_in => ram_data_out,
		data_3_in => "00000000",
		data_out  => mux1_data_out
	);
	mux2 : mux_2x1_3_bits
	PORT MAP(
		sel => ctrl_mux2_sel,
		data_0_in => rom_instruction(6 DOWNTO 4),
		data_1_in => rom_instruction(9 DOWNTO 7),
		data_out  => mux2_data_out
	);

	pc_data_in 		<= rom_instruction(9 DOWNTO 3) + pc_data_out;
	mux0_data_1_in 	<= rom_instruction(6) & rom_instruction(6 DOWNTO 0);
	mux1_data_1_in 	<= rom_instruction(6) & rom_instruction(6 DOWNTO 0);

END ARCHITECTURE;