import 'package:flutter/material.dart';

class GoogleGrid extends StatelessWidget {
  const GoogleGrid({
    Key key,
    this.columnCount = 2,
    @required this.children,
    this.gap,
    this.padding,
    this.margin,
    this.expanded = false,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  final int columnCount;
  final List<Widget> children;
  final double gap;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool expanded;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(children: _createRows()),
    );
  }

  List<Widget> _createRows() {
    final List<Widget> rows = [];
    final childrenLength = children.length;
    final rowCount = (childrenLength / columnCount).ceil();

    for (int i = 0; i < rowCount; i++) {
      final List<Widget> columns = _createColumns(i, childrenLength);

      rows.add(
        expanded
            ? Expanded(
                child: Row(
                  mainAxisAlignment: rowMainAxisAlignment,
                  crossAxisAlignment: rowCrossAxisAlignment,
                  children: columns,
                ),
              )
            : Row(
                mainAxisAlignment: rowMainAxisAlignment,
                crossAxisAlignment: rowCrossAxisAlignment,
                children: columns,
              ),
      );

      if (i != rowCount - 1) rows.add(SizedBox(height: gap));
    }

    return rows;
  }

  List<Widget> _createColumns(int rowIndex, int childrenLength) {
    final List<Widget> columns = [];

    for (int x = 0; x < columnCount; x++) {
      final index = rowIndex * columnCount + x;
      if (index <= childrenLength - 1) {
        columns.add(Expanded(child: children[index]));
      } else {
        columns.add(Expanded(child: Container()));
      }

      if (x != columnCount - 1) columns.add(SizedBox(width: gap));
    }

    return columns;
  }
}
