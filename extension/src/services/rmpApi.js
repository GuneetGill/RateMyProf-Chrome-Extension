import { norm } from "../utils/strings.js";

/** Must match API Gateway stage + origin (no trailing slash). */
const API_BASE =
  "https://mq8gd6t62l.execute-api.us-east-1.amazonaws.com/prod";

const cache = new Map();

/** Same idea as backend `_prof_name_search_key`: stable cache key per person. */
function cacheKey(name) {
  return norm(name).toLowerCase().replace(/\s+/g, "");
}

/**
 * Turn API JSON into the shape `buildOverlay` expects.
 * API: professor.py → prof_name, department, rating, number_of_ratings, top_tags, difficulty, would_take_again
 */
function mapApiToOverlay(api) {
  if (!api) return null;

  let tags = api.top_tags;
  if (tags == null) {
    tags = [];
  } else if (typeof tags === "string") {
    const s = tags.trim();
    if (s.startsWith("[")) {
      try {
        tags = JSON.parse(s);
      } catch {
        tags = [];
      }
    } else {
      tags = s.split(/[,;]/).map((t) => t.trim()).filter(Boolean);
    }
  }
  if (!Array.isArray(tags)) tags = [];

  const pid = api.prof_id;
  return {
    name: api.prof_name,
    department: api.department || "",
    school: "",
    rating: api.rating,
    difficulty: api.difficulty ?? 0,
    wouldTakeAgain: Number(api.would_take_again ?? 0),
    numRatings: api.number_of_ratings ?? 0,
    tags,
    topReview: null,
    rmpUrl:
      pid != null
        ? `https://www.ratemyprofessors.com/professor/${pid}`
        : "",
  };
}

export async function fetchProfData(name) {
  const key = cacheKey(name);
  if (!key) return null;

  if (cache.has(key)) {
    return cache.get(key);
  }

  const pathSegment = encodeURIComponent(norm(name));
  const url = `${API_BASE}/search_professor_name/${pathSegment}`;

  // Matches backend `_prof_name_search_key` — what the DB compares after stripping spaces.
  console.info("[rmp-ext] professor lookup", { displayName: norm(name), searchKey: key, url });

  try {
    const response = await fetch(url);

    if (response.status === 404) {
      cache.set(key, null);
      return null;
    }

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }

    const raw = await response.json();
    const mapped = mapApiToOverlay(raw);
    cache.set(key, mapped);
    return mapped;
  } catch (err) {
    console.error("[rmp-ext] fetchProfData failed:", name, err);
    return null;
  }
}
