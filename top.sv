module top;

import uvm_pkg::*;
import agent_pkg::*;

bit tclk,treset;


initial begin
    #20;
    forever begin
      #(10) tclk=~tclk;
   end
end
   

//hardware instatntiations
//alu_driver driver;
//alu_transaction top_tr;
alu_if alu_interface(tclk);
//alu_if monitor_interface(tclk);
alu_test test1;

//alu_test test1.env_1.e_monitor.m_if.monitor_mp (.clk(tclk),
//                result(monitor_interface.result),
//                carry(monitor_interface.carry),
//                opcode(monitor_interface.opcode),
//                operand_1(monitor_interface.operand_1),
//                operand_2(monitor_interface.operand_2), 
//                shift_rotate(monitor_interface.shift_rotate));


// binds DUT and interface
alu8 alu_dut(.clk(tclk),
             .reset(treset),
             .op_code(alu_interface.op_code),
             .operand_1(alu_interface.operand_1),
             .operand_2(alu_interface.operand_2),
             .shift_rotate(alu_interface.shift_rotate),
             .result(alu_interface.result),
             .carry(alu_interface.carry));
 


initial begin 
	test1=new ("test case 1 for alu"); // creates test1
  uvm_config_db # (virtual alu_if)::set(null,"*","top_alu",alu_interface);
  //uvm_config_db # (virtual alu_if)::set(null,"*","top_alu",monitor_interface);
	run_test(); // this starts the testbench
	//tclk=0;
end 

endmodule: top