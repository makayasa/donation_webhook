import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:saweria_webhook/app/components/default_button.dart';
import 'package:saweria_webhook/app/components/default_text.dart';
import 'package:saweria_webhook/app/utils/constant.dart';

import '../controllers/create_webhook_command_controller.dart';

class CreateWebhookCommandView extends GetResponsiveView<CreateWebhookCommandController> {
  CreateWebhookCommandView({Key? key})
      : super(
          key: key,
          settings: kScreenChangePoint,
          alwaysUseBuilder: false,
        );
  @override
  Widget builder() {
    Get.put(CreateWebhookCommandController());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: Get.mediaQuery.size.width * 0.5,
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefText('Name').large,
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DefText('Type').large,
              FormBuilderDropdown(
                name: 'type',
                items: controller.types
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Container(
                          child: DefText(e).normal,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              DefText('Input').large,
              const SizedBox(height: 10),
              DefText('test').normal,
              DefaultButton(
                color: kSecondaryColor,
                showBorder: true,
                borderColor: kThirdColor,
                child: DefText('Add timer').normal,
                onTap: () {},
              ),
              Container(
                height: 150,
                child: GetX<CreateWebhookCommandController>(
                  init: CreateWebhookCommandController(),
                  builder: (_) {
                    return ReorderableListView.builder(
                      itemCount: controller.test.length,
                      onReorder: (oldIndex, newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = controller.test.removeAt(oldIndex);
                        controller.test.insert(newIndex, item);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          key: Key('$index'),
                          child: DefText(controller.test[index]).large,
                        );
                      },
                    );
                    // return ListView.builder(
                    //   scrollDirection: Axis.horizontal,
                    //   shrinkWrap: true,
                    //   itemCount: controller.test.length,
                    //   itemBuilder: (context, index) {
                    //     return Container(
                    //       child: DefText(
                    //         controller.test[index],
                    //       ).extraLarge,
                    //     );
                    //   },
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
