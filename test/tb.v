`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Standard Tiny Tapeout pins
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // 1. ADD THESE POWER WIRES
  wire vcc = 1'b1;
  wire gnd = 1'b0;

  // Initial values
  initial begin
      clk = 0;
      rst_n = 0;
      ena = 0;
      ui_in = 0;
      uio_in = 0;
  end

  // 2. UPDATE THE INSTANTIATION
  tt_um_encoder_256to8 user_project (
`ifdef GL_TEST
      .VPWR(vcc),      // Connect to the wire, not the constant 1'b1
      .VGND(gnd),      // Connect to the wire, not the constant 1'b0
`endif
      .ui_in  (ui_in),
      .uo_out (uo_out),
      .uio_in (uio_in),
      .uio_out(uio_out),
      .uio_oe (uio_oe),
      .ena    (ena),
      .clk    (clk),
      .rst_n  (rst_n)
  );

endmodule
