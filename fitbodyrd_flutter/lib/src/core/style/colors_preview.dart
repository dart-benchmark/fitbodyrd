import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview()
WidgetBuilder preview() {
  return (context) => ColorsPreview();
}

class ColorsPreview extends StatelessWidget {
  const ColorsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Primary Colors', [
            _ColorItem('p900', KColors.primary.p900, '#151C00'),
            _ColorItem('p800', KColors.primary.p800, '#405500'),
            _ColorItem('p700', KColors.primary.p700, '#6B8E00'),
            _ColorItem('p600', KColors.primary.p600, '#96C600'),
            _ColorItem('p500', KColors.primary.p500, '#C1FF00'),
            _ColorItem('p400', KColors.primary.p400, '#CFFF39'),
            _ColorItem('p300', KColors.primary.p300, '#DDFF71'),
            _ColorItem('p200', KColors.primary.p200, '#EAFFAA'),
          ]),
          const SizedBox(height: 24),
          _buildSection('Grey Scale', [
            _ColorItem('g1000', KColors.greyScale.g1000, '#0F0F0F'),
            _ColorItem('g900', KColors.greyScale.g900, '#2C2C2C'),
            _ColorItem('g800', KColors.greyScale.g800, '#4A4A4A'),
            _ColorItem('g700', KColors.greyScale.g700, '#676767'),
            _ColorItem('g600', KColors.greyScale.g600, '#848484'),
            _ColorItem('g550', KColors.greyScale.g550, '#939393'),
            _ColorItem('g500', KColors.greyScale.g500, '#9E9E9E'),
            _ColorItem('g400', KColors.greyScale.g400, '#B3B3B3'),
            _ColorItem('g300', KColors.greyScale.g300, '#C9C9C9'),
            _ColorItem('g200', KColors.greyScale.g200, '#DFDFDF'),
            _ColorItem('g100', KColors.greyScale.g100, '#F4F4F4'),
          ]),
          const SizedBox(height: 24),
          _buildSection('Status Colors', [
            _ColorItem('success', KColors.status.success, '#00D33F'),
            _ColorItem('warning', KColors.status.warning, '#FFCC00'),
            _ColorItem('error', KColors.status.error, '#C50000'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<_ColorItem> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...colors.map(_buildColorRow),
      ],
    );
  }

  Widget _buildColorRow(_ColorItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              color: item.color,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item.hex,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorItem {
  _ColorItem(this.name, this.color, this.hex);
  final String name;
  final Color color;
  final String hex;
}
