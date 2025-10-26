import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Batterycard extends StatelessWidget {
  final double value; // Giá trị hiện tại
  final double min;
  final double max;
  final String label;

  const Batterycard({
    Key? key,
    required this.value,
    this.min = 0,
    this.max = 100,
    this.label = "battery",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // Giữ cho gauge vuông đẹp
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1000,
            axes: <RadialAxis>[
              RadialAxis(
                minimum: min,
                maximum: max,
                startAngle: 160,
                endAngle: 20,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.25,
                  color: Colors.grey.shade300,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: value,
                    width: 0.25,
                    sizeUnit: GaugeSizeUnit.factor,
                    gradient: const SweepGradient(
                      colors: [Colors.blue, Colors.yellow, Colors.red],
                      stops: [0.1, 0.7, 1],
                    ),
                    cornerStyle: CornerStyle.bothCurve,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 112, 92, 228),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.percent_outlined, color: Colors.grey),
                          ],
                        ),

                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Battery",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: Colors.grey,
                              ),
                            ),
                            Icon(
                              Icons.battery_6_bar_sharp,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                    positionFactor: 0.7,
                    angle: 90,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
