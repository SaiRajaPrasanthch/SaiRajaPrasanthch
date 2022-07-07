import 'package:dmggo/arch/commonUI/com_button.dart';
import 'package:dmggo/arch/commonUI/com_sizedboxes.dart';
import 'package:dmggo/arch/models/all_operation_types.dart';
import 'package:dmggo/arch/utils/constants.dart';
import 'package:dmggo/arch/utils/localization/local_borders.dart';
import 'package:dmggo/arch/utils/localization/local_colors.dart';
import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/navigation_routes.dart';
import 'package:dmggo/arch/view_model/carrier_terminal_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrierTerminalSelections extends StatelessWidget {
  const CarrierTerminalSelections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(h_5),
      child: Row(
        children: [Expanded(flex: 2, child: opsType(context: context)), sbh_5w_10, Expanded(flex: 3, child: carrierTerminalContainer(context: context))],
      ),
    );
  }

  Widget opsType({required BuildContext context}) {
    return SizedBox(
      height: h_35,
      child: DropdownButtonFormField(
        onTap: () {},
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: cteal_300,
        ),
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: h_1, horizontal: h_10),
          fillColor: Colors.teal.shade50,
          border: OutlineInputBorder(
            borderRadius: brCir_5,
            borderSide: BorderSide(color: cteal_300, width: h_1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: brCir_5,
            borderSide: BorderSide(color: cteal_300, width: h_1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: brCir_5,
            borderSide: BorderSide(color: cteal_300, width: h_1),
          ),
        ),
        value: context.watch<CarrierTerminalLog>().selectedOpsType,
        style: tscwbsn_14b,
        isExpanded: true,
        items: context
            .watch<CarrierTerminalLog>()
            .listOpsType
            .map((value) => DropdownMenuItem(
                  child: Text(value.displayName!),
                  value: value,
                ))
            .toList(),
        onChanged: (value) => context.read<CarrierTerminalLog>().selectedOpstype(value as AllOperationTypes),
      ),
    );
  }

  Widget carrierTerminalContainer({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        showDialog(barrierDismissible: false, context: context, builder: (_) => AlertCarrierNTerminal());
      },
      child: Container(
        height: h_35,
        decoration: BoxDecoration(color: Colors.teal.shade50, border: Border.all(color: Colors.teal.shade200, width: 1.5), borderRadius: brCir_5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: h_10, right: h_5, top: h_5, bottom: h_5),
              child: SizedBox(
                width: screenWidth! * 0.4,
                child: Text(
                  context.watch<CarrierTerminalLog>().selectedCarrierNTerminal,
                  style: tscwbsn_16b,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(h_5),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.teal.shade300,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AlertCarrierNTerminal extends StatefulWidget {
  const AlertCarrierNTerminal({Key? key}) : super(key: key);

  @override
  State<AlertCarrierNTerminal> createState() => _AlertCarrierNTerminalState();
}

class _AlertCarrierNTerminalState extends State<AlertCarrierNTerminal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Carrier and Terminal',
        style: tscwbsn_14b,
      ),
      content: context.watch<CarrierTerminalLog>().listCarrierNTerminal.isEmpty
          ? Text(
              "Carriers and Terminals are not assigned to ${context.watch<CarrierTerminalLog>().selectedOpsType.displayName} operation",
              style: tscwnsn_16b,
            )
          : carrierNTerminal(context: context),
      actions: [
        if (context.watch<CarrierTerminalLog>().listCarrierNTerminal.isEmpty)
          CommonButton(
            color: cblue_200,
            strBtnText: 'ok',
            dWidth: 100,
            textStyle: tscwnsn_14b,
            onPressed: () {
              exitScreen(context);
            },
          ),
        if (context.watch<CarrierTerminalLog>().listCarrierNTerminal.isNotEmpty)
          CommonButton(
            color: cblue_200,
            strBtnText: 'Close',
            dWidth: 100,
            textStyle: tscwnsn_14b,
            onPressed: () {
              exitScreen(context);
            },
          ),
        if (context.watch<CarrierTerminalLog>().listCarrierNTerminal.isNotEmpty)
          CommonButton(
            color: cblue_200,
            strBtnText: 'Apply',
            dWidth: 100,
            textStyle: tscwnsn_14b,
            onPressed: () {
              exitScreen(context);
              context.read<CarrierTerminalLog>().applyFilter();
            },
          )
      ],
    );
  }

  Widget carrierNTerminal({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            'Select All',
            style: tscwbsn_14b,
          ),
          trailing: Checkbox(
              value: context.watch<CarrierTerminalLog>().selectAll,
              onChanged: (v) {
                context.read<CarrierTerminalLog>().selectAllCarriersNTerminals(v!);
              }),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: h_35,
            maxHeight: h_200,
          ),
          child: SingleChildScrollView(
              child: Column(
            children: context
                .watch<CarrierTerminalLog>()
                .listCarrierNTerminal
                .map((e) => ExpansionTile(
                      initiallyExpanded: false,
                      title: Text("${e.accountName}", style: tscwnsn_14b),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.keyboard_arrow_down_outlined),
                          Checkbox(
                            onChanged: (value) {
                              context.read<CarrierTerminalLog>().carrierSelection(e);
                            },
                            value: e.isCarrierSelected,
                          ),
                        ],
                      ),
                      children: e.terminals != null
                          ? e.terminals!
                              .map((ex) => ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(left: h_10),
                                      child: Text("${ex.terminalCode}", style: tscwnsn_14b),
                                    ),
                                    trailing: Checkbox(
                                      onChanged: (value) {
                                        context.read<CarrierTerminalLog>().terminalSelection(e, ex);
                                      },
                                      value: ex.isTerminalSelected,
                                    ),
                                  ))
                              .toList()
                          : [],
                    ))
                .toList(),
          )),
        ),
      ],
    );
  }
}
