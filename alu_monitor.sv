import uvm_pkg::*;
import alu_pkg::*;
`include "uvm_macros.svh"
class alu_monitor extends uvm_monitor;
	`uvm_component_utils (alu_monitor)
	
	int iteration; //this is set through config variable
	
	//external interface 
	uvm_analysis_port # (alu_transaction) aport;
	
	alu_transaction rsp_tr; //internal variable
	virtual alu_if m_if; //virtual interface
	 
	alu_config m_config; // config object
	
function new(string name, uvm_component parent);
    super.new(name, parent);
    rsp_tr = new("rsp_tr");
endfunction
	

function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		aport=new("aport",this); // no overriding
		m_config = alu_config::type_id::create("m_config",this); 
		
		//this section retreives the alu_config just to read the number of transaction
		 if(!uvm_config_db # (alu_config)::get(this,"","alu_config",m_config))
	     `uvm_fatal("Monitor_config error", "can't get handle to the interface" );
		    iteration = m_config.number_of_transaction;
		 //  this section gets the handle to the interface  
         if(!uvm_config_db # (virtual alu_if)::get(this,"","top_alu",m_if))
	     `uvm_fatal("Monitor error", "can't get handle to the interface" );

endfunction

function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
	     m_if = m_config.a_interface; // set local vitrual if property
	    
endfunction: connect_phase
	
task run_phase (uvm_phase phase);
		repeat (iteration) begin
			@(m_if.drive); 
			//converts pin level activity to response transaction
			rsp_tr.op_code = m_if.op_code;
			rsp_tr.shift_rotate = m_if.shift_rotate;
			rsp_tr.operand_1 = m_if.operand_1;
			rsp_tr.operand_2 = m_if.operand_2;
			rsp_tr.result =  m_if.result;
			rsp_tr.carry = m_if.carry;
			
			//writes transaction to analysis port
			aport.write(rsp_tr); //broadcasts to the analysis component
			//$display("Monitor @ %0t operand_1=%b operand_2=%b op_code=%b shift_rotate=%b result=%b, carry=%b",$time,rsp_tr.operand_1, 
			           //rsp_tr.operand_2, rsp_tr.op_code, rsp_tr.shift_rotate, rsp_tr.result, rsp_tr.carry);

		end
	endtask
	
endclass