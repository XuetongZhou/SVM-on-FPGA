module SVM(
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

always@(posedge clk or negedge rst_)
if(!rst_)
	state <= IDLE;
else
	state <= next_state;

always@(state or rst_ or start or)

endmodule