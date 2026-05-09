import { BADGE_CLS } from "../config.js";
import { fetchProfData } from "../services/rmpApi.js";
import { buildOverlay, buildLoadingOverlay } from "../ui/overlay.js";
import { appendToPage, positionOverlay } from "../utils/dom.js";

const HOVER_CLOSE_MS = 280;

let globalListenersAttached = false;

export function cancelHoverClose(state) {
  if (state.hoverCloseTimer) {
    clearTimeout(state.hoverCloseTimer);
    state.hoverCloseTimer = null;
  }
}

export function scheduleHoverClose(state) {
  cancelHoverClose(state);
  state.hoverCloseTimer = setTimeout(() => {
    state.hoverCloseTimer = null;
    closeOverlay(state);
  }, HOVER_CLOSE_MS);
}

function wireOverlayHover(overlay, state) {
  overlay.addEventListener("mouseenter", () => cancelHoverClose(state));
  overlay.addEventListener("mouseleave", () => scheduleHoverClose(state));
}

export function closeOverlay(state) {
  cancelHoverClose(state);
  if (state.activeOverlay) {
    state.activeOverlay.remove();
    state.activeOverlay = null;
  }
  state.activeBadge = null;
}

export function repositionActiveOverlay(state) {
  if (state.activeOverlay && state.activeBadge) {
    positionOverlay(state.activeOverlay, state.activeBadge);
  }
}

export async function showPanelForBadge(badge, name, state) {
  if (state.activeOverlay && state.activeBadge !== badge) {
    closeOverlay(state);
  }

  state.activeBadge = badge;

  const loading = buildLoadingOverlay();
  appendToPage(loading);
  positionOverlay(loading, badge);
  state.activeOverlay = loading;
  wireOverlayHover(loading, state);

  const data = await fetchProfData(name);

  if (state.activeBadge !== badge) {
    loading.remove();
    return;
  }

  if (state.activeOverlay === loading) {
    loading.remove();
    const overlay = buildOverlay(data, name);
    appendToPage(overlay);
    positionOverlay(overlay, badge);
    state.activeOverlay = overlay;
    wireOverlayHover(overlay, state);
  }
}

export function attachGlobalOverlayListeners(state) {
  if (globalListenersAttached) return;
  globalListenersAttached = true;

  document.addEventListener("click", (e) => {
    if (
      state.activeOverlay &&
      !state.activeOverlay.contains(e.target) &&
      !e.target.closest("." + BADGE_CLS)
    ) {
      closeOverlay(state);
    }
  });

  window.addEventListener("scroll", () => repositionActiveOverlay(state), true);
  window.addEventListener("resize", () => repositionActiveOverlay(state));
}
