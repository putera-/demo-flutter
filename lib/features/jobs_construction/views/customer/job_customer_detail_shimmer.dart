import 'package:flutter/material.dart';
import 'package:pgnpartner_mobile/core/utils/shimmer_extension.dart';

class JobCustomerDetailShimmer extends StatelessWidget {
  const JobCustomerDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer untuk Google Map
        Container(
          width: double.infinity,
          height: 185.0,
          color: Colors.white,
        ).shimmer(true),
        const SizedBox(height: 4.0),

        // Shimmer untuk lokasi
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  )).shimmer(true),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ).shimmer(true),
                    const SizedBox(height: 12.0),
                    Container(
                      width: 150.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ).shimmer(true),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16.0),

        // Shimmer untuk informasi pelanggan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(6, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ).shimmer(true),
                  const SizedBox(height: 8.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ).shimmer(true),
                  const SizedBox(height: 16.0),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
