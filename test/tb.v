`timescale 1ns/1ps

module encoder_256to8_tb;

reg  [255:0] in;
wire [7:0] out;

encoder_256to8 uut (
    .in(in),
    .out(out)
);

initial begin
    $display("Time\tOutput");
    $monitor("%0t\t%d", $time, out);

    // Test cases
    in = 256'b0; 
    in[0]   = 1'b1; #10;

    in = 256'b0; 
    in[1]   = 1'b1; #10;

    in = 256'b0; 
    in[2]   = 1'b1; #10;

    in = 256'b0; 
    in[10]  = 1'b1; #10;

    in = 256'b0; 
    in[50]  = 1'b1; #10;

    in = 256'b0; 
    in[100] = 1'b1; #10;

    in = 256'b0; 
    in[200] = 1'b1; #10;

    in = 256'b0; 
    in[255] = 1'b1; #10;

    $finish;
end

endmodule

