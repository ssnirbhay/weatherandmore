import 'package:email_validator/email_validator.dart';
/**
 * created by Nishith on 24/4/21.
 */
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:toast/toast.dart';

class Home extends HookWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final theme = Theme.of(context).textTheme;
    final listState = useState({
      0: false,
      1: false,
      2: false,
      3: false,
    });
    final name = useTextEditingController();
    final email = useTextEditingController();
    final message = useTextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Weather and more'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  final list = Map<int, bool>.from(listState.value);
                  list[index] = !isExpanded;
                  listState.value = list;
                },
                children: [
                  _buildPanel(
                    question: 'How to login into the app',
                    answer: 'You are not required to log in to the app to use it. But to access music recommendations you will require to sign in or create an account.' +
                        '\nYou can do this by pressing the spotify icon on the home screen of the app',
                    isExpanded: listState.value[0],
                  ),
                  _buildPanel(
                    question: 'How to change temperature units',
                    answer:
                        'You can change the temperature unit to your preferred unit by pressing the drawer icon on the top right corner.',
                    isExpanded: listState.value[1],
                  ),
                  _buildPanel(
                    question: 'How to change wind speed units',
                    answer:
                        'You can change the wind speed unit to your preferred unit by pressing the drawer icon on the top right corner.',
                    isExpanded: listState.value[2],
                  ),
                  _buildPanel(
                    question: 'How to change time format',
                    answer:
                        'You can change the time format to your preferred format by pressing the drawer icon on the top right corner.',
                    isExpanded: listState.value[3],
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Text(
                'Send us a message:',
                style: theme.headline5,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                constraints: BoxConstraints(maxWidth: 450),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (_) =>
                                _.isNotEmpty ? null : 'Please enter your name',
                            controller: name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Name',
                              icon: Icon(Icons.text_fields),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            validator: (_) => EmailValidator.validate(_)
                                ? null
                                : 'Please enter a valid email',
                            controller: email,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              icon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 150,
                            child: Flexible(
                              child: TextFormField(
                                validator: (_) => _.isNotEmpty
                                    ? null
                                    : 'Please enter message',
                                controller: message,
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Message',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          Toast.show('Your message has been sent.', context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('Submit'),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionPanel _buildPanel({
    @required String question,
    @required String answer,
    @required bool isExpanded,
  }) =>
      ExpansionPanel(
        isExpanded: isExpanded,
        headerBuilder: (BuildContext context, bool isExpanded) => ListTile(
          title: Text(question),
        ),
        canTapOnHeader: true,
        body: ListTile(
          title: Text(answer),
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          tileColor: Colors.grey.shade100,
        ),
      );
}
