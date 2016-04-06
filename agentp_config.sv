class agentp_config extends uvm_object;
  //factory registration macro
	`uvm_object_utils(agent_config);
	
	virtual alu_if ap_interface;
	
	// IS the agent active or passive
	//uvm_active_passive_enum active = UVM_ACTIVE;
	uvm_active_passive_enum active = UVM_PASSIVE;
	
	//int number_of_transaction; 
	//bit [0:32] data_lenth;
	
	function new(string name="");
		super.new(name);
	endfunction 
 endclass