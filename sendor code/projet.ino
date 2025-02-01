#include <esp_now.h>
#include <WiFi.h>
#include <MFRC522.h>

// Define pin numbers for MFRC522
#define SS_PIN 21
#define RST_PIN 22

// Define LED pins
#define GREEN_LED 2
#define RED_LED 4

// the ID of card reciever
uint8_t broadcastAddress[] = {0x24, 0x6F, 0x28, 0xA3, 0x55, 0xF8};

// Structure to send data
typedef struct struct_message {
  char uid[32];         // UID string
  int randomValue;      // Example random value
  float exampleFloat;   // Example float value
  bool exampleBool;     // Example boolean value
} struct_message;



// Create an instance of the struct to hold the message data
struct_message myData;

esp_now_peer_info_t peerInfo;

// Create an instance of the MFRC522 class
MFRC522 mfrc522(SS_PIN, RST_PIN);

// Callback when data is sent
void OnDataSent(const uint8_t *mac_addr, esp_now_send_status_t status) {
  Serial.print("\r\nLast Packet Send Status:\t");
  Serial.println(status == ESP_NOW_SEND_SUCCESS ? "Delivery Success" : "Delivery Fail");
}

void setup() {
  // Initialize Serial Monitor
  Serial.begin(9600);

  // Set device as a Wi-Fi Station
  WiFi.mode(WIFI_STA);

  // Initialize ESP-NOW
  if (esp_now_init() != ESP_OK) {
    Serial.println("Error initializing ESP-NOW");
    return;
  }

  // Register the send callback
  esp_now_register_send_cb(OnDataSent);

  // Register peer (Receiver's MAC address)
  memcpy(peerInfo.peer_addr, broadcastAddress, 6);
  peerInfo.channel = 0;  // Default channel
  peerInfo.encrypt = false;

  // Add peer
  if (esp_now_add_peer(&peerInfo) != ESP_OK) {
    Serial.println("Failed to add peer");
    return;
  }

  // Initialize SPI and RFID module
  SPI.begin();
  mfrc522.PCD_Init();
  Serial.println("RFID Reader Initialized. Place your card near the reader...");

  // Initialize LEDs
  pinMode(GREEN_LED, OUTPUT);
  pinMode(RED_LED, OUTPUT);
  digitalWrite(GREEN_LED, LOW);
  digitalWrite(RED_LED, HIGH); // Red LED ON to indicate standby
}

void loop() {
  // Check if a new RFID card is present
  if (mfrc522.PICC_IsNewCardPresent() && mfrc522.PICC_ReadCardSerial()) {
    // Construct the UID string from the RFID card
    String uid = "";
    for (byte i = 0; i < mfrc522.uid.size; i++) {
      uid += String(mfrc522.uid.uidByte[i], HEX);
      if (i < mfrc522.uid.size - 1) uid += ":"; // Add ':' between bytes
    }

    Serial.print("UID: ");
    Serial.println(uid);

    // Copy UID to the message structure
    strncpy(myData.uid, uid.c_str(), sizeof(myData.uid));
    myData.randomValue = random(1, 20); // Example random data
    myData.exampleFloat = 1.2;         // Example float value
    myData.exampleBool = true;         // Example boolean value

    // Send message via ESP-NOW
    esp_err_t result = esp_now_send(broadcastAddress, (uint8_t *)&myData, sizeof(myData));

    if (result == ESP_OK) {
      Serial.println("Sent with success");
      indicateSuccess();
    } else {
      Serial.println("Error sending the data");
      indicateFailure();
    }

    // Halt RFID card communication
    mfrc522.PICC_HaltA();
  }

  delay(1000); // Delay to avoid rapid looping
}

void indicateSuccess() {
  digitalWrite(GREEN_LED, HIGH); // Turn on green LED
  digitalWrite(RED_LED, LOW);    // Turn off red LED
  delay(2000);                   // Hold for 2 seconds
  digitalWrite(GREEN_LED, LOW);  // Turn off green LED
  digitalWrite(RED_LED, HIGH);   // Turn on red LED (standby state)
}

void indicateFailure() {
  digitalWrite(RED_LED, HIGH);   // Keep red LED on
  digitalWrite(GREEN_LED, LOW);  // Ensure green LED is off
}
