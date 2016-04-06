import uvm_pkg::*;
//import alu_pkg::*;
`include"uvm_macros.svh"
class alu_transaction extends uvm_sequence_item;

	rand logic[3:0] op_code; // 4 bit op_code
	rand logic[7:0] operand_1; // 8 bit operand
	rand logic[7:0] operand_2;
	rand logic[2:0] shift_rotate; //maximum by 8 bits
	rand logic[7:0] result; // result
	rand logic carry;  

	

	// registers with factory

	`uvm_object_utils(alu_transaction) 
	// new function constructor
	function new (string name="alu_transaction"); 
		super.new(name);
	endfunction

	/* Defines the field automation cocept of UVM.
	do_xx methods are defined automatically*/

	//`uvm_object_utils_begin(alu_transaction)
//     `uvm_field_int(op_code, UVM_ALL_ON)
//     `uvm_field_int(operand_1, UVM_ALL_ON)
//     `uvm_field_int(operand_2, UVM_ALL_ON)
//     `uvm_field_int(shift_rotate, UVM_ALL_ON)
//     `uvm_field_int(result, UVM_ALL_ON)
//     `uvm_field_int(carry, UVM_ALL_ON)
//     `uvm_object_utils_end

	//Define constraints if any

endclass: alu_transaction


