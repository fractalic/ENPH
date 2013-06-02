#include <phys253.h>       //   ***** from 253 template file
#include <LiquidCrystal.h> //   ***** from 253 template file
#include <Servo253.h>      //   ***** from 253 template file 

void setup()
{
  /*
  portMode(0, INPUT) ;      //   ***** from 253 template file
  portMode(1, INPUT) ;      //   ***** from 253 template file
  RCServo0.attach(RCServo0Output) ;
  RCServo1.attach(RCServo1Output) ;
  RCServo2.attach(RCServo2Output) ;
 */
}

int motor_num = 0;
int knob_val;
int motor_speed;
int on=0;

void loop() 
{
  LCD.clear();
  LCD.home();
  
  knob_val = knob(6);
  LCD.print(knob_val);
  
  if(stopbutton()==1)
  {
    on=0;
  }
  
  else if(startbutton()==1)
  {
    on=1;
  }
  
  if(on==0)
  {
    motor.stop(motor_num);
  }
  
  else
  {
  motor.speed(motor_num, 2*(knob_val-512)+1);
  }
  
  
  
  delay(100);
}

