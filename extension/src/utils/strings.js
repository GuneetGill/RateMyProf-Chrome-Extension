export function norm(text) {
  return (text || "").replace(/\s+/g, " ").trim();
}

export function escHtml(str) {
  return String(str || "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

export function isSkippable(name) {
  const l = (name || "").toLowerCase();
  return !name || ["tba", "tbd", "staff", "—", "-"].includes(l);
}
