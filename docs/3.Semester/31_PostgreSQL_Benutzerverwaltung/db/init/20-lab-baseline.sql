\set ON_ERROR_STOP on

-- Known baseline; the exercise roles and policies are created by the learners.
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM PUBLIC;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
    REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;

-- In particular, rewards_report(integer, numeric) is SECURITY DEFINER.
-- Do not grant its execution as a shortcut for the marketing exercise.

DO $$
BEGIN
    IF (SELECT count(*) FROM public.customer) <> 599
       OR (SELECT count(*) FROM public.customer WHERE active = 1) <> 584
       OR (SELECT count(*) FROM public.customer WHERE active = 0) <> 15 THEN
        RAISE EXCEPTION 'Unexpected customer fixture; check the supplied dump';
    END IF;
END
$$;
