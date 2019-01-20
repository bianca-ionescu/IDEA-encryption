`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2019 10:19:15
// Design Name: 
// Module Name: inmultire
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

module inmultire(
    input[15:0] A,
    input[15:0] B,
    output reg [15:0]C
);
    
    reg[31:0] result;
    reg[15:0] lo, hi;
    
    always @(*) begin
     result = A * B;
     if (result == 32'b0) 
         begin
            C = (-1) * A + (-1) * B + 1;
         end 
     else 
         begin
             hi = result >> 16;
             lo = result;
         if (lo > hi) 
             begin
                C = lo - hi;
             end 
         else 
             begin
                C = lo - hi + 1;
             end
         end
    end
    
endmodule