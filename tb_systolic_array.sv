`timescale 1ns/1ps

module tb_systolic_array;
    logic clk;
    logic rst;
    logic clr;
    logic en;
    logic signed [7:0]  a_in [0:3];
    logic signed [7:0]  b_in [0:3];
    logic signed [31:0] c_out [0:3][0:3];

    systolic_array_4x4 uut (
        .clk(clk),
        .rst(rst),
        .clr(clr),
        .en(en),
        .a_in(a_in),
        .b_in(b_in),
        .c_out(c_out)
    );

    always #5 clk = ~clk;

    initial begin
        // Dump waveforms for GTKWave
        $dumpfile("systolic.vcd");
        $dumpvars(0, tb_systolic_array);

        clk = 0;
        rst = 1;
        clr = 0;
        en  = 0;
        for (int k = 0; k < 4; k++) begin
            a_in[k] = 8'sd0;
            b_in[k] = 8'sd0;
        end

        #20 rst = 0;
        #10 clr = 1; #10 clr = 0; en = 1;

        // Cycle 1
        a_in[0] = 8'sd2;  b_in[0] = 8'sd3;
        #10;
        
        // Cycle 2
        a_in[0] = 8'sd1;  b_in[0] = 8'sd4;
        a_in[1] = 8'sd5;  b_in[1] = 8'sd1;
        #10;

        // Cycle 3
        a_in[0] = 8'sd0;  b_in[0] = 8'sd0;
        a_in[1] = 8'sd2;  b_in[1] = 8'sd3;
        a_in[2] = 8'sd4;  b_in[2] = 8'sd2;
        #10;

        #100;
        
        $display("\n================ 4x4 MATRIX OUTPUT C ================");
        for (int i = 0; i < 4; i++) begin
            $display("[%d, %d, %d, %d]", c_out[i][0], c_out[i][1], c_out[i][2], c_out[i][3]);
        end
        $display("=====================================================\n");
        
        $finish;
    end
endmodule
