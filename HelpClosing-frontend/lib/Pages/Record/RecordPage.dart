import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_closing_frontend/Domain/HelpLog.dart';
import '../../Controller/Help_Log_Controller.dart';

class RecordPage extends StatefulWidget {
  RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final HelpLogController _helpLogController = Get.put(HelpLogController());
  Choice choiceView = Choice.receive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ChoiceState(
                  choiceView: choiceView,
                  onSelectionChanged: (newChoice) {
                    setState(() {
                      choiceView = newChoice;
                    });
                  })),
          Expanded(
            child: Obx(() => ListView.builder(
                itemCount: _helpLogController.recipientHelpLogs.length,
                itemBuilder: (context, index) {
                  final log = _helpLogController.recipientHelpLogs[index];
                  if (choiceView == Choice.receive) {
                    return _buildCardSos(log);
                  } else {
                    return _buildCardPeople(log);
                  }
                })),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSos(HelpLog helpLog) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordDetailRecipientPage(log: helpLog),
              ));
        },
        child: Card(
            color: Colors.white,
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: Icon(Icons.sos),
              title: Text('${helpLog.recipient.name}님에게 도움 요청'),
              subtitle: Text('${helpLog.time}'),
            )));
  }

  Widget _buildCardPeople(HelpLog helpLog) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordDetailRequesterPage(log: helpLog),
              ));
        },
        child: Card(
            color: Colors.white,
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: Icon(Icons.emoji_people),
              title: Text('${helpLog.requester.name}님에게 도움 제공'),
              subtitle: Text('${helpLog.time}'),
            )));
  }
}

class RecordDetailRequesterPage extends StatelessWidget {
  final HelpLog log;

  RecordDetailRequesterPage({required this.log});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${log.requester.name}님과의 도움 기록'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
        body:Center(
          child: Text('test'),
        )
    );
  }
}

class RecordDetailRecipientPage extends StatelessWidget {
  final HelpLog log;

  RecordDetailRecipientPage({required this.log});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${log.recipient.name}님과의 도움 기록'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body:Center(
        child: Text('test'),
      )
    );
  }
}

enum Choice { give, receive }

class ChoiceState extends StatefulWidget {
  final Choice choiceView;
  final ValueChanged<Choice> onSelectionChanged;

  const ChoiceState({
    Key? key,
    required this.choiceView,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<ChoiceState> createState() => _ChoiceStateState();
}

class _ChoiceStateState extends State<ChoiceState> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Choice>(
      // style: ButtonStyle(
      //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //     const RoundedRectangleBorder(borderRadius: BorderRadius.zero)
      //   )
      // ),
      segments: const <ButtonSegment<Choice>>[
        ButtonSegment<Choice>(
          value: Choice.receive,
          label: Text("도움 요청"),
          icon: Icon(Icons.arrow_circle_down_outlined),
        ),
        ButtonSegment<Choice>(
          value: Choice.give,
          label: Text("도움 제공"),
          icon: Icon(Icons.arrow_circle_up_outlined),
        ),
      ],
      selected: <Choice>{widget.choiceView},
      onSelectionChanged: (Set<Choice> newSelection) {
        widget.onSelectionChanged(newSelection.first);
      },
    );
  }
}
