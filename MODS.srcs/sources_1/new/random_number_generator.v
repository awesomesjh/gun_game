`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 07:50:58 AM
// Design Name: 
// Module Name: random_number_generator
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


module random_number_generator(
    input clk,
    output [5:0] random_number_8_55,
    output [2:0] random_number_0_5
);

    reg [31:0] lfsr_state = {16{2'b10}};
    
    always @(posedge clk) begin
        lfsr_state <= {lfsr_state[30:0], ~(lfsr_state[31] ^ lfsr_state[30])};
    end
    
    // Use the LFSR output as a random number in the range [8, 55]
    assign random_number_8_55 = (lfsr_state % 48) + 8; // 8 to 55 (inclusive)
    assign random_number_0_5 = lfsr_state % 6;
    
endmodule

