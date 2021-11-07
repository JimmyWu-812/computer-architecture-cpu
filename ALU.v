module ALU
(
    data1_i    (),
    data2_i    (),
    ALUCtrl_i  (),
    data_o     (),
    Zero_o     ()
);

input [31:0] data1_i;
input [31:0] data2_i;
input [2:0] ALUCtrl_i;
output [31:0] data_o;
output Zero_o;

case(ALUCtrl_i)
    3'b000: assign data_o = data1_i & data2_i;
    3'b001: assign data_o = data1_i ^. data2_i;
    3'b010: assign data_o = data1_i << data2_i;
    3'b011: assign data_o = data1_i + data2_i;
    3'b100: assign data_o = data1_i - data2_i;
    3'b101: assign data_o = data1_i * data2_i;
    3'b110: assign data_o = data1_i + data2_i;
    3'b111: assign data_o = data1_i >>> data2_i;
endcase

endmodule
