`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 05:49:31 PM
// Design Name: 
// Module Name: transmit_timer
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


module transmit_timer(
    input clk6p25m, pickup_active,
    input [2:0] game_state,
    input [5:0] pickup_pos_transmit,
    input [2:0] pickup_type_transmit,
    output reg transmit
);

    reg [31:0] COUNT = 0;
    reg [3:0] state = 0;
    
    always @(posedge clk6p25m) begin
        if (game_state != 4) begin
            COUNT <= 0;
            state <= 0;
        end
        else begin
            if (!pickup_active) begin
                if (state == 0) begin
                    transmit <= pickup_pos_transmit[0];
                end
                else if (state == 1) begin
                    transmit <= pickup_pos_transmit[1];
                end
                else if (state == 2) begin
                    transmit <= pickup_pos_transmit[2];
                end
                else if (state == 3) begin
                    transmit <= pickup_pos_transmit[3];
                end
                else if (state == 4) begin
                    transmit <= pickup_pos_transmit[4];
                end
                else if (state == 5) begin
                    transmit <= pickup_pos_transmit[5];
                end
                else if (state == 6) begin
                    transmit <= pickup_type_transmit[0];
                end
                else if (state == 7) begin
                    transmit <= pickup_type_transmit[1];
                end
                else begin
                    transmit <= pickup_type_transmit[2];
                end
                COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                if (COUNT == 6250000) begin
                    COUNT <= 0;
                    state <= state < 8 ? state + 1 : 8;
                end
            end
            else begin
                COUNT <= 0;
                state <= 0;
            end
        end     
    end
    
endmodule
