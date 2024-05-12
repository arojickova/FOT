

// Definice pinů pro ovládání H-můstku
const int in1 = 11;  // Pin pro řízení směru
const int in2 = 10; // Pin pro řízení směru
const int ledPin2 = 12; //pin pro zelenou ledku
const int ledPin1 = 9;  // pin pro červenou ledku

// pin for the button switch
//const int buttonPin = 3;
// value to check state of button switch
//int buttonState = 0; //proměnná pro uložení stavu tlačítka 
//bool loopStarted = false;

void zasunuti(unsigned long cas) {
  digitalWrite(in2, LOW);
  digitalWrite(in1, HIGH);
  delay(cas);
}

void vysunuti(unsigned long cas) {
  digitalWrite(in2, HIGH);
  digitalWrite(in1, LOW);
  delay(cas);
}

void zastaveni(unsigned long cas) {
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  delay(cas);
}


// Funkce pro posunutí aktuátoru dopředu po dobu 4 sekund a zpět po dobu 4 sekund s pauzou 2 sekundy mezi pohyby
void cyklus_aktuatoru() {
  
  vysunuti(4000);  // Vysunutí po dobu X sekund
  zastaveni(100);  // Zastavení aktuátoru a pauza X sekund
  zasunuti(4000);  // Zasunutí pro dobu X sekund
  zastaveni(100);  // Zastavení aktuátoru a pauza X sekund
}

void kalibrace()
{
  zasunuti(5000); // zasunutí motoru po dobu X sekund 
}

void setup() {
  delay(100);  // asi zbytecne

  // Nastavení pinů jako vstupy/výstupy
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
 // pinMode(buttonPin, INPUT);


  //Inicializace sériové komunikace pro debugovací účely
  Serial.begin(115000);
}


void loop() {
  //buttonState = digitalRead(buttonPin);

 // if (buttonState == HIGH && !loopStarted){
  //  loopStarted = true;
    //while (loopStarted){
  
  // Volání funkce pro provedení pohybu aktuátoru
  digitalWrite(ledPin1, HIGH); 
  digitalWrite(ledPin2, LOW);
  
  //kalibrace - 6s se motor vždy před měřením zasouvá
  kalibrace();
   for (int i = 0; i < 4; i++) { //proběhne X nádechů a X výdechů 
    
    cyklus_aktuatoru();
  }
  
  digitalWrite(ledPin2, HIGH); 
  digitalWrite(ledPin1, LOW); 
  zastaveni(30000);
  //buttonState = digitalRead(buttonPin);
  //if (buttonState == LOW){
    //loopStarted = false; 
  }
    
  


