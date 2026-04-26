# LED Blink — Simple On/Off Circuit

## Overview

This is the first Arduino circuit used in the course. An external LED blinks on for 3 seconds and off for 3 seconds in a continuous loop. The Arduino also reports its current state over serial, which allows Robot Framework to verify behavior.

---

## Components Required

| Quantity | Component              | Notes                                     |
|----------|------------------------|-------------------------------------------|
| 1×       | Arduino Uno            | Any USB-B cable for power and programming |
| 1×       | LED (any colour)       | 5 mm through-hole LED                     |
| 1×       | 220 Ω resistor         | Red-Red-Brown-Gold bands                  |
| 1×       | Breadboard             | Half-size or full-size                    |
| 2×       | Jumper wires (M-M)     | Male-to-male breadboard wires             |

---

## Identifying the LED Polarity

A standard 5 mm LED has two legs:

```
      ___
     /   \
    | LED |
     \___/
      |  |
   LONG  SHORT
  (anode) (cathode)
    (+)     (−)
```

- **Longer leg** = **anode (+)** — connect toward the positive side (digital pin)
- **Shorter leg** = **cathode (−)** — connect toward GND

If you are looking at the flat side of the LED, the cathode (−) leg is on that side.

---

## Why the Resistor is Needed

An LED has very low internal resistance. Without a current-limiting resistor, it would draw too much current, burn out immediately, and potentially damage the Arduino's output pin (which can safely supply up to ~40 mA, but should be kept below 20 mA).

**Ohm's law to choose the resistor:**

```
R = (Vcc - Vf) / I_desired
R = (5 V  - 2 V) / 0.010 A   ≈ 300 Ω
```

A **220 Ω** resistor is slightly below that, giving ~13 mA — bright enough and well within safe limits for the Arduino Uno.

---

## Wiring Diagram (ASCII)

```
Arduino Uno
┌─────────────────────────────────┐
│                                 │
│  Digital Pin 8  ──────────┐    │
│                            │    │
│  GND            ──┐       │    │
└────────────────┐  │       │    │
                 │  │       │    │
           ──────┘  │       │    │
          |         │       ▼    │
          │    [220 Ω]      │    │
          │         │       │    │
          │         └──[R]──┤    │
          │                 │    │
          │              LED (+) anode  (longer leg)
          │              LED (−) cathode (shorter leg)
          │                 │
          └─────────────────┘ (GND rail on breadboard)
```

### Cleaner step-by-step view:

```
 Arduino Pin 8
      │
      │
   [ 220 Ω ]       ← resistor (either orientation is fine)
      │
    ──┤ LED (+)     ← anode, longer leg
    ──┤ LED (−)     ← cathode, shorter leg
      │
   Arduino GND
```

---

## Step-by-Step Wiring Instructions

1. **Place the resistor** straddling the center gap of the breadboard. Note which row each leg is in.
2. **Place the LED** so that its **anode (+, long leg)** is in the same breadboard row as one leg of the resistor.
3. Connect a **jumper wire** from **Arduino Digital Pin 8** to the row containing the **other leg of the resistor** (the end not connected to the LED).
4. Connect a **jumper wire** from **Arduino GND** to the row containing the **LED cathode (−, short leg)**.
5. Double-check polarity: tracing from Pin 8 should go → resistor → LED anode → LED cathode → GND.

---

## Expected Behavior

Once the firmware (`firmware/led_blink/led_blink.ino`) is uploaded:

- The LED lights up for **3 seconds**, then turns off for **3 seconds**, repeating indefinitely.
- The Arduino sends the following over serial at **9600 baud**:
  ```
  LED ON
  LED OFF
  LED ON
  LED OFF
  ...
  ```

---

## Troubleshooting

| Symptom                   | Likely cause                              | Fix                                      |
|---------------------------|-------------------------------------------|------------------------------------------|
| LED never lights up       | LED polarity reversed                     | Swap the LED legs                        |
| LED stays on continuously | Wrong pin number in firmware              | Verify `LED_PIN = 8` in the `.ino` file  |
| LED very dim              | Resistor value too high                   | Replace with 220 Ω                       |
| LED flickers              | Loose breadboard connection               | Press connections firmly                 |
| No serial output          | Wrong baud rate in serial monitor         | Set serial monitor to 9600               |

---

## Firmware Location

```
firmware/led_blink/led_blink.ino
```

Open in the Arduino IDE, select **Board → Arduino Uno**, select the correct **Port**, then click **Upload**.
