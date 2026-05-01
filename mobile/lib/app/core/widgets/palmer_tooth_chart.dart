import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_card.dart';

/// Palmer Notation tooth numbering system.
///
/// Quadrants (from patient's perspective):
///   Upper Right (UR): 1-8    |   Upper Left (UL): 1-8
///   Lower Right (LR): 1-8   |   Lower Left (LL): 1-8
///
/// Stored as strings: "UR1", "UL5", "LR8", "LL3", etc.
class PalmerToothChart extends StatelessWidget {
  final Set<String> selectedTeeth;
  final ValueChanged<Set<String>> onChanged;
  final bool isDark;

  const PalmerToothChart({
    super.key,
    required this.selectedTeeth,
    required this.onChanged,
    required this.isDark,
  });

  /// Palmer notation corner symbols for each quadrant.
  static const _quadrantSymbols = {
    'UR': '┘', // upper right
    'UL': '└', // upper left
    'LR': '┐', // lower right
    'LL': '┌', // lower left
  };

  void _toggle(String id) {
    final updated = Set<String>.from(selectedTeeth);
    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Quadrant labels row
          Row(
            children: [
              Expanded(
                child: Text(
                  'UR',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'UL',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Upper row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._buildQuadrantButtons('UR', [8, 7, 6, 5, 4, 3, 2, 1]),
                Container(
                  width: 2,
                  height: 34,
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
                ..._buildQuadrantButtons('UL', [1, 2, 3, 4, 5, 6, 7, 8]),
              ],
            ),
          ),

          const SizedBox(height: 4),
          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          const SizedBox(height: 4),

          // Lower row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._buildQuadrantButtons('LR', [8, 7, 6, 5, 4, 3, 2, 1]),
                Container(
                  width: 2,
                  height: 34,
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
                ..._buildQuadrantButtons('LL', [1, 2, 3, 4, 5, 6, 7, 8]),
              ],
            ),
          ),

          const SizedBox(height: 4),
          // Bottom quadrant labels
          Row(
            children: [
              Expanded(
                child: Text(
                  'LR',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'LL',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildQuadrantButtons(String prefix, List<int> numbers) {
    final symbol = _quadrantSymbols[prefix] ?? '';
    return numbers.map((n) {
      final id = '$prefix$n';
      final isSelected = selectedTeeth.contains(id);
      return _ToothButton(
        label: '$n$symbol',
        isSelected: isSelected,
        isDark: isDark,
        onTap: () => _toggle(id),
      );
    }).toList();
  }
}

class _ToothButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _ToothButton({
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 34,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primaryLight : AppColors.primary)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 8,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
