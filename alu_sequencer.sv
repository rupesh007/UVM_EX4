import uvm_pkg::*;
import alu_pkg::*;
`include"uvm_macros.svh"
/* A simple sequencer with default API*/
class alu_sequencer extends uvm_sequencer # (alu_transaction);
//class alu_sequencer extends uvm_sequencer;
  `uvm_sequencer_utils(alu_sequencer) // registers for factory

  function new (string name, uvm_component parent);
    	super.new(name,parent);
  endfunction

endclass: alu_sequencer

// or it could simply be "typedef" ed

//typedf uvm_sequencer #(alu_transaction) alu_sequencer;
 