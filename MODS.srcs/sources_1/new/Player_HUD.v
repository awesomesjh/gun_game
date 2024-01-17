`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 14:24:48
// Design Name: 
// Module Name: Player_HUD
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


module Player_HUD(
    input clk,
    input [4:0] player_health, // Health from 0 to 16
    input [1:0] player_weapon, // Weapon from 0,1,2, pistol, automatic, sniper
    input [11:0] player_ammo, // Ammo from 0 to 99
    input [1:0] player_state, // 0 when game not started, 1 when player in game, 2 when player wins, 3 when player loses
    input [2:0] game_state, 
    output reg [6:0] seg = 7'b1111111, // 7 segments
    output reg dp = 1, // decimal point
    output reg [3:0] an = 4'b1111, // anode to use
    output reg [15:0] led = 0 // leds
);
    
    reg [1:0] anode_counter = 0;
    wire clk_1khz;
    wire rdy;
    wire [15:0] bcd_op;
    wire [15:0] bcd_seg;
    reg [6:0] bcd_to_seg [9:0]; // 0-9
    reg [6:0] letter_front [2:0]; // P,A,S
    reg [6:0] reload_letters [3:0]; // RELOAD
    reg [6:0] LOSE_letters [3:0];
    reg [6:0] ggEZ_letters [3:0];
    
    initial begin
        bcd_to_seg[0] = 7'b1000000; // "0"
        bcd_to_seg[1] = 7'b1111001; // "1"
        bcd_to_seg[2] = 7'b0100100; // "2"
        bcd_to_seg[3] = 7'b0110000; // "3"
        bcd_to_seg[4] = 7'b0011001; // "4"
        bcd_to_seg[5] = 7'b0010010; // "5"
        bcd_to_seg[6] = 7'b0000010; // "6"
        bcd_to_seg[7] = 7'b1111000; // "7"
        bcd_to_seg[8] = 7'b0000000; // "8"
        bcd_to_seg[9] = 7'b0010000; // "9"
        letter_front[0] = 7'b0001100; // Pistol
        letter_front[1] = 7'b0001000; // Automatic
        letter_front[2] = 7'b0010010; // Sniper
        letter_front[3] = 7'b1000111; // Laser
        reload_letters[0] = 7'b1001100; // "R"
        reload_letters[1] = 7'b0000110; // "E"
        reload_letters[2] = 7'b1111111; // "EMPTY"
        reload_letters[3] = 7'b1111111; // "EMPTY"
        LOSE_letters[0] = 7'b1000111; // "L"
        LOSE_letters[1] = 7'b1000000; // "O"
        LOSE_letters[2] = 7'b0010010; // "S"
        LOSE_letters[3] = 7'b0000110; // "E"
        ggEZ_letters[0] = 7'b0010000; // "g"
        ggEZ_letters[1] = 7'b0010000; // "g"
        ggEZ_letters[2] = 7'b0000110; // "E"
        ggEZ_letters[3] = 7'b0100100; // "Z"
    end
    
    // Convert Binary to BCD
    clk_divider mod_clk1khz(clk, 49999, clk_1khz);
    BCDConvert mod(clk, 1, player_ammo, bcd_op, rdy);
    assign bcd_seg = rdy ? bcd_op : bcd_seg;
    
    // Displaying BCD stuff
    reg flash_state = 0;
    reg [8:0] flash_counter = 0;
    
    // MAIN BCD CODE
    always @ (posedge clk_1khz)
    begin
        if (player_state != 0) begin
            anode_counter <= anode_counter + 1;
            case (anode_counter)
            2'b00: begin 
                an = 4'b0111; 
                seg = player_state == 3 ? LOSE_letters[0] : 
                      player_state == 2 ? ggEZ_letters[0] : 
                      player_ammo ? letter_front[player_weapon] : 
                      reload_letters[0]; 
            end
                        
            2'b01: begin 
                an = 4'b1011; 
                seg = player_state == 3 ? LOSE_letters[1] : 
                      player_state == 2 ? ggEZ_letters[1] :
                      player_ammo ? (bcd_seg[11:8] ? bcd_to_seg[bcd_seg[11:8]] : 7'b1111111) : 
                      reload_letters[1];  
            end
                        
            2'b10: begin 
                an = 4'b1101; 
                //seg = bcd_seg[7:4] ? bcd_to_seg[bcd_seg[7:4]] : 7'b1111111;
                seg = player_state == 3 ? LOSE_letters[2] : 
                      player_state == 2 ? ggEZ_letters[2] :
                      player_ammo ? (bcd_seg[7:4] | bcd_seg[11:8] ? bcd_to_seg[bcd_seg[7:4]] : 7'b1111111) : 
                      reload_letters[2];  
            end
                        
            2'b11: begin 
                an = 4'b1110; 
                //seg = bcd_to_seg[bcd_seg[3:0]];
                seg = player_state == 3 ? LOSE_letters[3] : 
                      player_state == 2 ? ggEZ_letters[3] :
                      player_ammo ? bcd_to_seg[bcd_seg[3:0]] : 
                      reload_letters[3]; 
            end
        endcase
        end else begin
            an = 4'b1111;
        end
    end
    
    // Flash RE - LOAD at intervals when player_ammo == 0
    always @ (posedge clk_1khz)
    begin
        if (player_ammo) begin 
            flash_state <= 0;
            flash_counter <= 0;
            reload_letters[0] <= 7'b1001100;
            reload_letters[1] <= 7'b0000110;
            reload_letters[2] = 7'b1111111; // EMPTY
            reload_letters[3] = 7'b1111111; 
        end 
        else begin
        case (flash_state)
            0: begin 
                reload_letters[0] <= 7'b1001100; // "R"
                reload_letters[1] <= 7'b0000110; // "E"
                reload_letters[2] = 7'b1111111; // EMPTY
                reload_letters[3] = 7'b1111111; // EMPTY
            end
            1: begin
                reload_letters[0] = 7'b1000111; // "L"
                reload_letters[1] = 7'b1000000; // "O"
                reload_letters[2] = 7'b0001000; // "A"
                reload_letters[3] = 7'b0100001; // "D"
            end
            default: begin
                reload_letters[0] <= 7'b1001100;
                reload_letters[1] <= 7'b0000110;
                reload_letters[2] = 7'b1111111; // EMPTY
                reload_letters[3] = 7'b1111111;
            end
            endcase
            flash_counter <= flash_counter + 1;
            if (flash_counter >= 500)
                begin
                    flash_counter <= 0;
                    flash_state <= flash_state + 1;
                end
        end
    end
    
    // Player Health HUD 
    reg [15:0] led_light = 65535;
    reg [12:0] pwm_counter = 0;
    reg [12:0] pwm = 0;
    reg fade_in = 1;
    
    always @ (posedge clk)
    begin
        pwm_counter <= pwm_counter + 1;
        if (pwm == {13{1'b1}})
            fade_in <= 0;
        else if (pwm == 0)
            fade_in <= 1;
            
        if (pwm_counter == {13{1'b1}})
            pwm <= (fade_in) ? pwm + 1 : pwm - 1;
    end
        
    always @ (posedge clk)
    begin
        if (player_state == 0) begin
            led_light[14:1] <= 0;
            led_light[0] <= game_state == 2 || game_state == 3 ? 1 : (pwm_counter <= pwm) ? 1 : 0;
            led_light[15] <= game_state == 1 || game_state == 3 ? 1 : (pwm_counter <= pwm) ? 1 : 0;
            
            led <= led_light;
        end else begin
        case(player_health)
        1: led_light = 16'b0000000000000001;
        2: led_light = 16'b0000000000000011; 
        3: led_light = 16'b0000000000000111; 
        4: led_light = 16'b0000000000001111; 
        5: led_light = 16'b0000000000011111; 
        6: led_light = 16'b0000000000111111; 
        7: led_light = 16'b0000000001111111; 
        8: led_light = 16'b0000000011111111; 
        9: led_light = 16'b0000000111111111; 
        10: led_light = 16'b0000001111111111; 
        11: led_light = 16'b0000011111111111; 
        12: led_light = 16'b0000111111111111; 
        13: led_light = 16'b0001111111111111; 
        14: led_light = 16'b0011111111111111; 
        15: led_light = 16'b0111111111111111; 
        16: led_light = 16'b1111111111111111;
        default: led_light = 16'b0;
        endcase
        led <= led_light;
        end
    end
    
endmodule
