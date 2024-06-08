transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/fredi/Documents/miniprocessor/Microprocessor {/home/fredi/Documents/miniprocessor/Microprocessor/load_tb.sv}
vlog -sv -work work +incdir+/home/fredi/Documents/miniprocessor/Microprocessor {/home/fredi/Documents/miniprocessor/Microprocessor/register_file.sv}
vlog -sv -work work +incdir+/home/fredi/Documents/miniprocessor/Microprocessor {/home/fredi/Documents/miniprocessor/Microprocessor/Memory.sv}
vlog -sv -work work +incdir+/home/fredi/Documents/miniprocessor/Microprocessor {/home/fredi/Documents/miniprocessor/Microprocessor/Control_Unit.sv}

vlog -sv -work work +incdir+/home/fredi/Documents/miniprocessor/Microprocessor {/home/fredi/Documents/miniprocessor/Microprocessor/load_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  load_tb

add wave *
view structure
view signals
run -all
