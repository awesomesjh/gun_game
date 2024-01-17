`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2023 20:06:49
// Design Name: 
// Module Name: kb_processing
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

module kb_processing(
    input         clk,
    input         PS2Data,
    input         PS2Clk,
    output reg [4:0] key_states = 16'b0
);

    reg CLK50MHZ=0;
    wire [15:0] keycode;
    wire flag;
    
    PS2Receiver uut (
            .clk(CLK50MHZ),
            .kclk(PS2Clk),
            .kdata(PS2Data),
            .keycode(keycode),
            .oflag(flag)
     );
    
    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end
                
    always@(posedge clk)
        begin
            if (keycode[15:8] == 8'hf0) begin
                if (keycode[7:0] == 8'h1c) begin key_states[1] <= 0; end
                if (keycode[7:0] == 8'h23) begin key_states[0] <= 0; end
                if (keycode[7:0] == 8'h1d) begin key_states[3] <= 0; end
                if (keycode[7:0] == 8'h1b) begin key_states[2] <= 0; end
                if (keycode[7:0] == 8'h5a) begin key_states[4] <= 0; end
            end else begin
                if (keycode[7:0] == 8'h1c) begin key_states[1] <= 1; end // Left (A)
                if (keycode[7:0] == 8'h23) begin key_states[0] <= 1; end // Right (D)
                if (keycode[7:0] == 8'h1d) begin key_states[3] <= 1; end // Up (W)
                if (keycode[7:0] == 8'h1b) begin key_states[2] <= 1; end // Down (S)
                if (keycode[7:0] == 8'h5a) begin key_states[4] <= 1; end // Shoot (Enter)
            end
     end
endmodule
