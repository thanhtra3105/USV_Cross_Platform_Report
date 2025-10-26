import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedGauge extends StatelessWidget {
  final double speed; // 0–10

  const SpeedGauge({Key? key, required this.speed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // can chinh hinh vuong
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 800,
            axes: <RadialAxis>[
              RadialAxis(
                radiusFactor: 0.8, // 👈 thu nhỏ gauge để vừa card
                minimum: 0,
                maximum: 10,
                startAngle: 180,
                endAngle: 0,
                showLabels: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.25,
                  cornerStyle: CornerStyle.bothFlat,
                  color: Colors.grey.shade300,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 2.5,
                    color: Colors.red,
                    startWidth: 0.2,
                    endWidth: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 2.5,
                    endValue: 5,
                    color: Colors.orange,
                    startWidth: 0.2,
                    endWidth: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 5,
                    endValue: 7.5,
                    color: Colors.blue,
                    startWidth: 0.2,
                    endWidth: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 7.5,
                    endValue: 10,
                    color: Colors.green,
                    startWidth: 0.2,
                    endWidth: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: speed,
                    needleColor: const Color.fromARGB(255, 58, 139, 153),
                    knobStyle: const KnobStyle(
                      color: Color.fromARGB(255, 16, 48, 95),
                    ),
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
                              "${speed.toStringAsFixed(1)}",
                              style: const TextStyle(
                                fontSize: 24,
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 112, 92, 228),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "km/h",
                              style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Speed ",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: Colors.grey,
                              ),
                            ),
                            Icon(Icons.speed, color: Colors.blueAccent),
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
