`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:58:07 01/07/2020
// Design Name:   newfourx4
// Module Name:   S:/newfourx4/new4x4multiplier.v
// Project Name:  newfourx4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: newfourx4
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module new4x4multiplier;

	// Inputs
	reg [3:0] X;
	reg [3:0] Y;

	// Outputs
	wire [7:0] Z;

	// Instantiate the Unit Under Test (UUT)
	newfourx4 uut (
		.X(X), 
		.Y(Y), 
		.Z(Z)
	);

	initial begin
		// Initialize Inputs
		X = 0;
		Y = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		X[0] = 0 ;
		X[1] = 1 ;
		X[2] = 0 ;
		X[3] = 1 ;

// Add stimulus here
		Y[0] = 0 ;
		Y[1] = 1 ;
		Y[2] = 0 ;
		Y[3] = 1 ;


	end
      
endmodule

