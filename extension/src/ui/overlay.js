import { escHtml } from "../utils/strings.js";

export function buildOverlay(data, name) {
  const el = document.createElement("div");
  el.className = "rmp-overlay";

  if (!data) {
    el.innerHTML = `
      <div class="rmp-ov-not-found">
        No RateMyProfessors listing found<br>for <strong>${escHtml(name)}</strong>.
      </div>`;
    return el;
  }

  const diffPct = Math.round((data.difficulty / 5) * 100);
  const againPct = Math.round(data.wouldTakeAgain);

  const tagsHtml = (data.tags || [])
    .map((t) => `<span class="rmp-ov-tag">${escHtml(t)}</span>`)
    .join("");

  const reviewHtml = data.topReview
    ? `
    <div class="rmp-ov-review">
      <div class="rmp-ov-review-meta">
        <span class="rmp-ov-review-course">${escHtml(data.topReview.course)}</span>
        <span class="rmp-ov-review-term">${escHtml(data.topReview.term)}</span>
      </div>
      <div class="rmp-ov-review-text">${escHtml(data.topReview.text)}</div>
    </div>`
    : "";

  el.innerHTML = `
    <div class="rmp-ov-header">
      <div>
        <div class="rmp-ov-name">${escHtml(data.name || name)}</div>
        <div class="rmp-ov-dept">${escHtml(data.department || "")}${data.school ? " · " + escHtml(data.school) : ""}</div>
      </div>
      <div class="rmp-ov-score">
        <span class="rmp-ov-score-num">${Number(data.rating).toFixed(1)}</span>
        <span class="rmp-ov-score-label">/ 5.0</span>
      </div>
    </div>

    <hr class="rmp-ov-divider">

    <div class="rmp-ov-stat">
      <div class="rmp-ov-stat-row">
        <span class="rmp-ov-stat-name">Difficulty</span>
        <span class="rmp-ov-stat-val">${Number(data.difficulty).toFixed(1)} / 5.0</span>
      </div>
      <div class="rmp-ov-bar-track">
        <div class="rmp-ov-bar-fill" style="width:${diffPct}%"></div>
      </div>
    </div>

    <div class="rmp-ov-stat">
      <div class="rmp-ov-stat-row">
        <span class="rmp-ov-stat-name">Would take again</span>
        <span class="rmp-ov-stat-val">${againPct}%</span>
      </div>
      <div class="rmp-ov-bar-track">
        <div class="rmp-ov-bar-fill" style="width:${againPct}%"></div>
      </div>
    </div>

    ${tagsHtml ? `<div class="rmp-ov-tags">${tagsHtml}</div>` : ""}
    ${reviewHtml}

    <div class="rmp-ov-footer">
      <span class="rmp-ov-count">${data.numRatings || 0} review${(data.numRatings || 0) === 1 ? "" : "s"}</span>
      ${data.rmpUrl ? `<a class="rmp-ov-link" href="${escHtml(data.rmpUrl)}" target="_blank" rel="noopener">View on RMP ↗</a>` : ""}
    </div>`;

  return el;
}

export function buildLoadingOverlay() {
  const el = document.createElement("div");
  el.className = "rmp-overlay";
  el.innerHTML = `
    <div class="rmp-ov-loading">
      <span class="rmp-ov-spinner"></span> Loading…
    </div>`;
  return el;
}
