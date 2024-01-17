`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 01:19:48 AM
// Design Name: 
// Module Name: pistol_module
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


module pistol_module(
    input clk200, shoot,
    input [1:0] curr_weapon,
    input [2:0] game_state,
    output reg cooldown = 0,
    output reg [2:0] ammo = 7
);

    reg [8:0] COUNT = 0;
    
    always @(posedge clk200) begin
        if (game_state != 4) begin
            cooldown <= 0;
            ammo <= 7;
            COUNT <= 0;
        end
        else begin
            if (curr_weapon != 0) begin
                cooldown <= 1;
                ammo <= 0;
                COUNT <= 0;
            end
            else begin
                if (!cooldown && ammo) begin
                    if (shoot) begin
                        cooldown <= 1;
                        ammo <= ammo - 1;
                    end
                end
                else if (!ammo) begin
                    COUNT <= COUNT == 300 ? COUNT : COUNT + 1;
                    if (COUNT == 300) begin
                        cooldown <= 0;
                        ammo <= 7;
                        COUNT <= 0;
                    end
                end
                else begin
                    COUNT <= COUNT == 100 ? COUNT : COUNT + 1;
                    if (COUNT == 100) begin
                        cooldown <= 0;
                        COUNT <= 0;
                    end
                end
            end
        end
    end
    
endmodule
