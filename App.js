import React, { useState, useEffect } from "react";
import OnboardingMobile from "./components/Onboarding/OnboardingMobile";
import MobileHome from "./components/Home/MobileHome";
import Pomodoro from "./components/Modules/Pomodoro";
import Planner from "./components/Modules/Planner";
import Notes from "./components/Modules/Notes";
import Reminders from "./components/Modules/Reminders";
import Jokes from "./components/Modules/Jokes";
import ThemeToggle from "./components/ui/ThemeToggle";
import "./index.css";

const MODULES = [
  { comp: Planner, label: "Planner" },
  { comp: Pomodoro, label: "Timer" },
  { comp: Notes, label: "Notes" },
  { comp: Reminders, label: "Analytics" },
  { comp: Jokes, label: "Profile" },
];

export default function App() {
  const [onboarded, setOnboarded] = useState(() =>
    localStorage.getItem("studypilot-onboarded") === "yes"
  );
  const [nav, setNav] = useState(0);

  useEffect(() => {
    if (onboarded) localStorage.setItem("studypilot-onboarded", "yes");
  }, [onboarded]);

  return (
    <div>
      <ThemeToggle />
      {!onboarded ? (
        <OnboardingMobile onGetStarted={() => setOnboarded(true)} onGoogleLogin={() => alert("Google Login coming soon!")}/>
      ) : nav === -1 ? (
        <MobileHome user="Smarajit" navIndex={nav} onNav={setNav} />
      ) : (
        <>
          <div className="sp-app">
            <header className="sp-header">
              <span>📚 StudyPilot</span>
            </header>
            <main className="sp-main">
              {nav === 0 && <Planner />}
              {nav === 1 && <Pomodoro />}
              {nav === 2 && <Notes />}
              {nav === 3 && <Reminders />}
              {nav === 4 && <Jokes />}
            </main>
          </div>
          <MobileHome user="Smarajit" navIndex={nav} onNav={setNav} />
        </>
      )}
    </div>
  );
}