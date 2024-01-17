`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 03:17:11 AM
// Design Name: 
// Module Name: sniper_module
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


module sniper_module(
    input clk300, shoot, reset_ammo,
    input [1:0] curr_weapon,
    output reg cooldown = 0,
    output drop_sniper,
    output reg reset_ammo_done = 0,
    output reg [2:0] ammo = 5
);

    reg [8:0] COUNT = 0;
    
    assign drop_sniper = ammo ? 0 : 1;
    
    always @(posedge clk300) begin
        if (curr_weapon != 2) begin
            cooldown <= 0;
            ammo <= 5;
            COUNT <= 0;
            reset_ammo_done <= 0;
        end
        else begin
            if (!cooldown && ammo) begin
                if (shoot) begin
                    cooldown <= 1;
                    ammo <= ammo - 1;
                end
            end
            else begin
                COUNT <= COUNT == 300 ? COUNT : COUNT + 1;
                if (COUNT == 300) begin
                    cooldown <= 0;
                    COUNT <= 0;
                end
            end
            
            if (reset_ammo) begin
                ammo <= 5;
                reset_ammo_done <= 1;
            end
            else begin
                reset_ammo_done <= 0;
            end
        end
    end
    
endmodule
