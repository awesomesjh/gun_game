`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input Basys_clock, reset_signal, btnC, PS2Data, PS2Clk, rx_U, rx_D, rx_L, rx_R, rx_C, rx_p1_rdy, rx_p2_rdy, rx_start, rx_data, rx_clk6khz, rx_death_state,
    input sw0, sw15,
    output rgb_cs, rgb_sdin, rgb_sclk, rgb_d_cn, rgb_resn, rgb_vccen, rgb_pmoden, tx_U, tx_D, tx_L, tx_R, tx_C, tx_p1_rdy, tx_p2_rdy, tx_start, tx_data, tx_clk6khz, tx_death_state,
    output dp,
    output [6:0] seg, 
    output [3:0] an,
    output [15:0] led
);

    wire clk6p25m, clk6khz;
    wire transmit, receive, pickup_active;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    wire [6:0] x;
    wire [5:0] y;
    wire [15:0] oled_data, start_screen_oled, game_data;
    wire [4:0] keys;
    wire w2,s2,a2,d2, shoot2;
    wire [1:0] player_weapon, curr_weapon_a, curr_weapon_b;
    wire [4:0] player_health, health_a, health_b;
    wire [11:0] player_ammo;
    wire [2:0] pistol_ammo_a, pistol_ammo_b, sniper_ammo_a, sniper_ammo_b;
    wire [4:0] rifle_ammo_a, rifle_ammo_b;
    wire [6:0] laser_ammo_a, laser_ammo_b;
    wire [5:0] pickup_pos_receive, pickup_pos_transmit;
    wire [2:0] pickup_type_receive, pickup_type_transmit;
    wire my_death, opp_death, p1_rdy, p2_rdy, opp_p1_rdy, opp_p2_rdy, start_game;
    wire [1:0] player_state;
    reg [2:0] state;
    reg btnC_flag_db = 1;
    reg [31:0] btnC_flag_counter = 0;
    
    // GAME STATE 
    // 0 >> p1,p2 not rdy @ start screen
    // 1 >> p1 rdy @ start screen
    // 2 >> p2 rdy @ start screen
    // 3 >> p1 & p2 rdy @ start screen
    // 4 >> In Game
    // 5 >> Player lose screen
    // 6 >> Player win screen
    always @(posedge Basys_clock) begin
    
        btnC_flag_counter <= btnC_flag_counter + 1;
        if (btnC_flag_counter >= 100000000) btnC_flag_db <= 1;    
        
        if ((state == 5 || state == 6)) // If on WIN/LOSE screen
        begin
            if (btnC) 
            begin
                state <= 0;
                btnC_flag_counter <= 0;
                btnC_flag_db <= 0;
            end
        end
        else if (player_state == 2) // Basys Board WIN
        begin
            state <= 6;
            btnC_flag_counter <= 0;
            btnC_flag_db <= 0;
        end 
        else if (player_state == 3) // Basys Board LOSE
        begin   
            state <= 5;
            btnC_flag_counter <= 0;
            btnC_flag_db <= 0;
        end 
        else if (state == 4) state <= 4;
        else if ( ( (p1_rdy && opp_p2_rdy && (start_game || btnC) ) || (opp_p1_rdy && p2_rdy && (start_game || btnC) ) )) state <= 4;
        else if (p1_rdy && ~p2_rdy && ~opp_p1_rdy && opp_p2_rdy || ~p1_rdy && p2_rdy && opp_p1_rdy && ~opp_p2_rdy) state <= 3;
        else if (~p1_rdy && p2_rdy && ~opp_p1_rdy && ~opp_p2_rdy || ~p1_rdy && ~p2_rdy && ~opp_p1_rdy && opp_p2_rdy) state <= 2;
        else if (p1_rdy && ~p2_rdy && ~opp_p1_rdy && ~opp_p2_rdy || ~p1_rdy && ~p2_rdy && opp_p1_rdy && ~opp_p2_rdy) state <= 1;
        else state <= 0;
        if (state == 3 || state == 4) begin
            btnC_flag_db <= 1;
        end
    end

    assign player_weapon = sw0 ? curr_weapon_b : curr_weapon_a;
    assign player_ammo = sw0 & (curr_weapon_b == 0)
        ? pistol_ammo_b
        : sw0 & (curr_weapon_b == 1)
        ? rifle_ammo_b
        : sw0 & (curr_weapon_b == 2)
        ? sniper_ammo_b
        : sw0 & (curr_weapon_b == 3)
        ? laser_ammo_b
        : curr_weapon_a == 0
        ? pistol_ammo_a
        : curr_weapon_a == 1
        ? rifle_ammo_a
        : curr_weapon_a == 2
        ? sniper_ammo_a
        : laser_ammo_a;
    
    // Player Health and State, 
    // 0 >> start screen
    // 1 >> in game
    // 2 >> win game
    // 3 >> lose game
    assign player_health = sw0 ? health_b : health_a;
    assign player_state = (state >= 4) ? 
            (sw0 && (!health_a | health_a > 16) ? 2 :
             sw0 && (!health_b | health_b > 16) ? 3 :
             sw15 && (!health_b | health_b > 16) ? 2 :
             sw15 && (!health_a | health_a > 16) ? 3 :
             1) :
             0;
    
    assign p1_rdy = sw15 && (state < 4) && btnC_flag_db;
    assign p2_rdy = sw0 && (state < 4) && btnC_flag_db;
    assign clk6khz = sw15 ? rx_clk6khz : tx_clk6khz;
        
    assign y = pixel_index / 96;
    assign x = pixel_index % 96;
 
    assign oled_data = state == 4 ? game_data : start_screen_oled;
    
    clk_divider clock_6p25m(Basys_clock, 7, clk6p25m);
    clk_divider clock_6khz(Basys_clock, 8332, tx_clk6khz);
    
    transmit_timer tt(clk6p25m, pickup_active, state, pickup_pos_transmit, pickup_type_transmit, transmit);
    receive_timer rt(clk6p25m, pickup_active, receive, state, pickup_pos_receive, pickup_type_receive);
    
    Oled_Display u1(
        .clk(clk6p25m),
        .reset(reset_signal),
        .frame_begin(frame_begin),
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        .pixel_index(pixel_index), 
        .pixel_data(oled_data) , 
        .cs(rgb_cs), 
        .sdin(rgb_sdin), 
        .sclk(rgb_sclk), 
        .d_cn(rgb_d_cn), 
        .resn(rgb_resn), 
        .vccen(rgb_vccen),
        .pmoden(rgb_pmoden)
    );
    
    keyboard u2(
        .clk(Basys_clock), 
        .PS2Data(PS2Data), 
        .PS2Clk(PS2Clk), 
        .keys(keys)
    );
    
    player2_input_transfer u3(
        .CLOCK(Basys_clock),
        .btnC_flag_db(btnC_flag_db), 
        .w(keys[3]), 
        .s(keys[2]), 
        .a(keys[1]), 
        .d(keys[0]),
        .enter(keys[4]),
        .p2_rdy(p2_rdy),
        .btnC(btnC),
        .p1_rdy(p1_rdy), 
        .my_death(my_death),
        .rx_U(rx_U), 
        .rx_D(rx_D), 
        .rx_L(rx_L),
        .rx_R(rx_R), 
        .rx_C(rx_C),
        .rx_start(rx_start),
        .rx_p1_rdy(rx_p1_rdy),
        .rx_p2_rdy(rx_p2_rdy),
        .rx_death_state(rx_death_state), 
        .tx_U(tx_U), 
        .tx_D(tx_D), 
        .tx_L(tx_L), 
        .tx_R(tx_R), 
        .tx_C(tx_C),
        .tx_start(tx_start),
        .tx_p1_rdy(tx_p1_rdy),
        .tx_p2_rdy(tx_p2_rdy),
        .tx_death_state(tx_death_state), 
        .w2(w2), 
        .s2(s2), 
        .a2(a2), 
        .d2(d2),
        .start_game(start_game),
        .opp_p1_rdy(opp_p1_rdy),
        .opp_p2_rdy(opp_p2_rdy), 
        .shoot2(shoot2),
        .tx_data(tx_data),
        .transmit(transmit),
        .receive(receive),
        .rx_data(rx_data),
        .opp_death(opp_death)
    );
    
    Player_HUD u4(
        .clk(Basys_clock),
        .player_health(player_health),
        .player_weapon(player_weapon),
        .player_ammo(player_ammo),
        .player_state(player_state),
        .game_state(state),
        .seg(seg), 
        .dp(dp),
        .an(an),
        .led(led)
    );
    
    StartingScreenTest u5(
        .state(state),
        .clk(Basys_clock), 
        .pixel_index(pixel_index), 
        .oled_data(start_screen_oled)
    );
    
    game_module u6(
        .clk6p25m(clk6p25m),
        .clk6khz(clk6khz),
        .shoot2(shoot2),
        .shoot1(keys[4]),
        .w1(keys[3]),
        .s1(keys[2]),
        .a1(keys[1]),
        .d1(keys[0]),
        .w2(w2),
        .s2(s2),
        .a2(a2),
        .d2(d2),
        .sw0(sw0),
        .sw15(sw15),
        .x(x),
        .y(y),
        .game_state(state),
        .pixel_data(game_data),
        .curr_weapon_a(curr_weapon_a),
        .curr_weapon_b(curr_weapon_b),
        .health_a(health_a),
        .health_b(health_b),
        .pistol_ammo_a(pistol_ammo_a),
        .pistol_ammo_b(pistol_ammo_b),
        .rifle_ammo_a(rifle_ammo_a),
        .rifle_ammo_b(rifle_ammo_b),
        .sniper_ammo_a(sniper_ammo_a),
        .sniper_ammo_b(sniper_ammo_b),
        .laser_ammo_a(laser_ammo_a),
        .laser_ammo_b(laser_ammo_b),
        .pickup_pos_receive(pickup_pos_receive),
        .pickup_type_receive(pickup_type_receive),
        .pickup_pos_transmit(pickup_pos_transmit),
        .pickup_type_transmit(pickup_type_transmit),
        .pickup_active(pickup_active),
        .opp_death(opp_death),
        .my_death(my_death)
    );
    
endmodule