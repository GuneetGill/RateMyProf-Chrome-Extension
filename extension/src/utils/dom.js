/**
 * Position a fixed overlay under a badge (document coordinates).
 */
export function positionOverlay(overlay, badge) {
  const rect = badge.getBoundingClientRect();
  const scrollX = window.scrollX;
  const scrollY = window.scrollY;
  overlay.style.position = "absolute";
  overlay.style.top = rect.bottom + scrollY + 4 + "px";
  overlay.style.left = rect.left + scrollX + "px";
}

/**
 * Append a node when `document.body` may still be null (iframes / early inject).
 */
export function appendToPage(node) {
  const root = document.body ?? document.documentElement;
  root.appendChild(node);
}
