import React from "react";
import "./OnboardingMobile.css";

export default function OnboardingMobile({ onGetStarted, onGoogleLogin }) {
  return (
    <div className="onboard-mobile-root">
      <div className="onboard-mobile-gradient" />
      <div className="onboard-mobile-content">
        <div className="onboard-mobile-logo">
          <svg width="68" height="68" viewBox="0 0 68 68" fill="none">
            <circle cx="34" cy="34" r="34" fill="#e0e9ff"/>
            <path d="M29 47L53 34L29 21V31L47 34L29 37V47Z" fill="#59cdff"/>
            <ellipse cx="34" cy="56" rx="10" ry="3" fill="#b0eacf" opacity="0.3"/>
          </svg>
        </div>
        <h1 className="onboard-mobile-headline">Your Focus Engine — <span className="sp-brand">StudyPilot</span></h1>
        <p className="onboard-mobile-subtext">
          Plan smart, stay focused, and conquer NEET, UPSC, SSC, or Boards — all in one app.
        </p>
        <div className="onboard-mobile-illustration">
          <img src={require("../../assets/student-desk-illustration.svg")} alt="Student at desk studying" style={{ width: "100%", maxWidth: 220 }}/>
        </div>
        <button className="onboard-mobile-btn" onClick={onGetStarted}>
          Get Started
        </button>
        <button className="onboard-mobile-google" onClick={onGoogleLogin}>
          <img src="https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg" alt="G" style={{ width: 22, height: 22, marginRight: 10, verticalAlign: "middle" }}/>
          Login with Google
        </button>
      </div>
    </div>
  );
}