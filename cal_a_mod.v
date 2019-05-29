module cal_a_mod(
input clk,
input rst_,
input start,
input[63:0] a1,
input[63:0] a2,
input[63:0] a_b,
input label1,
input label2,
output reg[63:0] new_a1,
output reg[63:0] new_a2,
output reg finish
);

parameter IDLE = 7'b0000000,
				S1 = 7'b0000001,
				S2 = 7'b0000010,
				S3 = 7'b0000100,
				S4 = 7'b0001000,
				S5 = 7'b0010000,
				S6 = 7'b0100000,
				S7 = 7'b1000000;
			
reg[6:0] state = IDLE;
reg[6:0] next_state = IDLE;
reg[3:0] count = 4'd0;

parameter C = 64'h3ff0000000000000;

reg[63:0] L,H;

reg[63:0] add_sub_1, add_sub_2;
reg add_sub_flag;
wire add_sub_result;

reg[63:0] adder1_1,adder1_2;
wire[63:0] adder1_result;

reg[63:0] sub1_1,sub1_2;
wire[63:0] sub1_result;

reg[63:0] sub2_1,sub2_2;
wire[63:0] sub2_result;

reg[63:0] comp_1,comp_2;
wire comp_result;

always@(posedge clk or negedge rst_)
if(!rst_)
	state <= IDLE;
else
	state <= next_state;
	
always@(state or rst_ or start or count)
if(!rst_)
	next_state = IDLE;
else
	case(state)
	IDLE:	if(start == 1)
				next_state = S1;
			else
				next_state = IDLE;
	S1:	if(count == 4'd7)
				next_state = S2;
			else
				next_state = S1;
	S2:	if(count == 4'd7)
				next_state = S3;
			else
				next_state = S2;
	S3:	if(count == 4'd7)
				next_state = S4;
			else
				next_state = S3;	
	S4:	if(count == 4'd7)
				next_state = S5;
			else
				next_state = S4;
	S5:	if(count == 4'd7)
				next_state = S6;
			else
				next_state = S5;
	S6:	if(count == 4'd7)
				next_state = S7;
			else
				next_state = S6;
	S7:	if(count == 4'd7)
				next_state = IDLE;
			else
				next_state = S7;	
	default:	next_state = IDLE;
	endcase
	
always@(posedge clk or negedge rst_)
if(!rst_)
	count <= 4'd0;
else if(state == IDLE)
	count <= 4'd0;
else
	count <= count + 1;

always@(posedge clk or negedge rst_)
if(!rst_)
	add_sub_flag <= 0;
else if(state == IDLE)
	add_sub_flag <= 0;
else if(state == S1)
	if(label1 == 1)
		add_sub_flag <= 1;
	else
		add_sub_flag <= 0;
else if(state == S6)
	if(label1 ^ label2 == 1)
		add_sub_flag <= 1;
	else
		add_sub_flag <= 0;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	add_sub_1 <= 64'd0;
else if(state == IDLE)
	add_sub_1 <= 64'd0;
else if(state == S1)
	add_sub_1 <= a1;
else if(state == S6)
	add_sub_1 <= a2;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	add_sub_2 <= 64'd0;
else if(state == IDLE)
	add_sub_2 <= 64'd0;
else if(state == S1)
	add_sub_2 <= a_b;
else if(state == S6)
	add_sub_2 <= sub2_result;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	adder1_1 <= 64'd0;
else if(state == IDLE)
	adder1_1 <= 64'd0;
else if(state == S1)
	if(label1 == label2)
		adder1_1 <= a1;
	else;
else if(state == S2)
	if(label1 != label2)
		adder1_1 <= sub1_result;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	adder1_2 <= 64'd0;
else if(state == IDLE)
	adder1_2 <= 64'd0;
else if(state == S1)
	if(label1 == label2)
		adder1_2 <= a2;
	else;
else if(state == S2)
	if(label1 != label2)
		adder1_2 <= C;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	sub1_1 <= 64'd0;
else if(state == IDLE)
	sub1_1 <= 64'd0;
else if(state == S1)
	if(label1 != label2)
		sub1_1 <= a1;
	else;
else if(state == S2)
	if(label1 == label2)
		sub1_1 <= adder1_result;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	sub1_2 <= 64'd0;
else if(state == IDLE)
	sub1_2 <= 64'd0;
else if(state == S1)
	if(label1 != label2)
		sub1_2 <= a2;
	else;
else if(state == S2)
	if(label1 == label2)
		sub1_2 <= C;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	comp_1 <= 64'd0;
else if(state == IDLE)
	comp_1 <= 64'd0;
else if(state == S2)
	if(label1 == label2)
		comp_1 <= adder1_result;
	else
		comp_1 <= sub1_result;
else if(state == S4)
	if(count == 4'd1)
		comp_1 <= new_a1;
	else if(count == 4'd4)
		comp_1 <= new_a1;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	comp_2 <= 64'd0;
else if(state == IDLE)
	comp_2 <= 64'd0;
else if(state == S2)
	if(label1 == label2)
		comp_2 <= C;
	else
		comp_2 <= 64'd0;
else if(state == S4)
	if(count == 4'd1)
		comp_2 <= L;
	else if(count == 4'd4)
		comp_2 <= H;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	L <= 64'd0;
else if(state == IDLE)
	L <= 64'd0;
else if(state == S2)
	if(label1 != label2)
		if(comp_result == 1)
			L <= sub1_result;
		else
			L <= 64'd0;
	else;
else if(state == S3)
	if(label1 == label2)
		if(comp_result == 1)
			L <= sub1_result;
		else
			L <= 64'd0;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	H <= 64'd0;
else if(state == IDLE)
	H <= 64'd0;
else if(state == S2)
	if(label1 == label2)
		if(comp_result == 1)
			H <= C;
		else
			H <= adder1_result;
	else;
else if(state == S3)
	if(label1 != label2)
		if(comp_result == 1)
			H <= C;
		else
			H <= adder1_result;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	new_a1 <= 64'd0;
else if(state == IDLE)
	new_a1 <= 64'd0;
else if(state == S2)
	new_a1 <= add_sub_result;
else if(state == S4)
	if(count == 4'd3)
		if(comp_result == 0)
			new_a1 <= L;
		else;
	else if(count == 4'd7)
		if(comp_result == 1)
			new_a1 <= H;
		else;
	else;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	sub2_1 <= 64'd0;
else if(state == IDLE)
	sub2_1 <= 64'd0;
else if(state == S5)
	sub2_1 <= a1;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	sub2_2 <= 64'd0;
else if(state == IDLE)
	sub2_2 <= 64'd0;
else if(state == S5)
	sub2_2 <= new_a1;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	new_a2 <= 64'd0;
else if(state == IDLE)
	new_a2 <= 64'd0;
else if(state == S7)
	new_a2 <= add_sub_result;
else;

always@(posedge clk or negedge rst_)
if(!rst_)
	finish <= 0;
else if(state == S7)
	finish <= 1;
else
	finish <= 0;

fp_add_sub add_sub(add_sub_flag, clk, add_sub_1, add_sub_2, add_sub_result);

fp_adder adder1(clk, adder1_1, adder1_2, adder1_result);
fp_sub sub1(clk, sub1_1, sub1_2, sub1_result);

fp_sub sub2(clk, sub2_1, sub2_2, sub2_result);	

fp_comp comp(clk, comp_1, comp_2, comp_result);

endmodule