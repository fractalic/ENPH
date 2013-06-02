PrintWriter output; // save data to disk

void setup()
{
  // prompt the user for a file to write, and run callback
  selectOutput("Please select data file for this run", "outputFile");
}

void draw()
{
}

// callback for output file dialog
void outputFile(File outfile) {  
  // check for file and open it
  if (outfile == null) {
    // the user must choose a file
    print("No file selected");
    exit();
  } else {
    // open the file for writing
    // this will overwrite file if it exists
    output = createWriter(outfile.getAbsolutePath());
    
    // give title to each column
    /*for(int i=0; i<5; i++) {
      output.print("voltage_");
      output.print(i+1);
      output.print('\t');
    }
    output.print('\n');*/
    
    beginSerial();
  }
}
