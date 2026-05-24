import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/create_post/bloc/create_post_bloc.dart';
import 'package:social_media/features/create_post/bloc/create_post_state.dart';

class AudienceScreen extends StatefulWidget {
  const AudienceScreen({super.key});

  @override
  State<AudienceScreen> createState() => _AudienceScreenState();
}

class _AudienceScreenState extends State<AudienceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePostBloc, CreatePostState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0F),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0A0A0F),
            elevation: 0,
            leading: const BackButton(color: Colors.white),
            centerTitle: true,
            title: const Text('Audience', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Section label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Who can see your post',
                  style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.2),
                ),
              ),

              const SizedBox(height: 8),

              // Public option
              _AudienceOption(
                icon: Icons.public,
                title: 'Public',
                subtitle: '',
                subtitleColor: Colors.white.withOpacity(0.55),
                isSelected: state.visibility == "Public",
                onTap: () => setState(() => context.read<CreatePostBloc>().add(UpdateVisibility("Public"))),
              ),

              // Divider between options
              Divider(color: Colors.white.withOpacity(0.08), height: 1, indent: 64, endIndent: 0),

              //  Friends option
              _AudienceOption(
                icon: Icons.people_outline,
                title: 'Friends',
                subtitle: '35 people',
                subtitleColor: const Color(0xFF4A90E2),
                subtitleSuffix: ' ›',
                isSelected: state.visibility == "Friends",
                onTap: () => setState(() => context.read<CreatePostBloc>().add(UpdateVisibility("Friends"))),
              ),

              // only me
              _AudienceOption(
                icon: Icons.lock_outline,
                title: 'Only Me',
                subtitle: '',
                subtitleColor: const Color(0xFF4A90E2),
                subtitleSuffix: ' ',
                isSelected: state.visibility == "Only Me",
                onTap: () => setState(() => context.read<CreatePostBloc>().add(UpdateVisibility("Only Me"))),
              ),
              // Disclaimer text
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Text(
                  "This doesn't affect your account privacy, which is private, or "
                  "change any sharing preference.",
                  style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 12.5, height: 1.45),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A single selectable row in the audience list.
class _AudienceOption extends StatelessWidget {
  const _AudienceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.subtitleColor,
    required this.isSelected,
    required this.onTap,
    this.subtitleSuffix = '',
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color subtitleColor;
  final String subtitleSuffix;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white10,
      highlightColor: Colors.white.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Leading icon
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 20),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: subtitle, style: TextStyle(color: subtitleColor, fontSize: 13)),
                        if (subtitleSuffix.isNotEmpty) TextSpan(text: subtitleSuffix, style: TextStyle(color: subtitleColor, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Radio button
            _RadioCircle(selected: isSelected),
          ],
        ),
      ),
    );
  }
}

/// Custom radio indicator matching the screenshot style.
class _RadioCircle extends StatelessWidget {
  const _RadioCircle({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: selected ? Colors.white : Colors.white.withOpacity(0.35), width: 2),
      ),
      child:
          selected
              ? Center(child: Container(width: 12, height: 12, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)))
              : null,
    );
  }
}
