module get_a_mod(
input clk,
input rst_,
input start,
input[63:0] new_a1,
input[63:0] new_a2,
input cal_finish,
output reg[63:0] a1,
output reg[63:0] a2,
output reg[63:0] a_b,
output reg label1,
output reg label2,
output reg cal_start,
output reg[63:0] w,
output reg[63:0] b,
output reg finish
);

parameter IDLE = 9'b000000000,
				S1 = 9'b000000001,
				S2 = 9'b000000010,
				S3 = 9'b000000100,
				S4 = 9'b000001000,
				S5 = 9'b000010000,
				S6 = 9'b000100000,
				S7 = 9'b001000000,
				S8 = 9'b010000000,
				S9 = 9'b100000000;

reg[8:0] state, next_state;

reg[10:0] ram_label_addr;
reg ram_label_wren;
reg ram_label_data;
wire ram_label_q;

reg[10:0] ram_a_addr;
reg ram_a_wren;
reg[63:0] ram_a_data;
wire[63:0] ram_a_q;

reg[10:0] ram_a_type_addr;
reg ram_a_type_wren;
reg[1:0] ram_a_type_data;
wire[1:0] ram_a_type_q;

reg[10:0] ram_a_grad_addr;
reg ram_a_grad_wren;
reg[63:0] ram_a_grad_data;
wire[63:0] ram_a_grad_q;

reg[15:0] rom_lib_addr;
wire[63:0] rom_lib_q;

reg[10:0] n_vector;
reg[5:0] n_dimension;

reg[1:0] count_1;

always@(posedge clk or negedge rst_)
if(!rst_)
	state <= IDLE;
else
	state <= next_state;

always@(state or rst_ or start or count_1 or ram_a_type_addr)
if(!rst_)
	next_state = IDLE;
else
	case(state)
	IDLE:	if(start == 1)
				next_state = S1;
			else
				next_state = IDLE;
	S1:	if(count_1 == 2'd3)
				next_state = S2;
			else
				next_state = S1;
	S2:	next_state = S3;
	S3:	if(ram_a_type_addr == n_vector)
				next_state = S4;
			else
				next_state = S3;
	default:	next_state = IDLE;
	endcase

always@(posedge clk or negedge rst_)
if(!rst_)
	count_1 <= 2'd0;
else if(state == S1)
	count_1 <= count_1 + 1;
else
	count_1 <= 2'd0;

always@(posedge clk or negedge rst_)
if(!rst_)
	n_vector <= 11'd0;
else if(state == IDLE)
	n_vector <= 11'd0;
else if(state == S1 && count_1 == 2'd1)
	n_vector <= rom_lib_q;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	n_dimension <= 6'd0;
else if(state == IDLE)
	n_dimension <= 6'd0;
else if(state == S1 && count_1 == 2'd2)
	n_dimension <= rom_lib_q;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	rom_lib_addr <= 16'd0;
else if(state == IDLE)
	rom_lib_addr <= 16'd0;
else if(state == S1 && count_1 == 2'd1)
	rom_lib_addr <= 16'd1;
else if(state == S1 && count_1 == 2'd3)
	rom_lib_addr <= 16'd2;
else if(state == S2 || state == S3)
	rom_lib_addr <= rom_lib_addr + n_dimension + 1;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	ram_label_wren <= 0;
else if(state == IDLE)
	ram_label_wren <= 0;
else if(state == S3)
	ram_label_wren <= 1;
else;
	
always@(posedge clk or negedge rst_)
if(!rst_)
	ram_label_addr <= 11'd0;
else if(state == IDLE)
	ram_label_addr <= 11'd0;
else if(state == S3)
	ram_label_addr <= ram_label_addr + 1;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	ram_label_data <= 0;
else if(state == IDLE)
	ram_label_data <= 0;
else if(state == S3)
	if(rom_lib_q == 64'h1111111111111111)
		ram_label_data <= 1;
	else
		ram_label_data <= 0;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	ram_a_type_wren <= 0;
else if(state == IDLE)
	ram_a_type_wren <= 0;
else if(state == S3)
	ram_a_type_wren <= 1;
else;
	
always@(posedge clk or negedge rst_)
if(!rst_)
	ram_a_type_addr <= 11'd0;
else if(state == IDLE)
	ram_a_type_addr <= 11'd0;
else if(state == S3)
	ram_a_type_addr <= ram_a_type_addr + 1;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	ram_a_type_data <= 2'd0;
else if(state == IDLE)
	ram_a_type_data <= 2'd0;
else if(state == S3)
	if(rom_lib_q == 64'h1111111111111111)
		ram_a_type_data <= 2'b10;
	else
		ram_a_type_data <= 2'b01;
else;


ram_1 ram_label(ram_label_addr, clk, ram_label_data, ram_label_q);
ram_64 ram_a(ram_a_addr, clk, ram_a_data, ram_a_wren, ram_a_q);
ram_2 ram_a_type(ram_a_type_addr, clk, ram_a_type_data, ram_a_type_wren, ram_a_type_q);
ram_64 ram_a_grad(ram_a_grad_addr, clk, ram_a_grad_data, ram_a_grad_wren, ram_a_grad_q);

rom_64 rom_lib(rom_lib_addr, clk, rom_lib_q);

endmodule