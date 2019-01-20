`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2019 10:17:43
// Design Name: 
// Module Name: test_codificare
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

module test_codificare();
    reg[127:0] K;
    reg[63:0] X;
    wire[63:0] X_OUT;
    codificare test_codificare(.K(K), .X(X), .X_OUT(X_OUT));

initial begin
    X = 64'b0000010100110010000010100110010000010100110010000001100111111010;
    K = 128'b00000000011001000000000011001000000000010010110000000001100100000000000111110100000000100101100000000010101111000000001100100000;
    #50;
end

endmodule
