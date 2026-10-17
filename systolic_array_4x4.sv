module systolic_array_4x4 (
    input  logic        clk,
    input  logic        rst,
    input  logic        clr,
    input  logic        en,
    input  logic signed [7:0]  a_in [0:3],
    input  logic signed [7:0]  b_in [0:3],
    output logic signed [31:0] c_out [0:3][0:3]
);
    logic signed [7:0] a_wire [0:3][0:4];
    logic signed [7:0] b_wire [0:4][0:3];

    genvar i, j;
    generate
        for (i = 0; i < 4; i++) begin : connect_inputs
            assign a_wire[i][0] = a_in[i];
            assign b_wire[0][i] = b_in[i];
        end
    endgenerate

    generate
        for (i = 0; i < 4; i++) begin : row
            for (j = 0; j < 4; j++) begin : col
                pe pe_inst (
                    .clk   (clk),
                    .rst   (rst),
                    .clr   (clr),
                    .en    (en),
                    .in_a  (a_wire[i][j]),
                    .in_b  (b_wire[i][j]),
                    .out_a (a_wire[i][j+1]),
                    .out_b (b_wire[i+1][j]),
                    .out_c (c_out[i][j])
                );
            end
        end
    endgenerate
endmodule
