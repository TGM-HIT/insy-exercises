\c venlab

DROP VIEW IF EXISTS venlab.sample_boxpos;
DROP EXTENSION IF EXISTS isn CASCADE;

DROP FUNCTION IF EXISTS venlab.get_box_positions(sid character varying(13), sstamp timestamp);
DROP FUNCTION IF EXISTS venlab.check_ean13( sampleId IN VARCHAR );
DROP FUNCTION IF EXISTS venlab.get_suspicious_ean13_samples(start_date date, end_date date);
DROP FUNCTION IF EXISTS venlab.get_suspicious_analysis_without_time(start_date date, end_date date);
DROP FUNCTION IF EXISTS venlab.get_suspicious_analysis_without_boxpos(start_date date, end_date date);
DROP FUNCTION IF EXISTS venlab.get_suspicious_analysis_with_null_values(start_date date, end_date date);
DROP FUNCTION IF EXISTS venlab.get_suspicious_samples_with_multiple_analysis(start_date date, end_date date);
DROP FUNCTION IF EXISTS venlab.get_day_reports(start_date date, end_date date);
DROP FUNCTION IF EXISTS venlab.get_suspicious_boxpos_without_samples();
DROP FUNCTION IF EXISTS venlab.get_suspicious_boxpos_without_analysis();
-- DROP FUNCTION IF EXISTS venlab.get_suspicious_reports(start_date date, end_date date);

--
-- Functions
--
-- https://www.postgresql.org/docs/current/sql-createfunction.html
-- https://www.postgresql.org/docs/current/xfunc-volatility.html

CREATE OR REPLACE FUNCTION venlab.get_box_positions(sid character varying(13), sstamp timestamp) RETURNS character varying(8) STABLE AS
$BODY$
DECLARE
bid text;
    bpos text;
count int;
BEGIN
SELECT venlab.boxpos.b_id, to_char(venlab.boxpos.bpos_id,'FM00') INTO bid, bpos FROM venlab.boxpos WHERE venlab.boxpos.s_stamp = sstamp AND venlab.boxpos.s_id = sid;
SELECT count(*) INTO count FROM venlab.boxpos WHERE venlab.boxpos.s_stamp = sstamp AND venlab.boxpos.s_id = sid;
IF count > 1 THEN
RETURN concat(bid, '!', bpos);
ELSIF count = 1 THEN
RETURN concat(bid, '/', bpos);
ELSE
RETURN '';
END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE EXTENSION isn SCHEMA venlab;
CREATE OR REPLACE FUNCTION venlab.check_ean13( sampleId IN VARCHAR ) RETURNS BOOLEAN
AS
$BODY$
BEGIN
    PERFORM venlab.isn_weak(true);
IF ( length(sampleId) = 13)
   then return venlab.is_valid(sampleId::ean13);
ELSE
    return false;
END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_suspicious_ean13_samples(start_date date, end_date date) RETURNS TABLE (
  s_id character varying(13), s_stamp timestamp, is_ean13 bool
)
AS
$BODY$
DECLARE
frueh timestamp := (start_date || ' 06:00:00');
    nacht_ende timestamp := (end_date + 1 || ' 06:00:00');
    test_sample_7 text := '777777777777%';
    test_sample_8 text := '888888888888%';
BEGIN
RETURN QUERY
SELECT venlab.sample.s_id, venlab.sample.s_stamp, venlab.check_ean13(venlab.sample.s_id) FROM venlab.sample
WHERE venlab.sample.s_stamp >= frueh AND venlab.sample.s_stamp < nacht_ende
  AND venlab.sample.s_id NOT LIKE test_sample_7 AND venlab.sample.s_id NOT LIKE test_sample_8
  AND venlab.sample.s_id LIKE ANY (ARRAY['________0000_', '________000__', '________00___', '________0____', '_________000_', '__________00_', '___________0_'])
ORDER BY 2;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_suspicious_analysis_without_time(start_date date, end_date date) RETURNS TABLE (
    s_id character varying(13), s_stamp timestamp, a_id bigint
)
AS
$BODY$
DECLARE
frueh timestamp := (start_date || ' 06:00:00');
    nacht_ende timestamp := (end_date + 1 || ' 06:00:00');
BEGIN
RETURN QUERY
SELECT venlab.analysis.s_id, venlab.analysis.s_stamp, venlab.analysis.a_id
FROM venlab.analysis
WHERE venlab.analysis.s_id LIKE '________0000_'
  AND ( ( venlab.analysis.date_out IS NULL AND venlab.analysis.date_in >= frueh AND venlab.analysis.date_in <= nacht_ende )
    OR ( venlab.analysis.date_in IS NULL AND venlab.analysis.date_out >= frueh AND venlab.analysis.date_out <= nacht_ende ) )
ORDER BY venlab.analysis.s_id, venlab.analysis.s_stamp;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_suspicious_analysis_without_boxpos(start_date date, end_date date) RETURNS TABLE (
    s_id character varying(13), s_stamp timestamp, a_id bigint
)
AS
$BODY$
DECLARE
frueh timestamp := (start_date || ' 06:00:00');
    nacht_ende timestamp := (end_date + 1 || ' 06:00:00');
BEGIN
RETURN QUERY
SELECT venlab.analysis.s_id, venlab.analysis.s_stamp, venlab.analysis.a_id
FROM venlab.analysis LEFT JOIN venlab.boxpos USING ( s_id, s_stamp )
WHERE venlab.analysis.date_in >= frueh AND venlab.analysis.date_in <= nacht_ende
  AND venlab.analysis.s_id LIKE '________0000_'
  AND venlab.boxpos.b_id IS NULL
ORDER BY venlab.analysis.s_id, venlab.analysis.s_stamp;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_suspicious_analysis_with_null_values(start_date date, end_date date) RETURNS TABLE (
    s_id character varying(13), s_stamp timestamp, a_id bigint
)
AS
$BODY$
DECLARE
frueh timestamp := (start_date || ' 06:00:00');
    nacht_ende timestamp := (end_date + 1 || ' 06:00:00');
BEGIN
RETURN QUERY
SELECT venlab.analysis.s_id, venlab.analysis.s_stamp, venlab.analysis.a_id
FROM venlab.analysis
WHERE venlab.analysis.date_in >= frueh AND venlab.analysis.date_in <= nacht_ende
  AND venlab.analysis.s_id LIKE '________0000_'
  AND ( venlab.analysis.pol IS NULL OR venlab.analysis.pol = 0 )
ORDER BY venlab.analysis.s_id, venlab.analysis.s_stamp;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_suspicious_samples_with_multiple_analysis(start_date date, end_date date) RETURNS TABLE (
    s_id character varying(13), s_stamp timestamp, count bigint
)
AS
$BODY$
DECLARE
frueh timestamp := (start_date || ' 06:00:00');
    nacht_ende timestamp := (end_date + 1 || ' 06:00:00');
BEGIN
RETURN QUERY
SELECT venlab.analysis.s_id, venlab.analysis.s_stamp, count(*)
FROM venlab.analysis
WHERE venlab.analysis.date_in >= frueh AND venlab.analysis.date_in <= nacht_ende
  AND venlab.analysis.s_id LIKE '________0000_'
GROUP BY venlab.analysis.s_id, venlab.analysis.s_stamp
HAVING count(*) > 1;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_day_reports(start_date date, end_date date) RETURNS TABLE (
  day date,
  proben_frueh bigint, proben_spaet bigint, proben_nacht bigint, proben_summe bigint,
  analysen_frueh bigint, analysen_spaet bigint, analysen_nacht bigint, analysen_summe bigint,
  -- Zucker, Kalium, Natrium, Amino, Trocken, Glucose
  avg_pol numeric, avg_kal numeric, avg_nat numeric, avg_an numeric, avg_dry numeric, avg_glu numeric
)
AS
$BODY$
DECLARE
reportdate date := start_date;
    frueh timestamp;
    spaet timestamp;
    nacht timestamp;
    nacht_ende timestamp;
    exc_sid text := '888888888888%';
BEGIN
WHILE reportdate <= end_date LOOP
  frueh := (reportdate || ' 06:00:00');
  spaet := (reportdate || ' 14:00:00');
  nacht := (reportdate || ' 22:00:00');
  nacht_ende := (reportdate + 1 || ' 06:00:00');
RETURN QUERY
-- daily report for analysis average
SELECT reportdate AS Datum,
       (SELECT count(*) FROM venlab.sample WHERE s_stamp >= frueh AND s_stamp < spaet AND s_id NOT LIKE exc_sid),
       (SELECT count(*) FROM venlab.sample WHERE s_stamp >= spaet AND s_stamp < nacht AND s_id NOT LIKE exc_sid),
       (SELECT count(*) FROM venlab.sample WHERE s_stamp >= nacht AND s_stamp < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT count(*) FROM venlab.sample WHERE s_stamp >= frueh AND s_stamp < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT count(*) FROM venlab.analysis WHERE date_in >= frueh AND date_in < spaet AND s_id NOT LIKE exc_sid),
       (SELECT count(*) FROM venlab.analysis WHERE date_in >= spaet AND date_in < nacht AND s_id NOT LIKE exc_sid),
       (SELECT count(*) FROM venlab.analysis WHERE date_in >= nacht AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT count(*) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(pol)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(kal)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(nat)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(an)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(dry)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(glu)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid);
reportdate := reportdate + interval '1 day';
END LOOP;
frueh := (start_date || ' 06:00:00');
nacht_ende := (end_date + 1 || ' 06:00:00');
RETURN QUERY
-- Overall report for analysis average
SELECT end_date + 1 AS Datum,
       (SELECT 0::bigint),
       (SELECT 0::bigint),
       (SELECT 0::bigint),
       (SELECT count(*) FROM venlab.sample WHERE s_stamp >= frueh AND s_stamp < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT 0::bigint),
       (SELECT 0::bigint),
       (SELECT 0::bigint),
       (SELECT count(*) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(pol)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(kal)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(nat)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(an)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(dry)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid),
       (SELECT COALESCE(avg(glu)::numeric(10,2), 0.00) FROM venlab.analysis WHERE date_in >= frueh AND date_in < nacht_ende AND s_id NOT LIKE exc_sid);
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_suspicious_boxpos_without_samples() RETURNS TABLE (
    b_id character varying(255), bpos_id integer, s_id character varying(13), s_stamp timestamp
)
AS
$BODY$
BEGIN
RETURN QUERY
SELECT venlab.boxpos.b_id, venlab.boxpos.bpos_id, venlab.boxpos.s_id, venlab.boxpos.s_stamp
FROM venlab.boxpos
WHERE (venlab.boxpos.s_id IS NULL OR venlab.boxpos.s_stamp IS NULL )
ORDER BY venlab.boxpos.b_id, venlab.boxpos.bpos_id;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION venlab.get_suspicious_boxpos_without_analysis() RETURNS TABLE (
    b_id character varying(255), bpos_id integer, s_id character varying(13), s_stamp timestamp
)
AS
$BODY$
BEGIN
RETURN QUERY
SELECT venlab.boxpos.b_id, venlab.boxpos.bpos_id, venlab.boxpos.s_id, venlab.boxpos.s_stamp
FROM venlab.boxpos LEFT JOIN venlab.analysis USING ( s_id, s_stamp )
WHERE venlab.boxpos.s_id LIKE '________0000_' AND venlab.analysis.a_id IS NULL
ORDER BY venlab.boxpos.b_id, venlab.boxpos.bpos_id;
END;
$BODY$
LANGUAGE plpgsql;

--
-- Views
--

CREATE OR REPLACE VIEW venlab.sample_boxpos AS
SELECT s_id, s_stamp, ( SELECT venlab.get_box_positions(s_id,s_stamp) AS boxpos ) FROM venlab.sample;
CREATE OR REPLACE RULE sample_boxpos_delete AS ON DELETE TO venlab.sample_boxpos DO INSTEAD SELECT 1;
CREATE OR REPLACE RULE sample_boxpos_insert AS ON INSERT TO venlab.sample_boxpos DO INSTEAD SELECT 1;
CREATE OR REPLACE RULE sample_boxpos_update AS ON UPDATE TO venlab.sample_boxpos DO INSTEAD SELECT 1;

--
-- Sequences
--

CREATE SEQUENCE IF NOT EXISTS venlab.screen_scr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Indexes
--

CREATE INDEX IF NOT EXISTS sample_sstamp_desc_idx ON venlab.sample ( s_stamp DESC);
CREATE INDEX IF NOT EXISTS sample_sstamp_idx ON venlab.sample ( s_stamp ASC );
CREATE INDEX IF NOT EXISTS sample_s_id_idx ON venlab.sample ( s_id, s_stamp );
CREATE INDEX IF NOT EXISTS sample_date_crumbled_idx ON venlab.sample ( date_crumbled );
CREATE INDEX IF NOT EXISTS sample_date_exported_idx ON venlab.sample ( date_exported );

CREATE INDEX IF NOT EXISTS analysis_sstamp_desc_idx ON venlab.analysis ( s_stamp DESC);
CREATE INDEX IF NOT EXISTS analysis_sstamp_idx ON venlab.analysis ( s_stamp ASC );
CREATE INDEX IF NOT EXISTS analysis_s_id_idx ON venlab.analysis ( s_id, s_stamp );
CREATE INDEX IF NOT EXISTS analysis_date_in_idx ON venlab.analysis ( date_in );
CREATE INDEX IF NOT EXISTS analysis_date_out_idx ON venlab.analysis ( date_out );
CREATE INDEX IF NOT EXISTS analysis_aflags_idx ON venlab.analysis ( a_flags );

CREATE INDEX IF NOT EXISTS boxpos_s_id_s_stamp_idx ON venlab.boxpos ( s_id, s_stamp );
