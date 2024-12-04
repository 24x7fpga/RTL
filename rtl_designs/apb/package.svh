`ifndef PACKAGE_SVH
 `define PACKAGE_SVH

 // define timescale
 `timescale 1ns/1ns

 // define clock 125MHz
 `define T        8

// define bus width
 `define WIDTH   32

//define uart parameters
 `define DBIT     8
 `define SB_TICK 16

// uart register
 `define TX_DIN   0
 `define TX_START 4
 `define TX_BUSY  8
 `define TX_DONE 12
 `define DVSR    16
 `define RX_DOUT 20
 `define RX_BUSY 24
 `define RX_DONE 28

`endif
