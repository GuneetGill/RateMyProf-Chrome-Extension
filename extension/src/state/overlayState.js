/**
 * Fresh state object for one content-script run (badge + panel coordination).
 */
export function createOverlayState() {
  return {
    activeOverlay: null,
    activeBadge: null,
    hoverCloseTimer: null,
    rmpGradSeq: 0,
  };
}
