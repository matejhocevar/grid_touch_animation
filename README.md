# Grid Touch Animation

Grid Touch Animation is a Flutter project that demonstrates grid-sensitive touch animation effects on a grid of sensors.

## Preview
![Example](/media/example.gif)


## Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/matejhocevar/grid_touch_animation.git
```

2. Navigate to the project directory:

```bash
cd grid_touch_animation
```

3. Run the app using Flutter:

```bash
flutter run
```

## Usage

Once the app is running, you'll see a grid of sensors. Touch and drag on any sensor to increase its intensity.
The intensity of the sensor determines the color and shadow of the sensor's circle.

## Code Structure

All source code is located in `/lib` directory.

- `main.dart`: Contains the main application code, including the MainApp widget.
- `grid_matrix.dart`: Defines the GridMatrix class responsible for managing the grid data.
- `sensor.dart`: Defines the Sensor widget used to display individual sensors.

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License.