//

module tb_g2e_buffer #(
    parameter WR_DATA_WIDTH = 8,
    parameter RD_DATA_WIDTH = 11,
    parameter BUF_BUFFER_SIZE = 18
) ();

    logic wr_clk;
    logic rd_clk;
    logic [WR_DATA_WIDTH - 1 : 0] wr_data;
    logic [RD_DATA_WIDTH - 1 : 0] rd_data;
    
    g2e_buffer #(
        .WR_DATA_WIDTH(WR_DATA_WIDTH),
        .RD_DATA_WIDTH(RD_DATA_WIDTH),
        .BUF_BUFFER_SIZE(BUF_BUFFER_SIZE)
    ) uut (
        .wr_clk(wr_clk),
        .rd_clk(wr_clk),
        .wr_data(wr_data),
        .rd_data(rd_data)
    );
    
    initial begin
        wr_clk = '0;
        forever begin
            #7 wr_clk = ~wr_clk;
        end
    end
    
    initial begin
        rd_clk = '0;
        forever begin
            #11 rd_clk = ~rd_clk;
        end
    end
    
    initial begin
        wr_data = '0;
        forever begin
            #16 wr_data = $urandom_range(0, 2 ** WR_DATA_WIDTH - 1);
        end
    end
endmodule