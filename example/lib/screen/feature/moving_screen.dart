import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../dummy_data/development.dart';
import '../../widget/pluto_example_button.dart';
import '../../widget/pluto_example_screen.dart';

class MovingScreen extends StatefulWidget {
  static const routeName = 'feature/moving';

  @override
  _MovingScreenState createState() => _MovingScreenState();
}

class _MovingScreenState extends State<MovingScreen> {
  List<PlutoColumn> columns;

  List<PlutoRow> rows;

  @override
  void initState() {
    super.initState();

    final dummyDate = DummyData(10, 100);

    columns = dummyDate.columns;

    rows = dummyDate.rows;
  }

  @override
  Widget build(BuildContext context) {
    return PlutoExampleScreen(
      title: 'Moving',
      topTitle: 'Moving',
      topContents: [
        Text(
            'Change the current cell position with the arrow keys, enter key, and tab key.'),
        Text(
            'When creating a Grid, you can control "Enter key action" and "After pop-up action" with enableMoveDownAfterSelecting and enterKeyAction properties in the configuration.'),
      ],
      topButtons: [
        PlutoExampleButton(
          url:
              'https://github.com/bosskmk/pluto_grid/blob/master/example/lib/screen/feature/moving_screen.dart',
        ),
      ],
      body: PlutoGrid(
        columns: columns,
        rows: rows,
        onChanged: (PlutoOnChangedEvent event) {
          print(event);
        },
        configuration: PlutoConfiguration(
          enableMoveDownAfterSelecting: true,
          enterKeyAction: PlutoEnterKeyAction.EditingAndMoveDown,
        ),
      ),
    );
  }
}
