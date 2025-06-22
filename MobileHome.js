import React from "react";
import "./MobileHome.css";

// Dummy data for illustration
const tasks = [
  { id: 1, text: "Revise Biology Ch.5", done: false },
  { id: 2, text: "Solve 2 mock papers", done: false },
  { id: 3, text: "Chemistry notes flashcards", done: true },
];
const quote = "Success is the sum of small efforts, repeated day in and day out.";
const streak = 5;
const studyMinutes = 165; // 2h 45m

export default function MobileHome({ user = "Smarajit", onNav, navIndex = 0 }) {
  const navItems = [
    { icon: "🗓️", label: "Planner" },
    { icon: "⏱", label: "Timer" },
    { icon: "📝", label: "Notes" },
    { icon: "📊", label: "Analytics" },
    { icon: "👤", label: "Profile" },
  ];
  const week = [30, 60, 45, 80, 50, 90, 70];
  const subjects = [
    { color: "#a684fa", label: "Bio", value: 120 },
    { color: "#5bd8c2", label: "Chem", value: 80 },
    { color: "#6db6fc", label: "Math", value: 45 },
  ];
  const total = subjects.reduce((a, s) => a + s.value, 0);

  return (
    <div className="mh-root">
      <section className="mh-top">
        <div>
          <div className="mh-greet">Hi {user} <span className="wave">👋</span></div>
          <div className="mh-subtext">Stay focused, stay consistent.</div>
        </div>
        <div className="mh-streak">
          <span role="img" aria-label="streak" className="mh-streak-emoji">🔥</span>
          <span className="mh-streak-count">{streak}-Day Streak</span>
        </div>
      </section>
      <section className="mh-middle">
        <div className="mh-card mh-tasks">
          <div className="mh-card-title">Today’s Tasks</div>
          <ul>
            {tasks.map(t => (
              <li key={t.id} className={t.done ? "done" : ""}>
                <label>
                  <input type="checkbox" checked={t.done} readOnly />
                  <span>{t.text}</span>
                </label>
              </li>
            ))}
          </ul>
        </div>
        <div className="mh-cards-row">
          <div className="mh-card mh-study">
            <div className="mh-card-title">Study Timer</div>
            <div className="mh-timer">
              ⏱ You studied <b>{Math.floor(studyMinutes/60)}h {studyMinutes%60}m</b> today
            </div>
          </div>
          <div className="mh-card mh-quote">
            <div className="mh-card-title">Quote of the Day</div>
            <div className="mh-quote-text">“{quote}”</div>
          </div>
        </div>
      </section>
      <section className="mh-bottom">
        <div className="mh-card mh-weekly">
          <div className="mh-card-title">Weekly Progress</div>
          <div className="mh-bar-chart">
            {week.map((v, i) => (
              <div key={i} className="mh-bar" style={{
                height: `${v}px`,
                background: "linear-gradient(135deg, #a684fa, #5bd8c2)",
              }}>
                <span className="mh-bar-label"></span>
              </div>
            ))}
          </div>
          <div className="mh-bar-days">
            {["M","T","W","T","F","S","S"].map((d,i) => <span key={i}>{d}</span>)}
          </div>
        </div>
        <div className="mh-card mh-pie">
          <div className="mh-card-title">Subject-wise</div>
          <div className="mh-pie-chart">
            <svg width="62" height="62" viewBox="0 0 62 62">
              {(() => {
                let acc = 0, elems = [];
                subjects.forEach((s, i) => {
                  const val = s.value/total * 100;
                  elems.push(
                    <circle
                      key={s.label}
                      r="25"
                      cx="31"
                      cy="31"
                      fill="transparent"
                      stroke={s.color}
                      strokeWidth="10"
                      strokeDasharray={`${val} ${100-val}`}
                      strokeDashoffset={-acc}
                      style={{transition: "stroke-dashoffset 0.5s"}}
                    />
                  );
                  acc -= val;
                });
                return elems;
              })()}
            </svg>
            <div className="mh-pie-legend">
              {subjects.map(s => (
                <span key={s.label}><span style={{background:s.color}}></span>{s.label}</span>
              ))}
            </div>
          </div>
        </div>
      </section>
      <nav className="mh-nav">
        {navItems.map((item, i) => (
          <button
            key={item.label}
            className={navIndex === i ? "active" : ""}
            onClick={() => onNav && onNav(i)}
            aria-label={item.label}
            tabIndex={0}
          >
            <span className="mh-nav-icon">{item.icon}</span>
            <span className="mh-nav-label">{item.label}</span>
            {navIndex === i && <span className="mh-nav-underline"></span>}
          </button>
        ))}
      </nav>
    </div>
  );
}