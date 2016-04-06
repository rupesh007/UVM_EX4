import uvm_pkg::*;
import alu_pkg::*;
import agent_pkg::*;
`include"uvm_macros.svh"

class alu_env extends uvm_env;
// declaration macros
  `uvm_component_utils (alu_env)
//internal components
  
  //instantiations
   alu_sequence seq;
   agent_config a_cfg;
   alu_agent e_agent;
   my_analysis_component env_analysis;
   alu_monitor e_monitor;
   
   

   function new (string name, uvm_component parent = null); // parent is //null because uvm_env is top level component
	   super.new(name,parent);
   endfunction: new


   function void build_phase (uvm_phase phase);	
	   super.build_phase(phase);
	   
	   //type creates with factory
	     seq = alu_sequence::type_id::create ("alu_sequence", this);
	     a_cfg = agent_config::type_id::create ("a_cfg", this);
	     e_agent = alu_agent::type_id::create ("alu_agent", this);
	     e_monitor= alu_monitor::type_id::create ("e_monitor", this);
	     env_analysis= my_analysis_component::type_id::create ("env_analysis", this);
	    //sets the config object in uvm database
	     uvm_config_db # (agent_config)::set(this,"*","env_agent_config",a_cfg);
	     
   endfunction: build_phase



//connect phase in uvm to connect driver and sequncer
   function void connect_phase (uvm_phase phase);
   	e_agent.ag_port.connect(env_analysis.d_port); //connects agent with the driver (hierachical connection)
    e_monitor.aport.connect(env_analysis.m_port); //monitor and analysis component connection
   endfunction: connect_phase  

// at end_of_elaboration, print topology 
   virtual function void end_of_elaboration_phase(uvm_phase phase);
     uvm_top.print_topology();
   endfunction

  // task run_phase (uvm_phase phase);
//	   seq = alu_sequence::type_id::create("seq"); //creates seq with factory
//	   phase.raise_objection(this);
//	   seq.start(e_agent.a_sequencer);  
//	   phase.drop_objection(this);
//   endtask 

endclass: alu_env
