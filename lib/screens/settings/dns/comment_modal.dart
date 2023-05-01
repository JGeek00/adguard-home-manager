import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentModal extends StatefulWidget {
  final String? comment;
  final void Function(String) onConfirm;
  final bool dialog;

  const CommentModal({
    Key? key,
    this.comment,
    required this.onConfirm,
    required this.dialog
  }) : super(key: key);

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  final TextEditingController commentController = TextEditingController();

  bool validData = false;

  @override
  void initState() {
    if (widget.comment != null) {
      commentController.text = widget.comment!.replaceFirst(RegExp(r'#(\s)?'), "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Icon(
                            Icons.comment_rounded,
                            size: 24,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.comment,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: commentController,
                    onChanged: (value) {
                      if (value != '') {
                        setState(() => validData = true);
                      }
                      else {
                        setState(() => validData = false);
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.comment_rounded),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      labelText: AppLocalizations.of(context)!.comment,
                      helperText: AppLocalizations.of(context)!.commentsDescription,
                      helperMaxLines: 3
                    )
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(AppLocalizations.of(context)!.cancel)
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: validData == true 
                    ? () {
                        Navigator.pop(context);
                        widget.onConfirm("# ${commentController.text}");
                      }
                    : null, 
                  child: Text(
                    AppLocalizations.of(context)!.confirm,
                    style: TextStyle(
                      color: validData == true
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey
                    ),
                  )
                ),
              ],
            ),
          )
        ],
      );
    }

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: content()
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28)
            ),
            color: Theme.of(context).dialogBackgroundColor
          ),
          child: content()
        ),
      );
    }
  }
}