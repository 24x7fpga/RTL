`ifndef PACKAGE_SVH
 `define PACKAGE_SVH

// Define Timescale
 `timescale 1ns/1ns

// Define Clock
`define T 8  // 125MHz => Zybo Z7-20

// 640x480 @ 60
`define HSYNC_PULSE   96
`define HBACK_PORCH  48
`define HACTIVE       640
`define HFRONT_PORCH  16

`define VSYNC_PULSE   2
`define VBACK_PORCH  33
`define VACTIVE       480
`define VFRONT_PORCH  10

`endif
