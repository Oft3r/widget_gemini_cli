import 'package:flutter/material.dart';

class TerminalWidget extends StatelessWidget {
  const TerminalWidget({super.key});

  static const TextStyle _monoStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11,
    fontWeight: FontWeight.bold,
    height: 1.15,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      height: 350,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title Bar
          Container(
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFF2D2D2D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildWindowControl(const Color(0xFFFF5F56)),
                const SizedBox(width: 8),
                _buildWindowControl(const Color(0xFFFFBD2E)),
                const SizedBox(width: 8),
                _buildWindowControl(const Color(0xFF27C93F)),
                const Expanded(
                  child: Center(
                    child: Text(
                      'oft3r@gemini-cli:~',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 52),
              ],
            ),
          ),

          // Terminal Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTerminalContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ASCII Art Header with Gradient
        FittedBox(
          fit: BoxFit.contain,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xFF4796E4),
                  Color(0xFF847ACE),
                  Color(0xFFC3677F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: const Text(
              r'''
 ███            █████████  ██████████ ██████   ██████ █████ ██████   █████ █████
░░░███         ███░░░░░███░░███░░░░░█░░██████ ██████ ░░███ ░░██████ ░░███ ░░███
  ░░░███      ███     ░░░  ░███  █ ░  ░███░█████░███  ░███  ░███░███ ░███  ░███
    ░░░███   ░███          ░██████    ░███░░███ ░███  ░███  ░███░░███░███  ░███
     ███░    ░███    █████ ░███░░█    ░███ ░░░  ░███  ░███  ░███ ░░██████  ░███
   ███░      ░░███  ░░███  ░███ ░   █ ░███      ░███  ░███  ░███  ░░█████  ░███
 ███░         ░░█████████  ██████████ █████     █████ █████ █████  ░░█████ █████
░░░            ░░░░░░░░░  ░░░░░░░░░░ ░░░░░     ░░░░░ ░░░░░ ░░░░░    ░░░░░ ░░░░░
''',
              softWrap: false,
              style: _monoStyle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tips for getting started:',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFE0E0E0),
          ),
        ),
        const Text(
          '1. Ask questions, edit files, or run commands.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFE0E0E0),
          ),
        ),
        const Text(
          '2. Be specific for the best results.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFE0E0E0),
          ),
        ),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFE0E0E0),
            ),
            children: [
              TextSpan(text: '3. '),
              TextSpan(
                text: '/help',
                style: TextStyle(color: Color(0xFFB39DDB)), // Light purple
              ),
              TextSpan(text: ' for more information.'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Terminal Input Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4796E4), width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Text(
                '> ',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFF4796E4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(width: 8, height: 16, color: Colors.white),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'oft3r@gemini:~\$ start',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Footer line
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '~/VibeCode',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF666666),
              ),
            ),
            Text(
              'no sandbox',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFC3677F),
              ),
            ),
            Text(
              'Auto (Gemini 3) /model',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWindowControl(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
