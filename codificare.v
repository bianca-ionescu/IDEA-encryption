`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2019 10:18:53
// Design Name: 
// Module Name: codificare
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

module codificare(
    input[127:0] K,
    input[63:0] X,
    output[63:0] X_OUT
);

    assign K[127:0] = K << 25 | K >> 103;

 
    // Runda 1:
    wire[15:0] X1, X2, X3, X4;
    
    assign X1 = X[63:48];
    assign X2 = X[47:32];
    assign X3 = X[31:16];
    assign X4 = X[15:0];
    
    wire[15:0] K1, K2, K3, K4, K5, K6;
    
    assign K1 = K[127:112];
    assign K2 = K[111:96];
    assign K3 = K[95:80];
    assign K4 = K[79:64];
    assign K5 = K[63:48];
    assign K6 = K[47:32];
    
    wire[15:0] X1_OUT, X2_OUT, X3_OUT, X4_OUT;
    
    round rd1(.K1(K1), .K2(K2), .K3(K3), .K4(K4), .K5(K5), .K6(K6),
              .X1(X1), .X2(X2), .X3(X3), .X4(X4),  
              .X1_OUT(X1_OUT), .X2_OUT(X2_OUT), .X3_OUT(X3_OUT), .X4_OUT(X4_OUT)
    );
    
    // Runda 2:
    wire[15:0] X1_R2, X2_R2, X3_R2, X4_R2;
    
    assign X1_R2 = X1_OUT;
    assign X2_R2 = X2_OUT;
    assign X3_R2 = X3_OUT;
    assign X4_R2 = X4_OUT;
    
    wire[15:0] K1_R2, K2_R2, K3_R2, K4_R2, K5_R2, K6_R2;
    
    assign K1_R2 = K[31:16];
    assign K2_R2 = K[15:0];           
                    
    // Schimbarea 1 a cheii:    
    wire[127:0] SHIFT_1;
   
    assign SHIFT_1[127:25] = K[102:0];
    assign SHIFT_1[24:0] = K[127:103];
    
    assign K3_R2 = SHIFT_1[127:112];
    assign K4_R2 = SHIFT_1[111:96];
    assign K5_R2 = SHIFT_1[95:80];
    assign K6_R2 = SHIFT_1[79:64];
    
    wire[15:0] X1_OUT_R2, X2_OUT_R2, X3_OUT_R2, X4_OUT_R2;
    
    round rd2(.K1(K1_R2), .K2(K2_R2), .K3(K3_R2), .K4(K4_R2), .K5(K5_R2), .K6(K6_R2),
              .X1(X1_R2), .X2(X2_R2), .X3(X3_R2), .X4(X4_R2),  
              .X1_OUT(X1_OUT_R2), .X2_OUT(X2_OUT_R2), .X3_OUT(X3_OUT_R2), .X4_OUT(X4_OUT_R2)
    );
    
    // Runda 3:
    wire[15:0] X1_R3, X2_R3, X3_R3, X4_R3;
    
    assign X1_R3 = X1_OUT_R2;
    assign X2_R3 = X2_OUT_R2;
    assign X3_R3 = X3_OUT_R2;
    assign X4_R3 = X4_OUT_R2;
    
    wire[15:0] K1_R3, K2_R3, K3_R3, K4_R3, K5_R3, K6_R3;
    
    assign K1_R3 = SHIFT_1[63:48];
    assign K2_R3 = SHIFT_1[47:32];
    assign K3_R3 = SHIFT_1[31:16];
    assign K4_R3 = SHIFT_1[15:0];
    
    // Schimbarea 2 a cheii:
    wire[127:0] SHIFT_2;
    
    assign SHIFT_2[127:25] = SHIFT_1[102:0];
    assign SHIFT_2[24:0] = SHIFT_1[127:103];
    
    assign K5_R3 = SHIFT_2[127:112];
    assign K6_R3 = SHIFT_2[111:96];
    
    wire[15:0] X1_OUT_R3, X2_OUT_R3, X3_OUT_R3, X4_OUT_R3;
    
    round rd3(.K1(K1_R3), .K2(K2_R3), .K3(K3_R3), .K4(K4_R3), .K5(K5_R3), .K6(K6_R3),
              .X1(X1_R3), .X2(X2_R3), .X3(X3_R3), .X4(X4_R3),  
              .X1_OUT(X1_OUT_R3), .X2_OUT(X2_OUT_R3), .X3_OUT(X3_OUT_R3), .X4_OUT(X4_OUT_R3)
    );
    
    // Runda 4:
    wire[15:0] X1_R4, X2_R4, X3_R4, X4_R4;
    
    assign X1_R4 = X1_OUT_R3;
    assign X2_R4 = X2_OUT_R3;
    assign X3_R4 = X3_OUT_R3;
    assign X4_R4 = X4_OUT_R3;
    
    wire[15:0] K1_R4, K2_R4, K3_R4, K4_R4, K5_R4, K6_R4;
    
    assign K1_R4 = SHIFT_2[95:80];
    assign K2_R4 = SHIFT_2[79:64];
    assign K3_R4 = SHIFT_2[63:48];
    assign K4_R4 = SHIFT_2[47:32];
    assign K5_R4 = SHIFT_2[31:16];
    assign K6_R4 = SHIFT_2[15:0];
    
    wire[15:0] X1_OUT_R4, X2_OUT_R4, X3_OUT_R4, X4_OUT_R4;
    
    round rd4(.K1(K1_R4), .K2(K2_R4), .K3(K3_R4), .K4(K4_R4), .K5(K5_R4), .K6(K6_R4),
              .X1(X1_R4), .X2(X2_R4), .X3(X3_R4), .X4(X4_R4), 
              .X1_OUT(X1_OUT_R4), .X2_OUT(X2_OUT_R4), .X3_OUT(X3_OUT_R4), .X4_OUT(X4_OUT_R4)
    );
    
    // Runda 5:
    wire[15:0] X1_R5, X2_R5, X3_R5, X4_R5;
    
    assign X1_R5 = X1_OUT_R4;
    assign X2_R5 = X2_OUT_R4;
    assign X3_R5 = X3_OUT_R4;
    assign X4_R5 = X4_OUT_R4;
    
    // Schimbarea 3 a cheii:
    wire[127:0] SHIFT_3;
    
    assign SHIFT_3[127:25] = SHIFT_2[102:0];
    assign SHIFT_3[24:0] = SHIFT_2[127:103];
    
    wire[15:0] K1_R5, K2_R5, K3_R5, K4_R5, K5_R5, K6_R5;
    
    assign K1_R5 = SHIFT_3[127:112];
    assign K2_R5 = SHIFT_3[111:96];
    assign K3_R5 = SHIFT_3[95:80];
    assign K4_R5 = SHIFT_3[79:64];
    assign K5_R5 = SHIFT_3[63:48];
    assign K6_R5 = SHIFT_3[47:32];
    
    wire[15:0] X1_OUT_R5, X2_OUT_R5, X3_OUT_R5, X4_OUT_R5;
    
    round rd5(.K1(K1_R5), .K2(K2_R5), .K3(K3_R5), .K4(K4_R5), .K5(K5_R5), .K6(K6_R5),
              .X1(X1_R5), .X2(X2_R5), .X3(X3_R5), .X4(X4_R5), 
              .X1_OUT(X1_OUT_R5), .X2_OUT(X2_OUT_R5), .X3_OUT(X3_OUT_R5), .X4_OUT(X4_OUT_R5)
    );
    
    // Runda 6:
    wire[15:0] X1_R6, X2_R6, X3_R6, X4_R6;
    
    assign X1_R6 = X1_OUT_R5;
    assign X2_R6 = X2_OUT_R5;
    assign X3_R6 = X3_OUT_R5;
    assign X4_R6 = X4_OUT_R5;
    
    wire[15:0] K1_R6, K2_R6, K3_R6, K4_R6, K5_R6, K6_R6;
    
    assign K1_R6 = SHIFT_3[31:16];
    assign K2_R6 = SHIFT_3[15:0];
    
    // Schimbarea 4 a cheii:
    wire[127:0] SHIFT_4;
    
    assign SHIFT_4[127:25] = SHIFT_3[102:0];
    assign SHIFT_4[24:0] = SHIFT_3[127:103];
    
    assign K3_R6 = SHIFT_4[127:112];
    assign K4_R6 = SHIFT_4[111:96];
    assign K5_R6 = SHIFT_4[95:80];
    assign K6_R6 = SHIFT_4[79:64];
    
    wire[15:0] X1_OUT_R6, X2_OUT_R6, X3_OUT_R6, X4_OUT_R6;
    
    round rd6(.K1(K1_R6), .K2(K2_R6), .K3(K3_R6), .K4(K4_R6), .K5(K5_R6), .K6(K6_R6),
              .X1(X1_R6), .X2(X2_R6), .X3(X3_R6), .X4(X4_R6), 
              .X1_OUT(X1_OUT_R6), .X2_OUT(X2_OUT_R6), .X3_OUT(X3_OUT_R6), .X4_OUT(X4_OUT_R6)
    );
    
    // Runda 7:
    wire[15:0] X1_R7, X2_R7, X3_R7, X4_R7;
    
    assign X1_R7 = X1_OUT_R6;
    assign X2_R7 = X2_OUT_R6;
    assign X3_R7 = X3_OUT_R6;
    assign X4_R7 = X4_OUT_R6;
        
    wire[15:0] K1_R7, K2_R7, K3_R7, K4_R7, K5_R7, K6_R7;
    
    assign K1_R7 = SHIFT_4[63:48];
    assign K2_R7 = SHIFT_4[47:32];
    assign K3_R7 = SHIFT_4[31:16];
    assign K4_R7 = SHIFT_4[15:0];
    
    // Schimbarea 5 a cheii:
    wire[127:0] SHIFT_5;
    
    assign SHIFT_5[127:25] = SHIFT_4[102:0];
    assign SHIFT_5[24:0] = SHIFT_4[127:103];
    
    assign K5_R7 = SHIFT_5[127:112];
    assign K6_R7 = SHIFT_5[111:96];
    
    wire[15:0] X1_OUT_R7, X2_OUT_R7, X3_OUT_R7, X4_OUT_R7;
    
    round rd7(.K1(K1_R7), .K2(K2_R7), .K3(K3_R7), .K4(K4_R7), .K5(K5_R7), .K6(K6_R7), 
              .X1(X1_R7), .X2(X2_R7), .X3(X3_R7), .X4(X4_R7), 
              .X1_OUT(X1_OUT_R7), .X2_OUT(X2_OUT_R7), .X3_OUT(X3_OUT_R7), .X4_OUT(X4_OUT_R7)
    );
    
    // Runda 8:
    wire[15:0] X1_R8, X2_R8, X3_R8, X4_R8;
    
    assign X1_R8 = X1_OUT_R7;
    assign X2_R8 = X2_OUT_R7;
    assign X3_R8 = X3_OUT_R7;
    assign X4_R8 = X4_OUT_R7;
    
    wire[15:0] K1_R8, K2_R8, K3_R8, K4_R8, K5_R8, K6_R8;
    
    assign K1_R8 = SHIFT_5[95:80];
    assign K2_R8 = SHIFT_5[79:64];
    assign K3_R8 = SHIFT_5[63:48];
    assign K4_R8 = SHIFT_5[47:32];
    assign K5_R8 = SHIFT_5[31:16];
    assign K6_R8 = SHIFT_5[15:0];
    
    wire[15:0] X1_OUT_R8, X2_OUT_R8, X3_OUT_R8, X4_OUT_R8;
    
    round rd8(.K1(K1_R8), .K2(K2_R8), .K3(K3_R8), .K4(K4_R8), .K5(K5_R8), .K6(K6_R8), 
              .X1(X1_R8), .X2(X2_R8), .X3(X3_R8), .X4(X4_R8), 
              .X1_OUT(X1_OUT_R8), .X2_OUT(X2_OUT_R8), .X3_OUT(X3_OUT_R8), .X4_OUT(X4_OUT_R8)
    );
    
    // Runda 8.5:
    wire[15:0] X1_R8_5, X2_R8_5, X3_R8_5, X4_R8_5;
    
    assign X1_R8_5 = X1_OUT_R8;
    assign X2_R8_5 = X3_OUT_R8;
    assign X3_R8_5 = X2_OUT_R8;
    assign X4_R8_5 = X4_OUT_R8;
    
    // Schimbarea 6 a cheii:
    wire[127:0] SHIFT_6;
    
    assign SHIFT_6[127:25] = SHIFT_5[102:0];
    assign SHIFT_6[24:0] = SHIFT_5[127:103];
    
    wire[15:0] K1_R8_5, K2_R8_5, K3_R8_5, K4_R8_5;
    
    assign K1_R8_5 = SHIFT_6[127:112];
    assign K2_R8_5 = SHIFT_6[111:96];
    assign K3_R8_5 = SHIFT_6[95:80];
    assign K4_R8_5 = SHIFT_6[79:64];
    
    
    wire[15:0] X1_OUT_R8_5, X2_OUT_R8_5, X3_OUT_R8_5, X4_OUT_R8_5;
    
    inmultire inm1(X1_R8_5, K1_R8_5, X1_OUT_R8_5);
    assign X2_OUT_R8_5 = (X2_R8_5 + K2_R8_5) % 65536;
    assign X3_OUT_R8_5 = (X3_R8_5 + K3_R8_5) % 65536;
    inmultire inm4(X4_R8_5, K4_R8_5, X4_OUT_R8_5);
    
    assign X_OUT[63:48] = X1_OUT_R8_5;
    assign X_OUT[47:32] = X2_OUT_R8_5;
    assign X_OUT[31:16] = X3_OUT_R8_5;
    assign X_OUT[15:0] = X4_OUT_R8_5;

endmodule