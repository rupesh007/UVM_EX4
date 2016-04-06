import uvm_pkg::*;
import alu_pkg::*;
import agent_pkg::*;
`include"uvm_macros.svh"

class alu_test extends uvm_test;
  `uvm_component_utils(alu_test);
  
  
   //alu_sequence seq;
	 alu_config config_1; // configuration object
	 //agent_config config_2; // agent config object'
	 
	 alu_env env_1;
	 //transaction_count = 10; // sets the number of transaction to 10
	 //alu_sequence seq;
	 
	 function new(string name = "alu_test",uvm_component parent=null);
		super.new(name,parent);
	 endfunction
		
	function void build_phase(uvm_phase phase);
	  //uvm_config_db # (alu_config)::set(null,"*","alu_config",config_1);
	  //make sure config object is created first, if not might bring bad handle or reference error
	  config_1 = alu_config::type_id::create("config_1",this); 
	  env_1 = alu_env::type_id::create ("env_1", this);
		
		//config_2 = agent_config::type_id::create("config_2",this); 
		//if(!uvm_config_db # (virtual alu_if)::get(this,"*","top_alu",config_1))
			//`uvm_fatal("Alu_test_error", "can't get config_object" );
	   // config_1 = alu_config::type_id::create("config_1",this); 
	   //this sets the number of transaction item 
	    if(!uvm_config_db # (virtual alu_if)::get(this,"","top_alu",config_1.a_interface))
	     `uvm_fatal("Agent_config error1", "can't get handle to the interface" );
		    config_1.number_of_transaction=10;
		      
		    uvm_config_db # (alu_config)::set(this,"*","alu_config",config_1);
		    
	endfunction
	 
	 //run_phase in env but should be here just checking
	  task run_phase (uvm_phase phase);
	   //seq = alu_sequence::type_id::create("seq"); //creates seq with factory
	   phase.raise_objection(this);
	   env_1.seq.start(env_1.e_agent.a_sequencer);  //sequence and sequencer connection
	   phase.drop_objection(this);
   endtask 
	
endclass
	 
	 
