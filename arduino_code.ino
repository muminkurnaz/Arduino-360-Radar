#include <HCSR04.h>
#include <Servo.h>

UltraSonicDistanceSensor distanceSensor(6, 7);             //Create the 1st sensor object
UltraSonicDistanceSensor distanceSensor2(5, 4);             //Create the 2nd sensor object
Servo servoMotor;            //Create the Servo object

int delayTime = 5;            //Delay value to wait for the servo to reach the 1 angle difference
long d;                 //Distance from 1st sensor calculated
long d2;                //Distance from 2nd sensor calculated

void setup() {
  Serial.begin(9600);           //Initialize the Serial communication at 9600 bauds

  servoMotor.attach(2);         //Attach the servo to the Digital PWM pin 2
  servoMotor.write(0);        //Rotate the servo to the 180?
  delay(1000);              //Wait for the servo to reach 180?
  servoMotor.write(180);          //Rotate the servo to the 0?
  delay(1000);              //Wait for the servo to reach 0?

}

void loop() {
  for (int i = 1; i < 180; i++) {   //Move the Servo 180 degrees forward
    readSensors();            //Read the sensors
    Serial.print(i);          //Print the angle
    Serial.print(",");          //Print a ","
    Serial.print(d);          //Print the 1st distance
    Serial.print(",");          //Print a ","
    Serial.println(d2);         //Print the 2nd distance with end line
    servoMotor.write(i);        //Set the sensor at the angle
    delay(delayTime);         //Wait for the servo to reach i?
  }
  for (int i = 180; i > 1; i--) {   //Move the Servo 180 degrees backward
    readSensors();            //Read the sensors
    Serial.print(i);          //Print the angle
    Serial.print(",");          //Print a ","
    Serial.print(d);          //Print the 1st distance
    Serial.print(",");          //Print a ","
    Serial.println(d2);         //Print the 2nd distance with end line
    servoMotor.write(i);        //Set the sensor at the angle
    delay(delayTime);         //Wait for the servo to reach i?
  }
}

void readSensors() {
  d = distanceSensor.measureDistanceCm();
  d2 = distanceSensor2.measureDistanceCm();
}
