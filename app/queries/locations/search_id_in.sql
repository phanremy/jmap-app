WITH city_match AS (
  SELECT id, city, county, country FROM locations
  WHERE locations.city IS NOT NULL
    AND locations.type = 'City'
    AND LOWER(UNACCENT(:text)) ~* (
      '(^|\W)' || LOWER(UNACCENT(TRIM(locations.city))) || '($|\W)'
    )
  ORDER BY id ASC
  LIMIT 1
),
county_match AS (
  SELECT id, city, county, country FROM locations
  WHERE locations.county IS NOT NULL
    AND locations.type = 'County'
    AND LOWER(UNACCENT(:text)) ~* (
      '(^|\W)' || LOWER(UNACCENT(TRIM(locations.county))) || '($|\W)'
    )
  ORDER BY id ASC
  LIMIT 1
),
country_match AS (
  SELECT id, city, county, country FROM locations
  WHERE locations.country IS NOT NULL
    AND locations.type = 'Country'
    AND LOWER(UNACCENT(:text)) ~* (
      '(^|\W)' || LOWER(UNACCENT(TRIM(locations.country))) || '($|\W)'
    )
  ORDER BY id ASC
  LIMIT 1
)
SELECT * FROM city_match
UNION ALL
SELECT * FROM county_match
WHERE NOT EXISTS (SELECT 1 FROM city_match)
UNION ALL
SELECT * FROM country_match
WHERE NOT EXISTS (SELECT 1 FROM city_match)
  AND NOT EXISTS (SELECT 1 FROM county_match)
LIMIT 1;
