import processing.serial.*;
import static javax.swing.JOptionPane.*;

Serial myPort;        // The serial port
String serialin;
int data[] = new int[360];
PFont f;

final boolean debug = true;

void setup() {
  String COMx, COMlist = "";
  size(1280, 720);
  f = createFont("Verdana", 32, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 20);
  frameRate(60);
  for (int i = 0; i < 360; i++) {
    data[i] = 0;
  }
  try {
    if (debug) printArray(Serial.list());
    int i = Serial.list().length;
    if (i != 0) {
      if (i >= 2) {
        // need to check which port the inst uses -
        // for now we'll just let the user decide
        for (int j = 0; j < i; ) {
          COMlist += char(j+'a') + " = " + Serial.list()[j];
          if (++j < i) COMlist += ",  ";
        }
        COMx = showInputDialog("Which COM port is correct? (a,b,..):\n"+COMlist);
        if (COMx == null) exit();
        if (COMx.isEmpty()) exit();
        i = parseInt(COMx.toLowerCase().charAt(0) - 'a') + 1;
      }
      String portName = Serial.list()[i-1];
      if (debug) println(portName);
      myPort = new Serial(this, portName, 9600); // change baud rate to your liking
      myPort.bufferUntil('\n'); // buffer until CR/LF appears, but not required..
    } else {
      // COM port bulunamadıysa
      println("Device is not connected to the PC");
      exit(); // Uygulamadan çıkış
    }
  } catch (Exception e) {
    // Hata durumunda
    println("COM port is not available (may be in use by another program)");
    println("Error:", e);
    exit(); // Uygulamadan çıkış
  }
}

void draw() {
  background(26, 26, 36, 200);
  textSize(18);
  stroke(255, 255, 255, 150);
  fill(255, 50, 200, 200);
  text("Arduino RADAR 2D Visualization", 20, 710);
  text(hour(), 1050, 710);
  text(":", 1075, 710);
  text(minute(), 1085, 710);
  text(":", 1110, 710);
  text(second(), 1120, 710);
  fill(36, 255, 100, 200);
  strokeWeight(3);
  circle(640, 360, 700);
  circle(640, 360, 600);
  circle(640, 360, 500);
  circle(640, 360, 400);
  circle(640, 360, 300);
  circle(640, 360, 200);
  circle(640, 360, 100);
  

  for (int i = 0; i < 360; i++) {
    // Calculate the position of the point based on distance
    float distance = map_values(data[i]);
    float x = 640 + distance * cos(radians(i));
    float y = 360 + distance * sin(radians(i));

    // Calculate the size based on distance
    float size = 10; // Default size
    if (distance < 40) {
      size = map(distance, 0, 40, 20, 50); // Reducing size for close distances
    } else if (distance >= 40 && distance < 80) {
      size = map(distance, 40, 80, 10, 20); // Adjusting size for medium distances
    } else {
      size = map(distance, 80, 200, 5, 10); // Reducing size for far distances
    }

    // Calculate the color based on distance
    int colorValue = color(0, 255, 0); // Default color (Green) for far distances
    if (distance < 40) {
      colorValue = color(255, 0, 0); // Red for close distances
    } else if (distance >= 40 && distance < 80) {
      colorValue = lerpColor(color(255, 0, 0), color(255, 255, 0), map(distance, 40, 80, 0, 1));
      // Interpolate between red and yellow for medium distances
    } else {
      colorValue = color(0, 0, 0); // black for far distances
    }

    // Draw a filled circle to represent the distance
    noStroke();
    fill(colorValue);
    ellipse(x, y, size, size); // Adjust the size of the circles based on distance
  }
  while (myPort.available() > 0) {
    serialin = myPort.readStringUntil(10);
    try {
      String serialdata[] = splitTokens(serialin, ",");
      if (serialdata[0] != null) {
        serialdata[0] = trim(serialdata[0]);
        serialdata[1] = trim(serialdata[1]);
        serialdata[2] = trim(serialdata[2]);

        int i = parseInt(serialdata[0]);
        data[179-i] = parseInt(serialdata[1]);
        data[(179-i)+180] = parseInt(serialdata[2]);
      }
    } 
    catch (java.lang.RuntimeException e) {
    }
  }
}

float map_values(float x) {
  float in_min = 0, in_max = 200, out_min = 0, out_max = 700;
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
