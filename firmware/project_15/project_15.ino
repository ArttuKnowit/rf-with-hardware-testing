//Naming a constant for the optocoupler control pin
const int optoPin=2;
void setup() {
  //Setting the optocoupler as an OUTPUT
  pinMode(optoPin,OUTPUT);
}

void loop() {
   //Pulling the optoPin HIGH for a few milliseconds. Time enough to close the switch's device.
   digitalWrite(optoPin,HIGH);
   delay(15);
   //Pullong the optoPin LOW for 21 seconds, then the recording will start again.
   digitalWrite(optoPin,LOW);
   delay(21000);
}