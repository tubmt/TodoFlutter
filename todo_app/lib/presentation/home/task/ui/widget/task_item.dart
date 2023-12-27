import 'package:domain/domain_ex.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    required this.taskUi,
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
  });

  final TaskUi taskUi;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Extract(theme: theme),
      child: ListTile(
        onTap: onTap,
        title: Text(
          taskUi.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: !taskUi.isCompleted
              ? null
              : TextStyle(
                  color: captionColor,
                  decoration: TextDecoration.lineThrough,
                ),
        ),
        subtitle: Text(
          taskUi.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Checkbox(
          value: taskUi.isCompleted,
          onChanged: onToggleCompleted == null
              ? null
              : (value) => onToggleCompleted!(value!),
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}

class Extract extends StatelessWidget {
  const Extract({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      color: theme.colorScheme.error,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(
        Icons.delete,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }
}
