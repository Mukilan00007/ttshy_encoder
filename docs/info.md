## How it works

This project is a **256-to-8 Binary Encoder**. It monitors a 256-bit wide input bus and outputs the 8-bit binary index of the active input bit.

The module is implemented using a combinational `always` block with a formal loop. Because the loop iterates from index 0 up to 255 and overwrites the `out` register, it functions as a **Priority Encoder** where the **highest** active bit takes precedence. For example, if both bit 10 and bit 50 are high, the output will be `50`.

**Key Specifications:**
* **Inputs:** 256-bit wide bus.
* **Outputs:** 8-bit binary encoded value ($2^8 = 256$).
* **Logic:** Combinational (no clock latency).

## How to test

Since a standard Tiny Tapeout tile has limited pins, testing this 256-bit input module typically requires a testbench (cocotb) or a wrapper that feeds the inputs.

1.  **Simulation:** Run the provided `test.py` using cocotb. The test sets individual bits across the 256-bit range (e.g., bit 0, 10, 50, 100, 255).
2.  **Verification:** Observe the `out` bus. When `in[N]` is high (and all bits `> N` are low), the output `out` should equal the decimal value `N`.
3.  **Priority Check:** Set `in[5]` and `in[200]` to high simultaneously. Verify that the output is `200`.

## External hardware

This project is entirely self-contained within the digital logic. However, to interface with 256 physical inputs, you would typically need:
* **Shift Registers (e.g., 74HC165):** To serialize the 256 inputs into the chip if physical pins are limited.
* **Logic Analyzer:** To verify the 8-bit output bus transitions in real-time.
