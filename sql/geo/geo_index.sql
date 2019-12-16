-- CREATE EXTENSION postgis;

-- CREATE TABLE IF NOT EXISTS locations (
--   id SERIAL PRIMARY KEY
-- );

-- SELECT AddGeometryColumn('locations', 'point', 4326, 'POINT', 2);

-- INSERT INTO locations (point) VALUES
--   (ST_GeomFromEWKT('SRID=4326;POINT(37.617635 55.755814)')),
--   (ST_GeomFromEWKT('SRID=4326;POINT(37.717635 55.855814)'));

CREATE TABLE IF NOT EXISTS points (
  id SERIAL PRIMARY KEY,
  p point
);

INSERT INTO points (p) VALUES
  (point '(37.617635,55.755814)'),
  (point '(37.717635,55.855814)');

SELECT * FROM points order by p <-> point '(37.617635,55.755814)' limit 10;

CREATE INDEX ON points USING gist(p);
DROP INDEX points_p_idx;

