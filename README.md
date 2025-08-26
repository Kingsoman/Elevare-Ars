Elevare Ars 🚀
Elevare Ars is an AI-powered career exploration platform that bridges the gap between education and industry by connecting students with experienced professionals for mentorship, guidance, and hands-on learning opportunities.
🎯 Problem Statement
Students often struggle to understand real-world career paths and lack access to industry insights. Meanwhile, professionals want to give back but don’t have structured ways to mentor the next generation. Elevare Ars solves this disconnect.
✨ Key Features
👩🎓 For Students
- Smart Matching Algorithm – AI-powered matching based on interests, skills, career goals, and learning preferences
- Career Exploration Tools – Interactive career pathway mapping and skills gap analysis
- Virtual Mentorship – In-app video calls, secure messaging, and structured mentorship programs
- Project-Based Learning – Collaborate on real industry projects with mentor guidance
- Skill Portfolio – Build and showcase digital portfolios with verified achievements
- Goal Tracking – Set and monitor career development milestones
👨🏫 For Industry Professionals
- Flexible Mentoring – Choose availability and mentoring style (1-on-1, group sessions, project-based)
- Impact Dashboard – Track mentees’ progress and outcomes
- Company Integration – Corporate mentorship programs and future talent pipeline building
- Knowledge Sharing – Share industry insights, resources, and best practices
- Professional Recognition – Build thought leadership and reputation within the platform

-----------

----


🛠 Platform Features
- Safety First – Verified profiles, moderation, and secure communication
- Analytics & Insights – Career trend analysis and skill demand forecasting
- Multi-Modal Communication – Video, voice, text, and collaborative workspace tools
- Mobile-First Design – Flutter apps for iOS, Android + Web (same codebase)
- Integration Ready – APIs for schools, universities, and corporate systems


---------


👐 Open Source & Free
- Elevare Ars is completely free and open source.
- Community-driven: built by developers, designers, mentors, and students.
- Everyone can use it without cost.
Future enhancements may come, but the core project will remain free and open source.




----------



🚀 How It Works (For Users)
1. Sign Up → Create a free account.
2. Discover Careers → AI suggests paths based on your interests and skills.
3. Skill Roadmap → Get a step-by-step learning plan with recommended resources.
4. Track Progress → Update your learning journey as you learn.
5. Find Mentors → Connect with experienced professionals.
6. Stay Updated → Receive reminders and alerts via FCM.
🛠 Tech Stack
- Frontend & Mobile: Flutter (Riverpod, Clean Architecture)
- Backend: Supabase (Auth, PostgreSQL + RLS, Realtime, Storage, Edge Functions)
- AI: Python microservices (FastAPI/Flask) for career matching, skills gap analysis, recommendations
- Communication: WebRTC (calls), Supabase Realtime (chat), FCM (push notifications)
- Infra: Supabase Cloud + Vercel, Docker for AI services, GitHub Actions (CI/CD)


--------


⚙️ Installation / Setup
1. Clone the repository
   git clone https://github.com/Kingsoman/Elevare-Ars.git
   cd Elevare-Ars

2. Install dependencies
   flutter pub get

3. Setup Supabase
   - Create a new Supabase project.
   - Add your API keys to .env or secure config.
   - Run schema migrations and enable RLS policies.

4. Setup Firebase (for FCM)
   - Create a Firebase project and add Android/iOS/Web apps.
   - Download google-services.json (Android) and GoogleService-Info.plist (iOS).
   - Enable Cloud Messaging (FCM).

5. Run the project
   flutter run



-------------

🗺 Roadmap
- [ ] AI-powered career recommendations
- [ ] Mentor matching system
- [ ] Project-based learning modules
- [ ] Push notifications (via FCM)
- [ ] Skill portfolio and progress dashboard
- [ ] Web + Mobile (Flutter responsive UI)
📛 Badges
Build: passing
License: MIT

-----------


Contributions: welcome
🤝 Contribution
We welcome contributions from developers, designers, mentors, and community members!
🔄 Branch Workflow
- main → Production branch (stable, always deployable)
- develop → Active branch for new features & fixes
📌 Steps to Contribute
1. Fork the repo
2. Clone your fork
   git clone https://github.com/Kingsoman/Elevare-Ars.git
   cd Elevare-Ars

3. Checkout to develop branch
   git checkout develop

4. Create a new feature branch
   git checkout -b feature/your-feature-name

5. Commit & Push your changes
   git add .
   git commit -m "Added [your feature]"
   git push origin feature/your-feature-name

6. Open a Pull Request → Merge into develop
7. Once reviewed, changes will merge into main

-------

👥 Contributors
Thanks goes to these wonderful people who make Elevare Ars possible 💜

-------

📜 License
Elevare Ars is released under the MIT License.


-------



📂 Project Structure
The project follows a modular <strong>feature-first architecture</strong> using Flutter + Riverpod.
lib/
│
├── core/               # Global app config (theme, constants, helpers, widgets)
│   ├── theme/          # Colors, typography, dark/light themes
│   ├── utils/          # Helpers, validators, formatters
│   └── widgets/        # Reusable shared widgets (buttons, inputs, etc.)
│
├── features/           # Independent features (scalable, testable)
│   ├── auth/           # Authentication (login, signup, reset password)
│   ├── profile/        # User profile, settings
│   ├── mentorship/     # Mentor/mentee matching, session booking
│   └── career/         # Career roadmap, AI recommendations
│
├── services/           # External services integration
│   ├── supabase_service.dart  # Supabase (auth, DB, storage)
│   ├── fcm_service.dart       # Firebase push notifications
│   └── resend_service.dart    # Email delivery
│
├── providers/          # Riverpod providers (global state management)
│
├── app.dart            # Root app widget
└── main.dart           # Entry point



---------



🖼 Architecture Overview
flowchart TD
  User[👩🎓 User] -->|UI Events| Flutter[📱 Flutter App]
  Flutter -->|API Calls| Supabase[(🗄 Supabase)]
  Flutter -->|Push Notifications| FCM[📢 Firebase Cloud Messaging]
  Flutter -->|Email| Resend[📧 Resend Service]
  Supabase -->|DB/Auth| Postgres[(🐘 PostgreSQL)]
  Flutter -->|AI Requests| AIService[🤖 AI Microservices]

---------

Running Tests

Before pushing your changes, make sure all tests pass locally:
