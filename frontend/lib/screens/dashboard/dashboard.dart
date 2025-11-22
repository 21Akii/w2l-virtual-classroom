import 'package:flutter/material.dart';
import 'package:watch2learn/screens/teacher/teacher_view.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final ScrollController _upcomingScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B24),
      body: Row(
        children: [
          // ---------------- SIDEBAR -----------------
          Container(
            width: 260,
            decoration: const BoxDecoration(
              color: Color(0xFF070B24),
              border: Border(
                right: BorderSide(color: Color(0xFF0F1439), width: 1),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Attendify",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00E0FF),
                  ),
                ),
                const SizedBox(height: 40),

                _sidebarItem(Icons.dashboard, "Dashboard", true),
                _sidebarItem(Icons.book, "Homework", false),
                _sidebarItem(Icons.video_camera_back, "Upcoming Classes", false),
                _sidebarItem(Icons.bar_chart, "Progress", false),
                _sidebarItem(Icons.check_circle, "Completed Lessons", false),

                const Spacer(),
                _sidebarItem(Icons.settings, "Settings", false),
                const SizedBox(height: 15),
                _sidebarItem(Icons.person, "Younsi Chakib", false),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // ---------------- BODY -----------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ScrollConfiguration(
                behavior: _NoGlow(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome back, Chakib",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // TOP CARDS
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          _statCard("Total Hours Studied", "12", "Hours"),
                          _statCard("Attendance this week", "100%", ""),
                          _statCard("Quizzes passed this week", "02", ""),
                          _statCard("Assignments Completed", "04", ""),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // CURRENT + HOMEWORK + QUICK JOIN
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: _currentSessionCard()),
                          const SizedBox(width: 20),
                          Flexible(child: _homeworkCard()),
                          const SizedBox(width: 20),
                          Flexible(child: _quickJoinCard()),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // UPCOMING SESSION TABLE
                      _scrollableUpcomingSessions(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- SIDEBAR ITEM ----------------
  Widget _sidebarItem(IconData icon, String label, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF1A1F3F) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: active ? Colors.white : Colors.white60),
        title: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.white60,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // ---------------- STAT CARD ----------------
  Widget _statCard(String title, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 200,
      decoration: _cardBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              Text(unit, style: const TextStyle(color: Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- CURRENT SESSION ----------------
  Widget _currentSessionCard() {
    return Container(
      constraints: const BoxConstraints(minHeight: 170),
      padding: const EdgeInsets.all(20),
      decoration: _cardBoxDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Mr. Justin Lipshutz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Text("Mathematics", style: TextStyle(color: Colors.white70)),
                Text("Solving linear equations pt2",
                    style: TextStyle(color: Colors.white70)),
                SizedBox(height: 8),
                Chip(
                  label: Text("Ends in 5 min"),
                  backgroundColor: Color(0xFF1F2A50),
                  labelStyle: TextStyle(color: Colors.white70),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ---------------- HOMEWORK CARD ----------------
  Widget _homeworkCard() {
    return Container(
      constraints: const BoxConstraints(minHeight: 170),
      padding: const EdgeInsets.all(20),
      decoration: _cardBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Homework",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          Text("Mathematics", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 4),
          Text(
            "Worksheet 5: Solving linear Equations",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text("Assigned by Mr. Justin Lipshutz",
              style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  // ---------------- QUICK JOIN ----------------
  Widget _quickJoinCard() {
    return Container(
      constraints: const BoxConstraints(minHeight: 170),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1DE9B6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          "Add a New  Class",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ---------------- UPCOMING SESSIONS ----------------
  Widget _scrollableUpcomingSessions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 330,
      decoration: _cardBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Upcoming sessions",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),

          // ---- HEADER FIXED ----
          Row(
            children: const [
              Expanded(
                flex: 3,
                child: Text("Teacher Name",
                    style: TextStyle(color: Colors.white54)),
              ),
              Expanded(
                flex: 2,
                child: Text("Subject", style: TextStyle(color: Colors.white54)),
              ),
              Expanded(
                flex: 2,
                child: Text("Start In", style: TextStyle(color: Colors.white54)),
              ),
              SizedBox(width: 110),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Scrollbar(
              controller: _upcomingScrollController,
              thumbVisibility: true,
              radius: const Radius.circular(12),
              child: ListView(
                controller: _upcomingScrollController,
                padding: const EdgeInsets.only(right: 20),
                children: [
                  _sessionRow(context, "Younsi Chakib", "English", "Started"),
                  _sessionRow(context, "Younsi Chakib", "English", "01h 26m 20s"),
                  _sessionRow(context, "Meziane Abderahmane", "French", "01d 01h 26m"),
                  _sessionRow(context, "Cherbane Akram", "Algebra", "02d 01h 26m"),
                  _sessionRow(context, "Chakib Younsi", "Science", "03d 05h 26m"),
                  _sessionRow(context, "Abderahmane Meziane", "Physics", "04d 03h 26m"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ONE ROW ----------------
  Widget _sessionRow(
    BuildContext context,
    String teacher,
    String subject,
    String startIn,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                const CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150")),
                const SizedBox(width: 10),
                Text(teacher, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(subject, style: const TextStyle(color: Colors.white70)),
          ),

          Expanded(
            flex: 2,
            child: Text(startIn, style: const TextStyle(color: Colors.white70)),
          ),

          // FIXED BUTTON COLUMN
          SizedBox(
            width: 110,
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F3F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF00E0FF),
                  width: 1.5,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VirtualClassroomScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Join",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- CARD DECORATION ----------------
  BoxDecoration _cardBoxDecoration() {
    return BoxDecoration(
      color: const Color(0xFF111633),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

// ---------------- REMOVE OVERSCROLL GLOW ----------------
class _NoGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
