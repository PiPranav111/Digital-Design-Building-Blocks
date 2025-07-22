`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 22.07.2025 11:21:19
// Design Name:  j-k flip-flop
// Module Name: jk_sim.v
 // DESCRIPTION: This module provides stimuli for simulating
 // a J-K flip-flop. It tests each combination of J and K
 // inputs, and the asynchronous clear input. The hold
 // function is tested twice to ensure that the flip-flop
 // correctly holds both 0 and 1 states of the output.
 //
 /*********************************************************/
 // DEFINES
 `define DEL 1  // Clock-to-output delay. Zero time delays can be confusing and sometimes cause problems.
 // TOP MODULE
 module jk_sim();
 // INPUTS
 // OUTPUTS
 // INOUTS

 // SIGNAL DECLARATIONS
 reg clock;
 reg clear_n;
 reg  j_in;
 reg  k_in;
 
 wire out;
 wire out_n;
 integer  cycle_count; // Clock count variable
 
 // PARAMETERS
 // Define the J-K input combinations as parameters
 parameter[1:0] HOLD = 0,
 RESET= 1,
 SET = 2,
 TOGGLE = 3;
 // ASSIGN STATEMENTS
 // MAIN CODE
 // Instantiate the flip-flop
 jk_FlipFlop jk(
 .clk(clock),
 .clr_n(clear_n),
 .j(j_in),
 .k(k_in),
 .q(out),
 .q_n(out_n));
 // Initialize inputs
 initial begin
 clock = 0;
 clear_n = 1;
 cycle_count = 0;
 end
 // Generate the clock
 always #100 clock = ~clock;
 // Simulate
 always @(posedge clock) begin
 case (cycle_count)
 0: begin
 clear_n = 0;
 // Wait for the outputs to change asynchronously
 #`DEL
 #`DEL
 // Test outputs
 if ((out === 0) && (out_n === 1))
 $display ("Clear is working");
 else begin
 $display("\nERROR at time %0t:", $time);
 $display("Clear is not working");
 
  $display("   out = %h, out_n = %h\n", out,out_n);
 // Use $stop for debugging
 $stop;
 end
 end
 1: begin
 // Deassert the clear signal
 clear_n = 1;
 {j_in, k_in} = TOGGLE;
 end
 2: begin
 // Test outputs
 if ((out === 1) && (out_n === 0))
 $display ("Toggle is working");
 else begin
 $display("\nERROR at time %0t:", $time);
 $display("Toggle is not working");
 $display("    out = %h, out_n = %h\n", out, out_n);
 // Use $stop for debugging
 $stop;
 end
 {j_in, k_in} = RESET;
 end
 3: begin
 // Test outputs
 if ((out === 0) && (out_n === 1))
 $display ("Reset is working");
 else begin
 $display("\nERROR at time %0t:", $time);
 $display("Reset is not working");
 $display("    out = %h, out_n = %h\b", out, out_n);
 // Use $stop for debugging
 $stop;
 end
 {j_in, k_in} = HOLD;
 end
 4: begin
 // Test outputs
 if ((out === 0) && (out_n === 1))
 $display ("Hold is working");
 else begin
 $display("\nERROR at time %0t:", $time);
 $display("Hold is not working");
 $display("    out = %h, out_n = %h\n", out, out_n);
 // Use $stop for debugging
 $stop;
 end
 {j_in, k_in} = SET;
 end
 5: begin
 // Test outputs
 if ((out === 1) && (out_n === 0))
 $display ("Set is working");
 else begin
 $display("\nERROR at time %0t:", $time);
 $display("Set is not working");
 $display("    out = %h, out_n = %h\n", out, out_n);
 // Use $stop for debugging
 $stop;
 end
 {j_in, k_in} = HOLD;
 end
 6: begin
 // Test outputs
 if ((out === 1) && (out_n === 0))
 $display ("Hold is working");
 else begin
 $display("\nERROR at time %0t:", $time);
 $display("Hold is not working");
 $display("    out = %h, out_n = %h\n", out, out_n);
 // Use $stop for debugging
 $stop;
 end
 {j_in, k_in} = SET;
 end
 7: begin
 $display("\nSimulation complete - no errors\n");
 $finish;
 end
 endcase
 cycle_count = cycle_count + 1;
 end
 endmodule // jk_sim