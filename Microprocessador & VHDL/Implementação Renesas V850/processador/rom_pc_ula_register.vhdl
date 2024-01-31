library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc_ula_register is
    port(
        clk_t : in std_logic;
        sel_ula_op: in unsigned(1 downto 0); -- operacao da ula
        rst_t : in std_logic; -- reset de todos os registradores do banco
        wr_en_t : in std_logic; -- write enable do banco de registradores
        pc_en_t : in std_logic;
        sel_reg_wr_t : in std_logic;
        jump_en_t : in std_logic;
        ram_in : in unsigned(7 downto 0);
        ram_reg_st_ctrl : in std_logic;
        mux2_control : in unsigned(1 downto 0);
        rom_out : out unsigned(13 downto 0);
        ula_out_t : out unsigned(7 downto 0);
        pc_out_t : out unsigned(6 downto 0);
        data1out_top : out unsigned(7 downto 0);
        data2out_top : out unsigned(7 downto 0)
    );
end entity;

architecture a_rom_pc_ula_register of rom_pc_ula_register is 

    component rom_pc is
        port(
            clk_all : in std_logic;
            pc_en: in std_logic;
            jump_en : in std_logic;
            data_out : out unsigned(13 downto 0);
            pc_out : out unsigned(6 downto 0)
        );
    end component;

    component ula_register is
        port(
            sel_t: in unsigned(1 downto 0);
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            sel_reg_wr : in std_logic; -- seleciona o reg para colocar no data write
            data1_sel : in unsigned(2 downto 0); -- select which reg is read in data1
            data2_sel : in unsigned(2 downto 0);
            data_reg_wr_t: in unsigned(2 downto 0); -- which reg data is written
            data_wr_t : in unsigned(7 downto 0); -- data to be written
            data2_in : in unsigned(7 downto 0);
            register2_out : out unsigned(7 downto 0);
            saida_ula : out unsigned(7 downto 0);
            data1out_t : out unsigned(7 downto 0);
            data2out_t : out unsigned(7 downto 0)
        );
    end component;

    signal instruction : unsigned(13 downto 0);
    signal ula_out, mux2_inA, mux2_out, saida_mux: unsigned(7 downto 0);

    begin
        rom_pc0 : rom_pc port map(
            clk_all=>clk_t, 
            pc_en=>pc_en_t, 
            jump_en=>jump_en_t, 
            data_out=>instruction,
             pc_out=>pc_out_t);
        ula_register0 : ula_register port map(
            sel_t=>sel_ula_op, 
            clk=>clk_t, 
            rst=>rst_t, 
            wr_en=>wr_en_t, 
            sel_reg_wr=>sel_reg_wr_t ,
            data1_sel=>instruction(9 downto 7), 
            data2_sel=>instruction(6 downto 4),
            data_reg_wr_t=>instruction(6 downto 4), 
            data_wr_t=>saida_mux, 
            data2_in=>mux2_out, 
            register2_out=>mux2_inA, 
            saida_ula=>ula_out, 
            data1out_t=>data1out_top, 
            data2out_t=>data2out_top);

        mux2_out <= mux2_inA when mux2_control = "00" else
                    instruction(6)&instruction(6 downto 0) when mux2_control = "01" else
                    "00000000" when ;

        saida_mux <= ula_out when (sel_reg_wr_t = '1' and ram_reg_st_ctrl = '0') else 
                    (instruction(6) & instruction(6 downto 0)) when (sel_reg_wr_t = '0' and ram_reg_st_ctrl = '0') else
                    ram_in when ram_reg_st_ctrl = '1' else
                    "00000000";
        -- tem que ser de 3 entradas


        ula_out_t <= ula_out;
        rom_out <= instruction;

end architecture;