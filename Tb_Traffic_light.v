### *2. Testbench - `tb_traffic_light.v`*
`timescale 1ns/1ps
module tb_traffic_light;
reg clk, rst, emergency_NS, emergency_EW;
wire [2:0] NS_light, EW_light;
traffic_light_priority uut(clk, rst, emergency_NS, emergency_EW, NS_light, EW_light);
initial begin
clk = 0;
forever #500000000 clk = ~clk; // 1Hz clock: 0.5s period
end
initial begin
$monitor("Time=%0t | NS=%b EW=%b | Emergency_NS=%b EW=%b",
$time, NS_light, EW_light, emergency_NS, emergency_EW); rst = 1; emergency_NS = 0; emergency_EW = 0;
#1 rst = 0;
#15; // Normal cycle: 10s NS Green + 3s Yellow
emergency_EW = 1; #2 emergency_EW = 0; // EW emergency trigger
#20;
emergency_NS = 1; #2 emergency_NS = 0; // NS emergency trigger
#30;
$finish;
end
endmodule
