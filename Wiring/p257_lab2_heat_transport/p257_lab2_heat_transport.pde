#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file

// number of analog channels that should be read
const int analogCount = 5;
// store the analog value read by the TINAH board
double analogValue[5];
// the channels whose values should be read
int analogChannel[5] = {0, 1, 2, 3, 4};
// store the voltage associated with an analog value
double voltage[5];

void setup() 
{
  portMode(0, INPUT);
  portMode(1, INPUT);
  beginSerial();
}

void loop() 
{
  // check power resistor temp
  // setPowerResistor();
  
  double voltage; // store analog voltage
  prepLCD();
  
  // measure analog input pins
  readVoltage();
  // show data on the TINAH LCD
  displayVoltage();
  // send data over serial port
  serializeVoltage();  
  
  // check that DAQ is writing data
  verifyWrite();
  
  delay(1000);
}

// read from analog inputs;
// convert to voltages and store
void readVoltage() {
  for (int i = 0; i < analogCount; i++) {
    // convert analog input value to voltage and record
    analogValue[i] = analogRead(analogChannel[i]);
    voltage[i] = analogToVolts(analogValue[i]);
  }
}

// displayed all stored voltages on the LCD
void displayVoltage() {
  for (int i =0; i < analogCount; i++) {
    // write voltage value to LCD
    LCD.print(voltage[i]);
    LCD.print(" ");
    // move to next column
    if(i == 2) LCD.setCursor(0,1);
  }
}

// turn on the power resistor if it is not too hot
void setPowerResistor() {
  // the voltage threshold
  int voltageThreshold = 3;
  // the input channel to which the power resistor thermocouple is connected
  int powerResistorChannel = 0;
  // the voltage value to set the power resistors amplifier input
  double powerVoltage = 5;
  
  // turn off the power resistor
  analogWrite(powerResistorChannel, 0);
  
  // check that the power resistor is not too hot
  if (voltage[powerResistorChannel] < voltageThreshold) {
    // supply power to the power resistor amplifier (controller) input
    analogWrite(powerResistorChannel, voltsToAnalog(powerVoltage));
  }
}

//prepLCD
//clear and home the LCD for next write operation
void prepLCD()
{
  LCD.clear();
  LCD.home();
}

// analogToVolts
// convert it to a voltage value
double analogToVolts(int analog)
{
  double voltage = (double)analog / 204.6;
  return voltage;
}

int voltsToAnalog(double voltage) {
  int analog = voltage * 204.6;
  return analog;
}
