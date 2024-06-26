# Arduino-360-Radar
This project demonstrates a 360-degree radar system using a single servo motor and an ultrasonic distance sensor controlled by an Arduino. The real-time scanning data is visualized using Processing.


## Contents

- `arduino_code.ino`: Arduino sketch responsible for servo control and distance measurement using ultrasonic sensors.
  
- `processing_code.pde*`: Processing sketch for visualizing the radar data in a 2D interface.

- `Result/`: Folder containing screenshots or images illustrating the project step-by-step.

## Components Used

- **Arduino Uno**: Microcontroller board for controlling the servo motor and processing sensor data.
  
- **HC-SR04 Ultrasonic Sensors**: Two ultrasonic sensors used to measure distances in front of the radar system.
  
- **SG90 Servo Motor**: Single servo motor used for 360-degree rotation to scan the environment.
  
## Setup Instructions

1. **Arduino Setup**:
   - Connect the ultrasonic sensors to the Arduino board (e.g., Sensor 1 to pins 6 (Trig) and 7 (Echo), Sensor 2 to pins 5 (Trig) and 4 (Echo)).
   - Connect the servo motor to a PWM capable pin (e.g., pin 2).
   - Upload `arduino_code.ino` to the Arduino board.

2. **Processing Setup**:
   - Ensure Processing IDE is installed on your computer.
   - Open `processing_code.pde` in Processing IDE.
   - Adjust the COM port selection in Processing to match your Arduino board.
   - Run the Processing sketch to visualize the radar data.

## How It Works

- **Arduino (`arduino_code.ino`)**:
  - Initializes the servo motor and ultrasonic sensors.
  - Rotates the servo motor from 0 to 180 degrees and back, while measuring distances using the ultrasonic sensors.
  - Sends angle and distance data via serial communication to the connected computer.

- **Processing (`processing_code.pde`)**:
  - Establishes serial communication with Arduino to receive angle and distance data.
  - Visualizes the received data in a 2D interface resembling a radar screen.
  - Each detected object is represented by a colored circle whose size and color vary based on the detected distance.

## Visual Results

- The `Result/` folder contains screenshots or images illustrating the radar system in action.
- These images show the radar interface with objects detected at various distances and angles.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspiration and initial guidance from [source/reference if any].


## Contact

For questions regarding the project, you can contact me at: [mmnkrnz@gmail.com](mailto:mmnkrnz@gmail.com)