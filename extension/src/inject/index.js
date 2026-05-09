import { createOverlayState } from "../state/overlayState.js";
import { scanPage } from "./scanner.js";
import { attachGlobalOverlayListeners } from "./overlayController.js";

let started = false;

function start(state) {
  if (started) return;
  const root = document.body ?? document.documentElement;
  if (!root) return;

  try {
    attachGlobalOverlayListeners(state);
    scanPage(state);

    new MutationObserver(() => scanPage(state)).observe(root, {
      childList: true,
      subtree: true,
    });
    started = true;
  } catch (err) {
    console.error("[rmp-ext] start failed:", err);
  }
}

function boot() {
  const state = createOverlayState();

  const run = () => requestAnimationFrame(() => start(state));

  if (document.body) {
    run();
  } else {
    document.addEventListener("DOMContentLoaded", run, { once: true });
  }
}

boot();
