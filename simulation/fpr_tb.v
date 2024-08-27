`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2024 10:13:59
// Design Name: 
// Module Name: fpr_tb
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


module fpr_tb(

    );
    reg [31:0]a,b;
    reg adsb;
    wire [31:0]C;
    fpr_add AA(C,a,b,adsb);
    
    initial
    begin
    a = 32'b01000100001111001011011010101000; 
    b = 32'b01000100011111010011011111110000; 
    adsb = 1'b0;
    #5
    a = 32'b01000011000110100011100110011010; 
    b = 32'b01000011000110100100001111010111; 
    adsb  = 1'b1;
    
    end
    
endmodule
