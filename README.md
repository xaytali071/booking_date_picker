
# Booking Date Picker 📅  

`booking_date_picker` is a customizable and easy-to-use date picker widget for Flutter.  

## Features  
✅ Navigate between months  
✅ Select a specific date  
✅ Fully customizable UI  
✅ Supports multiple `locale` settings  

## Installation  
Add the following to your `pubspec.yaml` file:  

```yaml
dependencies:
  booking_date_picker: ^1.0.0


## Screenshots

![App Screenshot](https://github.com/xaytali071/booking_date_picker/blob/master/5393421743802150449.jpg)

## Demo

import 'package:flutter/material.dart';
import 'package:booking_date_picker/booking_date_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Booking Date Picker Demo")),
        body: Center(
          child: BookingDatePicker(
            onChanged: (date) {
              print("Selected date: $date");
            },
            locale: "en_US",
            selectItemColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}


# License

---

## **2. `pubspec.yaml` (Package Configuration)**  
```yaml
name: booking_date_picker
description: "A Flutter widget for selecting dates with a customizable UI and multi-language support."
version: 1.0.0
repository: https://github.com/xaytali071/booking_date_picker
environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  assets:
    - assets/icon.png  # Add an icon if necessary



## Authors

- Xaytali Najmiddinov

- [@xaytalinajmiddinov071@gmail.com](https://github.com/xaytali071)

