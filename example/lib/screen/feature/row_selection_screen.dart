import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../dummy_data/development.dart';
import '../../widget/pluto_example_button.dart';
import '../../widget/pluto_example_screen.dart';

class RowSelectionScreen extends StatefulWidget {
  static const routeName = 'feature/row-selection';

  @override
  _RowSelectionScreenState createState() => _RowSelectionScreenState();
}

class _RowSelectionScreenState extends State<RowSelectionScreen> {
  List<PlutoColumn> columns;

  List<PlutoRow> rows;

  PlutoStateManager stateManager;

  @override
  void initState() {
    super.initState();

    final dummyDate = DummyData(10, 100);

    columns = dummyDate.columns;

    rows = dummyDate.rows;
  }

  void handleSelected() async {
    String value = '';

    stateManager.currentSelectingRows.forEach((element) {
      final cellValue = element.cells.entries.first.value.value;

      value += 'first cell value of row: $cellValue\n';
    });

    if (value.isEmpty) {
      value = 'No rows are selected.';
    }

    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            child: LayoutBuilder(
              builder: (ctx, size) {
                return Container(
                  padding: EdgeInsets.all(15),
                  width: 400,
                  height: 500,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(value),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PlutoExampleScreen(
      title: 'Row selection',
      topTitle: 'Row selection',
      topContents: [
        Text(
            'In Row selection mode, Shift + tap or long tap and then move or Control + tap to select a row.'),
      ],
      topButtons: [
        PlutoExampleButton(
          url:
              'https://github.com/bosskmk/pluto_grid/blob/master/example/lib/screen/feature/row_selection_screen.dart',
        ),
      ],
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FlatButton(
                  child: Text('Show selected rows.'),
                  onPressed: handleSelected,
                ),
              ],
            ),
          ),
          Expanded(
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onChanged: (PlutoOnChangedEvent event) {
                print(event);
              },
              onLoaded: (PlutoOnLoadedEvent event) {
                event.stateManager.setSelectingMode(PlutoSelectingMode.Row);

                stateManager = event.stateManager;
              },
            ),
          ),
        ],
      ),
    );
  }
}
