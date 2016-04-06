/* Simple Picoblaze Alu*/

module alu8
  (input clk,
	 input reset,
	 input reg [3:0] op_code, // 4 bit op_code
	 input [7:0] operand_1, // 8 bit operand
	 input  [7:0] operand_2,
	 input  [2:0] shift_rotate, // shift or rotate at maximum by 8 bits
	 output reg [7:0] result, // 8 bit result
	 output reg carry);  
	
	reg [7:0] temp_result; // register for result
	
	

	always @ (posedge clk or posedge reset)
	begin
	 //$display("DUT @ %0t port_name=%b",$time,alu_interface.operand_1);
		if (reset) begin 
			temp_result <= 0;
		end else begin 
			case (op_code)
			  //this is just a simple implementation...
				4'b0001: temp_result = operand_1 & operand_2;
				4'b0010: temp_result = operand_1 | operand_2;
				4'b0011: temp_result = operand_1 ^ operand_2;
				//4'b0100: temp_result = operand_1 ~ operand_2;
				4'b0101: temp_result = operand_1 + operand_2;				
				4'b0110: temp_result = operand_1 - operand_2;
				
				4'b0111: temp_result = operand_1 >> shift_rotate;
				4'b1000: temp_result = operand_1 << shift_rotate;
				4'b1001: temp_result = operand_1 >>> shift_rotate;
				4'b1010: temp_result = operand_1 <<<shift_rotate;				
				default: temp_result = 9'bz;
			endcase
		end
		result = temp_result[7:0]; 
		if (temp_result[7]==1) 		  
			carry <= 1;			
		  else 
			carry <= 0;
		$display("DUT @ %0t operand_1=%b operand_2=%b op_code=%b shift_rotate=%b result=%b carry = %b",$time,operand_1, operand_2, op_code, shift_rotate, result, carry);
	
		end
endmodule
	
					
					
					
					
					
					
					
					
				