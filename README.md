<h2>#Elevare Ars</h2>

![Flutter CI](https://github.com/Kingsoman/Elevare-Ars/actions/workflows/flutter-ci.yml/badge.svg)

<p><strong>Elevare Ars</strong> is an open-source AI-powered career guidance and mentorship platform. Our mission is to help students, graduates, and professionals discover career paths, acquire in-demand skills, and connect with mentors who can guide them to success.</p>

<p>
  <a href="https://github.com/Kingsoman/Elevare-Ars/stargazers">
    <img alt="GitHub Stars" src="https://img.shields.io/github/stars/Kingsoman/Elevare-Ars?style=social">
  </a>
  <a href="https://github.com/Kingsoman/Elevare-Ars/network/members">
    <img alt="GitHub Forks" src="https://img.shields.io/github/forks/Kingsoman/Elevare-Ars?style=social">
  </a>
  <a href="https://github.com/Kingsoman/Elevare-Ars/issues">
    <img alt="GitHub Issues" src="https://img.shields.io/github/issues/Kingsoman/Elevare-Ars">
  </a>
  <a href="https://github.com/Kingsoman/Elevare-Ars/pulls">
    <img alt="GitHub Pull Requests" src="https://img.shields.io/github/issues-pr/Kingsoman/Elevare-Ars">
  </a>
  <a href="LICENSE">
    <img alt="License" src="https://img.shields.io/github/license/Kingsoman/Elevare-Ars">
  </a>
</p>

<hr/>

<h2>✨ Key Features</h2>
<ul>
  <li>AI-powered career suggestions</li>
  <li>Personalized skill roadmap with curated resources</li>
  <li>Profile &amp; progress tracking</li>
  <li>Mentorship browsing &amp; connections</li>
  <li><strong>Push Notifications (via Firebase Cloud Messaging)</strong></li>
  <li>Web + Mobile (Flutter + Responsive Web)</li>
</ul>

<hr/>

<h2>👐 Open Source &amp; Free</h2>
<ul>
  <li>Elevare Ars is completely free and open source.</li>
  <li>Community-driven: built by developers, designers, mentors, and students.</li>
  <li>Everyone can use it without cost.</li>
</ul>
<p><em>Future enhancements may come, but the core project will remain free and open source.</em></p>

<hr/>

<h2>🏞 Demo / Screenshots</h2>
<p align="center">
  <img src="screenshots/homepage.png" width="800" alt="Homepage Screenshot Placeholder"/>
</p>
<p align="center">
  <img src="screenshots/mobile_home.png" width="300" alt="Mobile Screenshot Placeholder"/>
  <img src="screenshots/tablet_home.png" width="500" alt="Tablet Screenshot Placeholder"/>
</p>

<hr/>

<h2>🚀 How It Works (For Users)</h2>
<ol>
  <li><strong>Sign Up</strong> &rarr; Create a free account.</li>
  <li><strong>Discover Careers</strong> &rarr; AI suggests paths based on your interests and skills.</li>
  <li><strong>Skill Roadmap</strong> &rarr; Get a step-by-step learning plan with recommended resources.</li>
  <li><strong>Track Progress</strong> &rarr; Update your learning journey as you learn.</li>
  <li><strong>Find Mentors</strong> &rarr; Connect with experienced professionals.</li>
  <li><strong>Stay Updated</strong> &rarr; Receive reminders and alerts via FCM.</li>
</ol>

<hr/>

<h2>🛠 Tech Stack</h2>
<ul>
  <li><strong>Frontend &amp; Mobile:</strong> Flutter (iOS, Android, Web)</li>
  <li><strong>Backend:</strong> Supabase (Auth, Database, Storage, Edge Functions)</li>
  <li><strong>AI:</strong> OpenAI / HuggingFace (career insights &amp; embeddings)</li>
  <li><strong>Notifications:</strong> Firebase Cloud Messaging (FCM)</li>
  <li><strong>Hosting:</strong> GitHub Pages or Vercel (for Flutter Web), Supabase (backend)</li>
</ul>

<hr/>

<h2>⚙️ Installation / Setup</h2>
<ol>
  <li><strong>Clone the repository</strong>
    <pre><code>git clone https://github.com/Kingsoman/Elevare-Ars.git
cd Elevare-Ars</code></pre>
  </li>
  <li><strong>Install dependencies</strong>
    <pre><code>flutter pub get</code></pre>
  </li>
  <li><strong>Setup Supabase</strong>
    <ul>
      <li>Create a new Supabase project.</li>
      <li>Add your API keys to a <code>.env</code> or your secure config.</li>
      <li>Run SQL schema and enable RLS policies as needed.</li>
    </ul>
  </li>
  <li><strong>Setup Firebase (for FCM)</strong>
    <ul>
      <li>Create a Firebase project and add Android/iOS/Web apps.</li>
      <li>Download <code>google-services.json</code> (Android) and <code>GoogleService-Info.plist</code> (iOS) to the correct folders.</li>
      <li>Enable Cloud Messaging (FCM).</li>
    </ul>
  </li>
  <li><strong>Run the project</strong>
    <pre><code>flutter run</code></pre>
  </li>
</ol>

<hr/>

<h2>🗺 Roadmap</h2>
<ul>
  <li>[ ] AI-powered career recommendations</li>
  <li>[ ] Skill roadmap + curated resources</li>
  <li>[ ] Mentor matching system</li>
  <li>[ ] Push notifications (via FCM)</li>
  <li>[ ] Profile tracking and progress dashboard</li>
  <li>[ ] Web + Mobile (Flutter responsive UI)</li>
</ul>

<hr/>

<h2>📛 Badges</h2>
<p>
  <img alt="Build" src="https://img.shields.io/badge/build-passing-brightgreen">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-blue">
  <img alt="Contributions" src="https://img.shields.io/badge/contributions-welcome-orange">
</p>

<hr/>

<h2>🤝 Contribution</h2>
<p>We welcome contributions from developers, designers, mentors, and community members!</p>

<h3>🔄 Branch Workflow</h3>
<ul>
  <li><strong>main</strong> &rarr; Production branch (stable, clean, always deployable)</li>
  <li><strong>develop</strong> &rarr; Contribution branch (all new features &amp; fixes go here first)</li>
</ul>

<h3>📌 Steps to Contribute</h3>
<ol>
  <li>Fork the repo</li>
  <li>Clone your fork
    <ul>
      <li><code>git clone https://github.com/Kingsoman/Elevare-Ars.git</code></li>
      <li><code>cd Elevare-Ars</code></li>
    </ul>
  </li>
  <li>Checkout to develop branch
    <ul>
      <li><code>git checkout develop</code></li>
    </ul>
  </li>
  <li>Create a new feature branch
    <ul>
      <li><code>git checkout -b feature/your-feature-name</code></li>
    </ul>
  </li>
  <li>Commit &amp; Push your changes
    <ul>
      <li><code>git add .</code></li>
      <li><code>git commit -m "Added [your feature]"</code></li>
      <li><code>git push origin feature/your-feature-name</code></li>
    </ul>
  </li>
  <li>Open a Pull Request &rarr; Merge into <strong>develop</strong></li>
  <li>Once reviewed &amp; tested, changes will be merged into <strong>main</strong></li>
</ol>

<hr/>

<h2>👥 Contributors</h2>
<p>Thanks goes to these wonderful people who make Elevare Ars possible 💜</p>
<p>
  <a href="https://github.com/Kingsoman/Elevare-Ars/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Kingsoman/Elevare-Ars" alt="Contributors"/>
  </a>
</p>

<hr/>

<h2>📜 License</h2>
<p>Elevare Ars is released under the <strong>MIT License</strong>.</p>