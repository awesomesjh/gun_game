`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 06:06:52 PM
// Design Name: 
// Module Name: receive_timer
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


module receive_timer(
    input clk6p25m, pickup_active, receive,
    input [2:0] game_state,
    output reg [5:0] pickup_pos_receive,
    output reg [2:0] pickup_type_receive
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
                    COUNT <= COUNT == 3125000 ? COUNT : COUNT + 1;
                    if (COUNT == 3125000) begin
                        COUNT <= 0;
                        state <= 1;
                        pickup_pos_receive[0] <= receive;
                    end
                end
                else if (state == 1) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 2;
                        pickup_pos_receive[1] <= receive;
                    end
                end
                else if (state == 2) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 3;
                        pickup_pos_receive[2] <= receive;
                    end
                end
                else if (state == 3) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 4;
                        pickup_pos_receive[3] <= receive;
                    end
                end
                else if (state == 4) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 5;
                        pickup_pos_receive[4] <= receive;
                    end
                end
                else if (state == 5) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 6;
                        pickup_pos_receive[5] <= receive;
                    end
                end
                else if (state == 6) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 7;
                        pickup_type_receive[0] <= receive;
                    end
                end
                else if (state == 7) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 8;
                        pickup_type_receive[1] <= receive;
                    end
                end
                else if (state == 8) begin
                    COUNT <= COUNT == 6250000 ? COUNT : COUNT + 1;
                    if (COUNT == 6250000) begin
                        COUNT <= 0;
                        state <= 9;
                        pickup_type_receive[2] <= receive;
                    end
                end
            end
            else begin
                COUNT <= 0;
                state <= 0;
            end
        end
    end

endmodule
