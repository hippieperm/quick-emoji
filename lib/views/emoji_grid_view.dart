import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/emoji_view_model.dart';
import '../models/emoji_category.dart';

class EmojiGridView extends StatelessWidget {
  final EmojiCategory category;

  const EmojiGridView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EmojiViewModel>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 1.0,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: category.emojis.length,
      itemBuilder: (context, index) {
        final emoji = category.emojis[index];
        final isSelected = viewModel.selectedEmoji == emoji && viewModel.copied;

        return InkWell(
          onTap: () => viewModel.copyEmoji(emoji),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 28,
                    color: isSelected ? colorScheme.onPrimaryContainer : null,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
