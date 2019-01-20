`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2019 10:24:53
// Design Name: 
// Module Name: round
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

module round(
    input[15:0] K1, K2, K3, K4, K5, K6,
    input[15:0] X1, X2, X3, X4,
    output[15:0] X1_OUT, X2_OUT, X3_OUT, X4_OUT
);

    wire[15:0] step1, step2, step3, step4, step5, step6, step7, step8, step9, step10;
    
    inmultire inm1(X1, K1, step1);
    assign step2 = (X2 + K2) % 65536;
    assign step3 = (X3 + K3) % 65536;
    inmultire inm2(X4, K4, step4);
    
    assign step5 = step1 ^ step3;
    assign step6 = step2 ^ step4;
    
    inmultire inm3(K5, step5, step7);
    assign step8 = (step6 + step7) % 65536;
    
    inmultire inm4(step8, K6, step9);
    assign step10 = (step7 + step9) % 65536;

    wire[15:0] s0, s1, s2, s3;
    
    assign s0 = step1 ^ step9;
    assign s1 = step3 ^ step9;
    assign s2 = step2 ^ step10;
    assign s3 = step4 ^ step10;
    
    assign X1_OUT = s0;
    assign X2_OUT = s2;
    assign X3_OUT = s1;
    assign X4_OUT = s3;

endmodule