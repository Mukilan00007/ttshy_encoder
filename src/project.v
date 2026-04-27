/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_encoder_256to8 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock - MUST BE PRESENT
    input  wire       rst_n     // reset_n - low to reset
);

    // 1. Handle the "Unused" inputs to avoid linter warnings
    // We combine them so the tools don't think they are missing.
    wire _unused = &{clk, rst_n, ena, 1'b0};

    // 2. Logic for the Encoder
    // Since we only have 16 total input pins, let's map them to the first 16 bits
    wire [255:0] large_in;
    assign large_in = {240'b0, uio_in, ui_in}; 

    integer i;
    reg [7:0] encoded_val;

    always @(*) begin
        encoded_val = 8'b0;
        for (i = 0; i < 256; i = i + 1) begin
            if (large_in[i])
                encoded_val = i[7:0];
        end
    end

    // 3. Assign Outputs
    assign uo_out = encoded_val;

    // 4. Configure Bidirectional Pins
    // We used uio_in as inputs, so we set their output enables to 0
    assign uio_oe  = 8'b00000000; 
    assign uio_out = 8'b00000000;

endmodule
