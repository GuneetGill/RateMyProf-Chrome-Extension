"""
Department endpoints.

Department names are stored in the DB as human-readable strings like
`Criminal Justice` and `Mathematics`. To make URL input flexible we normalize
the path parameter by:
- lowercasing
- collapsing whitespace

On the DB side we do the same (collapse whitespace + trim + lowercase) before
comparing so rows with odd spacing/newlines still match.
"""

from __future__ import annotations

import sys
from pathlib import Path

from fastapi import APIRouter, HTTPException

sys.path.append(str(Path(__file__).resolve().parent.parent.parent))

from database import database

router = APIRouter()


def _department_search_key(department: str) -> str:
    """Lowercase + collapse whitespace (e.g. 'Criminal   Justice' -> 'criminal justice')."""
    return " ".join(department.replace("+", " ").strip().lower().split())


@router.get("/search_professor_department/{department}")
def search_professor_department(department: str):
    """Find all professors within a department."""

    dept_key = _department_search_key(department)
    if not dept_key:
        raise HTTPException(status_code=400, detail="Department cannot be empty.")

    conn = database.get_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Database connection not available.")

    cursor = None
    try:
        cursor = conn.cursor()
        cursor.execute(
            """
            SELECT
                prof_id,
                prof_name,
                department,
                rating,
                number_of_ratings,
                top_tags,
                difficulty,
                would_take_again
            FROM prof_info
            -- Match Python normalization: " ".join(s.split()).lower()
            WHERE LOWER(TRIM(BOTH FROM REGEXP_REPLACE(department, '[[:space:]]+', ' ', 'g'))) = %s
            """,
            (dept_key,),
        )

        results = cursor.fetchall()

        if not results:
            raise HTTPException(status_code=404, detail=f"'{dept_key}' not found.")

        return [
            {
                "prof_id": row[0],
                "prof_name": row[1],
                "department": row[2],
                "rating": row[3],
                "number_of_ratings": row[4],
                "top_tags": row[5],
                "difficulty": row[6],
                "would_take_again": row[7],
            }
            for row in results
        ]

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

    finally:
        if cursor is not None:
            cursor.close()
        if conn is not None:
            database.release_connection(conn)
