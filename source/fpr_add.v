`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2024 10:12:15
// Design Name: 
// Module Name: fpr_add
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fpr_add(Res,a,b,adsb);
input [31:0]a,b;
input adsb;
output reg [31:0]Res;
reg Sa,Sb,Sc;
reg [22:0]Ma,Mb,Mc;
reg [7:0]Ea,Eb,Ec;
reg EOP,Co;
reg [23:0]M_a,M_b,M_c,temp;
always @(*)
begin
 Sa = a[31];
 Sb = b[31];
 Ma = a[22:0];
 Mb = b[22:0];
 Ea = a[30:23];
 Eb = b[30:23];
//Normalise Mantissa
 M_a = {1'b1,Ma};
 M_b = {1'b1,Mb};
end
//Align Exponent
always @(*)
begin
if(Ea >Eb)
begin
 M_b = M_b >> (Ea - Eb);
 Ec = Ea;
end
else
begin
M_a = M_a >> (Eb - Ea);
Ec = Eb;
end
end

always @(*)
begin
EOP = Sa ^ Sb ^ adsb; // find actual operation
Sc = (M_a > M_b) ? Sa : Sb; //Decide sign bit based on largest mantissa

// For magnitude subtract or add always from larger value
// find if any carry exists
if(M_a>M_b)
begin
{Co,M_c} = EOP ? (M_a - M_b) : (M_a + M_b);
end
else
begin
{Co,M_c} = EOP ? (M_b - M_a) : (M_b + M_a);
end
// if carry right shift mantissa and increment exponent
Mc = Co ? M_c[23:1]: M_c[22:0];
Ec = Co ? (Ec + 1'b1): Ec;
Res = {Sc,Ec,Mc};
end
endmodule