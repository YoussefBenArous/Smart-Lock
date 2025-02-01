#include <esp_now.h>
#include <WiFi.h>

// Define LED pins
#define GREEN_LED 2
#define RED_LED 4
#define opendoor 5
#define buzeur 18

// Authorized UID  
String authorizedUID = "B3:F2:AE:E2"; 

// receive data
typedef struct struct_message {
  char uid[32]; // Array to hold received UID
} struct_message;


struct_message myData;

// Callback function executed when data is received
void OnDataRecv(const esp_now_recv_info *recv_info, const uint8_t *incomingData, int len) {
  // Copy received data into the structure
  memcpy(&myData, incomingData, sizeof(myData));

  Serial.print("Bytes received: ");
  Serial.println(len);
  Serial.print("Received UID: ");
  Serial.println(myData.uid);

  // Process the received UID
  String receivedUID = String(myData.uid);

  // Check if the received UID matches the authorized UID
  if (receivedUID.equalsIgnoreCase(authorizedUID)) {
    Serial.println("Authorized UID detected. Turning on green LED.");
    digitalWrite(GREEN_LED, HIGH); // Turn on green LED
    digitalWrite(RED_LED, LOW);    // Turn off red LED
    digitalWrite(opendoor, HIGH); 
    delay(2000); // Turn on the relay (open door)
  } else {
    Serial.println("Unauthorized UID detected. Turning on red LED.");
    digitalWrite(RED_LED, HIGH);   // Turn on red LED
    digitalWrite(GREEN_LED, LOW);  // Turn off green LED
    digitalWrite(opendoor, LOW);   // Turn off the relay (close door)
    digitalWrite(buzeur, HIGH);    // Turn on buzeur
  }

  // Turn off all and relay after 1 second
  delay(1000);
  digitalWrite(GREEN_LED, LOW);
  digitalWrite(RED_LED, LOW);
  digitalWrite(opendoor, LOW);
  digitalWrite(buzeur, LOW);
}

void setup() {
  Serial.begin(9600);

  // Set Wi-Fi mode to Station (STA) mode, necessary for ESP-NOW
  WiFi.mode(WIFI_STA);

  // Initialize ESP-NOW
  if (esp_now_init() != ESP_OK) {
    Serial.println("Error initializing ESP-NOW");
    return;
  }

  // Register the callback to handle received data
  esp_now_register_recv_cb(OnDataRecv);

  pinMode(GREEN_LED, OUTPUT);
  pinMode(RED_LED, OUTPUT);
  pinMode(opendoor, OUTPUT);
  pinMode(buzeur, OUTPUT);

  digitalWrite(GREEN_LED, LOW);
  digitalWrite(RED_LED, LOW);
  digitalWrite(opendoor, LOW);
  digitalWrite(buzeur , LOW);

  Serial.println("Receiver ready, waiting for data...");
}

void loop() {}
