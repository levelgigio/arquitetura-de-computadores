import os
import sys

def run(duration=100000):
    os.system("rm -rf work-obj93.cf")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a register_7_bits.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e register_7_bits")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a register_8_bits.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e register_8_bits")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a register_1_bits.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e register_1_bits")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a register_bank.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e register_bank")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a ula.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e ula")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a pc.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e pc")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a rom.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e rom")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a state_machine.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e state_machine")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a ram.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e ram")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a mux_2x1_3_bits.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e mux_2x1_3_bits")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a mux_4x1_8_bits.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e mux_4x1_8_bits")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a control_unit.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e control_unit")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a processor.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e processor")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -a processor_tb.vhdl")
    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -e processor_tb")

    os.system("../ghdl-0.36-macosx-mcode/bin/ghdl -r processor_tb --stop-time={}ns --wave=processor_alt_tb.ghw --ieee-asserts=disable".format(duration))