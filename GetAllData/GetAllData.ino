
#include <MPU6050_tockn.h>
#include <Wire.h>

MPU6050 mpu6050(Wire);

long timer = 0;

void setup() {
  Serial.begin(9600);
  Wire.begin();
  mpu6050.begin();
  //mpu6050.calcGyroOffsets(true);
}

void loop() {
   char temp[32];
  mpu6050.update();

  if(1){
    
    Serial.print("A");  //standing for acc
    Serial.print(mpu6050.getAccX());
    Serial.print(",");
    Serial.print(mpu6050.getAccY());
    Serial.print(",");
    Serial.print(mpu6050.getAccZ());

    delay(50);
    //sprintf(temp,"%d,%s,%.2f",1,mpu6050.getAccX(),mpu6050.getGyroZ());
    //Serial.println(temp);
    Serial.print(" G");  //standing for gyro
    Serial.print(mpu6050.getGyroX());
    Serial.print(",");
    Serial.print(mpu6050.getGyroY());
    Serial.print(",");
    Serial.println(mpu6050.getGyroZ());
    //Serial.print(",");
    delay(50);
    
    timer = millis();
    
  }

}
