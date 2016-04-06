import uvm_pkg::*;
`include "uvm_macros.svh"
class agent_config extends uvm_object;
  //factory registration macro
	`uvm_object_utils(agent_config);
	
	virtual alu_if a_interface;
	
	// IS the agent active or passive
	uvm_active_passive_enum active = UVM_ACTIVE;
	//uvm_active_passive_enum active2 = UVM_PASSIVE;
	
	
	function new(string name="");
		super.new(name);
	endfunction 
 endclass