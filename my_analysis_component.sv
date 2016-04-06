import uvm_pkg::*;
import alu_pkg::*;
`include "uvm_macros.svh"
class my_analysis_component extends  uvm_component;
	`uvm_component_utils(my_analysis_component)
	

uvm_analysis_port #(alu_transaction) m_port; //connects to monitor
uvm_analysis_port #(alu_transaction) d_port; //connects to driver

uvm_tlm_analysis_fifo #(alu_transaction) m_fifo; //fifo to read from monitor
uvm_tlm_analysis_fifo #(alu_transaction) d_fifo; //fifo to read from driver

alu_transaction m_tr,d_tr;

alu_config mac_config;
virtual alu_if mac_if;
int iteration;
	
function new (string name, uvm_component parent);
	super.new(name,parent);
		
endfunction
	
function void build_phase (uvm_phase phase);	
	   super.build_phase(phase);
	   //creates ports with no overriding
	     d_port = new ("analysis_port2",this);
	     m_port = new ("analysis_port1",this);
	     
	    //fifos without overriding 
	     d_fifo = new ("fifo_d",this);
	     m_fifo = new ("fifo_m",this);
	     
	     d_tr = alu_transaction::type_id::create("d_tr",this);
	     m_tr = alu_transaction::type_id::create("m_tr",this); 
	     
	     //this section just reads the number of transaction
	     if(!uvm_config_db # (alu_config)::get(this,"","alu_config",mac_config))
	     `uvm_fatal("Analysis_Component_config error", "can't get handle to the config_objet" );
		    iteration = mac_config.number_of_transaction;
		 //this gets the handle to the interface   
		    if(!uvm_config_db # (virtual alu_if)::get(this,"","top_alu",mac_if))
	     `uvm_fatal("Analysis_component error", "can't get handle to the interface" );
   endfunction: build_phase
   
function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
      mac_if = mac_config.a_interface; // interface handle
      d_port.connect(d_fifo.analysis_export); //driver and fifo connection
	  m_port.connect(m_fifo.analysis_export); //monitor and fifo connection
	   
endfunction: connect_phase


task run_phase (uvm_phase phase);
	
	repeat(iteration)begin
	  
	@ (mac_if.drive);
	        //this directly reads from the interface
			//this can also be implemented using analysis port in driver and reading through tlm_fifo
	        d_tr.op_code = mac_if.op_code;
			d_tr.shift_rotate = mac_if.shift_rotate;
			d_tr.operand_1 = mac_if.operand_1;
			d_tr.operand_2 = mac_if.operand_2;
			d_tr.result = mac_if.result;
			d_tr.carry = mac_if.carry;
	  
	  $display("Analysis component retrieved from driver @ %0t operand_1=%b operand_2=%b op_code=%b shift_rotate=%b",$time,
	               d_tr.operand_1, d_tr.operand_2, d_tr.op_code, d_tr.shift_rotate);
	  
	  //reads the transaction item from monitor through tlm_fifo
	   m_fifo.get(m_tr);//print these values
	   $display("Analysis component retreived from monitor @ %0t operand_1=%b operand_2=%b op_code=%b shift_rotate=%b reslut=%b carry=%b",$time,
	   m_tr.operand_1, m_tr.operand_2,m_tr.op_code, m_tr.shift_rotate, m_tr.result, m_tr.carry);

      //****Try to unocmment this and see the difference//
	   //d_fifo.get(d_tr);//print these values
	   //$display("Analysis component retrieved from driver @ %0t operand_1=%b operand_2=%b op_code=%b shift_rotate=%b",$time,
	              // d_tr.operand_1, d_tr.operand_2, d_tr.op_code, d_tr.shift_rotate);

     // *******************************************
// if (!(m_tr.compare(d_tr))) 
//	     $display("Analysis Comparision mismatch");
//	    else $display("Analysis Comparision match");
//	    
	   //$display("Analysis component @ %0t operand_1=%b operand_2=%b op_code=%b shift_rotate=%b",$time,m_tr.operand_1, m_tr.operand_2, m_tr.op_code, m_tr.shift_rotate);

	   // print this value
	  // fifo2.get(d_tr);
	   
	end
endtask

endclass