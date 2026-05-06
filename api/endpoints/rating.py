"""
Rating endpoints.

These endpoints are simple equality matches against values stored in `prof_info`.
"""

from __future__ import annotations

import sys
from pathlib import Path

from fastapi import APIRouter, HTTPException

sys.path.append(str(Path(__file__).resolve().parent.parent.parent))

from database import database

router = APIRouter()


@router.get("/search_professor_rating/{rating}")
def search_professor_rating(rating: float):
    """Return all professors with exactly this rating."""
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
            WHERE rating = %s
            """,
            (rating,),
        )
        results = cursor.fetchall()

        if not results:
            raise HTTPException(status_code=404, detail=f"'{rating}' not found.")

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
