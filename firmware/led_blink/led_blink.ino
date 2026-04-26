/*
 * led_blink.ino
 *
 * Blinks an external LED connected to Digital Pin 8.
 * ON for 3 seconds, OFF for 3 seconds — continuous loop.
 *
 * Wiring: Digital Pin 8 → 220 Ω resistor → LED anode (+) → LED cathode (−) → GND
 *
 * Serial output (9600 baud):
 *   "LED ON"  — when the LED is turned on
 *   "LED OFF" — when the LED is turned off
 *
 * Board: Arduino Uno
 */

const int LED_PIN = 8;
const int ON_TIME  = 3000;  // milliseconds
const int OFF_TIME = 3000;  // milliseconds

void setup() {
  pinMode(LED_PIN, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(LED_PIN, HIGH);
  Serial.println("LED ON");
  delay(ON_TIME);

  digitalWrite(LED_PIN, LOW);
  Serial.println("LED OFF");
  delay(OFF_TIME);
}
