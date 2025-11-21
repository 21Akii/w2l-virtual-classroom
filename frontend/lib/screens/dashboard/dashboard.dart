import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2B),
      body: Row(
        children: [
          // ---------------- SIDEBAR -----------------
          Container(
            width: 260,
            color: const Color(0xFF0D1137),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text("Watch2Learn",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 40),

                _sidebarItem(Icons.dashboard, "Dashboard"),
                _sidebarItem(Icons.book, "Homework"),
                _sidebarItem(Icons.video_camera_back, "Upcoming Classes"),
                _sidebarItem(Icons.bar_chart, "Progress"),
                _sidebarItem(Icons.check_circle, "Completed Lessons"),
                const Spacer(),
                _sidebarItem(Icons.settings, "Settings"),
                const SizedBox(height: 20),
                _sidebarItem(Icons.person, "John Carter"),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // ---------------- BODY -----------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome back, John",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),

                    const SizedBox(height: 30),

                    // TOP STAT CARDS
                    Row(
                      children: [
                        _statCard("Total Hours Studied", "12", "Hours"),
                        _statCard("Attendance this week", "100%", ""),
                        _statCard("Quizzes passed this week", "02", ""),
                        _statCard("Assignments Completed", "04", ""),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // CURRENT SESSION + HOMEWORK
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _currentSessionCard(),
                        const SizedBox(width: 20),
                        _homeworkCard(),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // UPCOMING SESSIONS TABLE
                    _upcomingSessionsTable(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- WIDGETS ----------------

  Widget _sidebarItem(IconData icon, String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(label, style: const TextStyle(color: Colors.white)),
        hoverColor: Colors.white12,
      ),
    );
  }

  Widget _statCard(String title, String value, String unit) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(20),
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF111633),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(width: 5),
              Text(unit, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _currentSessionCard() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF111633),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=12"),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Mr. Justin Lipshutz",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text("Mathematics",
                    style: TextStyle(color: Colors.white70)),
                Text("Solving linear equations pt2",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeworkCard() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF111633),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Homework",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Text("Mathematics",
                style: TextStyle(color: Colors.white70)),
            Text("Worksheet 5: Solving linear equations",
                style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            Text("Assigned by Mr. Justin Lipshutz",
                style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }

  Widget _upcomingSessionsTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111633),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Upcoming sessions",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 20),

          // TABLE HEADER
          Row(
            children: const [
              Expanded(
                  flex: 3,
                  child: Text("Teacher Name",
                      style: TextStyle(color: Colors.white70))),
              Expanded(
                  flex: 2,
                  child: Text("Subject",
                      style: TextStyle(color: Colors.white70))),
              Expanded(
                  child: Text("Start in",
                      style: TextStyle(color: Colors.white70))),
            ],
          ),

          const SizedBox(height: 10),

          // ROW 1
          _sessionRow("Justin Lipshutz", "English", "01h 26m"),
          _sessionRow("Marcus Culhane", "French", "01d 01h"),
          _sessionRow("Leo Stanton", "Algebra", "02d 01h"),
        ],
      ),
    );
  }

  Widget _sessionRow(String teacher, String subject, String startIn) {
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
              child: Text(subject, style: const TextStyle(color: Colors.white70))),
          Expanded(
              child: Text(startIn, style: const TextStyle(color: Colors.white70))),
        ],
      ),
    );
  }
}
