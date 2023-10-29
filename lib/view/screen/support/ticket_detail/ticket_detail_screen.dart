import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../di_container.dart';
import '../../../../helper/api_checker.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/ticket_detail_provider.dart';
import '../../../../utill/dimensions.dart';
import '../../../basewidget/custom_expanded_app_bar.dart';
import '../../../basewidget/show_custom_snakbar.dart';
import 'ticket_detail_effect.dart';
import 'ticket_detail_extra.dart';
import 'widgets/conversation_section.dart';
import 'widgets/detail_section.dart';

class TicketDetailScreen extends StatelessWidget {
  final TicketDetailExtra extra;
  const TicketDetailScreen({
    Key key,
    @required this.extra,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<TicketDetailProvider>()
        ..init(
          effect: (effect) => _onEffectTriggered(context, effect),
          extra: extra,
        ),
      child: TicketDetailView(),
    );
  }

  void _onEffectTriggered(BuildContext context, TicketDetailEffect effect) {
    if (effect is ShowSnackbar) {
      showCustomSnackBar(effect.message, context, isError: effect.isError);
    } else if (effect is CheckApi) {
      ApiChecker.checkApi(context, effect.apiResponse);
    }
  }
}

class TicketDetailView extends StatelessWidget {
  const TicketDetailView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      isGuestCheck: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TicketDetailProvider>().refresh();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    DetailSection(),
                    Expanded(
                      child: ConversationSection(),
                    ),
                    ChatField(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatField extends StatefulWidget {
  const ChatField({
    Key key,
  }) : super(key: key);

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        bottom: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Write your message here...',
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          suffixIcon: Selector<TicketDetailProvider, bool>(
            selector: (context, provider) {
              return provider.isLoadingSendComment;
            },
            builder: (context, isLoadingSendComment, child) {
              if (isLoadingSendComment) {
                return SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                );
              }

              return InkWell(
                onTap: () {
                  context
                      .read<TicketDetailProvider>()
                      .sendMessage(controller.text);
                  controller.text = '';
                },
                child: Icon(Icons.send_rounded),
              );
            },
          ),
        ),
      ),
    );
  }
}
