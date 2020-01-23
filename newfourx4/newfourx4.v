`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SVNIT Surat
// Engineer: Sat J. Patel
// 
// Create Date:    21:14:41 01/07/2020 
// Design Name:  Four x Four Multiplier
// Module Name:    newfourx4 
// Project Name: 
// Target Devices: FPGAs
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module newfourx4(
input [3:0] X, Y, 
output [7:0] Z
    );
	 
wire [3:0] P0, P1, P2, P3 ; 


 and pp0 (P0[0] , X[0] , Y[0] );
  and pp1 (P0[1] , X[1] , Y[0] );
  and pp2 (P0[2] , X[2] , Y[0] );
  and pp3 (P0[3] , X[3] , Y[0] );
  and pp4 (P1[0] , X[0] , Y[1] );
  and pp5 (P1[1] , X[1] , Y[1] );
  and pp6 (P1[2] , X[2] , Y[1] );
  and pp7 (P1[3] , X[3] , Y[1] );
  and pp8 (P2[0] , X[0] , Y[2] );
  and pp9 (P2[1] , X[1] , Y[2] );
  and pp10 (P2[2] , X[2] , Y[2] );
  and pp11 (P2[3] , X[3] , Y[2] );
  and pp12 (P3[0] , X[0] , Y[3] );
  and pp13 (P3[1] , X[1] , Y[3] );
  and pp14 (P3[2] , X[2] , Y[3] );
  and pp15 (P3[3] , X[3] , Y[3] );
 



//Z[0] 

assign Z[0] = P0[0] ; 

//Z[1] 

wire HA1x0sum, HA1x0carry ; 

ha instanceha0 ( P0[1] , P1[0] , HA1x0sum, HA1x0carry ) ; 

assign Z[1] = HA1x0sum  ; 

//Z[2] 

wire FA2x0sum, FA2x0carry,  HA2x0sum, HA2x0carry ; 

fa instancefa0 ( P0[2] , P1[1] , P2[0] , FA2x0carry , FA2x0sum ) ; 
ha instanceha1 ( HA1x0carry , FA2x0sum ,  HA2x0sum, HA2x0carry ) ; 

assign Z[2] = HA2x0sum ; 

//Z[3] 

wire FA3x0carry , FA3x0sum, FA3x1carry, FA3x1sum , HA3x0sum , HA3x0carry ; 

fa instancefa1 ( HA2x0carry , FA2x0carry , P0[3] , FA3x0carry , FA3x0sum ) ; 
fa instancefa2 ( P1[2] , P2[1] , P3[0] , FA3x1carry, FA3x1sum ) ; 
ha instanceha2 ( FA3x1sum , FA3x0sum , HA3x0sum , HA3x0carry ) ; 

assign Z[3] = HA3x0sum ; 

//Z[4] 

wire FA4x0carry , FA4x0sum, FA4x1carry, FA4x1sum , HA4x0sum , HA4x0carry ;  

fa instancefa3 ( FA3x0carry , FA3x1carry , HA3x0carry ,  FA4x0carry , FA4x0sum ) ; 
fa instancefa4 ( P1[3] , P2[2] , P3[1] , FA4x1carry, FA4x1sum ) ; 
ha instanceha3 ( FA4x0sum , FA4x1sum , HA4x0sum , HA4x0carry ) ; 

assign Z[4] = HA4x0sum ; 


//Z[5] 

wire Z6x2x0 , Z6x1x0 , Z6x0x0 ; 

a5x3 instancea5x30 ( FA4x0carry , FA4x1carry , HA4x0carry , P2[3] , P3[2] , Z6x2x0 , Z6x1x0 , Z6x0x0 ) ; 

assign Z[5] = Z6x0x0 ; 

//Z[6] 

wire HA6x0sum , HA6x0carry ; 

ha instanceha4 ( Z6x1x0 , P3[3] , HA6x0sum , HA6x0carry ) ; 

assign Z[6] = HA6x0sum ; 


//Z[7] 

wire HA7x0sum, HA7x0carry ; 

ha instanceha5 ( HA6x0carry, Z6x2x0,  HA7x0sum, HA7x0carry ) ; 

assign Z[7] = HA7x0sum ; 

//assign Z[8] = HA7x0carry ; 


endmodule




module a5x3  (input A, input B, input C, input D, input E, output Z2, output Z1, output Z0 ) ; //Approximate 5 to 3 Compressor
assign Z0 = A^B^C^D^E ; 
 assign Z1= (((A^B^C^D)&E)|(~(A^B^C^D)&D)^(((A^B)&C)|(~(A^B)&A ) ); 

assign Z2 = ((A^B^C^D)&E | (~(A^B^C^D)&D) & ((A^B)&C | (~(A^B))&A) ) ; 
endmodule  // End of Approximate 5 to 3 compressor 


module fa (A, B, Cin, Cout, Sum);  // Full Adder 
input A, B, Cin;
output Sum, Cout;
ha ha1 (A, B, temp1, g1 ); 
ha ha2 (temp1, Cin, Sum,g2 );
or o1 (Cout, g1, g2);
endmodule // End of Full Adder 

module ha ( a, b, s, c) ;   // Half Adder 
input a, b;
output s, c;
assign s= a ^ b;
assign c= a & b;
endmodule  // End of Half Adder 
