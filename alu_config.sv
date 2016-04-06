import uvm_pkg::*;
`include "uvm_macros.svh"

class alu_config extends uvm_object;

	`uvm_object_utils(alu_config);
	
	virtual alu_if a_interface;
	
	int number_of_transaction; 
	//bit [0:32] data_lenth;
	
	function new(string name="");
		super.new(name);
	endfunction 
 endclass