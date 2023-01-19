import 'package:agil_coletas/app/utils/loading_widget.dart';
import 'package:flutter/material.dart';

class MyListShimmerWidget extends StatelessWidget {
  const MyListShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: List.generate(
          5,
          (index) => Column(
            children: const [
              LoadingWidget(
                size: Size(double.infinity, 45),
                radius: 10,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
