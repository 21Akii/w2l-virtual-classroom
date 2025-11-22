import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:watch2learn/screens/teacher/white_boared.dart';

class VirtualClassroomScreen extends StatefulWidget {
  const VirtualClassroomScreen({super.key});

  @override
  State<VirtualClassroomScreen> createState() => _VirtualClassroomScreenState();
}

class _VirtualClassroomScreenState extends State<VirtualClassroomScreen> {
  bool showChat = true;
  bool showWhiteboard = true;

  bool showWarning = false; // <-- distraction popup

  CameraController? _cameraController;
  bool _cameraReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();

    // --- DEMO: trigger distraction popup after 5 seconds ---
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) setState(() => showWarning = true);
    });
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      setState(() => _cameraReady = true);
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B24),

      body: Row(
        children: [

          // --------------------------------------------------------------
          // MAIN AREA (VIDEO STREAM + WHITEBOARD + CONTROLS)
          // --------------------------------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  // ======================================================
                  // MAIN COLUMN
                  // ======================================================
                  Column(
                    children: [

                      // ----------------------------------------------------------
                      // CAMERA STREAM + VIEWER COUNTER
                      // ----------------------------------------------------------
                      Expanded(
                        flex: showWhiteboard ? 3 : 6,
                        child: Container(
                          width: double.infinity,
                          decoration: _cardBox(),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: _cameraReady
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CameraPreview(_cameraController!),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: Color(0xFF00E0FF),
                                        ),
                                      ),
                              ),

                              // Viewer counter
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha:0.45),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF00E0FF),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.remove_red_eye,
                                          size: 18,
                                          color: Color(0xFF00E0FF)),
                                      SizedBox(width: 6),
                                      Text(
                                        "5000 viewers",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (showWhiteboard) const SizedBox(height: 20),

                      // ----------------------------------------------------------
                      // WHITEBOARD (Animated)
                      // ----------------------------------------------------------
                      Expanded(
                        flex: showWhiteboard ? 3 : 0,
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: showWhiteboard
                              ? Container(
                                  decoration: _cardBox(),
                                  child: const ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    child: Whiteboard(),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ----------------------------------------------------------
                      // CONTROLS BAR
                      // ----------------------------------------------------------
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1A3A),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF00E0FF)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _control(Icons.mic_off, "Mic"),
                            _control(Icons.videocam, "Camera"),

                            // Toggle Whiteboard
                            GestureDetector(
                              onTap: () {
                                setState(() => showWhiteboard = !showWhiteboard);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: const Color(0xFF111633),
                                    child: Icon(
                                      showWhiteboard
                                          ? Icons.dashboard
                                          : Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    showWhiteboard
                                        ? "Hide Board"
                                        : "Whiteboard",
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),

                            _control(Icons.call_end, "Leave"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // ======================================================
                  // DISTRACTION WARNING POPUP
                  // ======================================================
                  if (showWarning)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha:0.6), // blur overlay
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 1500),
                            opacity: showWarning ? 1 : 0,
                            child: Container(
                              width: 420,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D1A3A),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color(0xFF00E0FF), width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha:0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.warning_amber_rounded,
                                      color: Color(0xFFFFD541), size: 40),
                                  const SizedBox(height: 12),

                                  const Text(
                                    "⚠ Stay Focused",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  const Text(
                                    "It seems you're distracted.\nPlease pay attention to the lesson.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 15),
                                  ),

                                  const SizedBox(height: 20),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFF00E0FF),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() => showWarning = false);
                                    },
                                    child: const Text(
                                      "I'm focused",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // --------------------------------------------------------------
          // CHAT PANEL (COLLAPSIBLE)
          // --------------------------------------------------------------
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: showChat ? 280 : 60,
            color: const Color(0xFF03132E),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      showChat ? Icons.chevron_right : Icons.chevron_left,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() => showChat = !showChat);
                    },
                  ),
                ),

                if (showChat) ...[
                  const Text(
                    "Class Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView(
                      children: [
                        _chatBubble("Teacher", "Welcome everyone! If you have any questions during the lesson, feel free to ask. Don’t worry — our smart assistant will group similar questions together, so even with thousands of students, I’ll be able to answer everything clearly."),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFF111633),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF00E0FF)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Type message...",
                              hintStyle: TextStyle(color: Colors.white38),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.send,
                          color: Color(0xFF00E0FF), size: 28),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------
  // HELPERS
  // --------------------------------------------------------------

  Widget _control(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFF111633),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(text,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _chatBubble(String sender, String message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111633),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF00E0FF), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sender,
              style: const TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(message, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  BoxDecoration _cardBox() {
    return BoxDecoration(
      color: const Color(0xFF111633),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF00E0FF)),
    );
  }
}
