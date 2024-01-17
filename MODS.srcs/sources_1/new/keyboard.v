`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 05:28:22 PM
// Design Name: 
// Module Name: keyboard
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


module keyboard(
    input clk,
    input PS2Data,
    input PS2Clk,
    output reg [4:0] keys = 0
);

    /*Explanation
        key_states is a 5 bit value that carries keyboard input data
        WASD and Enter keys take one bit each
        '1' if key is pressed, '0' if key is not pressed
            key_states[0] >> RIGHT (D)
            key_states[1] >> LEFT (A)
            key_states[2] >> DOWN (S)
            key_states[3] >> UP (W)
            key_states[4] >> SHOOT (ENTER) 
        eg. 5'b00101 means only the RIGHT and DOWN keys are pressed 
    */
    wire [4:0] key_states;
    kb_processing mod_kbtest(
        .clk(clk), 
        .PS2Data(PS2Data), 
        .PS2Clk(PS2Clk), 
        .key_states(key_states)
        );
    
    // Mapped it to led lights just to see outputs
    always @ (key_states)
    begin
        keys = key_states;
    end
     
endmodule
