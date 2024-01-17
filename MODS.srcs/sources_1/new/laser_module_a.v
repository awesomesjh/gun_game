`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 02:32:25 AM
// Design Name: 
// Module Name: laser_module_a
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


module laser_module_a(
    input clk6p25m, shoot_a, reset_ammo, shield_b, pickup_active,
    input [1:0] curr_weapon,
    input [6:0] curr_x_b,
    input [5:0] curr_y_a, lower_y_b, higher_y_b, pickup_pos,
    output [6:0] laser_end_a, 
    output damage, pickup_collision, drop_laser,
    output reg reset_ammo_done = 0,
    output [6:0] displayed_ammo
);

    wire [21:0] MAX_COUNT;
    assign MAX_COUNT = shield_b ? 3125000 : 1562500;
    
    reg [21:0] COUNT = 0;
    assign damage = COUNT == MAX_COUNT;
    
    reg [21:0] PICKUP_COUNT = 0;
    assign pickup_collision = PICKUP_COUNT == 3125000;
    
    reg [24:0] ammo = 31250000;
    assign displayed_ammo = ammo == 31250000
        ? 100
        : ammo
        ? ammo / 312500 + 1
        : 0;
        
    assign drop_laser = ammo ? 0 : 1;
    
    wire hit_pickup, hit_player;
    assign hit_pickup = pickup_active && curr_y_a >= pickup_pos - 2 && curr_y_a <= pickup_pos + 3 && shoot_a && ammo;
    assign hit_player = !hit_pickup && curr_y_a >= lower_y_b && curr_y_a <= higher_y_b && shoot_a && ammo;
    assign laser_end_a = pickup_active && curr_y_a >= pickup_pos - 2 && curr_y_a <= pickup_pos + 3
        ? 44
        : curr_y_a >= lower_y_b && curr_y_a <= higher_y_b
        ? curr_x_b
        : 95;
    
    always @(posedge clk6p25m) begin
        if (curr_weapon != 3) begin
            ammo <= 31250000;
            COUNT <= 0;
            PICKUP_COUNT <= 0;
            reset_ammo_done <= 0;
        end
        else begin     
            if (shoot_a && ammo) begin
                ammo <= ammo - 1;
            end
            
            if (hit_pickup) begin
                PICKUP_COUNT <= PICKUP_COUNT + 1;
            end
            else begin
                PICKUP_COUNT <= 0;
            end
            
            if (hit_player) begin
                COUNT <= COUNT == MAX_COUNT ? 0 : COUNT + 1;
            end
            else begin
                COUNT <= 0;
            end
            
            if (reset_ammo) begin
                ammo <= 31250000;
                reset_ammo_done <= 1;
            end
            else begin
                reset_ammo_done <= 0;
            end
        end
    end

endmodule

