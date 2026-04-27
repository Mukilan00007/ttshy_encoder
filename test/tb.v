`default_nettype none
`timescale 1ns / 1ps

/* This testbench is used by the gate-level simulation (GL) */
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

  // Replace "tt_um_encoder_256to8" with your actual top module name if different
  tt_um_encoder_256to8 user_project (
`ifdef GL_TEST
      .VPWR(1'b1),  // Power pins for Gate Level
      .VGND(1'b0),
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

