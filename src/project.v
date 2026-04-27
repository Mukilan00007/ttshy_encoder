module encoder_256to8 (
    input  [255:0] in,
    output reg [7:0] out
);

integer i;

always @(*) begin
    out = 8'b00000000;
    for (i = 0; i < 256; i = i + 1) begin
        if (in[i])
            out = i;
    end
end

endmodule
