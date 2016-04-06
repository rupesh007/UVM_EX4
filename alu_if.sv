
interface alu_if(input clk);
	
	logic [3:0] op_code ;	
	logic [7:0] operand_1 ; 
	logic [7:0] operand_2 ;
	logic [2:0] shift_rotate ;
	logic [7:0] result ; 
	logic carry;
	
  clocking drive @ (posedge clk);
	  output op_code;
	  output operand_1;
	  output operand_2;
	  output shift_rotate;
	  input result;
	  input carry;
	endclocking
	
	//clocking moni @ (posedge clk);
//	  input op_code;
//	  input operand_1;
//	  input operand_2;
//	  input shift_rotate;
//	  output result;
//	  output carry;
//	endclocking
	
	//modport dut_mp(input clk, op_code, operand_1,
	                        // operand_2, shift_rotate); // this is the DUT in interface
	//modport monitor_mp(input clk, result, carry, output op_code, operand_1, operand_2,
	                   //shift_rotate); // this is the DUT out interface
	
					
endinterface: alu_if
