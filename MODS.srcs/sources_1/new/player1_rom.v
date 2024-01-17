`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 22:21:45
// Design Name: 
// Module Name: player1_rom
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
module player1_rom(
    input clk,
    input [6:0] x,
    input [5:0] y,
    input [1:0] player1_sprite_state,
    output reg [15:0] player1_sprite
    );
    
    always @(posedge clk)begin
    if(player1_sprite_state == 0 || player1_sprite_state == 3)begin
    if (x == 0 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 3 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 4 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 5 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 8 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 1)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 1)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 2)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 2)
     player1_sprite <= 16'b1101011101101100;
    if (x == 3 && y == 2)
     player1_sprite <= 16'b1101011101101100;
    if (x == 4 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 2)
     player1_sprite <= 16'b0001010011100101;
    if (x == 7 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 2)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 3)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 2 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 3 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 4 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 5 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 3)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 4)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 4)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 5)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 5)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 6)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 6)
     player1_sprite <= 16'b0011100101000110;
    if (x == 4 && y == 6)
     player1_sprite <= 16'b0011100101000110;
    if (x == 5 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 6)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 7)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 7)
     player1_sprite <= 16'b0011100101000110;
    if (x == 3 && y == 7)
     player1_sprite <= 16'b0010100110101001;
    if (x == 4 && y == 7)
     player1_sprite <= 16'b1001110100110111;
    if (x == 5 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 7)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 8)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 8)
     player1_sprite <= 16'b0011101001001101;
    if (x == 3 && y == 8)
     player1_sprite <= 16'b0011101001001101;
    if (x == 4 && y == 8)
     player1_sprite <= 16'b1110111111111100;
    if (x == 5 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 8)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 9)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 9)
     player1_sprite <= 16'b0001010011100101;
    if (x == 2 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 9)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 9)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 10)
     player1_sprite <= 16'b0101010111100110;
    if (x == 9 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 11)
     player1_sprite <= 16'b0001010011100101;
    if (x == 4 && y == 11)
     player1_sprite <= 16'b0001010011100101;
    if (x == 5 && y == 11)
     player1_sprite <= 16'b0001010011100101;
    if (x == 6 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 11)
     player1_sprite <= 16'b0101010111100110;
    if (x == 8 && y == 11)
     player1_sprite <= 16'b0101010111100110;
    if (x == 9 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 12)
     player1_sprite <= 16'b0101010111100110;
    if (x == 4 && y == 12)
     player1_sprite <= 16'b0101010111100110;
    if (x == 5 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 12)
     player1_sprite <= 16'b0101010111100110;
    if (x == 9 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 13)
     player1_sprite <= 16'b0101010111100110;
    if (x == 4 && y == 13)
     player1_sprite <= 16'b0101010111100110;
    if (x == 5 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 13)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 13)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 10 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 3 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 14)
     player1_sprite <= 16'b0001010011100101;
    if (x == 5 && y == 14)
     player1_sprite <= 16'b0001010011100101;
    if (x == 6 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 10 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 14)
     player1_sprite <= 16'b0000000000000000;
     end
     
    if(player1_sprite_state == 1) begin
    if (x == 0 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 5 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 8 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 9 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 10 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 1)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 1)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 2)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 2)
     player1_sprite <= 16'b1101011101101100;
    if (x == 3 && y == 2)
     player1_sprite <= 16'b1101011101101100;
    if (x == 4 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 2)
     player1_sprite <= 16'b0001010011100101;
    if (x == 7 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 2)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 3)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 2 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 3 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 4 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 5 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 3)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 4)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 4)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 5)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 5)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 6)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 6)
     player1_sprite <= 16'b0011100101000110;
    if (x == 4 && y == 6)
     player1_sprite <= 16'b0011100101000110;
    if (x == 5 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 6)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 7)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 7)
     player1_sprite <= 16'b0011100101000110;
    if (x == 3 && y == 7)
     player1_sprite <= 16'b0010100110101001;
    if (x == 4 && y == 7)
     player1_sprite <= 16'b1001110100110111;
    if (x == 5 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 7)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 8)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 8)
     player1_sprite <= 16'b0011101001001101;
    if (x == 3 && y == 8)
     player1_sprite <= 16'b0011101001001101;
    if (x == 4 && y == 8)
     player1_sprite <= 16'b1110111111111100;
    if (x == 5 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 8)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 9)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 9)
     player1_sprite <= 16'b0001010011100101;
    if (x == 2 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 9)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 9)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 10)
     player1_sprite <= 16'b0101010111100110;
    if (x == 9 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 11)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 11)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 11)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 11)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 13)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 13)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 13)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 13)
     player1_sprite <= 16'b0101010111100110;
    if (x == 10 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 14)
     player1_sprite <= 16'b0101010111100110;
    if (x == 3 && y == 14)
     player1_sprite <= 16'b0101010111100110;
    if (x == 4 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 6 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 7 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 14)
     player1_sprite <= 16'b0101010111100110;
    if (x == 9 && y == 14)
     player1_sprite <= 16'b0101010111100110;
    if (x == 10 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    end
    
    if(player1_sprite_state == 2)begin
    if (x == 0 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 5 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 0)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 8 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 9 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 10 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 0)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 2 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 4 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 1)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 1)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 1)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 1)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 2)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 2)
     player1_sprite <= 16'b1101011101101100;
    if (x == 3 && y == 2)
     player1_sprite <= 16'b1101011101101100;
    if (x == 4 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 2)
     player1_sprite <= 16'b0001010011100101;
    if (x == 7 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 2)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 2)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 2)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 3)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 2 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 3 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 4 && y == 3)
     player1_sprite <= 16'b1101011101101100;
    if (x == 5 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 3)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 3)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 4)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 4)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 4)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 5)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 5)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 5)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 6)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 6)
     player1_sprite <= 16'b0011100101000110;
    if (x == 4 && y == 6)
     player1_sprite <= 16'b0011100101000110;
    if (x == 5 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 6)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 6)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 7)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 7)
     player1_sprite <= 16'b0011100101000110;
    if (x == 3 && y == 7)
     player1_sprite <= 16'b0010100110101001;
    if (x == 4 && y == 7)
     player1_sprite <= 16'b1001110100110111;
    if (x == 5 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 7)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 7)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 8)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 8)
     player1_sprite <= 16'b0011101001001101;
    if (x == 3 && y == 8)
     player1_sprite <= 16'b0011101001001101;
    if (x == 4 && y == 8)
     player1_sprite <= 16'b1110111111111100;
    if (x == 5 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 8)
     player1_sprite <= 16'b1001011011001000;
    if (x == 11 && y == 8)
     player1_sprite <= 16'b0001000011000011;
    if (x == 0 && y == 9)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 9)
     player1_sprite <= 16'b0001010011100101;
    if (x == 2 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 9)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 9)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 9)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 3 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 4 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 5 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 6 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 7 && y == 10)
     player1_sprite <= 16'b1001011011001000;
    if (x == 8 && y == 10)
     player1_sprite <= 16'b0101010111100110;
    if (x == 9 && y == 10)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 10)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 11)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 11)
     player1_sprite <= 16'b0001010011100101;
    if (x == 4 && y == 11)
     player1_sprite <= 16'b0001010011100101;
    if (x == 5 && y == 11)
     player1_sprite <= 16'b0001010011100101;
    if (x == 6 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 11)
     player1_sprite <= 16'b0101010111100110;
    if (x == 8 && y == 11)
     player1_sprite <= 16'b0101010111100110;
    if (x == 9 && y == 11)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 11 && y == 11)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 1 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 2 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 12)
     player1_sprite <= 16'b0101010111100110;
    if (x == 4 && y == 12)
     player1_sprite <= 16'b0101010111100110;
    if (x == 5 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 12)
     player1_sprite <= 16'b0101010111100110;
    if (x == 7 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 12)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 12)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 12)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 3 && y == 13)
     player1_sprite <= 16'b0101010111100110;
    if (x == 4 && y == 13)
     player1_sprite <= 16'b0101010111100110;
    if (x == 5 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 6 && y == 13)
     player1_sprite <= 16'b0101010111100110;
    if (x == 7 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 13)
     player1_sprite <= 16'b1001011011001000;
    if (x == 9 && y == 13)
     player1_sprite <= 16'b1001011011001000;
    if (x == 10 && y == 13)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 13)
     player1_sprite <= 16'b0000000000000000;
    if (x == 0 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 1 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 2 && y == 14)
     player1_sprite <= 16'b0001010011100101;
    if (x == 3 && y == 14)
     player1_sprite <= 16'b0001010011100101;
    if (x == 4 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 5 && y == 14)
     player1_sprite <= 16'b0000000000000000;
    if (x == 6 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 7 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 8 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 9 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 10 && y == 14)
     player1_sprite <= 16'b0001000011000011;
    if (x == 11 && y == 14)
     player1_sprite <= 16'b0000000000000000;

    end
    
    end

endmodule