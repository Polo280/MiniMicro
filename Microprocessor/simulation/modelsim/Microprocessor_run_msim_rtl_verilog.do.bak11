transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/register_file.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/instruction_memory.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/Microprocessor.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/ProgramCounter.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/Memory.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/Control_Unit.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/ALU.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/ANDS.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/ASR.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/Adder.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/BitwiseNot.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/BoothMul.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/Comparator.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/EORS.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/EXT.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/LSLS.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/LSRS.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/ORRS.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/ROR.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/FullAdder.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/HalfAdder.sv}
vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/Subtractor.sv}

vlog -sv -work work +incdir+C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor {C:/Users/jorgl/OneDrive/Escritorio/MiniMicro/Microprocessor/load_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  load_tb

add wave *
view structure
view signals
run -all
