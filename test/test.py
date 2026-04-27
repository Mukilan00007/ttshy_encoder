# SPDX-FileCopyrightText: © 2024 Your Name
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_encoder(dut):
    dut._log.info("Starting 256-to-8 Encoder Test")

    # Initialize pins
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.ena.value = 1
    
    # Define test cases (Index, Expected Output)
    # Note: Only bits 0-15 are physically accessible via ui_in and uio_in
    test_cases = [
        (0, 0),   # Bit 0 of ui_in
        (7, 7),   # Bit 7 of ui_in
        (8, 8),   # Bit 0 of uio_in (mapped to index 8)
        (15, 15)  # Bit 7 of uio_in (mapped to index 15)
    ]

    for bit_index, expected_out in test_cases:
        # Reset inputs
        dut.ui_in.value = 0
        dut.uio_in.value = 0

        # Apply logic to set the correct bit on the correct physical port
        if bit_index < 8:
            dut.ui_in.value = 1 << bit_index
        else:
            dut.uio_in.value = 1 << (bit_index - 8)

        # Wait for combinational logic to settle
        await Timer(1, units="ns")

        # Log results
        actual_out = int(dut.uo_out.value)
        dut._log.info(f"Testing Bit Index {bit_index}: Expected {expected_out}, Got {actual_out}")

        # Assertions
        assert actual_out == expected_out, f"Error at index {bit_index}: expected {expected_out} but got {actual_out}"

    dut._log.info("All reachable test cases passed!")
