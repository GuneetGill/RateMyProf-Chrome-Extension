import { norm, isSkippable } from "../utils/strings.js";
import { createBadgeEl } from "../ui/badge.js";
import {
  showPanelForBadge,
  repositionActiveOverlay,
  cancelHoverClose,
  scheduleHoverClose,
} from "./overlayController.js";

const INJECTED = "data-rmp-injected";

const INSTRUCTOR_SELECTORS = [
  'div[title="Instructor(s)"]',
  'div[title="Instructor"]',
];

export function firstInstructorDivPerTbody() {
  const chosen = new Map();

  for (const sel of INSTRUCTOR_SELECTORS) {
    for (const div of document.querySelectorAll(sel)) {
      const tbody = div.closest("tbody");
      if (!tbody || chosen.has(tbody)) continue;

      const name = norm(div.textContent);
      if (!isSkippable(name)) chosen.set(tbody, div);
    }
  }

  return chosen;
}

export function injectBadge(instructorEl, state) {
  if (instructorEl.hasAttribute(INJECTED)) return;

  const name = norm(instructorEl.textContent);
  if (isSkippable(name)) return;

  instructorEl.setAttribute(INJECTED, "1");

  const badge = createBadgeEl(name, state);

  badge.addEventListener("mouseenter", () => {
    cancelHoverClose(state);
    if (state.activeBadge === badge && state.activeOverlay) {
      repositionActiveOverlay(state);
      return;
    }
    void showPanelForBadge(badge, name, state);
  });

  badge.addEventListener("mouseleave", () => scheduleHoverClose(state));

  badge.addEventListener("click", (e) => {
    e.preventDefault();
    e.stopPropagation();
  });

  instructorEl.appendChild(document.createTextNode(" "));
  instructorEl.appendChild(badge);
}

export function scanPage(state) {
  for (const el of firstInstructorDivPerTbody().values()) {
    injectBadge(el, state);
  }
}
