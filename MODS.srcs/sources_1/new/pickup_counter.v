`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 06:21:20 AM
// Design Name: 
// Module Name: pickup_counter
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


module pickup_counter(
    input clk6p25m, pickup_collision,
    input [2:0] game_state,
    output reg pickup_active = 0
);

    reg [31:0] COUNT = 0;

    always @(posedge clk6p25m) begin
        if (game_state < 4) begin
            pickup_active <= 0;
            COUNT <= 0;
        end
        else begin
            if (pickup_active) begin
                if (pickup_collision) begin
                    pickup_active <= 0;
                end
            end
            else begin
                COUNT <= COUNT == 62500000 ? COUNT : COUNT + 1;
                if (COUNT == 62500000) begin
                    pickup_active <= 1;
                    COUNT <= 0;
                end
            end
        end
    end

endmodule
