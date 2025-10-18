import 'package:elevare_ars/core/global%20providers/supabase_providers.dart';
import 'package:elevare_ars/core/widgets/menu/mentor_menucard.dart';
import 'package:elevare_ars/core/widgets/menu/student_menucard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.read(currentUserMetaDataRoleProvider);
    return userRole == 'student'
        ? StudentMenuCard()
        : userRole == 'mentor'
        ? MentorMenuCard()
        : const SizedBox.shrink();
  }
}
