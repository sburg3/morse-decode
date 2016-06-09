# Copyright (C) 1991-2010 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: morsedecode.tcl
# Generated on: Wed Oct 14 08:45:55 2015

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "morsedecode"]} {
		puts "Project morsedecode is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists morsedecode]} {
		project_open -revision morsedecode morsedecode
	} else {
		project_new -revision morsedecode morsedecode
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone II"
	set_global_assignment -name DEVICE EP2C35F672C6
	set_global_assignment -name TOP_LEVEL_ENTITY morsedecode_top
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION "9.1 SP2"
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "15:36:43  OCTOBER 09, 2015"
	set_global_assignment -name LAST_QUARTUS_VERSION "9.1 SP2"
	set_global_assignment -name USE_GENERATED_PHYSICAL_CONSTRAINTS OFF -section_id eda_blast_fpga
	set_global_assignment -name SEARCH_PATH "C:\\altera\\quartus42\\libraries\\booksoft\\UP2/"
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name VHDL_FILE decoder.vhd
	set_global_assignment -name USE_CONFIGURATION_DEVICE ON
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (VHDL)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT VHDL -section_id eda_simulation
	set_global_assignment -name MISC_FILE "P:/morsedecode/morsedecode.dpf"
	set_global_assignment -name VECTOR_WAVEFORM_FILE testwf.vwf
	set_global_assignment -name SIMULATION_MODE TIMING
	set_global_assignment -name INCREMENTAL_VECTOR_INPUT_SOURCE testwf.vwf
	set_global_assignment -name ADD_DEFAULT_PINS_TO_SIMULATION_OUTPUT_WAVEFORMS OFF
	set_global_assignment -name VHDL_FILE morsedecode_top.vhd
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name LL_ROOT_REGION ON -section_id "Root Region"
	set_global_assignment -name LL_MEMBER_STATE LOCKED -section_id "Root Region"
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS_NO_OUTPUT_GND "AS INPUT TRI-STATED"
	set_global_assignment -name VHDL_FILE morse_sm.vhd
	set_global_assignment -name VHDL_FILE CHAR_ROM.VHD
	set_global_assignment -name VHDL_FILE vga_sync.vhd
	set_global_assignment -name VHDL_FILE vga_controller.vhd
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
