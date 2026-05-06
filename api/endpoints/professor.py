"""
Professor endpoints.

Important: `prof_name` values in the DB are not consistently "First Last" — many
are stored like `GarthDavies`. To make lookups user-friendly we normalize the
path parameter and the DB value by:
- lowercasing
- stripping *all* whitespace
"""

from __future__ import annotations

import sys
from pathlib import Path

from fastapi import APIRouter, HTTPException

sys.path.append(str(Path(__file__).resolve().parent.parent.parent))

from database import database

router = APIRouter()


def _prof_name_search_key(name: str) -> str:
    """Lowercase + remove all whitespace (e.g. 'Garth Davies' -> 'garthdavies')."""
    return "".join(name.replace("+", " ").strip().lower().split())


@router.get("/search_professor_name/{name}")
def search_professor_name(name: str):
    """Searches for a professor by name in the database and returns their details."""

    display_name = name.replace("+", " ").strip()
    key = _prof_name_search_key(name)
    if not key:
        raise HTTPException(status_code=400, detail="Name cannot be empty.")

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
            -- POSIX [[:space:]] is reliable across Postgres/RDS.
            WHERE LOWER(REGEXP_REPLACE(prof_name, '[[:space:]]', '', 'g')) = %s
            """,
            (key,),
        )

        result = cursor.fetchone()

        if not result:
            raise HTTPException(
                status_code=404,
                detail=f"Professor '{display_name}' not found.",
            )

        return {
            "prof_id": result[0],
            "prof_name": result[1],
            "department": result[2],
            "rating": result[3],
            "number_of_ratings": result[4],
            "top_tags": result[5],
            "difficulty": result[6],
            "would_take_again": result[7],
        }

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

    finally:
        if cursor is not None:
            cursor.close()
        if conn is not None:
            database.release_connection(conn)


@router.get("/search_professor_id/{id}")
def search_professor_id(id: int):
    """Searches for a professor by id in the database and returns their details."""

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
            WHERE prof_id = %s
            """,
            (id,),
        )

        result = cursor.fetchone()

        if not result:
            raise HTTPException(
                status_code=404, detail=f"Professor with ID {id} not found."
            )

        return {
            "prof_id": result[0],
            "prof_name": result[1],
            "department": result[2],
            "rating": result[3],
            "number_of_ratings": result[4],
            "top_tags": result[5],
            "difficulty": result[6],
            "would_take_again": result[7],
        }

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

    finally:
        if cursor is not None:
            cursor.close()
        if conn is not None:
            database.release_connection(conn)
