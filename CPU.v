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

wire pc_o, const_4 = 3'b100, adder_o, ALUSrc;
wire [31:0] instruction_memory_o, register_data_2, sign_extend_o, mux_o;

/*
Control Control(
    .Op_i       (),
    .ALUOp_o    (),
    .ALUSrc_o   (),
    .RegWrite_o ()
);
*/

Adder Add_PC(
    .data1_in   (pc_o),
    .data2_in   (const_4),
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
    .clk_i      (),
    .RS1addr_i   (),
    .RS2addr_i   (),
    .RDaddr_i   (), 
    .RDdata_i   (),
    .RegWrite_i (), 
    .RS1data_o   (), 
    .RS2data_o   () 
);

MUX32 MUX_ALUSrc(
    .data1_i    (register_data_2),
    .data2_i    (sign_extend_o),
    .select_i   (ALUSrc),
    .data_o     (mux_o)
);

/*
Sign_Extend Sign_Extend(
    .data_i     (),
    .data_o     ()
);
*/
  
/*
ALU ALU(
    .data1_i    (),
    .data2_i    (),
    .ALUCtrl_i  (),
    .data_o     (),
    .Zero_o     ()
);
*/

/*
ALU_Control ALU_Control(
    .funct_i    (),
    .ALUOp_i    (),
    .ALUCtrl_o  ()
);
*/

endmodule

