package agent_pkg;

//standard UVM import & include

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "alu_monitor.sv"
`include "agent_config.sv"
`include "alu_sequencer.sv"
`include "alu_driver.sv"
`include "alu_agent.sv"
`include "my_analysis_component.sv"
`include "alu_env.sv"
`include "alu_test.sv"


endpackage: agent_pkg
