import processing.serial.*; // for com port to TINAH
// serial properties
Serial com; // TINAH com link
// serial bitrate
int baud = 9600;
// set channel to first available serial port
String channel = Serial.list()[0];
// there are two subsets of the data stream:
// blocks: a collection of values, sent at intervals from the TINAH board
// chunks: single values, corresponding to voltages, settings, etc.
// character marking the end of a data block
char blockMark = '\n';
// character marking the end of a data chunk
char chunkMark = ' ';
// maximum size of one chunk (or value)
int chunkSize = 16;

// callback for readUntil
// takes a serial parameter and splits data stream into chunks
void serialEvent(Serial p) {
  int status = 1;
  
  // byte array to store data as it is read
  byte[] bytes_in;
  // string that will be written to disk
  String str = "";
  
  // loop through all available data
  // except last character
  // which is trigChar set on bufferUntil
  while(p.available()>1) {
    bytes_in = new byte[chunkSize];
    // split stream into chunk and remove chunk
    p.readBytesUntil(chunkMark, bytes_in);
    // check for data
    if(bytes_in!=null) {
      // convert data to a string for writing
      str = new String(bytes_in);
      
      // debugging outputs
      print(str);
      print("\n");
      
      // save the data in tabbed form
      output.print(str);
      output.print('\t');
      status = 10;
    }
  }
  
  // write a timestamp
  output.print(millis()/1000);
  // and prepare next write operation for next line
  output.print('\n');
  // ensure all buffered data gets written
  output.flush();
  
  com.write(status);
}

// begin serial communication
void beginSerial() {
    // begin listening on the serial port
    com = new Serial(this, Serial.list()[0], 9600); // create new serial link with parent "this" and baud 9600
    // trigger serialEvent when character detected
    com.bufferUntil(blockMark);
}
