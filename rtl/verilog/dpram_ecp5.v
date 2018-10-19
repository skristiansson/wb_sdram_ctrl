/*
 * Copyright (c) 2011, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 * All rights reserved.
 *
 * Redistribution and use in source and non-source forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in non-source form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS WORK IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * WORK, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

module dpram_ecp5 #(
	parameter ADDR_WIDTH = 3
)
(
	input			clk_a,
	input  [ADDR_WIDTH-1:0]	addr_a,
	input  [3:0]		we_a,
	input  [31:0]		di_a,
	output [31:0]	do_a,

	input			clk_b,
	input  [ADDR_WIDTH-1:0]	addr_b,
	input  [3:0]		we_b,
	input  [31:0]		di_b,
	output [31:0]	do_b
);

	wire [9:0] ada_ext = addr_a, adb_ext = addr_b;
	wire [17:0] dia_1 = {1'b0, di_a[15:8], 1'b0, di_a[7:0]};
	wire [17:0] dib_1 = {1'b0, di_b[15:8], 1'b0, di_b[7:0]};
	wire [17:0] dia_2 = {1'b0, di_a[31:24], 1'b0, di_a[23:16]};
	wire [17:0] dib_2 = {1'b0, di_b[31:24], 1'b0, di_b[23:16]};
	wire [17:0] doa_1, dob_1, doa_2, dob_2;

	assign do_a[7:0] = doa_1[7:0];
	assign do_a[15:8] = doa_1[16:9];
	assign do_a[23:16] = doa_2[7:0];
	assign do_a[31:24] = doa_2[16:9];

	assign do_b[7:0] = dob_1[7:0];
	assign do_b[15:8] = dob_1[16:9];
	assign do_b[23:16] = dob_2[7:0];
	assign do_b[31:24] = dob_2[16:9];

	DP16KD #(
		.DATA_WIDTH_A(18),
		.DATA_WIDTH_B(18),
		.WRITEMODE_A("READBEFOREWRITE"),
		.WRITEMODE_B("READBEFOREWRITE"),
		.GSR("DISABLED")
	) dpram_1 (
		.ADA0(we_a[0]), .ADA1(we_a[1]), .ADA2(1'b0), .ADA3(1'b0), .ADA4(ada_ext[0]), .ADA5(ada_ext[1]), .ADA6(ada_ext[2]), .ADA7(ada_ext[3]), .ADA8(ada_ext[4]), .ADA9(ada_ext[5]), .ADA10(ada_ext[6]), .ADA11(ada_ext[7]), .ADA12(ada_ext[8]), .ADA13(ada_ext[9]),
		.ADB0(we_b[0]), .ADB1(we_b[1]), .ADB2(1'b0), .ADB3(1'b0), .ADB4(adb_ext[0]), .ADB5(adb_ext[1]), .ADB6(adb_ext[2]), .ADB7(adb_ext[3]), .ADB8(adb_ext[4]), .ADB9(adb_ext[5]), .ADB10(adb_ext[6]), .ADB11(adb_ext[7]), .ADB12(adb_ext[8]), .ADB13(adb_ext[9]),
		.DIA0(dia_1[0]), .DIA1(dia_1[1]), .DIA2(dia_1[2]), .DIA3(dia_1[3]), .DIA4(dia_1[4]), .DIA5(dia_1[5]), .DIA6(dia_1[6]), .DIA7(dia_1[7]), .DIA8(dia_1[8]), .DIA9(dia_1[9]), .DIA10(dia_1[10]), .DIA11(dia_1[11]), .DIA12(dia_1[12]), .DIA13(dia_1[13]), .DIA14(dia_1[14]), .DIA15(dia_1[15]), .DIA16(dia_1[16]), .DIA17(dia_1[17]),
		.DIB0(dib_1[0]), .DIB1(dib_1[1]), .DIB2(dib_1[2]), .DIB3(dib_1[3]), .DIB4(dib_1[4]), .DIB5(dib_1[5]), .DIB6(dib_1[6]), .DIB7(dib_1[7]), .DIB8(dib_1[8]), .DIB9(dib_1[9]), .DIB10(dib_1[10]), .DIB11(dib_1[11]), .DIB12(dib_1[12]), .DIB13(dib_1[13]), .DIB14(dib_1[14]), .DIB15(dib_1[15]), .DIB16(dib_1[16]), .DIB17(dib_1[17]),
		.DOA0(doa_1[0]), .DOA1(doa_1[1]), .DOA2(doa_1[2]), .DOA3(doa_1[3]), .DOA4(doa_1[4]), .DOA5(doa_1[5]), .DOA6(doa_1[6]), .DOA7(doa_1[7]), .DOA8(doa_1[8]), .DOA9(doa_1[9]), .DOA10(doa_1[10]), .DOA11(doa_1[11]), .DOA12(doa_1[12]), .DOA13(doa_1[13]), .DOA14(doa_1[14]), .DOA15(doa_1[15]), .DOA16(doa_1[16]), .DOA17(doa_1[17]),
		.DOB0(dob_1[0]), .DOB1(dob_1[1]), .DOB2(dob_1[2]), .DOB3(dob_1[3]), .DOB4(dob_1[4]), .DOB5(dob_1[5]), .DOB6(dob_1[6]), .DOB7(dob_1[7]), .DOB8(dob_1[8]), .DOB9(dob_1[9]), .DOB10(dob_1[10]), .DOB11(dob_1[11]), .DOB12(dob_1[12]), .DOB13(dob_1[13]), .DOB14(dob_1[14]), .DOB15(dob_1[15]), .DOB16(dob_1[16]), .DOB17(dob_1[17]),
		.CLKA(clk_a), .CLKB(clk_b),
		.WEA(|we_a), .CEA(1'b1), .OCEA(1'b1),
		.WEB(|we_b), .CEB(1'b1), .OCEB(1'b1),
		.RSTA(1'b0), .RSTB(1'b0)
	);

	DP16KD #(
		.DATA_WIDTH_A(18),
		.DATA_WIDTH_B(18),
		.WRITEMODE_A("READBEFOREWRITE"),
		.WRITEMODE_B("READBEFOREWRITE"),
		.GSR("DISABLED")
	) dpram_2 (
		.ADA0(we_a[2]), .ADA1(we_a[3]), .ADA2(1'b0), .ADA3(1'b0), .ADA4(ada_ext[0]), .ADA5(ada_ext[1]), .ADA6(ada_ext[2]), .ADA7(ada_ext[3]), .ADA8(ada_ext[4]), .ADA9(ada_ext[5]), .ADA10(ada_ext[6]), .ADA11(ada_ext[7]), .ADA12(ada_ext[8]), .ADA13(ada_ext[9]),
		.ADB0(we_b[2]), .ADB1(we_b[3]), .ADB2(1'b0), .ADB3(1'b0), .ADB4(adb_ext[0]), .ADB5(adb_ext[1]), .ADB6(adb_ext[2]), .ADB7(adb_ext[3]), .ADB8(adb_ext[4]), .ADB9(adb_ext[5]), .ADB10(adb_ext[6]), .ADB11(adb_ext[7]), .ADB12(adb_ext[8]), .ADB13(adb_ext[9]),
		.DIA0(dia_2[0]), .DIA1(dia_2[1]), .DIA2(dia_2[2]), .DIA3(dia_2[3]), .DIA4(dia_2[4]), .DIA5(dia_2[5]), .DIA6(dia_2[6]), .DIA7(dia_2[7]), .DIA8(dia_2[8]), .DIA9(dia_2[9]), .DIA10(dia_2[10]), .DIA11(dia_2[11]), .DIA12(dia_2[12]), .DIA13(dia_2[13]), .DIA14(dia_2[14]), .DIA15(dia_2[15]), .DIA16(dia_2[16]), .DIA17(dia_2[17]),
		.DIB0(dib_2[0]), .DIB1(dib_2[1]), .DIB2(dib_2[2]), .DIB3(dib_2[3]), .DIB4(dib_2[4]), .DIB5(dib_2[5]), .DIB6(dib_2[6]), .DIB7(dib_2[7]), .DIB8(dib_2[8]), .DIB9(dib_2[9]), .DIB10(dib_2[10]), .DIB11(dib_2[11]), .DIB12(dib_2[12]), .DIB13(dib_2[13]), .DIB14(dib_2[14]), .DIB15(dib_2[15]), .DIB16(dib_2[16]), .DIB17(dib_2[17]),
		.DOA0(doa_2[0]), .DOA1(doa_2[1]), .DOA2(doa_2[2]), .DOA3(doa_2[3]), .DOA4(doa_2[4]), .DOA5(doa_2[5]), .DOA6(doa_2[6]), .DOA7(doa_2[7]), .DOA8(doa_2[8]), .DOA9(doa_2[9]), .DOA10(doa_2[10]), .DOA11(doa_2[11]), .DOA12(doa_2[12]), .DOA13(doa_2[13]), .DOA14(doa_2[14]), .DOA15(doa_2[15]), .DOA16(doa_2[16]), .DOA17(doa_2[17]),
		.DOB0(dob_2[0]), .DOB1(dob_2[1]), .DOB2(dob_2[2]), .DOB3(dob_2[3]), .DOB4(dob_2[4]), .DOB5(dob_2[5]), .DOB6(dob_2[6]), .DOB7(dob_2[7]), .DOB8(dob_2[8]), .DOB9(dob_2[9]), .DOB10(dob_2[10]), .DOB11(dob_2[11]), .DOB12(dob_2[12]), .DOB13(dob_2[13]), .DOB14(dob_2[14]), .DOB15(dob_2[15]), .DOB16(dob_2[16]), .DOB17(dob_2[17]),
		.CLKA(clk_a), .CLKB(clk_b),
		.WEA(|we_a), .CEA(1'b1), .OCEA(1'b1),
		.WEB(|we_b), .CEB(1'b1), .OCEB(1'b1),
		.RSTA(1'b0), .RSTB(1'b0)
	);

endmodule
