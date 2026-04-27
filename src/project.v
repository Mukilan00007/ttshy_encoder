`default_nettype none

module tt_um_encoder_256to8 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // This handles the unused pins to keep the compiler happy
    wire _unused = &{clk, rst_n, ena, 1'b0};

    // Mapping physical pins to the bottom 16 bits of our 256-bit logic
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

    assign uo_out = encoded_val;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0; // All bidirectional pins as inputs

endmodule
