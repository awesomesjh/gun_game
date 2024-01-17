`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 12:37:36
// Design Name: 
// Module Name: player2_input_transfer
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


module player2_input_transfer(
    input CLOCK, btnC_flag_db,
    input my_death, p2_rdy, btnC, p1_rdy, w, s, a, d, enter, rx_U, rx_D, rx_L, rx_R, rx_C, rx_p1_rdy, rx_p2_rdy, rx_start, transmit, rx_data, rx_death_state,
    output reg tx_U, tx_D, tx_L, tx_R, tx_C, tx_start, tx_data, tx_p1_rdy, tx_p2_rdy, w2,s2,a2,d2, shoot2, opp_p1_rdy, opp_p2_rdy, start_game, receive, tx_death_state, opp_death
    );
    

    always @ (posedge CLOCK)
    begin
    tx_U <= w;
    tx_D <= s;
    tx_L <= a;
    tx_R <= d;
    tx_C <= enter;
    tx_start <= btnC && btnC_flag_db;
    tx_p1_rdy <= p1_rdy;
    tx_p2_rdy <= p2_rdy;
    tx_data <= transmit; 
    tx_death_state <= my_death;
        
    w2 <= rx_U;
    s2 <= rx_D;
    a2 <= rx_L;
    d2 <= rx_R;
    start_game <= rx_start;
    opp_p1_rdy <= rx_p1_rdy;
    opp_p2_rdy <= rx_p2_rdy;
    shoot2 <= rx_C;
    receive <= rx_data;
    opp_death <= rx_death_state;
    end
    
endmodule
