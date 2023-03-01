`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 05:42:56 PM
// Design Name: 
// Module Name: tester
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


module tester();

reg rst, clk;
wire hsync, vsync;
wire [3:0] red;
wire [3:0] green;
wire [3:0] blue;
 
VGAwcolor vga0(clk,rst,hsync,vsync,red,green,blue);
 
always begin
#5 clk = ~clk; // trigger the clock every 40 ticks
end
 
 initial begin
 rst = 1'b0; // reset the clk
 clk = 1'b0; // set the initial value of the clock
 #1
 rst = 1'b1; // start the state machine
 #4000000000; // let it run for 400 million time ticks
 end
 
 // when a rising edge is detected on clock, print the time and the
 // associated values of clk and gclk.
 always @(posedge clk) begin
 $display("clk=%b hsync=%b vsync=%b time=%d",clk,hsync,vsync,$time);
 end


endmodule
