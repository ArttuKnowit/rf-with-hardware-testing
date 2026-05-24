const int switchPin = 8;
unsigned long previousTime = 0;
int switchState = 0;
int prevSwitchState = 0;
int led = 2;
long interval = 5000;

void setup() {
    for (int x = 2; x < 8; x++) {
        pinMode(x, OUTPUT);
    }
    pinMode(switchPin, INPUT);
}

void loop() {
    unsigned long currentTime = millis();

    if (currentTime - previousTime > interval) {
        previousTime = currentTime;
        digitalWrite(led, HIGH);
        led++;

        if (led == 7) {
            delay(2500);
            led = 0;
            while (led < 5) {
                for (int x = 2; x < 8; x++) {
                    digitalWrite(x, LOW);
                }
                delay(500);
                for (int x = 2; x < 8; x++) {
                    digitalWrite(x, HIGH);
                }
                delay(500);
                led++;
            }
        }
    }

    switchState = digitalRead(switchPin);
    if (switchState != prevSwitchState) {
        for (int x = 2; x < 8; x++) {
            digitalWrite(x, LOW);
        }
        led = 2;
        previousTime = currentTime;
    }
    prevSwitchState = switchState;
}