module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

wire ALUSrc, RegWrite, Zero;
wire [31:0] instruction_memory_o, register_data_1, register_data_2, sign_extend_o, mux_o, alu_o, pc_o, adder_o;
wire [1:0] ALUOp;
wire [2:0] alu_control_o;

Control Control(
    .Op_i       (instruction_memory_o[6:0]),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite)
);

Adder Add_PC(
    .data1_in   (pc_o),
    .data2_in   (32'b100),
    .data_o     (adder_o)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (adder_o),
    .pc_o       (pc_o)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (pc_o), 
    .instr_o    (instruction_memory_o)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i   (instruction_memory_o[19:15]),
    .RS2addr_i   (instruction_memory_o[24:20]),
    .RDaddr_i   (instruction_memory_o[11:7]), 
    .RDdata_i   (alu_o),
    .RegWrite_i (RegWrite), 
    .RS1data_o   (register_data_1), 
    .RS2data_o   (register_data_2) 
);

MUX32 MUX_ALUSrc(
    .data1_i    (register_data_2),
    .data2_i    (sign_extend_o),
    .select_i   (ALUSrc),
    .data_o     (mux_o)
);

Sign_Extend Sign_Extend(
    .data_i     (instruction_memory_o[31:20]),
    .data_o     (sign_extend_o)
);
  
ALU ALU(
    .data1_i    (register_data_1),
    .data2_i    (mux_o),
    .ALUCtrl_i  (alu_control_o),
    .data_o     (alu_o),
    .Zero_o     (Zero)
);

ALU_Control ALU_Control(
    .funct_i    ({instruction_memory_o[31:25], instruction_memory_o[14:12]}),
    .ALUOp_i    (ALUOp[6:5]),
    .ALUCtrl_o  (alu_control_o)
);

endmodule

