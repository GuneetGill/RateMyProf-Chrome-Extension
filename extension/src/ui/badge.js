import { BADGE_SPEECH } from "../config.js";

export function createBadgeEl(name, state) {
  const wrap = document.createElement("span");
  wrap.className = BADGE_SPEECH ? "rmp-wrap" : "rmp-wrap-default";
  wrap.title = `RateMyProfessors: ${name}`;
  wrap.setAttribute("data-prof-name", name);

  if (!BADGE_SPEECH) {
    const btn = document.createElement("button");
    btn.type = "button";
    btn.className = "rmp-btn-default";
    btn.textContent = "RMP";
    wrap.appendChild(btn);
    return wrap;
  }

  const bubble = document.createElement("span");
  bubble.className = "rmp-speech-bubble";

  const gradId = `rmp-redGradient-${++state.rmpGradSeq}`;
  const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute("class", "rmp-speech-bg");
  svg.setAttribute("viewBox", "0 0 54 48");
  svg.setAttribute("xmlns", "http://www.w3.org/2000/svg");
  svg.setAttribute("preserveAspectRatio", "none");
  svg.innerHTML = `
    <defs>
      <linearGradient id="${gradId}" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#ff4a3d" />
        <stop offset="55%" stop-color="#e63027" />
        <stop offset="100%" stop-color="#a8141b" />
      </linearGradient>
    </defs>
    <path
      d="M 8,2 L 46,2 Q 52,2 52,8 L 52,30 Q 52,36 46,36 L 18,36 L 8,46 L 12,36 L 8,36 Q 2,36 2,30 L 2,8 Q 2,2 8,2 Z"
      fill="url(#${gradId})"
      stroke="#0a0a0a"
      stroke-width="2.5"
      stroke-linejoin="round"
    />`;

  const btn = document.createElement("button");
  btn.type = "button";
  btn.className = "rmp-btn";
  btn.textContent = "RMP";

  bubble.appendChild(svg);
  bubble.appendChild(btn);
  wrap.appendChild(bubble);

  return wrap;
}
