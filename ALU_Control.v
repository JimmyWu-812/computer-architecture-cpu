module ALU_Control
(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

input [9:0] funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;

wire z1, z2, z3, z4, z5, z6, z7;

assign z1 = !funct_i[8] && !funct_i[3] &&  funct_i[2] && !funct_i[1] && !funct_i[0] &&  ALUOp_i[0];
assign z2 = !funct_i[8] && !funct_i[3] && !funct_i[2] && !funct_i[1] &&  funct_i[0] &&  ALUOp_i[0];
assign z3 = !funct_i[8] && !funct_i[3] && !funct_i[2] && !funct_i[1] && !funct_i[0] &&  ALUOp_i[0];
assign z4 =  funct_i[8] && !funct_i[3] && !funct_i[2] && !funct_i[1] && !funct_i[0] &&  ALUOp_i[0];
assign z5 = !funct_i[8] &&  funct_i[3] && !funct_i[2] && !funct_i[1] && !funct_i[0] && !ALUOp_i[0];
assign z6 =                               !funct_i[2] && !funct_i[1] && !funct_i[0] &&  ALUOp_i[0];
assign z7 =  funct_i[8] && !funct_i[3] &&  funct_i[2] && !funct_i[1] &&  funct_i[0] && !ALUOp_i[0];

assign ALUCtrl_o[2] = z4 || z5 || z6 || z7;
assign ALUCtrl_o[1] = z2 || z2 || z6 || z7;
assign ALUCtrl_o[0] = z1 || z3 || z5 || z7;

endmodule
