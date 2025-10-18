import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:elevare_ars/core/global%20providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/get_started_provider.dart';

class BasicInfoStep extends ConsumerStatefulWidget {
  const BasicInfoStep({super.key});

  @override
  ConsumerState<BasicInfoStep> createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends ConsumerState<BasicInfoStep> {
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(getStartedProvider);
    _bioController = TextEditingController(text: state.bio);
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getStartedProvider);
    final notifier = ref.read(getStartedProvider.notifier);

    final colorScheme = ref.read(colorSchemeProvider);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell Us About Yourself',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 32),

          // Country Picker
          Text(
            'Country *',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: CSCPickerPlus(
                showStates: false,
                showCities: false,
                flagState: CountryFlag.ENABLE,
                defaultCountry: state.country.isNotEmpty
                    ? CscCountry.values.firstWhere(
                        (e) => e.name == state.country,
                        orElse: () => CscCountry.United_Kingdom,
                      )
                    : CscCountry.United_Kingdom,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                dropdownDialogRadius: 12,
                dropdownHeadingStyle: theme.textTheme.titleMedium!,
                dropdownItemStyle: theme.textTheme.bodyMedium!,
                disabledDropdownDecoration: BoxDecoration(
                  color: theme.disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                onCountryChanged: (country) {
                  if (country.isNotEmpty) notifier.updateCountry(country);
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Short Bio
          Text(
            'Short Bio (Optional)',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _bioController,
            onChanged: notifier.updateBio,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Tell us a little about yourself and your goals...',
              alignLabelWithHint: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Icon(Icons.edit_note),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
