//

module g2e_buffer #(
    parameter WR_DATA_WIDTH = 8,
    parameter RD_DATA_WIDTH = 11,
    parameter BUF_BUFFER_SIZE = 18
) (wr_clk, rd_clk, wr_data, rd_data);

    input wr_clk;
    input rd_clk;
    
    input [WR_DATA_WIDTH - 1 : 0] wr_data;
    
    output logic [RD_DATA_WIDTH - 1 : 0] rd_data;

    parameter BUF_POINTER_SIZE = $clog2(BUF_BUFFER_SIZE);
    logic [BUF_BUFFER_SIZE - 1 : 0] buffer;
    logic [BUF_POINTER_SIZE - 1 : 0] wr_ptr;

    always_ff @(posedge wr_clk) begin
        buffer[wr_ptr +: WR_DATA_WIDTH] <= wr_data;
        wr_ptr <= wr_ptr + WR_DATA_WIDTH;
    end
    
    always_ff @(posedge rd_clk) begin
        buffer <= buffer >> RD_DATA_WIDTH;
        wr_ptr <= wr_ptr - RD_DATA_WIDTH;
    end
    
    always_comb begin
        rd_data = buffer[RD_DATA_WIDTH - 1 : 0];
    end
endmodule
