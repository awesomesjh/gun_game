`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 12:03:33 AM
// Design Name: 
// Module Name: game_module
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


module game_module(
    input clk6p25m, clk6khz, shoot2, shoot1, 
    w1,s1,a1,d1,w2,s2,a2,d2,sw0,sw15, // from movement module
    input [6:0] x,
    input [5:0] y,
    input [2:0] game_state,
    output reg [15:0] pixel_data,
    output reg [1:0] curr_weapon_a = 0,
    output reg [1:0] curr_weapon_b = 0,
    output reg [4:0] health_a = 16,
    output reg [4:0] health_b = 16,
    output [2:0] pistol_ammo_a, pistol_ammo_b,
    output [4:0] rifle_ammo_a, rifle_ammo_b,
    output [2:0] sniper_ammo_a, sniper_ammo_b,
    output [6:0] laser_ammo_a, laser_ammo_b,
    input [5:0] pickup_pos_receive,
    input [2:0] pickup_type_receive,
    output reg [5:0] pickup_pos_transmit = 32,
    output reg [2:0] pickup_type_transmit = 1,
    output pickup_active,
    input opp_death,
    output reg my_death
);

    parameter BLACK = 0;
    parameter DARK_GRAY = 16'h2104;
    parameter LIGHT_GRAY = 16'hA618;
    parameter WHITE = 16'hFFFF;
    parameter RED = 16'hF800;
    parameter ORANGE = 16'hFC00;
    parameter YELLOW = 16'hFFE0;
    parameter GREEN = 16'h07E0;
    parameter BLUE = 16'h001F;
    parameter CYAN = 16'h07FF;
    parameter PINK = 16'hFA1F;
    parameter BROWN = 16'h9AC7;
    
    wire [6:0] curr_x_a, curr_x_b;
    wire [5:0] curr_y_a, curr_y_b;
    wire [15:0] player1_sprite, player2_sprite;
    
    wire clk200, clk300, clk50,
    shoot_a, shoot_b,
    pistol_cooldown_a, pistol_cooldown_b,
    rifle_cooldown_a, rifle_cooldown_b,
    sniper_cooldown_a, sniper_cooldown_b,
    drop_rifle_a, drop_rifle_b,
    drop_sniper_a, drop_sniper_b,
    drop_laser_a, drop_laser_b,
    reset_rifle_ammo_done_a, reset_rifle_ammo_done_b,
    reset_sniper_ammo_done_a, reset_sniper_ammo_done_b,
    reset_laser_ammo_done_a, reset_laser_ammo_done_b,
    laser_damage_a, laser_damage_b,
    shield_a, shield_b;
    wire [6:0] laser_end_a, laser_end_b;
    reg reset_rifle_ammo_a = 0;
    reg reset_rifle_ammo_b = 0;
    reg reset_sniper_ammo_a = 0;
    reg reset_sniper_ammo_b = 0;
    reg reset_laser_ammo_a = 0;
    reg reset_laser_ammo_b = 0;
    reg activate_shield_a = 0;
    reg activate_shield_b = 0;
    wire [5:0] random_y, pickup_pos;
    wire [2:0] random_pickup, pickup_type;
    assign shoot_a = game_state != 4 ? 0 : sw15 ? shoot1 : shoot2;
    assign shoot_b = game_state != 4 ? 0 : sw0 ? shoot1 : shoot2;
    assign pickup_pos = sw0 ? pickup_pos_transmit : pickup_pos_receive;
    assign pickup_type = sw0 ? pickup_type_transmit : pickup_type_receive;
    
    parameter PISTOL_BASE_DMG = 2;
    parameter RIFLE_BASE_DMG = 2;
    parameter SNIPER_BASE_DMG = 16;
    wire [1:0] pistol_dmg_a, pistol_dmg_b;
    wire [1:0] rifle_dmg_a, rifle_dmg_b;
    wire [4:0] sniper_dmg_a, sniper_dmg_b;
    assign pistol_dmg_a = shield_b ? PISTOL_BASE_DMG / 2 : PISTOL_BASE_DMG;
    assign pistol_dmg_b = shield_a ? PISTOL_BASE_DMG / 2 : PISTOL_BASE_DMG;
    assign rifle_dmg_a = shield_b ? RIFLE_BASE_DMG / 2 : RIFLE_BASE_DMG;
    assign rifle_dmg_b = shield_a ? RIFLE_BASE_DMG / 2 : RIFLE_BASE_DMG;
    assign sniper_dmg_a = shield_b ? SNIPER_BASE_DMG / 2 : SNIPER_BASE_DMG;
    assign sniper_dmg_b = shield_a ? SNIPER_BASE_DMG / 2 : SNIPER_BASE_DMG;
    
    reg pickup_pistol_collision_a = 0;
    reg pickup_pistol_collision_b = 0;
    reg pickup_sniper_collision_a = 0;
    reg pickup_sniper_collision_b = 0;
    reg pickup_rifle1_collision_a = 0;
    reg pickup_rifle1_collision_b = 0;
    reg pickup_rifle2_collision_a = 0;
    reg pickup_rifle2_collision_b = 0;
    reg pickup_rifle3_collision_a = 0;
    reg pickup_rifle3_collision_b = 0;
    reg pickup_rifle4_collision_a = 0;
    reg pickup_rifle4_collision_b = 0;
    wire pickup_laser_collision_a;
    wire pickup_laser_collision_b;
    wire pickup_collision;
    assign pickup_collision = pickup_pistol_collision_a | pickup_pistol_collision_b 
    | pickup_sniper_collision_a | pickup_sniper_collision_b
    | pickup_rifle1_collision_a | pickup_rifle1_collision_b
    | pickup_rifle2_collision_a | pickup_rifle2_collision_b
    | pickup_rifle3_collision_a | pickup_rifle3_collision_b
    | pickup_rifle4_collision_a | pickup_rifle4_collision_b
    | pickup_laser_collision_a | pickup_laser_collision_b;
    
    reg hitbox_pistol_collision_a = 0;
    reg hitbox_pistol_collision_b = 0;
    reg hitbox_sniper_collision_a = 0;
    reg hitbox_sniper_collision_b = 0;
    reg hitbox_rifle1_collision_a = 0;
    reg hitbox_rifle1_collision_b = 0;
    reg hitbox_rifle2_collision_a = 0;
    reg hitbox_rifle2_collision_b = 0;
    reg hitbox_rifle3_collision_a = 0;
    reg hitbox_rifle3_collision_b = 0;
    reg hitbox_rifle4_collision_a = 0;
    reg hitbox_rifle4_collision_b = 0;
    wire hitbox_collision;
    assign hitbox_collision = hitbox_pistol_collision_a | hitbox_pistol_collision_b 
    | hitbox_sniper_collision_a | hitbox_sniper_collision_b
    | hitbox_rifle1_collision_a | hitbox_rifle1_collision_b
    | hitbox_rifle2_collision_a | hitbox_rifle2_collision_b
    | hitbox_rifle3_collision_a | hitbox_rifle3_collision_b
    | hitbox_rifle4_collision_a | hitbox_rifle4_collision_b;
    
    wire collision;
    assign collision = pickup_collision | hitbox_collision;
    
    parameter NULL_X = 7'b1110101;
    parameter NULL_Y = 6'b111111;
    reg [6:0] pistol_data_x_a = NULL_X;
    reg [5:0] pistol_data_y_a = NULL_Y;
    wire [6:0] pistol_head_x_a;
    assign pistol_head_x_a = pistol_data_x_a == NULL_X ? NULL_X : pistol_data_x_a < 91 ? pistol_data_x_a + 4 : 95;
    reg [6:0] pistol_data_x_b = NULL_X;
    reg [5:0] pistol_data_y_b = NULL_Y;
    wire [6:0] pistol_head_x_b;
    assign pistol_head_x_b = pistol_data_x_b == NULL_X ? NULL_X : pistol_data_x_b > 3 ? pistol_data_x_b - 4 : 0;
    reg [6143:0] rifle_data_a = 0;
    reg [6143:0] rifle_data_b = 0;
    reg [6:0] sniper_data_x_a = NULL_X;
    reg [5:0] sniper_data_y_a = NULL_Y;
    reg [6:0] sniper_data_x_b = NULL_X;
    reg [5:0] sniper_data_y_b = NULL_Y;
    wire [6:0] sniper_head_x_a;
    assign sniper_head_x_a = sniper_data_x_a == NULL_X ? NULL_X : sniper_data_x_a < 86 ? sniper_data_x_a + 9 : 95;
    wire [6:0] sniper_head_x_b;
    assign sniper_head_x_b = sniper_data_x_b == NULL_X ? NULL_X : sniper_data_x_b > 8 ? sniper_data_x_b - 9 : 0;
    
    reg [6:0] rifle1_data_x_a = NULL_X;
    reg [5:0] rifle1_data_y_a = NULL_Y;
    reg [6:0] rifle1_data_x_b = NULL_X;
    reg [5:0] rifle1_data_y_b = NULL_Y;
    wire [6:0] rifle1_head_x_a;
    assign rifle1_head_x_a = rifle1_data_x_a == NULL_X ? NULL_X : rifle1_data_x_a < 88 ? rifle1_data_x_a + 7 : 95;
    wire [6:0] rifle1_head_x_b;
    assign rifle1_head_x_b = rifle1_data_x_b == NULL_X ? NULL_X : rifle1_data_x_b > 6 ? rifle1_data_x_b - 7 : 0;
    reg [6:0] rifle2_data_x_a = NULL_X;
    reg [5:0] rifle2_data_y_a = NULL_Y;
    reg [6:0] rifle2_data_x_b = NULL_X;
    reg [5:0] rifle2_data_y_b = NULL_Y;
    wire [6:0] rifle2_head_x_a;
    assign rifle2_head_x_a = rifle2_data_x_a == NULL_X ? NULL_X : rifle2_data_x_a < 88 ? rifle2_data_x_a + 7 : 95;
    wire [6:0] rifle2_head_x_b;
    assign rifle2_head_x_b = rifle2_data_x_b == NULL_X ? NULL_X : rifle2_data_x_b > 6 ? rifle2_data_x_b - 7 : 0;
    reg [6:0] rifle3_data_x_a = NULL_X;
    reg [5:0] rifle3_data_y_a = NULL_Y;
    reg [6:0] rifle3_data_x_b = NULL_X;
    reg [5:0] rifle3_data_y_b = NULL_Y;
    wire [6:0] rifle3_head_x_a;
    assign rifle3_head_x_a = rifle3_data_x_a == NULL_X ? NULL_X : rifle3_data_x_a < 88 ? rifle3_data_x_a + 7 : 95;
    wire [6:0] rifle3_head_x_b;
    assign rifle3_head_x_b = rifle3_data_x_b == NULL_X ? NULL_X : rifle3_data_x_b > 6 ? rifle3_data_x_b - 7 : 0;
    reg [6:0] rifle4_data_x_a = NULL_X;
    reg [5:0] rifle4_data_y_a = NULL_Y;
    reg [6:0] rifle4_data_x_b = NULL_X;
    reg [5:0] rifle4_data_y_b = NULL_Y;
    wire [6:0] rifle4_head_x_a;
    assign rifle4_head_x_a = rifle4_data_x_a == NULL_X ? NULL_X : rifle4_data_x_a < 88 ? rifle4_data_x_a + 7 : 95;
    wire [6:0] rifle4_head_x_b;
    assign rifle4_head_x_b = rifle4_data_x_b == NULL_X ? NULL_X : rifle4_data_x_b > 6 ? rifle4_data_x_b - 7 : 0;
    
    ///////////////////////////////////////////////////////////
    reg signed [31:0] x_movement_player1 = 0, x_movement_player2 = 0;
    reg signed [31:0] y_movement_player1 = 0, y_movement_player2 = 0;
    reg knockback_player1 = 0, knockback_player2 = 0;
    wire [6:0] player1_x_lower, player1_x_higher, player2_x_lower, player2_x_higher;
    wire [5:0] player1_y_lower, player1_y_higher, player2_y_lower, player2_y_higher;
    reg [31:0] counter = 0, counter2 = 0, knockback_counter = 0, knockback_counter_player2 = 0;
    wire clk1khz;
    reg _w1 = 0 , _s1 = 0, _a1 = 0, _d1 = 0, _w2 = 0, _s2 = 0, _a2 = 0, _d2 = 0;
    clk_divider clock_1khz(clk6khz, 2, clk1khz);
    //////////////////////////////////////////////////////////

    clk_divider clock_200(clk6khz, 14, clk200); // more robust
    clk_divider clock_300(clk6khz, 9, clk300); // more robust
    
    pistol_module pistol_a(clk200, shoot_a, curr_weapon_a, game_state, pistol_cooldown_a, pistol_ammo_a);
    pistol_module pistol_b(clk200, shoot_b, curr_weapon_b, game_state, pistol_cooldown_b, pistol_ammo_b);
    rifle_module rifle_a(clk200, shoot_a, reset_rifle_ammo_a, curr_weapon_a, rifle_cooldown_a, drop_rifle_a, reset_rifle_ammo_done_a, rifle_ammo_a);
    rifle_module rifle_b(clk200, shoot_b, reset_rifle_ammo_b, curr_weapon_b, rifle_cooldown_b, drop_rifle_b, reset_rifle_ammo_done_b, rifle_ammo_b);
    sniper_module sniper_a(clk300, shoot_a, reset_sniper_ammo_a, curr_weapon_a, sniper_cooldown_a, drop_sniper_a, reset_sniper_ammo_done_a, sniper_ammo_a);
    sniper_module sniper_b(clk300, shoot_b, reset_sniper_ammo_b, curr_weapon_b, sniper_cooldown_b, drop_sniper_b, reset_sniper_ammo_done_b, sniper_ammo_b);
    laser_module_a laser_a(clk6p25m, shoot_a, reset_laser_ammo_a, shield_b, pickup_active, curr_weapon_a, curr_x_b, curr_y_a, player1_y_lower, player1_y_higher, pickup_pos, laser_end_a, laser_damage_a, pickup_laser_collision_a, drop_laser_a, reset_laser_ammo_done_a, laser_ammo_a);
    laser_module_b laser_b(clk6p25m, shoot_b, reset_laser_ammo_b, shield_a, pickup_active, curr_weapon_b, curr_x_a, curr_y_b, player2_y_lower, player2_y_higher, pickup_pos, laser_end_b, laser_damage_b, pickup_laser_collision_b, drop_laser_b, reset_laser_ammo_done_b, laser_ammo_b);
    
    pickup_counter pickupcounter(clk6p25m, pickup_collision, game_state, pickup_active);
    shield_counter shieldcounter(clk6p25m, activate_shield_a, activate_shield_b, game_state, shield_a, shield_b);
    
    random_number_generator rng(clk1khz, random_y, random_pickup);
    
    integer i;
    always @(posedge clk200, posedge collision) begin
        
        if (collision) begin
            if (pickup_pistol_collision_a || hitbox_pistol_collision_a) begin
                pistol_data_x_a <= NULL_X;
                pistol_data_y_a <= NULL_Y;
            end
            if (pickup_pistol_collision_b || hitbox_pistol_collision_b) begin
                pistol_data_x_b <= NULL_X;
                pistol_data_y_b <= NULL_Y;
            end
            if (pickup_rifle1_collision_a || hitbox_rifle1_collision_a) begin
                rifle1_data_x_a <= NULL_X;
                rifle1_data_y_a <= NULL_Y;
            end
            if (pickup_rifle1_collision_b || hitbox_rifle1_collision_b) begin
                rifle1_data_x_b <= NULL_X;
                rifle1_data_y_b <= NULL_Y;
            end
            if (pickup_rifle2_collision_a || hitbox_rifle2_collision_a) begin
                rifle2_data_x_a <= NULL_X;
                rifle2_data_y_a <= NULL_Y;
            end
            if (pickup_rifle2_collision_b || hitbox_rifle2_collision_b) begin
                rifle2_data_x_b <= NULL_X;
                rifle2_data_y_b <= NULL_Y;
            end
            if (pickup_rifle3_collision_a || hitbox_rifle3_collision_a) begin
                rifle3_data_x_a <= NULL_X;
                rifle3_data_y_a <= NULL_Y;
            end
            if (pickup_rifle3_collision_b || hitbox_rifle3_collision_b) begin
                rifle3_data_x_b <= NULL_X;
                rifle3_data_y_b <= NULL_Y;
            end
            if (pickup_rifle4_collision_a || hitbox_rifle4_collision_a) begin
                rifle4_data_x_a <= NULL_X;
                rifle4_data_y_a <= NULL_Y;
            end
            if (pickup_rifle4_collision_b || hitbox_rifle4_collision_b) begin
                rifle4_data_x_b <= NULL_X;
                rifle4_data_y_b <= NULL_Y;
            end
        end
        
        else begin
            pistol_data_x_a <= pistol_data_x_a == NULL_X ? NULL_X : (pistol_data_x_a != 95) ? pistol_data_x_a + 1 : NULL_X;
            pistol_data_x_b <= pistol_data_x_b == NULL_X ? NULL_X : (pistol_data_x_b != 0) ? pistol_data_x_b - 1 : NULL_X;
            rifle1_data_x_a <= rifle1_data_x_a == NULL_X ? NULL_X : (rifle1_data_x_a != 95) ? rifle1_data_x_a + 1 : NULL_X;
            rifle1_data_x_b <= rifle1_data_x_b == NULL_X ? NULL_X : (rifle1_data_x_b != 0) ? rifle1_data_x_b - 1 : NULL_X;
            rifle2_data_x_a <= rifle2_data_x_a == NULL_X ? NULL_X : (rifle2_data_x_a != 95) ? rifle2_data_x_a + 1 : NULL_X;
            rifle2_data_x_b <= rifle2_data_x_b == NULL_X ? NULL_X : (rifle2_data_x_b != 0) ? rifle2_data_x_b - 1 : NULL_X;
            rifle3_data_x_a <= rifle3_data_x_a == NULL_X ? NULL_X : (rifle3_data_x_a != 95) ? rifle3_data_x_a + 1 : NULL_X;
            rifle3_data_x_b <= rifle3_data_x_b == NULL_X ? NULL_X : (rifle3_data_x_b != 0) ? rifle3_data_x_b - 1 : NULL_X;
            rifle4_data_x_a <= rifle4_data_x_a == NULL_X ? NULL_X : (rifle4_data_x_a != 95) ? rifle4_data_x_a + 1 : NULL_X;
            rifle4_data_x_b <= rifle4_data_x_b == NULL_X ? NULL_X : (rifle4_data_x_b != 0) ? rifle4_data_x_b - 1 : NULL_X;
            if (shoot_a && !pistol_cooldown_a && curr_weapon_a == 0) begin
                pistol_data_x_a <= curr_x_a;
                pistol_data_y_a <= curr_y_a;
            end
            if (shoot_b && !pistol_cooldown_b && curr_weapon_b == 0) begin
                pistol_data_x_b <= curr_x_b;
                pistol_data_y_b <= curr_y_b;
            end
            if (shoot_a && !rifle_cooldown_a && curr_weapon_a == 1) begin
                if (rifle1_data_x_a == NULL_X) begin
                    rifle1_data_x_a <= curr_x_a;
                    rifle1_data_y_a <= curr_y_a;
                end
                else if (rifle2_data_x_a == NULL_X) begin
                    rifle2_data_x_a <= curr_x_a;
                    rifle2_data_y_a <= curr_y_a;
                end
                else if (rifle3_data_x_a == NULL_X) begin
                    rifle3_data_x_a <= curr_x_a;
                    rifle3_data_y_a <= curr_y_a;
                end
                else begin
                    rifle4_data_x_a <= curr_x_a;
                    rifle4_data_y_a <= curr_y_a;
                end
            end
            if (shoot_b && !rifle_cooldown_b && curr_weapon_b == 1) begin
                if (rifle1_data_x_b == NULL_X) begin
                    rifle1_data_x_b <= curr_x_b;
                    rifle1_data_y_b <= curr_y_b;
                end
                else if (rifle2_data_x_b == NULL_X) begin
                    rifle2_data_x_b <= curr_x_b;
                    rifle2_data_y_b <= curr_y_b;
                end
                else if (rifle3_data_x_b == NULL_X) begin
                    rifle3_data_x_b <= curr_x_b;
                    rifle3_data_y_b <= curr_y_b;
                end
                else begin
                    rifle4_data_x_b <= curr_x_b;
                    rifle4_data_y_b <= curr_y_b;
                end
            end
        end
    end
    
    integer j;
    always @(posedge clk300, posedge collision) begin
    
        if (collision) begin
            if (pickup_sniper_collision_a || hitbox_sniper_collision_a) begin
                sniper_data_x_a <= NULL_X;
                sniper_data_y_a <= NULL_Y;
            end
            if (pickup_sniper_collision_b || hitbox_sniper_collision_b) begin
                sniper_data_x_b <= NULL_X;
                sniper_data_y_b <= NULL_Y;
            end
        end
        
        else begin
            sniper_data_x_a <= sniper_data_x_a == NULL_X ? NULL_X : (sniper_data_x_a != 95) ? sniper_data_x_a + 1 : NULL_X;
            sniper_data_x_b <= sniper_data_x_b == NULL_X ? NULL_X : (sniper_data_x_b != 0) ? sniper_data_x_b - 1 : NULL_X;
            if (shoot_a && !sniper_cooldown_a && curr_weapon_a == 2) begin
                sniper_data_x_a <= curr_x_a;
                sniper_data_y_a <= curr_y_a;
            end
            if (shoot_b && !sniper_cooldown_b && curr_weapon_b == 2) begin
                sniper_data_x_b <= curr_x_b;
                sniper_data_y_b <= curr_y_b;
            end
        end
    end

    always @(negedge pickup_active) begin
        pickup_pos_transmit <= random_y;
        pickup_type_transmit <= random_pickup;
    end

    wire pistol_bullet_a, pistol_bullet_b,
    sniper_bullet_a, sniper_bullet_b,
    rifle1_bullet_a, rifle1_bullet_b,
    rifle2_bullet_a, rifle2_bullet_b,
    rifle3_bullet_a, rifle3_bullet_b,
    rifle4_bullet_a, rifle4_bullet_b,
    laser_beam_a, laser_beam_b;
    
    assign pistol_bullet_a = y == pistol_data_y_a && x >= pistol_data_x_a && x <= pistol_head_x_a;
    assign pistol_bullet_b = y == pistol_data_y_b && x >= pistol_head_x_b && x <= pistol_data_x_b;
    assign sniper_bullet_a = y == sniper_data_y_a && x >= sniper_data_x_a && x <= sniper_head_x_a;
    assign sniper_bullet_b = y == sniper_data_y_b && x >= sniper_head_x_b && x <= sniper_data_x_b;
    assign rifle1_bullet_a = y == rifle1_data_y_a && x >= rifle1_data_x_a && x <= rifle1_head_x_a;
    assign rifle1_bullet_b = y == rifle1_data_y_b && x >= rifle1_head_x_b && x <= rifle1_data_x_b;
    assign rifle2_bullet_a = y == rifle2_data_y_a && x >= rifle2_data_x_a && x <= rifle2_head_x_a;
    assign rifle2_bullet_b = y == rifle2_data_y_b && x >= rifle2_head_x_b && x <= rifle2_data_x_b;
    assign rifle3_bullet_a = y == rifle3_data_y_a && x >= rifle3_data_x_a && x <= rifle3_head_x_a;
    assign rifle3_bullet_b = y == rifle3_data_y_b && x >= rifle3_head_x_b && x <= rifle3_data_x_b;
    assign rifle4_bullet_a = y == rifle4_data_y_a && x >= rifle4_data_x_a && x <= rifle4_head_x_a;
    assign rifle4_bullet_b = y == rifle4_data_y_b && x >= rifle4_head_x_b && x <= rifle4_data_x_b;
    assign laser_beam_a = curr_weapon_a == 3 && shoot_a && y == curr_y_a && x >= curr_x_a && x <= laser_end_a;
    assign laser_beam_b = curr_weapon_b == 3 && shoot_b && y == curr_y_b && x >= laser_end_b && x <= curr_x_b;

    wire shieldbox_a, shieldbox_b;
    wire [6:0] player1_x_lower_shield, player1_x_higher_shield, player2_x_lower_shield, player2_x_higher_shield;
    wire [5:0] player1_y_lower_shield, player1_y_higher_shield, player2_y_lower_shield, player2_y_higher_shield;
    assign player1_x_lower_shield = player1_x_lower - 1;
    assign player1_x_higher_shield = player1_x_higher + 1;
    assign player1_y_lower_shield = player1_y_lower > 0 ? player1_y_lower - 1 : 0;
    assign player1_y_higher_shield = player1_y_higher < 63 ? player1_y_higher + 1 : 63;
    assign player2_x_lower_shield = player2_x_lower - 1;
    assign player2_x_higher_shield = player2_x_higher + 1;
    assign player2_y_lower_shield = player2_y_lower > 0 ? player2_y_lower - 1 : 0;
    assign player2_y_higher_shield = player2_y_higher < 63 ? player2_y_higher + 1 : 63;
    assign shieldbox_a = (x == player2_x_lower_shield || x == player2_x_higher_shield) && y >= player2_y_lower_shield && y <= player2_y_higher_shield
    || (y == player2_y_lower_shield || y == player2_y_higher_shield) && x >= player2_x_lower_shield && x <= player2_x_higher_shield;
    assign shieldbox_b = (x == player1_x_lower_shield || x == player1_x_higher_shield) && y >= player1_y_lower_shield && y <= player1_y_higher_shield
    || (y == player1_y_lower_shield || y == player1_y_higher_shield) && x >= player1_x_lower_shield && x <= player1_x_higher_shield;
    
    wire hitbox_a, hitbox_b, pickup_hitbox;
    assign hitbox_a = x >= player2_x_lower && x <= player2_x_higher && y <= player2_y_higher && y >= player2_y_lower;
    assign hitbox_b = x >= player1_x_lower && x <= player1_x_higher && y <= player1_y_higher && y >= player1_y_lower;
    assign pickup_hitbox = (x == 45 || x == 50) && y >= pickup_pos - 2 && y <= pickup_pos + 3;
    // improved
    always @(posedge clk6p25m) begin
        // if one person dies, send flag to notify other player am dead
        if (sw0 && health_b == 0 && game_state >= 4) begin
            my_death <= 1;
        end
        if (sw15 && health_a == 0 && game_state >= 4) begin
            my_death <= 1;
        end
        if (game_state < 4) begin
            curr_weapon_a <= 0;
            curr_weapon_b <= 0;
            health_a <= 16;
            health_b <= 16;
            my_death <= 0;
        end
        if (sw0 && opp_death && game_state == 4) begin
            health_a <= 0;
        end
        if (sw15 && opp_death && game_state == 4) begin
            health_b <= 0;
        end
        else begin
            if (hitbox_a) begin
                pixel_data <= player2_sprite;
            end
            else if (hitbox_b) begin
                pixel_data <= player1_sprite;
            end
            else if (laser_beam_a) begin
                pixel_data <= RED;
            end
            else if (laser_beam_b) begin
                pixel_data <= BLUE;
            end
            else if (pistol_bullet_a || shield_a && shieldbox_a || shield_b && shieldbox_b) begin
                pixel_data <= YELLOW;
            end
            else if (pistol_bullet_b) begin
                pixel_data <= GREEN;
            end
            else if (rifle1_bullet_a || rifle2_bullet_a || rifle3_bullet_a || rifle4_bullet_a) begin
                pixel_data <= ORANGE;
            end
            else if (rifle1_bullet_b || rifle2_bullet_b || rifle3_bullet_b || rifle4_bullet_b) begin
                pixel_data <= CYAN;
            end
            else if (sniper_bullet_a) begin
                pixel_data <= RED;
            end
            else if (sniper_bullet_b) begin
                pixel_data <= PINK;
            end
            else if (x >= 47 && x <= 48 && y >= 0 && y <= 63) begin
                pixel_data <= WHITE;
            end
            else begin
                pixel_data <= BLACK;
            end
            
            if ((curr_weapon_a == 1 && drop_rifle_a) || (curr_weapon_a == 2 && drop_sniper_a) || (curr_weapon_a == 3 && drop_laser_a)) begin
                curr_weapon_a <= 0;
            end
            
            if ((curr_weapon_b == 1 && drop_rifle_b) || (curr_weapon_b == 2 && drop_sniper_b) || (curr_weapon_b == 3 && drop_laser_b)) begin
                curr_weapon_b <= 0;
            end
            
            if (reset_rifle_ammo_done_a) begin
                reset_rifle_ammo_a <= 0;
            end
            
            if (reset_rifle_ammo_done_b) begin
                reset_rifle_ammo_b <= 0;
            end
            
            if (reset_sniper_ammo_done_a) begin
                reset_sniper_ammo_a <= 0;
            end
            
            if (reset_sniper_ammo_done_b) begin
                reset_sniper_ammo_b <= 0;
            end
            
            if (reset_laser_ammo_done_a) begin
                reset_laser_ammo_a <= 0;
            end
            
            if (reset_laser_ammo_done_b) begin
                reset_laser_ammo_b <= 0;
            end
            
            if (hitbox_a) begin
                if (pistol_bullet_b) begin
                    hitbox_pistol_collision_b <= 1;
                    if (sw15)
                        health_a <= health_a > pistol_dmg_b ? health_a - pistol_dmg_b : 0;
                end
                else if (sniper_bullet_b) begin
                    hitbox_sniper_collision_b <= 1;
                    if (sw15)
                        health_a <= health_a > sniper_dmg_b ? health_a - sniper_dmg_b : 0;
                end
                else if (rifle1_bullet_b) begin
                    hitbox_rifle1_collision_b <= 1;
                    if (sw15)
                        health_a <= health_a > rifle_dmg_b ? health_a - rifle_dmg_b : 0;
                end
                else if (rifle2_bullet_b) begin
                    hitbox_rifle2_collision_b <= 1;
                    if (sw15)
                        health_a <= health_a > rifle_dmg_b ? health_a - rifle_dmg_b : 0;
                end
                else if (rifle3_bullet_b) begin
                    hitbox_rifle3_collision_b <= 1;
                    if (sw15)
                        health_a <= health_a > rifle_dmg_b ? health_a - rifle_dmg_b : 0;
                end
                else if (rifle4_bullet_b) begin
                    hitbox_rifle4_collision_b <= 1;
                    if (sw15)
                        health_a <= health_a > rifle_dmg_b ? health_a - rifle_dmg_b : 0;
                end
                else begin
                    hitbox_pistol_collision_b <= 0;
                    hitbox_sniper_collision_b <= 0;
                    hitbox_rifle1_collision_b <= 0;
                    hitbox_rifle2_collision_b <= 0;
                    hitbox_rifle3_collision_b <= 0;
                    hitbox_rifle4_collision_b <= 0;
                end
            end
           
            
            
            if (hitbox_b) begin
                if (pistol_bullet_a) begin
                    hitbox_pistol_collision_a <= 1;
                    if (sw0)
                        health_b <= health_b > pistol_dmg_a ? health_b - pistol_dmg_a : 0;
                end
                else if (sniper_bullet_a) begin
                    hitbox_sniper_collision_a <= 1;
                    if (sw0)
                        health_b <= health_b > sniper_dmg_a ? health_b - sniper_dmg_a : 0;
                end
                else if (rifle1_bullet_a) begin
                    hitbox_rifle1_collision_a <= 1;
                    if (sw0)
                        health_b <= health_b > rifle_dmg_a ? health_b - rifle_dmg_a : 0;
                end
                else if (rifle2_bullet_a) begin
                    hitbox_rifle2_collision_a <= 1;
                    if (sw0)
                        health_b <= health_b > rifle_dmg_a ? health_b - rifle_dmg_a : 0;
                end
                else if (rifle3_bullet_a) begin
                    hitbox_rifle3_collision_a <= 1;
                    if (sw0)
                        health_b <= health_b > rifle_dmg_a ? health_b - rifle_dmg_a : 0;
                end
                else if (rifle4_bullet_a) begin
                    hitbox_rifle4_collision_a <= 1;
                    if (sw0)
                        health_b <= health_b > rifle_dmg_a ? health_b - rifle_dmg_a : 0;
                end
                else begin
                    hitbox_pistol_collision_a <= 0;
                    hitbox_sniper_collision_a <= 0;
                    hitbox_rifle1_collision_a <= 0;
                    hitbox_rifle2_collision_a <= 0;
                    hitbox_rifle3_collision_a <= 0;
                    hitbox_rifle4_collision_a <= 0;
                end
            end
            
            
            if (laser_damage_a) begin
                if (sw0)
                    health_b <= health_b - 1;
            end
            
            if (laser_damage_b) begin
                if (sw15)
                    health_a <= health_a - 1;
            end
            
            if (pickup_active) begin
                if (pickup_hitbox && (pistol_bullet_a || sniper_bullet_a || rifle1_bullet_a || rifle2_bullet_a || rifle3_bullet_a || rifle4_bullet_a) || pickup_laser_collision_a) begin
                    
                    if (pistol_bullet_a) 
                        pickup_pistol_collision_a <= 1;
                    else if (sniper_bullet_a)
                        pickup_sniper_collision_a <= 1;
                    else if (rifle1_bullet_a)
                        pickup_rifle1_collision_a <= 1;
                    else if (rifle2_bullet_a)
                        pickup_rifle2_collision_a <= 1;
                    else if (rifle3_bullet_a)
                        pickup_rifle3_collision_a <= 1;
                    else
                        pickup_rifle4_collision_a <= 1;
                    
                    if (pickup_type == 1) begin
                        if (curr_weapon_a == 1) begin
                            reset_rifle_ammo_a <= 1;
                        end
                        curr_weapon_a <= 1;
                    end
                    else if (pickup_type == 2) begin
                        if (curr_weapon_a == 2) begin
                            reset_sniper_ammo_a <= 1;
                        end
                        curr_weapon_a <= 2;
                    end
                    else if (pickup_type == 3) begin
                        if (curr_weapon_a == 3) begin
                            reset_laser_ammo_a <= 1;
                        end
                        curr_weapon_a <= 3;
                    end
                    else if (pickup_type == 4) begin
                        health_a <= health_a + 4 > 16 ? 16 : health_a + 4;
                    end
                    else begin
                        activate_shield_a <= 1;
                    end
                end
                else if (pickup_hitbox && (pistol_bullet_b || sniper_bullet_b || rifle1_bullet_b || rifle2_bullet_b || rifle3_bullet_b || rifle4_bullet_b) || pickup_laser_collision_b) begin
                    
                    if (pistol_bullet_b) 
                        pickup_pistol_collision_b <= 1;
                    else if (sniper_bullet_b)
                        pickup_sniper_collision_b <= 1;
                    else if (rifle1_bullet_b)
                        pickup_rifle1_collision_b <= 1;
                    else if (rifle2_bullet_b)
                        pickup_rifle2_collision_b <= 1;
                    else if (rifle3_bullet_b)
                        pickup_rifle3_collision_b <= 1;
                    else
                        pickup_rifle4_collision_b <= 1;
                    
                    if (pickup_type == 1) begin
                        if (curr_weapon_b == 1) begin
                            reset_rifle_ammo_b <= 1;
                        end
                        curr_weapon_b <= 1;
                    end
                    else if (pickup_type == 2) begin
                        if (curr_weapon_b == 2) begin
                            reset_sniper_ammo_b <= 1;
                        end
                        curr_weapon_b <= 2;
                    end
                    else if (pickup_type == 3) begin
                        if (curr_weapon_b == 3) begin
                            reset_laser_ammo_b <= 1;
                        end
                        curr_weapon_b <= 3;
                    end
                    else if (pickup_type == 4) begin
                        health_b <= health_b + 4 > 16 ? 16 : health_b + 4;
                    end
                    else begin
                        activate_shield_b <= 1;
                    end
                end
                else if (pickup_type >= 1 && pickup_type <= 3) begin
                    if (((y == pickup_pos + 3 || y == pickup_pos - 2) && x >= 45 && x <= 50)
                    || (y == pickup_pos && (x == 45 || x == 46 || x == 49 || x == 50))
                    || ((x == 45 || x == 50) && y >= pickup_pos - 2 && y <= pickup_pos + 3)
                    ) begin
                        pixel_data <= DARK_GRAY;
                    end
                    else if (y == pickup_pos && (x == 47 || x == 48)) begin
                        pixel_data <= LIGHT_GRAY;
                    end
                    else if ((y == pickup_pos - 1 || y == pickup_pos + 1 || y == pickup_pos + 2)
                    && x >= 46 && x <= 49
                    ) begin
                        pixel_data <= BROWN;
                    end
                end
                else if (pickup_type == 4) begin
                    if (((y == pickup_pos || y == pickup_pos + 1) && x >= 45 && x <= 50)
                    || ((x == 47 || x == 48) && y >= pickup_pos - 2 && y <= pickup_pos + 3)
                    ) begin
                        pixel_data <= GREEN;
                    end
                end
                else begin
                    if (((y == pickup_pos - 2 || y == pickup_pos + 3) && x >= 45 && x <= 50)
                    || ((x == 45 || x == 50) && y >= pickup_pos - 2 && y <= pickup_pos + 3)
                    ) begin
                        pixel_data <= YELLOW;
                    end
                end
            end
            else begin
                pickup_pistol_collision_a <= 0;
                pickup_pistol_collision_b <= 0;
                pickup_sniper_collision_a <= 0;
                pickup_sniper_collision_b <= 0;
                pickup_rifle1_collision_a <= 0;
                pickup_rifle1_collision_b <= 0;
                pickup_rifle2_collision_a <= 0;
                pickup_rifle2_collision_b <= 0;
                pickup_rifle3_collision_a <= 0;
                pickup_rifle3_collision_b <= 0;
                pickup_rifle4_collision_a <= 0;
                pickup_rifle4_collision_b <= 0;
                activate_shield_a <= 0;
                activate_shield_b <= 0;
            end
        end
    end
    
    ////////////////////////////////////////////////////////////////
    
    assign curr_x_b = player1_x_lower - 1;
    assign curr_y_b = (player1_y_higher - player1_y_lower)/2 + player1_y_lower;
    assign curr_x_a = player2_x_higher + 1;
    assign curr_y_a = (player2_y_higher - player2_y_lower)/2 + player2_y_lower;
    
    assign player1_x_lower = 79 + x_movement_player1;
    assign player1_x_higher = 91 + x_movement_player1;
    assign player1_y_lower = 24 + y_movement_player1;
    assign player1_y_higher = 38 + y_movement_player1;
    assign player2_x_lower = 4 + x_movement_player2;
    assign player2_x_higher = 16 + x_movement_player2; 
    assign player2_y_lower = 24 + y_movement_player2;
    assign player2_y_higher = 38 + y_movement_player2;
    
    
    reg [1:0] player1_sprite_state, player2_sprite_state;
    player1_rom(.x(x-player1_x_lower), .y(y-player1_y_lower), .clk(clk6p25m), .player1_sprite(player1_sprite), .player1_sprite_state(player1_sprite_state)); 
    player2_rom(.x(x-player2_x_lower), .y(y-player2_y_lower), .clk(clk6p25m), .player2_sprite(player2_sprite), .player2_sprite_state(player2_sprite_state));
    
    //Next state movement for players
    always @(posedge clk6p25m) begin

    if(hitbox_pistol_collision_a || hitbox_sniper_collision_a || hitbox_rifle1_collision_a || hitbox_rifle2_collision_a || hitbox_rifle3_collision_a || hitbox_rifle4_collision_a)       
    knockback_player1 <= 1;
    if (knockback_counter == 50)
    knockback_player1 <= 0;

    if(hitbox_pistol_collision_b || hitbox_sniper_collision_b || hitbox_rifle1_collision_b || hitbox_rifle2_collision_b || hitbox_rifle3_collision_b || hitbox_rifle4_collision_b)
    knockback_player2 <= 1;
    if (knockback_counter_player2 == 50)
    knockback_player2 <= 0;
    end
    
    // checking the keyboard inputs for player1 and collisions
    always @(posedge clk1khz) begin
        if (game_state < 4) begin
            x_movement_player1 <= 0;
            y_movement_player1 <= 0;
        end
        else begin
            if (sw0) begin
                if (counter % 50 == 0) begin
                    if(_w1)
                        y_movement_player1 <= (y_movement_player1 <= -24)? -24: y_movement_player1 - 1;
                    if(_s1)
                        y_movement_player1 <= (y_movement_player1 >= 25)? 25: y_movement_player1 + 1;
                    if(_a1)
                        x_movement_player1 <= (x_movement_player1 <= -30) ? -30: x_movement_player1 - 1;
                    if(_d1)
                        x_movement_player1 <= (x_movement_player1 >= 3)? 3: x_movement_player1 + 1;
                    if(counter == 50)                        
                        player1_sprite_state <= 1;
                    if(counter == 100)                        
                        player1_sprite_state <= 2;
                    if(counter == 0)                        
                        player1_sprite_state <= 0;
                end
            end
            if (sw15) begin
                if(counter2 % 50 == 0) begin
                    if(_w2)
                        y_movement_player1 <= (y_movement_player1 <= -24)? -24: y_movement_player1 - 1;
                    if(_s2)
                        y_movement_player1 <= (y_movement_player1 >= 25)? 25: y_movement_player1 + 1;
                    if(_a2)
                        x_movement_player1 <= (x_movement_player1 <= -30) ? -30: x_movement_player1 - 1;
                    if(_d2)
                        x_movement_player1 <= (x_movement_player1 >= 3)? 3: x_movement_player1 + 1;
                    if(counter2 == 50)                        
                        player1_sprite_state <= 1;
                    if(counter2 == 100)                        
                        player1_sprite_state <= 2;
                    if(counter2 == 0)                        
                        player1_sprite_state <= 0;
                end
            end
            if (knockback_player1 && (knockback_counter % 2500000 == 0) && !shield_b)
                x_movement_player1<= (x_movement_player1 >= 2)? 3: x_movement_player1 + 2;
        end
    end
    
    //checking keyboard inputs for player2 and collisions
    always @(posedge clk1khz) begin
        if (game_state < 4) begin
            x_movement_player2 <= 0;
            y_movement_player2 <= 0;
        end
        else begin
            if (sw0) begin
                if (counter2 % 50 == 0) begin
                    if(_w2)
                        y_movement_player2 <= (y_movement_player2 <= -24)? -24: y_movement_player2 - 1;
                    if(_s2)
                        y_movement_player2 <= (y_movement_player2 >= 25)? 25: y_movement_player2 + 1;
                    if(_a2)
                        x_movement_player2 <= (x_movement_player2 <= -3)? -3: x_movement_player2 - 1;
                    if(_d2)
                        x_movement_player2 <= (x_movement_player2 >= 30)? 30: x_movement_player2 + 1;
                    if(counter2 == 50)                        
                        player2_sprite_state <= 1;
                    if(counter2 == 100)                        
                        player2_sprite_state <= 2;
                    if(counter2 == 0)                        
                        player2_sprite_state <= 0;
                end
            end
            if (sw15) begin
                if (counter % 50 == 0) begin       
                    if(_w1)
                        y_movement_player2 <= (y_movement_player2 <= -24)? -24: y_movement_player2 - 1;
                    if(_s1)
                        y_movement_player2 <= (y_movement_player2 >= 25)? 25: y_movement_player2 + 1;
                    if(_a1)
                        x_movement_player2 <= (x_movement_player2 <= -3)? -3: x_movement_player2 - 1;
                    if(_d1)
                        x_movement_player2 <= (x_movement_player2 >= 30)? 30: x_movement_player2 + 1;
                    if(counter == 50)                        
                        player2_sprite_state <= 1;
                    if(counter == 100)                        
                        player2_sprite_state <= 2;
                    if(counter == 0)                        
                        player2_sprite_state <= 0;
                end
            end
                if (knockback_player2 && (knockback_counter_player2 % 2500000 == 0) && !shield_a)
                    x_movement_player2 <= (x_movement_player2 <= -2)? -3: x_movement_player2 - 2;
        end
    end
    
    // button counter for player 1 for debouncing
    always @(posedge clk1khz) begin
    counter <= (counter == 100)? counter: counter+1;
    if(w1)
    _w1 <= 1;
    if(s1)
    _s1 <= 1;
    if(a1)
    _a1 <= 1;
    if(d1)
    _d1 <= 1;
    if(counter == 100)begin
    _w1 <= 0;
    _s1 <= 0;
    _a1 <= 0;
    _d1 <= 0;
    end
    if(!_w1 && !_s1 && !_a1 && !_d1)
    counter<= 0;
    end
    
    
    //button counter for player 2
    always @(posedge clk1khz) begin
        counter2 <= (counter2 == 100)? counter2: counter2+1;
        if(w2)
        _w2 <= 1;
        if(s2)
        _s2 <= 1;
        if(a2)
        _a2 <= 1;
        if(d2)
        _d2 <= 1;
        if(counter2 == 100)begin
        _w2 <= 0;
        _s2 <= 0;
        _a2 <= 0;
        _d2 <= 0;
        end
        if(!_w2 && !_s2 && !_a2 && !_d2)
        counter2<= 0;
        end
       
       
    
    //knockback counter for player 1
    always @(posedge clk1khz) begin
    if(knockback_player1)begin
    knockback_counter <= (knockback_counter == 50)? knockback_counter: knockback_counter + 1;
    end
    if(!knockback_player1)
    knockback_counter <= 0;
    end
    
    //knockback counter for player 2
    always @(posedge clk1khz) begin
    if(knockback_player2)begin
    knockback_counter_player2 <= (knockback_counter_player2 == 50)? knockback_counter_player2: knockback_counter_player2 + 1;
    end
    if(!knockback_player2)
    knockback_counter_player2 <= 0;
    end
    
endmodule
