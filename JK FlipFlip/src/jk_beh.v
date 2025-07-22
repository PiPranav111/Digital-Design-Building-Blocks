 /*********************************************************/
 // MODULE:j-k flip-flop
 //
 // FILE NAME:jk_beh.v
 // VERSION:1.0
 // DATE:January 1, 1999
 // AUTHOR:Bob Zeidman, Zeidman Consulting
 //
 // CODE TYPE: Behavioral Level
 //
 // DESCRIPTION: This module defines a J-K flip-flop with
 // an asynchronous, active low reset.
 //
 /*********************************************************/
 // DEFINES
 `define DEL 1  // Clock-to-output delay. Zero time delays can be confusing and sometimes cause problems.
 // TOP MODULE
 module jk_FlipFlop(
 clk,
 clr_n,
 j,
 k,
 q,
 q_n);
 // INPUTS
 input clk; // Clock
 input clr_n; // Active low, asynchronous reset
 input j; // J input
 input k; // K input

 // OUTPUTS
 output q;// Output
 output q_n; // Inverted output
 // INOUTS
 
 // SIGNAL DECLARATIONS
 wire clk;
 wire clr_n;
 wire j;
 wire k;
 reg q;
 wire q_n;
 // PARAMETERS
 // Define the J-K input combinations as parameters
 parameter[1:0] HOLD= 0,
 RESET = 1,
 SET = 2,
 TOGGLE= 3;
 // ASSIGN STATEMENTS
 assign #`DEL q_n = ~q;
 // MAIN CODE
 // Look at the edges of clr_n
 always @(posedge clr_n or negedge clr_n) begin
 if (~clr_n)
 #`DEL assign q = 1'b0;
 else
 #`DEL deassign q;
 end
 // Look at the falling edge of clock for state transitions
 always @(negedge clk) begin
 case ({j,k})
 RESET:q <= #`DEL 1'b0;
 SET:q <= #`DEL 1'b1;
 TOGGLE: q <= #`DEL ~q;
 endcase
 end
 endmodule // jk_FlipFlop