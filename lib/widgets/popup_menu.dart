import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onBookmarked;
  final VoidCallback onDelete;
  final VoidCallback onRestore;

  const PopupMenu({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onBookmarked,
    required this.onDelete,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    if (task.isDeleted == true) {
      return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: onRestore,
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.restore_from_trash),
                label: const Text("Restore"),
              ),
            ),
            PopupMenuItem(
              onTap: onDelete,
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.delete),
                label: const Text("Delete Forever"),
              ),
            ),
          ];
        },
      );
    } else {
      return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: onEdit,
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.edit),
                label: const Text("Edit"),
              ),
            ),
            PopupMenuItem(
              onTap: onBookmarked,
              child: TextButton.icon(
                onPressed: null,
                icon: Icon(
                  task.isFavorite == false
                      ? Icons.bookmark_outline
                      : Icons.bookmark_remove,
                ),
                label: Text(
                  task.isFavorite == false
                      ? "Add to Bookmarks"
                      : "Remove Bookmarks",
                ),
              ),
            ),
            PopupMenuItem(
              onTap: onDelete,
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
              ),
            ),
          ];
        },
      );
    }
  }
}
