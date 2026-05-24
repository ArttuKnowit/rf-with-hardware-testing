// controlPin1 and controlPin2 carry the logic (direction) applied to the H-Bridge
const int controlPin1 = 2;
const int controlPin2 = 3;
// enablePin is attached to the EN pin
const int enablePin = 9;
// directionSwitchPin and onOffSwitchStateSwitchPin carry the values of the button switches
const int directionSwitchPin = 4;
const int onOffSwitchStateSwitchPin = 5;
// potPin is analogue, delivering continuous values from the potentiometer
const int potPin = A5;

int onOffSwitchState = 0;
int previousOnOffSwitchState = 0;
int directionSwitchState = 0;
int previousDirectionSwitchState = 0;
int motorEnabled = 0;
int motorSpeed = 0;
int motorDirection = 1;

void setup() {
    pinMode(directionSwitchPin, INPUT);
    pinMode(onOffSwitchStateSwitchPin, INPUT);
    pinMode(controlPin1, OUTPUT);
    pinMode(controlPin2, OUTPUT);
    pinMode(enablePin, OUTPUT);

    // the motor initializes at OFF
    digitalWrite(enablePin, LOW);
}

void loop() {
    onOffSwitchState = digitalRead(onOffSwitchStateSwitchPin);
    delay(1);
    directionSwitchState = digitalRead(directionSwitchPin);
    motorSpeed = analogRead(potPin) / 4;

    // allows the motor to spin without holding the button continuously
    if (onOffSwitchState != previousOnOffSwitchState) {
        if (onOffSwitchState == HIGH) {
            motorEnabled = !motorEnabled;
        }
    }

    // analogous to onOffSwitchState handling
    if (directionSwitchState != previousDirectionSwitchState) {
        if (directionSwitchState == HIGH) {
            motorDirection = !motorDirection;
        }
    }

    if (motorDirection == 1) {
        // direction 1: turn left
        digitalWrite(controlPin1, HIGH);
        digitalWrite(controlPin2, LOW);
    } else {
        // direction 0: turn right
        digitalWrite(controlPin1, LOW);
        digitalWrite(controlPin2, HIGH);
    }

    if (motorEnabled == 1) {
        // set EN to motorSpeed as indicated by the potentiometer
        analogWrite(enablePin, motorSpeed);
    } else {
        // motor off: set EN to LOW
        analogWrite(enablePin, 0);
    }

    // keep track of previous states for edge detection
    previousDirectionSwitchState = directionSwitchState;
    previousOnOffSwitchState = onOffSwitchState;
}
