module pe (
    input  logic        clk,
    input  logic        rst,
    input  logic        clr,
    input  logic        en,
    input  logic signed [7:0]  in_a,
    input  logic signed [7:0]  in_b,
    output logic signed [7:0]  out_a,
    output logic signed [7:0]  out_b,
    output logic signed [31:0] out_c
);
    logic signed [15:0] mult_result;
    assign mult_result = in_a * in_b;

    always_ff @(posedge clk) begin
        if (rst) begin
            out_a  <= 8'sd0;
            out_b  <= 8'sd0;
            out_c  <= 32'sd0;
        end else if (clr) begin
            out_c  <= 32'sd0;
            out_a  <= in_a;
            out_b  <= in_b;
        end else if (en) begin
            out_a  <= in_a;
            out_b  <= in_b;
            out_c  <= out_c + $signed({{16{mult_result[15]}}, mult_result});
        end
    end
endmodule
