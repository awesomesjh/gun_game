`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 01:24:07 AM
// Design Name: 
// Module Name: rifle_module
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


module rifle_module(
    input clk200, shoot, reset_ammo,
    input [1:0] curr_weapon,
    output reg cooldown = 0,
    output drop_rifle,
    output reg reset_ammo_done = 0,
    output reg [4:0] ammo = 30
);

    reg [4:0] COUNT = 0;
    
    assign drop_rifle = ammo ? 0 : 1;
    
    always @(posedge clk200) begin
        if (curr_weapon != 1) begin
            cooldown <= 0;
            ammo <= 30;
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
                COUNT <= COUNT == 25 ? COUNT : COUNT + 1;
                if (COUNT == 25) begin
                    cooldown <= 0;
                    COUNT <= 0;
                end
            end
            
            if (reset_ammo) begin
                ammo <= 30;
                reset_ammo_done <= 1;
            end
            else begin
                reset_ammo_done <= 0;
            end
        end
    end
    
endmodule
