# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_encoder(dut):
    dut._log.info("Starting 256-to-8 Encoder Test")

    # Define test cases: (input_bit_index, expected_output)
    test_cases = [0, 1, 2, 10, 50, 100, 200, 255]

    for bit_index in test_cases:
        # Construct a 256-bit value with only one bit set
        input_value = 1 << bit_index
        
        # Apply input to the DUT
        dut.in_.value = input_value

        # Wait for a small amount of time for combinational logic to settle
        await Timer(1, units="ns")

        # Log the current check
        dut._log.info(f"Input Bit: {bit_index} | Output: {int(dut.out.value)}")

        # Assert the output matches the index
        assert int(dut.out.value) == bit_index, f"Error at bit {bit_index}: expected {bit_index} but got {int(dut.out.value)}"

    dut._log.info("All test cases passed!")
