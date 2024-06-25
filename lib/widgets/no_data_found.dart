import 'package:amazon/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({
    super.key,
    this.msg,
    this.desc,
    this.isError = false,
  });
  final String? msg;
  final String? desc;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: isError
              ? SvgPicture.asset(
                  'assets/icons/error.svg',
                  height: 114,
                  width: 114,
                )
              : SvgPicture.asset(
                  'assets/icons/no_data_found.svg',
                ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            msg ?? noDataFound,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SizedBox(
            width: 200,
            child: Text(
              desc ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
