This folder is build output only — do not edit inject_overlay.js or overlay.css.

They are generated from ../src/ (JS bundle + merged CSS). Same idea as node_modules: auto-built, not source.

Edit only under ../src/ then from the extension/ directory run:

  npm run build

Reload the extension in chrome://extensions.
