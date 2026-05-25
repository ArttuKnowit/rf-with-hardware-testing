/* Arduino Starter Kit example Project 3 - Love-O-Meter
   Parts required:
   1 TMP36 temperature sensor
   3 red LEDs
   3 220 ohm resistors
*/

const int sensorPin = A0;
const float baselineTemp = 20.0;
const int ANALOG_PIN_COUNT = 6;

const int LED_PINS[] = {2, 3, 4};  // green, yellow, red
const int LED_COUNT = 3;

const int GREEN_LED = 0;
const int YELLOW_LED = 1;
const int RED_LED = 2;

int currentLed = GREEN_LED;

float readTemperature() {
  int sensorVal = analogRead(sensorPin);
  float voltage = (sensorVal / 1024.0) * 5.0;
  return (voltage - 0.5) * 100;
}

float readAnalogVoltage(int pinIndex) {
  int rawValue = analogRead(pinIndex);
  return rawValue * (5.0 / 1023.0);
}

void setLed(int index) {
  currentLed = index;
  for (int i = 0; i < LED_COUNT; i++) {
    digitalWrite(LED_PINS[i], i == index ? HIGH : LOW);
  }
}

int getLedForTemperature(float temperature) {
  if (temperature >= baselineTemp + 4) {
    return RED_LED;
  } else if (temperature >= baselineTemp) {
    return YELLOW_LED;
  } else {
    return GREEN_LED;
  }
}

void setup() {
  Serial.begin(9600);
  for (int i = 0; i < LED_COUNT; i++) {
    pinMode(LED_PINS[i], OUTPUT);
    digitalWrite(LED_PINS[i], LOW);
  }
  setLed(GREEN_LED);
}

void loop() {
  if (Serial.available()) {
    String cmd = Serial.readStringUntil('\n');
    if (cmd == "ReadTemperature") {
      Serial.println(readTemperature());
    } else if (cmd.startsWith("ReadAnalog ")) {
      int pinIndex = cmd.substring(11).toInt();
      if (pinIndex >= 0 && pinIndex < ANALOG_PIN_COUNT) {
        Serial.println(readAnalogVoltage(pinIndex));
      }
    } else if (cmd.startsWith("SetLed ")) {
      int index = cmd.substring(7).toInt();
      if (index >= 0 && index < LED_COUNT) {
        setLed(index);
        Serial.println(currentLed);
      }
    } else if (cmd == "GetLed") {
      Serial.println(currentLed);
    }
  }

  setLed(getLedForTemperature(readTemperature()));
  delay(1);
}
