`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2023 09:47:51 PM
// Design Name: 
// Module Name: shield_counter
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


module shield_counter(
    input clk6p25m, activate_shield_a, activate_shield_b,
    input [2:0] game_state,
    output reg shield_a = 0,
    output reg shield_b = 0
);

    reg [31:0] COUNT = 0;
    
    always @(posedge clk6p25m) begin
        if (game_state < 4) begin
            shield_a <= 0;
            shield_b <= 0;
            COUNT <= 0;
        end
        else begin
            if (!shield_a && !shield_b) begin
                if (activate_shield_a) begin
                    shield_a <= 1;
                end
                else if (activate_shield_b) begin
                    shield_b <= 1;
                end
            end
            else begin
                COUNT <= COUNT == 50000000 ? COUNT : COUNT + 1;
                if (COUNT == 50000000) begin
                    shield_a <= 0;
                    shield_b <= 0;
                    COUNT <= 0;
                end
            end
        end
    end
    
endmodule
