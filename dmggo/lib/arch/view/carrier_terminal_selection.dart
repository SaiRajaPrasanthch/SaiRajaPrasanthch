import 'package:dmggo/arch/view_model/carrier_terminal_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrierTerminalSelection extends StatefulWidget {
  const CarrierTerminalSelection({Key? key}) : super(key: key);

  @override
  State<CarrierTerminalSelection> createState() => _CarrierTerminalSelectionState();
}

class _CarrierTerminalSelectionState extends State<CarrierTerminalSelection> {
  // List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    context.read<CarrierTerminalLog>().getCarriersAndTerminal();
    // setState(() {
    //   _items = _generateItems();
    // });
  }

  // List<Item> _generateItems() {
  //   return List.generate(20, (int index) {
  //     return Item(
  //       id: index,
  //       name: 'Item $index',
  //       description: 'Details of item $index',
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // SafeArea(
            //   child: SingleChildScrollView(
            //       child: Column(
            //     children: _items.map((e) => ExpansionTile(title: Text(e.name!))).toList(),
            //   )

            SingleChildScrollView(
      child: ExpansionPanelList.radio(
        // animationDuration: const Duration(seconds: 2),
        // expandedHeaderPadding: EdgeInsets.all(10),
        dividerColor: Colors.red,
        elevation: 1,
        // initialOpenPanelValue: 3,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            // _items[index].isExpanded = !isExpanded;
          });
        },
        children: context. .map((item) => _buildExpansionPanelRadio(item)).toList(),
        //  [_buildExpansionPanelRadio(_items[0])],
      ),
    ));
  }

  // ExpansionPanelRadio _buildExpansionPanelRadio(Item item) {
  //   return ExpansionPanelRadio(
  //     value: item.id!,
  //     backgroundColor: Colors.lightBlueAccent,
  //     canTapOnHeader: true,
  //     headerBuilder: (BuildContext context, bool isExpanded) {
  //       return ListTile(
  //         title: Text(item.name!),
  //         trailing: Checkbox(
  //           onChanged: (value) {},
  //           value: true,
  //         ),
  //         subtitle: Text(item.name!),
  //       );
  //     },
  //     body: ListTile(
  //       title: Text(item.description!),
  //     ),
  //   );
  }
}

class CarrierTerminalSelections extends StatelessWidget {
  const CarrierTerminalSelections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarrierTerminalSelection();
  }
}

// class Item {
//   Item({
//     this.id,
//     this.name,
//     this.description,
//     this.isExpanded = true,
//   });

//   int? id;
//   String? name;
//   String? description;
//   bool? isExpanded;
// }
