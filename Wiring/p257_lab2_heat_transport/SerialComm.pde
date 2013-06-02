// set the bitrate for serial communication
int baud = 9600;
// store value read over serial
int integer_in;
// number of times to check for bi-directional communication
int statusFailure = 1;

// there are two subsets of the data stream:
// blocks: a collection of values, sent at intervals from the TINAH board
// chunks: single values, corresponding to voltages, settings, etc.
// character marking the end of a data block
char blockMark = '\n';
// character marking the end of a data chunk
char chunkMark = ' ';

// setup serial communication
void beginSerial() {
  // initialize serial communication with baud 9600
  Serial.begin(baud);
}

int statusOk() {
  // status integer
  int status;
  // read all data on serial port
  while(Serial.available()>0) {
    status = Serial.read();
  }
  return status;
}

// check that the DAQ computer is writing data
void verifyWrite() {
  // set attempts to zero
  int statusChecks = 0;
  // try to communicate with the DAQ computer
  if (!statusOk()) {
    // status has been checked one more time than  before
    statusChecks++;
    // threshold reached
    /*if (statusChecks==statusFailure) {
      // communication is not verified
      LCD.print("fail");
      break;
    }*/
    LCD.print("d_fail");
    // wait before next attempt
    //delay(100);
  } else {
    LCD.print("d_save");
  }
}

// send all voltages over serial port
void serializeVoltage() {
  for (int i = 0; i < analogCount; i++) {
   // send voltage value to serial port
    Serial.print(voltage[i]);
    // split into chunks
    Serial.print(chunkMark);
  }
  // split into blocks
  Serial.print(blockMark);
}
  
