`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 05:25:30 PM
// Design Name: 
// Module Name: VGAwcolor
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


module VGAwcolor(input clk, input rst, output hsync, output vsync, output 
[3:0] red, output [3:0] green, output [3:0] blue);

wire pixclk;
reg [13:0] hcount, vcount;
reg [13:0] counter;
reg [3:0] red,green,blue;


//toggle clock/clock counter
assign pixclk = (counter < 14'd1) ? 1'b1 : 1'b0;
assign hsync = (hcount < 14'd96) ? 1'b0 : 1'b1; //pulse width
assign vsync = (vcount < 14'd2) ? 1'b0 : 1'b1;


 //trigger at the positive edge of the clock or active low reset
 always @(posedge clk or negedge rst) begin
 if (~rst) begin // if rst==0
 counter <= 14'd0; // set the flip flops all equal to zero
 end else begin
 if (counter < 14'd3) begin //period
 counter <= counter + 14'd1;
 end else begin
 counter <= 14'd0;
 
 end
 end
 end
 
 always @(posedge clk or negedge rst) begin //hsync
 if (~rst) begin // if rst==0
 hcount <= 14'd0; // set the flip flops all equal to zero
 end else begin
 if ((counter == 14'b0)) begin
   if ((hcount< 14'd799)) begin
      hcount <= hcount + 14'd1;
   end else begin
      hcount <= 14'd0;
   end
 

 
 end
 end
 end
 
 always @(negedge clk or negedge rst) begin //vsync
    if (~rst) begin // if rst==0
        vcount <= 14'd0; // set the flip flops all equal to zero
     end else begin
    if ((hcount == 14'b0) && (counter == 14'b0))begin
        if (vcount < 14'd520) begin
         vcount <= vcount + 14'd1;
             end else begin
            vcount <= 14'd0;
          end

 end
 end
 end
 
 
 always@(*) begin
 if(hcount < 14'd356 && hcount > 14'd143)begin //143-784
 red = 4'b1111;
// end else begin
// red = 4'h0000; 
// end
 end
 end
 
 always@(*)begin
 if(hcount < 14'd569 && hcount > 14'd357)begin
 green = 4'h000F;
// end else 
// green = 4'h0000;
 end
 end

 
 always@(*)begin
 if(hcount < 14'd783 && hcount > 14'd570)begin 
 blue = 4'b1111;
// end else
// blue = 4'h0000;
 end
 end


endmodule
