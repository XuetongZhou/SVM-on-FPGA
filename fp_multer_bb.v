// megafunction wizard: %ALTFP_MULT%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTFP_MULT 

// ============================================================
// File Name: fp_multer.v
// Megafunction Name(s):
// 			ALTFP_MULT
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.1.0 Build 162 10/23/2013 SJ Full Version
// ************************************************************

//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.

module fp_multer (
	clock,
	dataa,
	datab,
	result)/* synthesis synthesis_clearbox = 1 */;

	input	  clock;
	input	[63:0]  dataa;
	input	[63:0]  datab;
	output	[63:0]  result;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: FPM_FORMAT STRING "Double"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: DEDICATED_MULTIPLIER_CIRCUITRY STRING "YES"
// Retrieval info: CONSTANT: DENORMAL_SUPPORT STRING "NO"
// Retrieval info: CONSTANT: EXCEPTION_HANDLING STRING "NO"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altfp_mult"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "5"
// Retrieval info: CONSTANT: REDUCED_FUNCTIONALITY STRING "NO"
// Retrieval info: CONSTANT: ROUNDING STRING "TO_NEAREST"
// Retrieval info: CONSTANT: WIDTH_EXP NUMERIC "11"
// Retrieval info: CONSTANT: WIDTH_MAN NUMERIC "52"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: USED_PORT: dataa 0 0 64 0 INPUT NODEFVAL "dataa[63..0]"
// Retrieval info: CONNECT: @dataa 0 0 64 0 dataa 0 0 64 0
// Retrieval info: USED_PORT: datab 0 0 64 0 INPUT NODEFVAL "datab[63..0]"
// Retrieval info: CONNECT: @datab 0 0 64 0 datab 0 0 64 0
// Retrieval info: USED_PORT: result 0 0 64 0 OUTPUT NODEFVAL "result[63..0]"
// Retrieval info: CONNECT: result 0 0 64 0 @result 0 0 64 0
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_multer.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_multer.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_multer.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_multer_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_multer_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_multer.inc TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_multer.cmp FALSE TRUE
// Retrieval info: LIB_FILE: lpm
