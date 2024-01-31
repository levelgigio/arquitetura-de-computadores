library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_register is
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
end entity;

architecture a_ula_register of ula_register is

    component register_bank is 
    port( clk_r : in std_logic;
        rst_r : in std_logic;
        wr_en_r : in std_logic;
        data1_reg : in unsigned(2 downto 0); -- select which reg is read in data1
        data2_reg : in unsigned(2 downto 0);
        data_reg_wr: in unsigned(2 downto 0); -- which reg data is written
        data_wr : in unsigned(7 downto 0); -- data to be written
        data1_out : out unsigned(7 downto 0);
        data2_out : out unsigned(7 downto 0)
        );
    end component;

    component ula is 
    port(
        sel: in unsigned(1 downto 0);
        in0, in1: in unsigned(7 downto 0);
        saida: out unsigned(7 downto 0)
    );
    end component;

signal ula_saida_sig : unsigned(7 downto 0);
signal reg_saida1_sig, register2_out_sig : unsigned(7 downto 0);
signal saida_mux_reg_wr : unsigned(2 downto 0);

begin
    ula0 : ula port map (
        sel=>sel_t, 
        in0=>reg_saida1_sig, 
        in1=>data2_in, 
        saida=>ula_saida_sig); 
    registers0 : register_bank port map (
        clk_r=>clk,
        rst_r=>rst, 
        wr_en_r=>wr_en,
        data1_reg=>data1_sel,
        data2_reg=>data2_sel,
        data_reg_wr=>saida_mux_reg_wr,
        data_wr=>data_wr_t,
        data1_out=>reg_saida1_sig,
        data2_out=>register2_out_sig
    ); 

    data1out_t <= reg_saida1_sig;
    data2out_t <= register2_out_sig;

    register2_out <= register2_out_sig;

    saida_mux_reg_wr <= data_reg_wr_t when sel_reg_wr = '1' else data1_sel;
    
    saida_ula <= ula_saida_sig;

end architecture;
