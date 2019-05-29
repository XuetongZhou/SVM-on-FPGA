module cal_a_grad_mod(
input clk,
input rst_,
input start,
input[10:0] n_vector,
input[5:0] n_dimension,
input ram_label_q,
input[63:0] ram_a_q,
input[63:0] ram_lib_q,
output reg[10:0] ram_a_grad_addr,
output reg ram_a_grad_wren,
output reg[63:0] ram_a_grad_data,
output reg finish
);

parameter IDLE = 3'b000,
				S1 = 3'b001,
				S2 = 3'b010,
				S3 = 3'b100;
				
reg[2:0] state, next_state;

reg[2:0] count_1;
reg[5:0] count_2;
reg[10:0] count_3;

always@(posedge clk or negedge rst_)
if(!rst_)
	state <= IDLE;
else
	state <= next_state;
	
always@(state or rst_ or start or count_1 or count_2 or count_3)
if(!rst_)
	next_state = IDDLE;
else
	case(state)
	IDLE:	if(start == 1)
				next_state = S1;
			else
				next_state = IDLE;
	S1:	if(count_2 == n_dimension)
				next_state = S2;
			else
				next_state = S1;
	S2:	if(count_3 == n_vector)
				next_state = S3;
			else if(count_2 == n_dimension)
				next_state = S1;
			else
				next_state = S2;
	S3:	if(count_1 == 3'd7)
				next_state = IDLE;
			else
				next_state = S3;
	default:	next_state = IDLE;
	endcase

endmodule