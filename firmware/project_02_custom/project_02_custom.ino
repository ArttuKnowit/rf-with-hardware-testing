#include <Arduino.h>

const int BUTTON_PIN = 2;
const int LED_PINS[] = {3, 4, 5};
const int PINS[] = {0, 1, 2, 3, 4, 5};
const int LED_COUNT = 3;

int currentLed = 0;
int lastButtonState = LOW;

void setLed(int index) {
    for (int i = 0; i < LED_COUNT; i++) {
        digitalWrite(LED_PINS[i], i == index ? HIGH : LOW);
    }
}

void handleButtonPress() {
    currentLed = (currentLed + 1) % LED_COUNT;
    setLed(currentLed);
    Serial.println(currentLed);
}

void setup() {
    currentLed = 0;
    lastButtonState = LOW;
    Serial.begin(9600);
    for (int i = 0; i < LED_COUNT; i++) {
        pinMode(LED_PINS[i], OUTPUT);
    }
    for (int i = 0; i < sizeof(PINS) / sizeof(PINS[0]); i++) {
        pinMode(PINS[i], OUTPUT);
    }
    pinMode(BUTTON_PIN, INPUT);
    setLed(currentLed);
    Serial.println(currentLed);
}

void loop() {
    if (Serial.available()) {
        char cmd = Serial.read();
        if (cmd == 'P') {
            handleButtonPress();
        }
    }

    int buttonState = digitalRead(BUTTON_PIN);
    if (buttonState == HIGH && lastButtonState == LOW) {
        handleButtonPress();
        delay(200);
    }
    lastButtonState = buttonState;
}