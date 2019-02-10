//Arduino Code to get data from temp/hum sensor
//WITH THE HELP OF https://create.arduino.cc
//sensor GND port to GND arduino
//sensor vcc port to 5v arduino

#include <DHT.h> //dht library

#define DHT_PIN 7     //sensor data pin
#define DHT_Model DHT22   // DHT 22  (ASAIR AM2302)

DHT dht(DHT_PIN, DHT_Model); // create an instance of the sensor

float temp; //Stores temperature value
float hum;  //Stores humidity value

void setup()
{
  Serial.begin(9600);
  dht.begin();
}

void loop()
{
    temp= dht.readTemperature();
    hum = dht.readHumidity();
    //print
    if (isnan(temp) or isnan(hum))
        Serial.print("error in reading");
    else{
      Serial.print("Humidity:");
      Serial.print(hum);
      Serial.print("%, Temp:");
      Serial.print(temp);
      Serial.println("Celsius");
      delay(20000);
    }
}
