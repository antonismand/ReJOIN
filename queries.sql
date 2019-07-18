--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9 (Ubuntu 10.9-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.9 (Ubuntu 10.9-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: queries; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (1, '22b.sql', 11, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS western_violent_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code != ''[us]''
  AND it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind IN (''movie'',
                  ''episode'')
  AND mc.note NOT LIKE ''%(USA)%''
  AND mc.note LIKE ''%(200%)%''
  AND mi.info IN (''Germany'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info < ''7.0''
  AND t.production_year > 2009
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "western_violent_movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"neq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"in": ["kt.kind", {"literal": ["movie", "episode"]}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"in": ["mi.info", {"literal": ["Germany", "German", "USA", "American"]}]}, {"lt": ["mi_idx.info", {"literal": "7.0"}]}, {"gt": ["t.production_year", 2009]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}]}}', 30.5090008, 1086.32605, 7476.10986);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (2, '8a.sql', 7, 'SELECT MIN(an1.name) AS actress_pseudonym,
       MIN(t.title) AS japanese_movie_dubbed
FROM aka_name AS an1,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n1,
     role_type AS rt,
     title AS t
WHERE ci.note =''(voice: English version)''
  AND cn.country_code =''[jp]''
  AND mc.note LIKE ''%(Japan)%''
  AND mc.note NOT LIKE ''%(USA)%''
  AND n1.name LIKE ''%Yo%''
  AND n1.name NOT LIKE ''%Yu%''
  AND rt.role =''actress''
  AND an1.person_id = n1.id
  AND n1.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND an1.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "an1.name"}, "name": "actress_pseudonym"}, {"value": {"min": "t.title"}, "name": "japanese_movie_dubbed"}], "from": [{"value": "aka_name", "name": "an1"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "movie_companies", "name": "mc"}, {"value": "name", "name": "n1"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ci.note", {"literal": "(voice: English version)"}]}, {"eq": ["cn.country_code", {"literal": "[jp]"}]}, {"like": ["mc.note", {"literal": "%(Japan)%"}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["n1.name", {"literal": "%Yo%"}]}, {"nlike": ["n1.name", {"literal": "%Yu%"}]}, {"eq": ["rt.role", {"literal": "actress"}]}, {"eq": ["an1.person_id", "n1.id"]}, {"eq": ["n1.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.role_id", "rt.id"]}, {"eq": ["an1.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}]}}', 16.4290009, 3667.21899, 43245.7188);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (3, '18c.sql', 7, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(t.title) AS movie_title
FROM cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     name AS n,
     title AS t
WHERE ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND mi.info IN (''Horror'',
                  ''Action'',
                  ''Sci-Fi'',
                  ''Thriller'',
                  ''Crime'',
                  ''War'')
  AND n.gender = ''m''
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "t.title"}, "name": "movie_title"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["mi.info", {"literal": ["Horror", "Action", "Sci-Fi", "Thriller", "Crime", "War"]}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}]}}', 2.47799993, 7185.18701, 96954.0078);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (4, '6b.sql', 5, 'SELECT MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS hero_movie
FROM cast_info AS ci,
     keyword AS k,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword IN (''superhero'',
                    ''sequel'',
                    ''second-part'',
                    ''marvel-comics'',
                    ''based-on-comic'',
                    ''tv-special'',
                    ''fight'',
                    ''violence'')
  AND n.name LIKE ''%Downey%Robert%''
  AND t.production_year > 2014
  AND k.id = mk.keyword_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mk.movie_id
  AND n.id = ci.person_id;

', '{"select": [{"value": {"min": "k.keyword"}, "name": "movie_keyword"}, {"value": {"min": "n.name"}, "name": "actor_name"}, {"value": {"min": "t.title"}, "name": "hero_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["k.keyword", {"literal": ["superhero", "sequel", "second-part", "marvel-comics", "based-on-comic", "tv-special", "fight", "violence"]}]}, {"like": ["n.name", {"literal": "%Downey%Robert%"}]}, {"gt": ["t.production_year", 2014]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}]}}', 0.92900002, 380.635986, 12345.71);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (5, '16a.sql', 8, 'SELECT MIN(an.name) AS cool_actor_pseudonym,
       MIN(t.title) AS series_named_after_char
FROM aka_name AS an,
     cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cn.country_code =''[us]''
  AND k.keyword =''character-name-in-title''
  AND t.episode_nr >= 50
  AND t.episode_nr < 100
  AND an.person_id = n.id
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND an.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "cool_actor_pseudonym"}, {"value": {"min": "t.title"}, "name": "series_named_after_char"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"gte": ["t.episode_nr", 50]}, {"lt": ["t.episode_nr", 100]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["an.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 4.16099977, 282.002014, 3805.07007);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (6, '17f.sql', 7, 'SELECT MIN(n.name) AS member_in_charnamed_movie
FROM cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword =''character-name-in-title''
  AND n.name LIKE ''%B%''
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": {"value": {"min": "n.name"}, "name": "member_in_charnamed_movie"}, "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"like": ["n.name", {"literal": "%B%"}]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 2.44199991, 13212.915, 4640.56006);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (7, '25c.sql', 9, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS male_writer,
       MIN(t.title) AS violent_movie_title
FROM cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''violence'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'',
                    ''hospital'')
  AND mi.info IN (''Horror'',
                  ''Action'',
                  ''Sci-Fi'',
                  ''Thriller'',
                  ''Crime'',
                  ''War'')
  AND n.gender = ''m''
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "male_writer"}, {"value": {"min": "t.title"}, "name": "violent_movie_title"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "violence", "blood", "gore", "death", "female-nudity", "hospital"]}]}, {"in": ["mi.info", {"literal": ["Horror", "Action", "Sci-Fi", "Thriller", "Crime", "War"]}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}]}}', 9.17300034, 8416.57715, 9233.78027);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (9, '1d.sql', 5, 'SELECT MIN(mc.note) AS production_note,
       MIN(t.title) AS movie_title,
       MIN(t.production_year) AS movie_year
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info_idx AS mi_idx,
     title AS t
WHERE ct.kind = ''production companies''
  AND it.info = ''bottom 10 rank''
  AND mc.note NOT LIKE ''%(as Metro-Goldwyn-Mayer Pictures)%''
  AND t.production_year >2000
  AND ct.id = mc.company_type_id
  AND t.id = mc.movie_id
  AND t.id = mi_idx.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND it.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mc.note"}, "name": "production_note"}, {"value": {"min": "t.title"}, "name": "movie_title"}, {"value": {"min": "t.production_year"}, "name": "movie_year"}], "from": [{"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "bottom 10 rank"}]}, {"nlike": ["mc.note", {"literal": "%(as Metro-Goldwyn-Mayer Pictures)%"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["it.id", "mi_idx.info_type_id"]}]}}', 2.50099993, 66.2750015, 19621.0508);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (11, '22a.sql', 11, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS western_violent_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code != ''[us]''
  AND it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind IN (''movie'',
                  ''episode'')
  AND mc.note NOT LIKE ''%(USA)%''
  AND mc.note LIKE ''%(200%)%''
  AND mi.info IN (''Germany'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info < ''7.0''
  AND t.production_year > 2008
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "western_violent_movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"neq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"in": ["kt.kind", {"literal": ["movie", "episode"]}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"in": ["mi.info", {"literal": ["Germany", "German", "USA", "American"]}]}, {"lt": ["mi_idx.info", {"literal": "7.0"}]}, {"gt": ["t.production_year", 2008]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}]}}', 25.8959999, 688.004028, 7477.16016);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (12, '33b.sql', 14, 'SELECT MIN(cn1.name) AS first_company,
       MIN(cn2.name) AS second_company,
       MIN(mi_idx1.info) AS first_rating,
       MIN(mi_idx2.info) AS second_rating,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM company_name AS cn1,
     company_name AS cn2,
     info_type AS it1,
     info_type AS it2,
     kind_type AS kt1,
     kind_type AS kt2,
     link_type AS lt,
     movie_companies AS mc1,
     movie_companies AS mc2,
     movie_info_idx AS mi_idx1,
     movie_info_idx AS mi_idx2,
     movie_link AS ml,
     title AS t1,
     title AS t2
WHERE cn1.country_code = ''[nl]''
  AND it1.info = ''rating''
  AND it2.info = ''rating''
  AND kt1.kind IN (''tv series'')
  AND kt2.kind IN (''tv series'')
  AND lt.link LIKE ''%follow%''
  AND mi_idx2.info < ''3.0''
  AND t2.production_year = 2007
  AND lt.id = ml.link_type_id
  AND t1.id = ml.movie_id
  AND t2.id = ml.linked_movie_id
  AND it1.id = mi_idx1.info_type_id
  AND t1.id = mi_idx1.movie_id
  AND kt1.id = t1.kind_id
  AND cn1.id = mc1.company_id
  AND t1.id = mc1.movie_id
  AND ml.movie_id = mi_idx1.movie_id
  AND ml.movie_id = mc1.movie_id
  AND mi_idx1.movie_id = mc1.movie_id
  AND it2.id = mi_idx2.info_type_id
  AND t2.id = mi_idx2.movie_id
  AND kt2.id = t2.kind_id
  AND cn2.id = mc2.company_id
  AND t2.id = mc2.movie_id
  AND ml.linked_movie_id = mi_idx2.movie_id
  AND ml.linked_movie_id = mc2.movie_id
  AND mi_idx2.movie_id = mc2.movie_id;

', '{"select": [{"value": {"min": "cn1.name"}, "name": "first_company"}, {"value": {"min": "cn2.name"}, "name": "second_company"}, {"value": {"min": "mi_idx1.info"}, "name": "first_rating"}, {"value": {"min": "mi_idx2.info"}, "name": "second_rating"}, {"value": {"min": "t1.title"}, "name": "first_movie"}, {"value": {"min": "t2.title"}, "name": "second_movie"}], "from": [{"value": "company_name", "name": "cn1"}, {"value": "company_name", "name": "cn2"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "kind_type", "name": "kt1"}, {"value": "kind_type", "name": "kt2"}, {"value": "link_type", "name": "lt"}, {"value": "movie_companies", "name": "mc1"}, {"value": "movie_companies", "name": "mc2"}, {"value": "movie_info_idx", "name": "mi_idx1"}, {"value": "movie_info_idx", "name": "mi_idx2"}, {"value": "movie_link", "name": "ml"}, {"value": "title", "name": "t1"}, {"value": "title", "name": "t2"}], "where": {"and": [{"eq": ["cn1.country_code", {"literal": "[nl]"}]}, {"eq": ["it1.info", {"literal": "rating"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["kt1.kind", {"literal": "tv series"}]}, {"in": ["kt2.kind", {"literal": "tv series"}]}, {"like": ["lt.link", {"literal": "%follow%"}]}, {"lt": ["mi_idx2.info", {"literal": "3.0"}]}, {"eq": ["t2.production_year", 2007]}, {"eq": ["lt.id", "ml.link_type_id"]}, {"eq": ["t1.id", "ml.movie_id"]}, {"eq": ["t2.id", "ml.linked_movie_id"]}, {"eq": ["it1.id", "mi_idx1.info_type_id"]}, {"eq": ["t1.id", "mi_idx1.movie_id"]}, {"eq": ["kt1.id", "t1.kind_id"]}, {"eq": ["cn1.id", "mc1.company_id"]}, {"eq": ["t1.id", "mc1.movie_id"]}, {"eq": ["ml.movie_id", "mi_idx1.movie_id"]}, {"eq": ["ml.movie_id", "mc1.movie_id"]}, {"eq": ["mi_idx1.movie_id", "mc1.movie_id"]}, {"eq": ["it2.id", "mi_idx2.info_type_id"]}, {"eq": ["t2.id", "mi_idx2.movie_id"]}, {"eq": ["kt2.id", "t2.kind_id"]}, {"eq": ["cn2.id", "mc2.company_id"]}, {"eq": ["t2.id", "mc2.movie_id"]}, {"eq": ["ml.linked_movie_id", "mi_idx2.movie_id"]}, {"eq": ["ml.linked_movie_id", "mc2.movie_id"]}, {"eq": ["mi_idx2.movie_id", "mc2.movie_id"]}]}}', 61.2130013, 41.8899994, 386.950012);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (13, '8d.sql', 7, 'SELECT MIN(an1.name) AS costume_designer_pseudo,
       MIN(t.title) AS movie_with_costumes
FROM aka_name AS an1,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n1,
     role_type AS rt,
     title AS t
WHERE cn.country_code =''[us]''
  AND rt.role =''costume designer''
  AND an1.person_id = n1.id
  AND n1.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND an1.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "an1.name"}, "name": "costume_designer_pseudo"}, {"value": {"min": "t.title"}, "name": "movie_with_costumes"}], "from": [{"value": "aka_name", "name": "an1"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "movie_companies", "name": "mc"}, {"value": "name", "name": "n1"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["rt.role", {"literal": "costume designer"}]}, {"eq": ["an1.person_id", "n1.id"]}, {"eq": ["n1.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.role_id", "rt.id"]}, {"eq": ["an1.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}]}}', 2.20499992, 4856.16016, 620935.75);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (14, '20a.sql', 10, 'SELECT MIN(t.title) AS complete_downey_ironman_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     char_name AS chn,
     cast_info AS ci,
     keyword AS k,
     kind_type AS kt,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cct1.kind = ''cast''
  AND cct2.kind LIKE ''%complete%''
  AND chn.name NOT LIKE ''%Sherlock%''
  AND (chn.name LIKE ''%Tony%Stark%''
       OR chn.name LIKE ''%Iron%Man%'')
  AND k.keyword IN (''superhero'',
                    ''sequel'',
                    ''second-part'',
                    ''marvel-comics'',
                    ''based-on-comic'',
                    ''tv-special'',
                    ''fight'',
                    ''violence'')
  AND kt.kind = ''movie''
  AND t.production_year > 1950
  AND kt.id = t.kind_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND t.id = cc.movie_id
  AND mk.movie_id = ci.movie_id
  AND mk.movie_id = cc.movie_id
  AND ci.movie_id = cc.movie_id
  AND chn.id = ci.person_role_id
  AND n.id = ci.person_id
  AND k.id = mk.keyword_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": {"value": {"min": "t.title"}, "name": "complete_downey_ironman_movie"}, "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cct1.kind", {"literal": "cast"}]}, {"like": ["cct2.kind", {"literal": "%complete%"}]}, {"nlike": ["chn.name", {"literal": "%Sherlock%"}]}, {"or": [{"like": ["chn.name", {"literal": "%Tony%Stark%"}]}, {"like": ["chn.name", {"literal": "%Iron%Man%"}]}]}, {"in": ["k.keyword", {"literal": ["superhero", "sequel", "second-part", "marvel-comics", "based-on-comic", "tv-special", "fight", "violence"]}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"gt": ["t.production_year", 1950]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "ci.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["ci.movie_id", "cc.movie_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 10.177, 127939.75, 2496.69995);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (16, '13c.sql', 9, 'SELECT MIN(cn.name) AS producing_company,
       MIN(miidx.info) AS rating,
       MIN(t.title) AS movie_about_winning
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it,
     info_type AS it2,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS miidx,
     title AS t
WHERE cn.country_code =''[us]''
  AND ct.kind =''production companies''
  AND it.info =''rating''
  AND it2.info =''release dates''
  AND kt.kind =''movie''
  AND t.title != ''''
  AND (t.title LIKE ''Champion%''
       OR t.title LIKE ''Loser%'')
  AND mi.movie_id = t.id
  AND it2.id = mi.info_type_id
  AND kt.id = t.kind_id
  AND mc.movie_id = t.id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id
  AND miidx.movie_id = t.id
  AND it.id = miidx.info_type_id
  AND mi.movie_id = miidx.movie_id
  AND mi.movie_id = mc.movie_id
  AND miidx.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "producing_company"}, {"value": {"min": "miidx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "movie_about_winning"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "info_type", "name": "it2"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "miidx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "rating"}]}, {"eq": ["it2.info", {"literal": "release dates"}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"neq": ["t.title", {"literal": ""}]}, {"or": [{"like": ["t.title", {"literal": "Champion%"}]}, {"like": ["t.title", {"literal": "Loser%"}]}]}, {"eq": ["mi.movie_id", "t.id"]}, {"eq": ["it2.id", "mi.info_type_id"]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["miidx.movie_id", "t.id"]}, {"eq": ["it.id", "miidx.info_type_id"]}, {"eq": ["mi.movie_id", "miidx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["miidx.movie_id", "mc.movie_id"]}]}}', 5.25400019, 466.5, 19236.6992);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (17, '6d.sql', 5, 'SELECT MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS hero_movie
FROM cast_info AS ci,
     keyword AS k,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword IN (''superhero'',
                    ''sequel'',
                    ''second-part'',
                    ''marvel-comics'',
                    ''based-on-comic'',
                    ''tv-special'',
                    ''fight'',
                    ''violence'')
  AND n.name LIKE ''%Downey%Robert%''
  AND t.production_year > 2000
  AND k.id = mk.keyword_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mk.movie_id
  AND n.id = ci.person_id;

', '{"select": [{"value": {"min": "k.keyword"}, "name": "movie_keyword"}, {"value": {"min": "n.name"}, "name": "actor_name"}, {"value": {"min": "t.title"}, "name": "hero_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["k.keyword", {"literal": ["superhero", "sequel", "second-part", "marvel-comics", "based-on-comic", "tv-special", "fight", "violence"]}]}, {"like": ["n.name", {"literal": "%Downey%Robert%"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}]}}', 0.992999971, 6842.53076, 15184.8701);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (18, '2b.sql', 5, 'SELECT MIN(t.title) AS movie_title
FROM company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code =''[nl]''
  AND k.keyword =''character-name-in-title''
  AND cn.id = mc.company_id
  AND mc.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND mc.movie_id = mk.movie_id;

', '{"select": {"value": {"min": "t.title"}, "name": "movie_title"}, "from": [{"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[nl]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 0.855000019, 556.06897, 3846.29004);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (19, '3a.sql', 4, 'SELECT MIN(t.title) AS movie_title
FROM keyword AS k,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t
WHERE k.keyword LIKE ''%sequel%''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Denish'',
                  ''Norwegian'',
                  ''German'')
  AND t.production_year > 2005
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND mk.movie_id = mi.movie_id
  AND k.id = mk.keyword_id;

', '{"select": {"value": {"min": "t.title"}, "name": "movie_title"}, "from": [{"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["k.keyword", {"literal": "%sequel%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Denish", "Norwegian", "German"]}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}]}}', 0.745000005, 204.335999, 16738.0391);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (22, '2c.sql', 5, 'SELECT MIN(t.title) AS movie_title
FROM company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code =''[sm]''
  AND k.keyword =''character-name-in-title''
  AND cn.id = mc.company_id
  AND mc.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND mc.movie_id = mk.movie_id;

', '{"select": {"value": {"min": "t.title"}, "name": "movie_title"}, "from": [{"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[sm]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 0.769999981, 443.34201, 3845.78003);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (23, '2a.sql', 5, 'SELECT MIN(t.title) AS movie_title
FROM company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code =''[de]''
  AND k.keyword =''character-name-in-title''
  AND cn.id = mc.company_id
  AND mc.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND mc.movie_id = mk.movie_id;

', '{"select": {"value": {"min": "t.title"}, "name": "movie_title"}, "from": [{"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[de]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 0.736000001, 487.746002, 3848.80005);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (25, '6a.sql', 5, 'SELECT MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS marvel_movie
FROM cast_info AS ci,
     keyword AS k,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword = ''marvel-cinematic-universe''
  AND n.name LIKE ''%Downey%Robert%''
  AND t.production_year > 2010
  AND k.id = mk.keyword_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mk.movie_id
  AND n.id = ci.person_id;

', '{"select": [{"value": {"min": "k.keyword"}, "name": "movie_keyword"}, {"value": {"min": "n.name"}, "name": "actor_name"}, {"value": {"min": "t.title"}, "name": "marvel_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "marvel-cinematic-universe"}]}, {"like": ["n.name", {"literal": "%Downey%Robert%"}]}, {"gt": ["t.production_year", 2010]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}]}}', 0.889999986, 21.5319996, 3860.13989);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (26, '16c.sql', 8, 'SELECT MIN(an.name) AS cool_actor_pseudonym,
       MIN(t.title) AS series_named_after_char
FROM aka_name AS an,
     cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cn.country_code =''[us]''
  AND k.keyword =''character-name-in-title''
  AND t.episode_nr < 100
  AND an.person_id = n.id
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND an.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "cool_actor_pseudonym"}, {"value": {"min": "t.title"}, "name": "series_named_after_char"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"lt": ["t.episode_nr", 100]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["an.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 4.54799986, 2273.25293, 4346.10986);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (27, '5b.sql', 5, 'SELECT MIN(t.title) AS american_vhs_movie
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info AS mi,
     title AS t
WHERE ct.kind = ''production companies''
  AND mc.note LIKE ''%(VHS)%''
  AND mc.note LIKE ''%(USA)%''
  AND mc.note LIKE ''%(1994)%''
  AND mi.info IN (''USA'',
                  ''America'')
  AND t.production_year > 2010
  AND t.id = mi.movie_id
  AND t.id = mc.movie_id
  AND mc.movie_id = mi.movie_id
  AND ct.id = mc.company_type_id
  AND it.id = mi.info_type_id;

', '{"select": {"value": {"min": "t.title"}, "name": "american_vhs_movie"}, "from": [{"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ct.kind", {"literal": "production companies"}]}, {"like": ["mc.note", {"literal": "%(VHS)%"}]}, {"like": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(1994)%"}]}, {"in": ["mi.info", {"literal": ["USA", "America"]}]}, {"gt": ["t.production_year", 2010]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.movie_id", "mi.movie_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["it.id", "mi.info_type_id"]}]}}', 0.917999983, 140.128006, 38846.2812);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (28, '1a.sql', 5, 'SELECT MIN(mc.note) AS production_note,
       MIN(t.title) AS movie_title,
       MIN(t.production_year) AS movie_year
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info_idx AS mi_idx,
     title AS t
WHERE ct.kind = ''production companies''
  AND it.info = ''top 250 rank''
  AND mc.note NOT LIKE ''%(as Metro-Goldwyn-Mayer Pictures)%''
  AND (mc.note LIKE ''%(co-production)%''
       OR mc.note LIKE ''%(presents)%'')
  AND ct.id = mc.company_type_id
  AND t.id = mc.movie_id
  AND t.id = mi_idx.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND it.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mc.note"}, "name": "production_note"}, {"value": {"min": "t.title"}, "name": "movie_title"}, {"value": {"min": "t.production_year"}, "name": "movie_year"}], "from": [{"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "top 250 rank"}]}, {"nlike": ["mc.note", {"literal": "%(as Metro-Goldwyn-Mayer Pictures)%"}]}, {"or": [{"like": ["mc.note", {"literal": "%(co-production)%"}]}, {"like": ["mc.note", {"literal": "%(presents)%"}]}]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["it.id", "mi_idx.info_type_id"]}]}}', 0.898000002, 76.0319977, 19564.1191);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (29, '33c.sql', 14, 'SELECT MIN(cn1.name) AS first_company,
       MIN(cn2.name) AS second_company,
       MIN(mi_idx1.info) AS first_rating,
       MIN(mi_idx2.info) AS second_rating,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM company_name AS cn1,
     company_name AS cn2,
     info_type AS it1,
     info_type AS it2,
     kind_type AS kt1,
     kind_type AS kt2,
     link_type AS lt,
     movie_companies AS mc1,
     movie_companies AS mc2,
     movie_info_idx AS mi_idx1,
     movie_info_idx AS mi_idx2,
     movie_link AS ml,
     title AS t1,
     title AS t2
WHERE cn1.country_code != ''[us]''
  AND it1.info = ''rating''
  AND it2.info = ''rating''
  AND kt1.kind IN (''tv series'',
                   ''episode'')
  AND kt2.kind IN (''tv series'',
                   ''episode'')
  AND lt.link IN (''sequel'',
                  ''follows'',
                  ''followed by'')
  AND mi_idx2.info < ''3.5''
  AND t2.production_year BETWEEN 2000 AND 2010
  AND lt.id = ml.link_type_id
  AND t1.id = ml.movie_id
  AND t2.id = ml.linked_movie_id
  AND it1.id = mi_idx1.info_type_id
  AND t1.id = mi_idx1.movie_id
  AND kt1.id = t1.kind_id
  AND cn1.id = mc1.company_id
  AND t1.id = mc1.movie_id
  AND ml.movie_id = mi_idx1.movie_id
  AND ml.movie_id = mc1.movie_id
  AND mi_idx1.movie_id = mc1.movie_id
  AND it2.id = mi_idx2.info_type_id
  AND t2.id = mi_idx2.movie_id
  AND kt2.id = t2.kind_id
  AND cn2.id = mc2.company_id
  AND t2.id = mc2.movie_id
  AND ml.linked_movie_id = mi_idx2.movie_id
  AND ml.linked_movie_id = mc2.movie_id
  AND mi_idx2.movie_id = mc2.movie_id;

', '{"select": [{"value": {"min": "cn1.name"}, "name": "first_company"}, {"value": {"min": "cn2.name"}, "name": "second_company"}, {"value": {"min": "mi_idx1.info"}, "name": "first_rating"}, {"value": {"min": "mi_idx2.info"}, "name": "second_rating"}, {"value": {"min": "t1.title"}, "name": "first_movie"}, {"value": {"min": "t2.title"}, "name": "second_movie"}], "from": [{"value": "company_name", "name": "cn1"}, {"value": "company_name", "name": "cn2"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "kind_type", "name": "kt1"}, {"value": "kind_type", "name": "kt2"}, {"value": "link_type", "name": "lt"}, {"value": "movie_companies", "name": "mc1"}, {"value": "movie_companies", "name": "mc2"}, {"value": "movie_info_idx", "name": "mi_idx1"}, {"value": "movie_info_idx", "name": "mi_idx2"}, {"value": "movie_link", "name": "ml"}, {"value": "title", "name": "t1"}, {"value": "title", "name": "t2"}], "where": {"and": [{"neq": ["cn1.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "rating"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["kt1.kind", {"literal": ["tv series", "episode"]}]}, {"in": ["kt2.kind", {"literal": ["tv series", "episode"]}]}, {"in": ["lt.link", {"literal": ["sequel", "follows", "followed by"]}]}, {"lt": ["mi_idx2.info", {"literal": "3.5"}]}, {"between": ["t2.production_year", 2000, 2010]}, {"eq": ["lt.id", "ml.link_type_id"]}, {"eq": ["t1.id", "ml.movie_id"]}, {"eq": ["t2.id", "ml.linked_movie_id"]}, {"eq": ["it1.id", "mi_idx1.info_type_id"]}, {"eq": ["t1.id", "mi_idx1.movie_id"]}, {"eq": ["kt1.id", "t1.kind_id"]}, {"eq": ["cn1.id", "mc1.company_id"]}, {"eq": ["t1.id", "mc1.movie_id"]}, {"eq": ["ml.movie_id", "mi_idx1.movie_id"]}, {"eq": ["ml.movie_id", "mc1.movie_id"]}, {"eq": ["mi_idx1.movie_id", "mc1.movie_id"]}, {"eq": ["it2.id", "mi_idx2.info_type_id"]}, {"eq": ["t2.id", "mi_idx2.movie_id"]}, {"eq": ["kt2.id", "t2.kind_id"]}, {"eq": ["cn2.id", "mc2.company_id"]}, {"eq": ["t2.id", "mc2.movie_id"]}, {"eq": ["ml.linked_movie_id", "mi_idx2.movie_id"]}, {"eq": ["ml.linked_movie_id", "mc2.movie_id"]}, {"eq": ["mi_idx2.movie_id", "mc2.movie_id"]}]}}', 60.4939995, 268.209991, 1890.31006);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (30, '5a.sql', 5, 'SELECT MIN(t.title) AS typical_european_movie
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info AS mi,
     title AS t
WHERE ct.kind = ''production companies''
  AND mc.note LIKE ''%(theatrical)%''
  AND mc.note LIKE ''%(France)%''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Denish'',
                  ''Norwegian'',
                  ''German'')
  AND t.production_year > 2005
  AND t.id = mi.movie_id
  AND t.id = mc.movie_id
  AND mc.movie_id = mi.movie_id
  AND ct.id = mc.company_type_id
  AND it.id = mi.info_type_id;

', '{"select": {"value": {"min": "t.title"}, "name": "typical_european_movie"}, "from": [{"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ct.kind", {"literal": "production companies"}]}, {"like": ["mc.note", {"literal": "%(theatrical)%"}]}, {"like": ["mc.note", {"literal": "%(France)%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Denish", "Norwegian", "German"]}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.movie_id", "mi.movie_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["it.id", "mi.info_type_id"]}]}}', 0.833000004, 107.974998, 36260.1602);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (31, '32b.sql', 6, 'SELECT MIN(lt.link) AS link_type,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM keyword AS k,
     link_type AS lt,
     movie_keyword AS mk,
     movie_link AS ml,
     title AS t1,
     title AS t2
WHERE k.keyword =''character-name-in-title''
  AND mk.keyword_id = k.id
  AND t1.id = mk.movie_id
  AND ml.movie_id = t1.id
  AND ml.linked_movie_id = t2.id
  AND lt.id = ml.link_type_id
  AND mk.movie_id = t1.id;

', '{"select": [{"value": {"min": "lt.link"}, "name": "link_type"}, {"value": {"min": "t1.title"}, "name": "first_movie"}, {"value": {"min": "t2.title"}, "name": "second_movie"}], "from": [{"value": "keyword", "name": "k"}, {"value": "link_type", "name": "lt"}, {"value": "movie_keyword", "name": "mk"}, {"value": "movie_link", "name": "ml"}, {"value": "title", "name": "t1"}, {"value": "title", "name": "t2"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t1.id", "mk.movie_id"]}, {"eq": ["ml.movie_id", "t1.id"]}, {"eq": ["ml.linked_movie_id", "t2.id"]}, {"eq": ["lt.id", "ml.link_type_id"]}, {"eq": ["mk.movie_id", "t1.id"]}]}}', 1.01900005, 128.893997, 3809.79004);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (33, '31b.sql', 11, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS violent_liongate_movie
FROM cast_info AS ci,
     company_name AS cn,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND cn.name LIKE ''Lionsgate%''
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''violence'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'',
                    ''hospital'')
  AND mc.note LIKE ''%(Blu-ray)%''
  AND mi.info IN (''Horror'',
                  ''Thriller'')
  AND n.gender = ''m''
  AND t.production_year > 2000
  AND (t.title LIKE ''%Freddy%''
       OR t.title LIKE ''%Jason%''
       OR t.title LIKE ''Saw%'')
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND ci.movie_id = mc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND mi_idx.movie_id = mc.movie_id
  AND mk.movie_id = mc.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id
  AND cn.id = mc.company_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "writer"}, {"value": {"min": "t.title"}, "name": "violent_liongate_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"like": ["cn.name", {"literal": "Lionsgate%"}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "violence", "blood", "gore", "death", "female-nudity", "hospital"]}]}, {"like": ["mc.note", {"literal": "%(Blu-ray)%"}]}, {"in": ["mi.info", {"literal": ["Horror", "Thriller"]}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"gt": ["t.production_year", 2000]}, {"or": [{"like": ["t.title", {"literal": "%Freddy%"}]}, {"like": ["t.title", {"literal": "%Jason%"}]}, {"like": ["t.title", {"literal": "Saw%"}]}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cn.id", "mc.company_id"]}]}}', 36.7459984, 299.778992, 9465.79004);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (35, '20b.sql', 10, 'SELECT MIN(t.title) AS complete_downey_ironman_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     char_name AS chn,
     cast_info AS ci,
     keyword AS k,
     kind_type AS kt,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cct1.kind = ''cast''
  AND cct2.kind LIKE ''%complete%''
  AND chn.name NOT LIKE ''%Sherlock%''
  AND (chn.name LIKE ''%Tony%Stark%''
       OR chn.name LIKE ''%Iron%Man%'')
  AND k.keyword IN (''superhero'',
                    ''sequel'',
                    ''second-part'',
                    ''marvel-comics'',
                    ''based-on-comic'',
                    ''tv-special'',
                    ''fight'',
                    ''violence'')
  AND kt.kind = ''movie''
  AND n.name LIKE ''%Downey%Robert%''
  AND t.production_year > 2000
  AND kt.id = t.kind_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND t.id = cc.movie_id
  AND mk.movie_id = ci.movie_id
  AND mk.movie_id = cc.movie_id
  AND ci.movie_id = cc.movie_id
  AND chn.id = ci.person_role_id
  AND n.id = ci.person_id
  AND k.id = mk.keyword_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": {"value": {"min": "t.title"}, "name": "complete_downey_ironman_movie"}, "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cct1.kind", {"literal": "cast"}]}, {"like": ["cct2.kind", {"literal": "%complete%"}]}, {"nlike": ["chn.name", {"literal": "%Sherlock%"}]}, {"or": [{"like": ["chn.name", {"literal": "%Tony%Stark%"}]}, {"like": ["chn.name", {"literal": "%Iron%Man%"}]}]}, {"in": ["k.keyword", {"literal": ["superhero", "sequel", "second-part", "marvel-comics", "based-on-comic", "tv-special", "fight", "violence"]}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"like": ["n.name", {"literal": "%Downey%Robert%"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "ci.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["ci.movie_id", "cc.movie_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 8.40699959, 54568.0898, 2496.75);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (36, '4b.sql', 5, 'SELECT MIN(mi_idx.info) AS rating,
       MIN(t.title) AS movie_title
FROM info_type AS it,
     keyword AS k,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE it.info =''rating''
  AND k.keyword LIKE ''%sequel%''
  AND mi_idx.info > ''9.0''
  AND t.production_year > 2010
  AND t.id = mi_idx.movie_id
  AND t.id = mk.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "movie_title"}], "from": [{"value": "info_type", "name": "it"}, {"value": "keyword", "name": "k"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["it.info", {"literal": "rating"}]}, {"like": ["k.keyword", {"literal": "%sequel%"}]}, {"gt": ["mi_idx.info", {"literal": "9.0"}]}, {"gt": ["t.production_year", 2010]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it.id", "mi_idx.info_type_id"]}]}}', 0.846000016, 117.505997, 16426.4199);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (37, '22d.sql', 11, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS western_violent_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code != ''[us]''
  AND it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind IN (''movie'',
                  ''episode'')
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Danish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info < ''8.5''
  AND t.production_year > 2005
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "western_violent_movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"neq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"in": ["kt.kind", {"literal": ["movie", "episode"]}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Danish", "Norwegian", "German", "USA", "American"]}]}, {"lt": ["mi_idx.info", {"literal": "8.5"}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}]}}', 29.1930008, 2998.92993, 7480.25977);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (38, '14b.sql', 8, 'SELECT MIN(mi_idx.info) AS rating,
       MIN(t.title) AS western_dark_production
FROM info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'')
  AND kt.kind = ''movie''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Denish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info > ''6.0''
  AND t.production_year > 2010
  AND (t.title LIKE ''%murder%''
       OR t.title LIKE ''%Murder%''
       OR t.title LIKE ''%Mord%'')
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "western_dark_production"}], "from": [{"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title"]}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Denish", "Norwegian", "German", "USA", "American"]}]}, {"gt": ["mi_idx.info", {"literal": "6.0"}]}, {"gt": ["t.production_year", 2010]}, {"or": [{"like": ["t.title", {"literal": "%murder%"}]}, {"like": ["t.title", {"literal": "%Murder%"}]}, {"like": ["t.title", {"literal": "%Mord%"}]}]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}]}}', 3.30999994, 145.643997, 4911.2998);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (40, '18a.sql', 7, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(t.title) AS movie_title
FROM cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     name AS n,
     title AS t
WHERE ci.note IN (''(producer)'',
                  ''(executive producer)'')
  AND it1.info = ''budget''
  AND it2.info = ''votes''
  AND n.gender = ''m''
  AND n.name LIKE ''%Tim%''
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "t.title"}, "name": "movie_title"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(producer)", "(executive producer)"]}]}, {"eq": ["it1.info", {"literal": "budget"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"like": ["n.name", {"literal": "%Tim%"}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}]}}', 2.70499992, 6979.24609, 143713.906);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (41, '17c.sql', 7, 'SELECT MIN(n.name) AS member_in_charnamed_movie,
       MIN(n.name) AS a1
FROM cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword =''character-name-in-title''
  AND n.name LIKE ''X%''
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": [{"value": {"min": "n.name"}, "name": "member_in_charnamed_movie"}, {"value": {"min": "n.name"}, "name": "a1"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"like": ["n.name", {"literal": "X%"}]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 2.76300001, 11126.79, 4393.58008);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (43, '10c.sql', 7, 'SELECT MIN(chn.name) AS character,
       MIN(t.title) AS movie_with_american_producer
FROM char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     company_type AS ct,
     movie_companies AS mc,
     role_type AS rt,
     title AS t
WHERE ci.note LIKE ''%(producer)%''
  AND cn.country_code = ''[us]''
  AND t.production_year > 1990
  AND t.id = mc.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mc.movie_id
  AND chn.id = ci.person_role_id
  AND rt.id = ci.role_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id;
', '{"select": [{"value": {"min": "chn.name"}, "name": "character"}, {"value": {"min": "t.title"}, "name": "movie_with_american_producer"}], "from": [{"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "movie_companies", "name": "mc"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["ci.note", {"literal": "%(producer)%"}]}, {"eq": ["cn.country_code", {"literal": "[us]"}]}, {"gt": ["t.production_year", 1990]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["rt.id", "ci.role_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}]}}', 1.87699997, 7751.32178, 823326);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (44, '15b.sql', 9, 'SELECT MIN(mi.info) AS release_date,
       MIN(t.title) AS youtube_movie
FROM aka_title AS at,
     company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     keyword AS k,
     movie_companies AS mc,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code = ''[us]''
  AND cn.name = ''YouTube''
  AND it1.info = ''release dates''
  AND mc.note LIKE ''%(200%)%''
  AND mc.note LIKE ''%(worldwide)%''
  AND mi.note LIKE ''%internet%''
  AND mi.info LIKE ''USA:% 200%''
  AND t.production_year BETWEEN 2005 AND 2010
  AND t.id = at.movie_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = at.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = at.movie_id
  AND mc.movie_id = at.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "release_date"}, {"value": {"min": "t.title"}, "name": "youtube_movie"}], "from": [{"value": "aka_title", "name": "at"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["cn.name", {"literal": "YouTube"}]}, {"eq": ["it1.info", {"literal": "release dates"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"like": ["mc.note", {"literal": "%(worldwide)%"}]}, {"like": ["mi.note", {"literal": "%internet%"}]}, {"like": ["mi.info", {"literal": "USA:% 200%"}]}, {"between": ["t.production_year", 2005, 2010]}, {"eq": ["t.id", "at.movie_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "at.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "at.movie_id"]}, {"eq": ["mc.movie_id", "at.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}]}}', 12.9069996, 154.460999, 42649.2188);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (45, '28b.sql', 14, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS complete_euro_dark_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE cct1.kind = ''crew''
  AND cct2.kind != ''complete+verified''
  AND cn.country_code != ''[us]''
  AND it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind IN (''movie'',
                  ''episode'')
  AND mc.note NOT LIKE ''%(USA)%''
  AND mc.note LIKE ''%(200%)%''
  AND mi.info IN (''Sweden'',
                  ''Germany'',
                  ''Swedish'',
                  ''German'')
  AND mi_idx.info > ''6.5''
  AND t.production_year > 2005
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND t.id = cc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = cc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = cc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND mc.movie_id = cc.movie_id
  AND mi_idx.movie_id = cc.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "complete_euro_dark_movie"}], "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cct1.kind", {"literal": "crew"}]}, {"neq": ["cct2.kind", {"literal": "complete+verified"}]}, {"neq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"in": ["kt.kind", {"literal": ["movie", "episode"]}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Germany", "Swedish", "German"]}]}, {"gt": ["mi_idx.info", {"literal": "6.5"}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "cc.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["mc.movie_id", "cc.movie_id"]}, {"eq": ["mi_idx.movie_id", "cc.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 63.5660019, 1705.60803, 3195.67993);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (48, '6e.sql', 5, 'SELECT MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS marvel_movie
FROM cast_info AS ci,
     keyword AS k,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword = ''marvel-cinematic-universe''
  AND n.name LIKE ''%Downey%Robert%''
  AND t.production_year > 2000
  AND k.id = mk.keyword_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mk.movie_id
  AND n.id = ci.person_id;

', '{"select": [{"value": {"min": "k.keyword"}, "name": "movie_keyword"}, {"value": {"min": "n.name"}, "name": "actor_name"}, {"value": {"min": "t.title"}, "name": "marvel_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "marvel-cinematic-universe"}]}, {"like": ["n.name", {"literal": "%Downey%Robert%"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}]}}', 0.815999985, 28.059, 4117.18994);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (52, '1b.sql', 5, 'SELECT MIN(mc.note) AS production_note,
       MIN(t.title) AS movie_title,
       MIN(t.production_year) AS movie_year
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info_idx AS mi_idx,
     title AS t
WHERE ct.kind = ''production companies''
  AND it.info = ''bottom 10 rank''
  AND mc.note NOT LIKE ''%(as Metro-Goldwyn-Mayer Pictures)%''
  AND t.production_year BETWEEN 2005 AND 2010
  AND ct.id = mc.company_type_id
  AND t.id = mc.movie_id
  AND t.id = mi_idx.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND it.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mc.note"}, "name": "production_note"}, {"value": {"min": "t.title"}, "name": "movie_title"}, {"value": {"min": "t.production_year"}, "name": "movie_year"}], "from": [{"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "bottom 10 rank"}]}, {"nlike": ["mc.note", {"literal": "%(as Metro-Goldwyn-Mayer Pictures)%"}]}, {"between": ["t.production_year", 2005, 2010]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["it.id", "mi_idx.info_type_id"]}]}}', 0.944000006, 90.7600021, 19621.0898);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (53, '19d.sql', 10, 'SELECT MIN(n.name) AS voicing_actress,
       MIN(t.title) AS jap_engl_voiced_movie
FROM aka_name AS an,
     char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     info_type AS it,
     movie_companies AS mc,
     movie_info AS mi,
     name AS n,
     role_type AS rt,
     title AS t
WHERE ci.note IN (''(voice)'',
                  ''(voice: Japanese version)'',
                  ''(voice) (uncredited)'',
                  ''(voice: English version)'')
  AND cn.country_code =''[us]''
  AND it.info = ''release dates''
  AND n.gender =''f''
  AND rt.role =''actress''
  AND t.production_year > 2000
  AND t.id = mi.movie_id
  AND t.id = mc.movie_id
  AND t.id = ci.movie_id
  AND mc.movie_id = ci.movie_id
  AND mc.movie_id = mi.movie_id
  AND mi.movie_id = ci.movie_id
  AND cn.id = mc.company_id
  AND it.id = mi.info_type_id
  AND n.id = ci.person_id
  AND rt.id = ci.role_id
  AND n.id = an.person_id
  AND ci.person_id = an.person_id
  AND chn.id = ci.person_role_id;

', '{"select": [{"value": {"min": "n.name"}, "name": "voicing_actress"}, {"value": {"min": "t.title"}, "name": "jap_engl_voiced_movie"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "name", "name": "n"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(voice)", "(voice: Japanese version)", "(voice) (uncredited)", "(voice: English version)"]}]}, {"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it.info", {"literal": "release dates"}]}, {"eq": ["n.gender", {"literal": "f"}]}, {"eq": ["rt.role", {"literal": "actress"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["mc.movie_id", "ci.movie_id"]}, {"eq": ["mc.movie_id", "mi.movie_id"]}, {"eq": ["mi.movie_id", "ci.movie_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["it.id", "mi.info_type_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["rt.id", "ci.role_id"]}, {"eq": ["n.id", "an.person_id"]}, {"eq": ["ci.person_id", "an.person_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}]}}', 15.0380001, 7340.93311, 489761.375);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (54, '30a.sql', 12, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS complete_violent_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cct1.kind IN (''cast'',
                    ''crew'')
  AND cct2.kind =''complete+verified''
  AND ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''violence'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'',
                    ''hospital'')
  AND mi.info IN (''Horror'',
                  ''Thriller'')
  AND n.gender = ''m''
  AND t.production_year > 2000
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND t.id = cc.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND ci.movie_id = cc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi.movie_id = cc.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND mi_idx.movie_id = cc.movie_id
  AND mk.movie_id = cc.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "writer"}, {"value": {"min": "t.title"}, "name": "complete_violent_movie"}], "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["cct1.kind", {"literal": ["cast", "crew"]}]}, {"eq": ["cct2.kind", {"literal": "complete+verified"}]}, {"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "violence", "blood", "gore", "death", "female-nudity", "hospital"]}]}, {"in": ["mi.info", {"literal": ["Horror", "Thriller"]}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "cc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "cc.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 55.8979988, 2587.04102, 2555.72998);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (55, '10b.sql', 7, 'SELECT MIN(chn.name) AS character,
       MIN(t.title) AS russian_mov_with_actor_producer
FROM char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     company_type AS ct,
     movie_companies AS mc,
     role_type AS rt,
     title AS t
WHERE ci.note LIKE ''%(producer)%''
  AND cn.country_code = ''[ru]''
  AND rt.role = ''actor''
  AND t.production_year > 2010
  AND t.id = mc.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mc.movie_id
  AND chn.id = ci.person_role_id
  AND rt.id = ci.role_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id;

', '{"select": [{"value": {"min": "chn.name"}, "name": "character"}, {"value": {"min": "t.title"}, "name": "russian_mov_with_actor_producer"}], "from": [{"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "movie_companies", "name": "mc"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["ci.note", {"literal": "%(producer)%"}]}, {"eq": ["cn.country_code", {"literal": "[ru]"}]}, {"eq": ["rt.role", {"literal": "actor"}]}, {"gt": ["t.production_year", 2010]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["rt.id", "ci.role_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}]}}', 1.92900002, 266.363007, 40274.4219);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (57, '30b.sql', 12, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS complete_gore_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cct1.kind IN (''cast'',
                    ''crew'')
  AND cct2.kind =''complete+verified''
  AND ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''violence'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'',
                    ''hospital'')
  AND mi.info IN (''Horror'',
                  ''Thriller'')
  AND n.gender = ''m''
  AND t.production_year > 2000
  AND (t.title LIKE ''%Freddy%''
       OR t.title LIKE ''%Jason%''
       OR t.title LIKE ''Saw%'')
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND t.id = cc.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND ci.movie_id = cc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi.movie_id = cc.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND mi_idx.movie_id = cc.movie_id
  AND mk.movie_id = cc.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "writer"}, {"value": {"min": "t.title"}, "name": "complete_gore_movie"}], "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["cct1.kind", {"literal": ["cast", "crew"]}]}, {"eq": ["cct2.kind", {"literal": "complete+verified"}]}, {"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "violence", "blood", "gore", "death", "female-nudity", "hospital"]}]}, {"in": ["mi.info", {"literal": ["Horror", "Thriller"]}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"gt": ["t.production_year", 2000]}, {"or": [{"like": ["t.title", {"literal": "%Freddy%"}]}, {"like": ["t.title", {"literal": "%Jason%"}]}, {"like": ["t.title", {"literal": "Saw%"}]}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "cc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "cc.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 54.3320007, 144.477005, 2561.15991);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (59, '9c.sql', 8, 'SELECT MIN(an.name) AS alternative_name,
       MIN(chn.name) AS voiced_character_name,
       MIN(n.name) AS voicing_actress,
       MIN(t.title) AS american_movie
FROM aka_name AS an,
     char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n,
     role_type AS rt,
     title AS t
WHERE ci.note IN (''(voice)'',
                  ''(voice: Japanese version)'',
                  ''(voice) (uncredited)'',
                  ''(voice: English version)'')
  AND cn.country_code =''[us]''
  AND n.gender =''f''
  AND n.name LIKE ''%An%''
  AND rt.role =''actress''
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND ci.movie_id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND n.id = ci.person_id
  AND chn.id = ci.person_role_id
  AND an.person_id = n.id
  AND an.person_id = ci.person_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "alternative_name"}, {"value": {"min": "chn.name"}, "name": "voiced_character_name"}, {"value": {"min": "n.name"}, "name": "voicing_actress"}, {"value": {"min": "t.title"}, "name": "american_movie"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "movie_companies", "name": "mc"}, {"value": "name", "name": "n"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(voice)", "(voice: Japanese version)", "(voice) (uncredited)", "(voice: English version)"]}]}, {"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["n.gender", {"literal": "f"}]}, {"like": ["n.name", {"literal": "%An%"}]}, {"eq": ["rt.role", {"literal": "actress"}]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.role_id", "rt.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["an.person_id", "ci.person_id"]}]}}', 3.65700006, 1382.38098, 333698.906);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (60, '17a.sql', 7, 'SELECT MIN(n.name) AS member_in_charnamed_american_movie,
       MIN(n.name) AS a1
FROM cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cn.country_code =''[us]''
  AND k.keyword =''character-name-in-title''
  AND n.name LIKE ''B%''
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": [{"value": {"min": "n.name"}, "name": "member_in_charnamed_american_movie"}, {"value": {"min": "n.name"}, "name": "a1"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"like": ["n.name", {"literal": "B%"}]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 2.51200008, 12950.6514, 4566.02002);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (62, '32a.sql', 6, 'SELECT MIN(lt.link) AS link_type,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM keyword AS k,
     link_type AS lt,
     movie_keyword AS mk,
     movie_link AS ml,
     title AS t1,
     title AS t2
WHERE k.keyword =''10,000-mile-club''
  AND mk.keyword_id = k.id
  AND t1.id = mk.movie_id
  AND ml.movie_id = t1.id
  AND ml.linked_movie_id = t2.id
  AND lt.id = ml.link_type_id
  AND mk.movie_id = t1.id;

', '{"select": [{"value": {"min": "lt.link"}, "name": "link_type"}, {"value": {"min": "t1.title"}, "name": "first_movie"}, {"value": {"min": "t2.title"}, "name": "second_movie"}], "from": [{"value": "keyword", "name": "k"}, {"value": "link_type", "name": "lt"}, {"value": "movie_keyword", "name": "mk"}, {"value": "movie_link", "name": "ml"}, {"value": "title", "name": "t1"}, {"value": "title", "name": "t2"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "10,000-mile-club"}]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t1.id", "mk.movie_id"]}, {"eq": ["ml.movie_id", "t1.id"]}, {"eq": ["ml.linked_movie_id", "t2.id"]}, {"eq": ["lt.id", "ml.link_type_id"]}, {"eq": ["mk.movie_id", "t1.id"]}]}}', 5.23799992, 8.61900043, 3809.79004);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (63, '28c.sql', 14, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS complete_euro_dark_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE cct1.kind = ''cast''
  AND cct2.kind = ''complete''
  AND cn.country_code != ''[us]''
  AND it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind IN (''movie'',
                  ''episode'')
  AND mc.note NOT LIKE ''%(USA)%''
  AND mc.note LIKE ''%(200%)%''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Danish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info < ''8.5''
  AND t.production_year > 2005
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND t.id = cc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = cc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = cc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND mc.movie_id = cc.movie_id
  AND mi_idx.movie_id = cc.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "complete_euro_dark_movie"}], "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cct1.kind", {"literal": "cast"}]}, {"eq": ["cct2.kind", {"literal": "complete"}]}, {"neq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"in": ["kt.kind", {"literal": ["movie", "episode"]}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Danish", "Norwegian", "German", "USA", "American"]}]}, {"lt": ["mi_idx.info", {"literal": "8.5"}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "cc.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["mc.movie_id", "cc.movie_id"]}, {"eq": ["mi_idx.movie_id", "cc.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 63.2709999, 3346.39893, 2492.19995);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (64, '31c.sql', 11, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS violent_liongate_movie
FROM cast_info AS ci,
     company_name AS cn,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND cn.name LIKE ''Lionsgate%''
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''violence'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'',
                    ''hospital'')
  AND mi.info IN (''Horror'',
                  ''Action'',
                  ''Sci-Fi'',
                  ''Thriller'',
                  ''Crime'',
                  ''War'')
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND ci.movie_id = mc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND mi_idx.movie_id = mc.movie_id
  AND mk.movie_id = mc.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id
  AND cn.id = mc.company_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "writer"}, {"value": {"min": "t.title"}, "name": "violent_liongate_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"like": ["cn.name", {"literal": "Lionsgate%"}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "violence", "blood", "gore", "death", "female-nudity", "hospital"]}]}, {"in": ["mi.info", {"literal": ["Horror", "Action", "Sci-Fi", "Thriller", "Crime", "War"]}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cn.id", "mc.company_id"]}]}}', 38.9860001, 1420.38599, 9483.91992);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (65, '15a.sql', 9, 'SELECT MIN(mi.info) AS release_date,
       MIN(t.title) AS internet_movie
FROM aka_title AS at,
     company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     keyword AS k,
     movie_companies AS mc,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code = ''[us]''
  AND it1.info = ''release dates''
  AND mc.note LIKE ''%(200%)%''
  AND mc.note LIKE ''%(worldwide)%''
  AND mi.note LIKE ''%internet%''
  AND mi.info LIKE ''USA:% 200%''
  AND t.production_year > 2000
  AND t.id = at.movie_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = at.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = at.movie_id
  AND mc.movie_id = at.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "release_date"}, {"value": {"min": "t.title"}, "name": "internet_movie"}], "from": [{"value": "aka_title", "name": "at"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "release dates"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"like": ["mc.note", {"literal": "%(worldwide)%"}]}, {"like": ["mi.note", {"literal": "%internet%"}]}, {"like": ["mi.info", {"literal": "USA:% 200%"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["t.id", "at.movie_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "at.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "at.movie_id"]}, {"eq": ["mc.movie_id", "at.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}]}}', 8.48200035, 592.273987, 54633.2891);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (66, '17d.sql', 7, 'SELECT MIN(n.name) AS member_in_charnamed_movie
FROM cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword =''character-name-in-title''
  AND n.name LIKE ''%Bert%''
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": {"value": {"min": "n.name"}, "name": "member_in_charnamed_movie"}, "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"like": ["n.name", {"literal": "%Bert%"}]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 2.5079999, 9650.24805, 4393.56982);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (67, '13a.sql', 9, 'SELECT MIN(mi.info) AS release_date,
       MIN(miidx.info) AS rating,
       MIN(t.title) AS german_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it,
     info_type AS it2,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS miidx,
     title AS t
WHERE cn.country_code =''[de]''
  AND ct.kind =''production companies''
  AND it.info =''rating''
  AND it2.info =''release dates''
  AND kt.kind =''movie''
  AND mi.movie_id = t.id
  AND it2.id = mi.info_type_id
  AND kt.id = t.kind_id
  AND mc.movie_id = t.id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id
  AND miidx.movie_id = t.id
  AND it.id = miidx.info_type_id
  AND mi.movie_id = miidx.movie_id
  AND mi.movie_id = mc.movie_id
  AND miidx.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "release_date"}, {"value": {"min": "miidx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "german_movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "info_type", "name": "it2"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "miidx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[de]"}]}, {"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "rating"}]}, {"eq": ["it2.info", {"literal": "release dates"}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"eq": ["mi.movie_id", "t.id"]}, {"eq": ["it2.id", "mi.info_type_id"]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["miidx.movie_id", "t.id"]}, {"eq": ["it.id", "miidx.info_type_id"]}, {"eq": ["mi.movie_id", "miidx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["miidx.movie_id", "mc.movie_id"]}]}}', 6.05700016, 1298.48499, 19268.2109);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (68, '12a.sql', 8, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS drama_horror_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     title AS t
WHERE cn.country_code = ''[us]''
  AND ct.kind = ''production companies''
  AND it1.info = ''genres''
  AND it2.info = ''rating''
  AND mi.info IN (''Drama'',
                  ''Horror'')
  AND mi_idx.info > ''8.0''
  AND t.production_year BETWEEN 2005 AND 2008
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND mi.info_type_id = it1.id
  AND mi_idx.info_type_id = it2.id
  AND t.id = mc.movie_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id
  AND mc.movie_id = mi.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND mi.movie_id = mi_idx.movie_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "drama_horror_movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["mi.info", {"literal": ["Drama", "Horror"]}]}, {"gt": ["mi_idx.info", {"literal": "8.0"}]}, {"between": ["t.production_year", 2005, 2008]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mi.info_type_id", "it1.id"]}, {"eq": ["mi_idx.info_type_id", "it2.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["mc.movie_id", "mi.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}]}}', 3.84599996, 209.733002, 16739.9297);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (69, '1c.sql', 5, 'SELECT MIN(mc.note) AS production_note,
       MIN(t.title) AS movie_title,
       MIN(t.production_year) AS movie_year
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info_idx AS mi_idx,
     title AS t
WHERE ct.kind = ''production companies''
  AND it.info = ''top 250 rank''
  AND mc.note NOT LIKE ''%(as Metro-Goldwyn-Mayer Pictures)%''
  AND (mc.note LIKE ''%(co-production)%'')
  AND t.production_year >2010
  AND ct.id = mc.company_type_id
  AND t.id = mc.movie_id
  AND t.id = mi_idx.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND it.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mc.note"}, "name": "production_note"}, {"value": {"min": "t.title"}, "name": "movie_title"}, {"value": {"min": "t.production_year"}, "name": "movie_year"}], "from": [{"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "top 250 rank"}]}, {"nlike": ["mc.note", {"literal": "%(as Metro-Goldwyn-Mayer Pictures)%"}]}, {"like": ["mc.note", {"literal": "%(co-production)%"}]}, {"gt": ["t.production_year", 2010]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["it.id", "mi_idx.info_type_id"]}]}}', 0.841000021, 82.6819992, 19496.8008);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (70, '13b.sql', 9, 'SELECT MIN(cn.name) AS producing_company,
       MIN(miidx.info) AS rating,
       MIN(t.title) AS movie_about_winning
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it,
     info_type AS it2,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS miidx,
     title AS t
WHERE cn.country_code =''[us]''
  AND ct.kind =''production companies''
  AND it.info =''rating''
  AND it2.info =''release dates''
  AND kt.kind =''movie''
  AND t.title != ''''
  AND (t.title LIKE ''%Champion%''
       OR t.title LIKE ''%Loser%'')
  AND mi.movie_id = t.id
  AND it2.id = mi.info_type_id
  AND kt.id = t.kind_id
  AND mc.movie_id = t.id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id
  AND miidx.movie_id = t.id
  AND it.id = miidx.info_type_id
  AND mi.movie_id = miidx.movie_id
  AND mi.movie_id = mc.movie_id
  AND miidx.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "producing_company"}, {"value": {"min": "miidx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "movie_about_winning"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "info_type", "name": "it2"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "miidx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "rating"}]}, {"eq": ["it2.info", {"literal": "release dates"}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"neq": ["t.title", {"literal": ""}]}, {"or": [{"like": ["t.title", {"literal": "%Champion%"}]}, {"like": ["t.title", {"literal": "%Loser%"}]}]}, {"eq": ["mi.movie_id", "t.id"]}, {"eq": ["it2.id", "mi.info_type_id"]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["miidx.movie_id", "t.id"]}, {"eq": ["it.id", "miidx.info_type_id"]}, {"eq": ["mi.movie_id", "miidx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["miidx.movie_id", "mc.movie_id"]}]}}', 5.06400013, 510.984009, 19236.6992);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (71, '5c.sql', 5, 'SELECT MIN(t.title) AS american_movie
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info AS mi,
     title AS t
WHERE ct.kind = ''production companies''
  AND mc.note NOT LIKE ''%(TV)%''
  AND mc.note LIKE ''%(USA)%''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Denish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND t.production_year > 1990
  AND t.id = mi.movie_id
  AND t.id = mc.movie_id
  AND mc.movie_id = mi.movie_id
  AND ct.id = mc.company_type_id
  AND it.id = mi.info_type_id;

', '{"select": {"value": {"min": "t.title"}, "name": "american_movie"}, "from": [{"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ct.kind", {"literal": "production companies"}]}, {"nlike": ["mc.note", {"literal": "%(TV)%"}]}, {"like": ["mc.note", {"literal": "%(USA)%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Denish", "Norwegian", "German", "USA", "American"]}]}, {"gt": ["t.production_year", 1990]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.movie_id", "mi.movie_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["it.id", "mi.info_type_id"]}]}}', 1.01100004, 160.964996, 37497.3516);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (73, '16d.sql', 8, 'SELECT MIN(an.name) AS cool_actor_pseudonym,
       MIN(t.title) AS series_named_after_char
FROM aka_name AS an,
     cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cn.country_code =''[us]''
  AND k.keyword =''character-name-in-title''
  AND t.episode_nr >= 5
  AND t.episode_nr < 100
  AND an.person_id = n.id
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND an.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "cool_actor_pseudonym"}, {"value": {"min": "t.title"}, "name": "series_named_after_char"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"gte": ["t.episode_nr", 5]}, {"lt": ["t.episode_nr", 100]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["an.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 4.82600021, 1973.77002, 4192.14014);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (74, '33a.sql', 14, 'SELECT MIN(cn1.name) AS first_company,
       MIN(cn2.name) AS second_company,
       MIN(mi_idx1.info) AS first_rating,
       MIN(mi_idx2.info) AS second_rating,
       MIN(t1.title) AS first_movie,
       MIN(t2.title) AS second_movie
FROM company_name AS cn1,
     company_name AS cn2,
     info_type AS it1,
     info_type AS it2,
     kind_type AS kt1,
     kind_type AS kt2,
     link_type AS lt,
     movie_companies AS mc1,
     movie_companies AS mc2,
     movie_info_idx AS mi_idx1,
     movie_info_idx AS mi_idx2,
     movie_link AS ml,
     title AS t1,
     title AS t2
WHERE cn1.country_code = ''[us]''
  AND it1.info = ''rating''
  AND it2.info = ''rating''
  AND kt1.kind IN (''tv series'')
  AND kt2.kind IN (''tv series'')
  AND lt.link IN (''sequel'',
                  ''follows'',
                  ''followed by'')
  AND mi_idx2.info < ''3.0''
  AND t2.production_year BETWEEN 2005 AND 2008
  AND lt.id = ml.link_type_id
  AND t1.id = ml.movie_id
  AND t2.id = ml.linked_movie_id
  AND it1.id = mi_idx1.info_type_id
  AND t1.id = mi_idx1.movie_id
  AND kt1.id = t1.kind_id
  AND cn1.id = mc1.company_id
  AND t1.id = mc1.movie_id
  AND ml.movie_id = mi_idx1.movie_id
  AND ml.movie_id = mc1.movie_id
  AND mi_idx1.movie_id = mc1.movie_id
  AND it2.id = mi_idx2.info_type_id
  AND t2.id = mi_idx2.movie_id
  AND kt2.id = t2.kind_id
  AND cn2.id = mc2.company_id
  AND t2.id = mc2.movie_id
  AND ml.linked_movie_id = mi_idx2.movie_id
  AND ml.linked_movie_id = mc2.movie_id
  AND mi_idx2.movie_id = mc2.movie_id;

', '{"select": [{"value": {"min": "cn1.name"}, "name": "first_company"}, {"value": {"min": "cn2.name"}, "name": "second_company"}, {"value": {"min": "mi_idx1.info"}, "name": "first_rating"}, {"value": {"min": "mi_idx2.info"}, "name": "second_rating"}, {"value": {"min": "t1.title"}, "name": "first_movie"}, {"value": {"min": "t2.title"}, "name": "second_movie"}], "from": [{"value": "company_name", "name": "cn1"}, {"value": "company_name", "name": "cn2"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "kind_type", "name": "kt1"}, {"value": "kind_type", "name": "kt2"}, {"value": "link_type", "name": "lt"}, {"value": "movie_companies", "name": "mc1"}, {"value": "movie_companies", "name": "mc2"}, {"value": "movie_info_idx", "name": "mi_idx1"}, {"value": "movie_info_idx", "name": "mi_idx2"}, {"value": "movie_link", "name": "ml"}, {"value": "title", "name": "t1"}, {"value": "title", "name": "t2"}], "where": {"and": [{"eq": ["cn1.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "rating"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["kt1.kind", {"literal": "tv series"}]}, {"in": ["kt2.kind", {"literal": "tv series"}]}, {"in": ["lt.link", {"literal": ["sequel", "follows", "followed by"]}]}, {"lt": ["mi_idx2.info", {"literal": "3.0"}]}, {"between": ["t2.production_year", 2005, 2008]}, {"eq": ["lt.id", "ml.link_type_id"]}, {"eq": ["t1.id", "ml.movie_id"]}, {"eq": ["t2.id", "ml.linked_movie_id"]}, {"eq": ["it1.id", "mi_idx1.info_type_id"]}, {"eq": ["t1.id", "mi_idx1.movie_id"]}, {"eq": ["kt1.id", "t1.kind_id"]}, {"eq": ["cn1.id", "mc1.company_id"]}, {"eq": ["t1.id", "mc1.movie_id"]}, {"eq": ["ml.movie_id", "mi_idx1.movie_id"]}, {"eq": ["ml.movie_id", "mc1.movie_id"]}, {"eq": ["mi_idx1.movie_id", "mc1.movie_id"]}, {"eq": ["it2.id", "mi_idx2.info_type_id"]}, {"eq": ["t2.id", "mi_idx2.movie_id"]}, {"eq": ["kt2.id", "t2.kind_id"]}, {"eq": ["cn2.id", "mc2.company_id"]}, {"eq": ["t2.id", "mc2.movie_id"]}, {"eq": ["ml.linked_movie_id", "mi_idx2.movie_id"]}, {"eq": ["ml.linked_movie_id", "mc2.movie_id"]}, {"eq": ["mi_idx2.movie_id", "mc2.movie_id"]}]}}', 63.7900009, 46.1459999, 1878.25);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (75, '4a.sql', 5, 'SELECT MIN(mi_idx.info) AS rating,
       MIN(t.title) AS movie_title
FROM info_type AS it,
     keyword AS k,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE it.info =''rating''
  AND k.keyword LIKE ''%sequel%''
  AND mi_idx.info > ''5.0''
  AND t.production_year > 2005
  AND t.id = mi_idx.movie_id
  AND t.id = mk.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "movie_title"}], "from": [{"value": "info_type", "name": "it"}, {"value": "keyword", "name": "k"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["it.info", {"literal": "rating"}]}, {"like": ["k.keyword", {"literal": "%sequel%"}]}, {"gt": ["mi_idx.info", {"literal": "5.0"}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it.id", "mi_idx.info_type_id"]}]}}', 0.829999983, 141.671997, 16434.0098);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (76, '8b.sql', 7, 'SELECT MIN(an.name) AS acress_pseudonym,
       MIN(t.title) AS japanese_anime_movie
FROM aka_name AS an,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n,
     role_type AS rt,
     title AS t
WHERE ci.note =''(voice: English version)''
  AND cn.country_code =''[jp]''
  AND mc.note LIKE ''%(Japan)%''
  AND mc.note NOT LIKE ''%(USA)%''
  AND (mc.note LIKE ''%(2006)%''
       OR mc.note LIKE ''%(2007)%'')
  AND n.name LIKE ''%Yo%''
  AND n.name NOT LIKE ''%Yu%''
  AND rt.role =''actress''
  AND t.production_year BETWEEN 2006 AND 2007
  AND (t.title LIKE ''One Piece%''
       OR t.title LIKE ''Dragon Ball Z%'')
  AND an.person_id = n.id
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND an.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "acress_pseudonym"}, {"value": {"min": "t.title"}, "name": "japanese_anime_movie"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "movie_companies", "name": "mc"}, {"value": "name", "name": "n"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ci.note", {"literal": "(voice: English version)"}]}, {"eq": ["cn.country_code", {"literal": "[jp]"}]}, {"like": ["mc.note", {"literal": "%(Japan)%"}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"or": [{"like": ["mc.note", {"literal": "%(2006)%"}]}, {"like": ["mc.note", {"literal": "%(2007)%"}]}]}, {"like": ["n.name", {"literal": "%Yo%"}]}, {"nlike": ["n.name", {"literal": "%Yu%"}]}, {"eq": ["rt.role", {"literal": "actress"}]}, {"between": ["t.production_year", 2006, 2007]}, {"or": [{"like": ["t.title", {"literal": "One Piece%"}]}, {"like": ["t.title", {"literal": "Dragon Ball Z%"}]}]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.role_id", "rt.id"]}, {"eq": ["an.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}]}}', 2.22900009, 159.072998, 43266.3203);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (77, '3joins.sql', 3, 'SELECT ci.id AS id FROM cast_info AS ci, aka_title AS at, aka_name AS an
WHERE ci.movie_id=at.movie_id AND ci.person_id=an.person_id
LIMIT 5;
', '{"select": {"value": "ci.id", "name": "id"}, "from": [{"value": "cast_info", "name": "ci"}, {"value": "aka_title", "name": "at"}, {"value": "aka_name", "name": "an"}], "where": {"and": [{"eq": ["ci.movie_id", "at.movie_id"]}, {"eq": ["ci.person_id", "an.person_id"]}]}, "limit": 5}', 0.546999991, 0.221000001, 2.3599999);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (79, '3b.sql', 4, 'SELECT MIN(t.title) AS movie_title
FROM keyword AS k,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t
WHERE k.keyword LIKE ''%sequel%''
  AND mi.info IN (''Bulgaria'')
  AND t.production_year > 2010
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND mk.movie_id = mi.movie_id
  AND k.id = mk.keyword_id;

', '{"select": {"value": {"min": "t.title"}, "name": "movie_title"}, "from": [{"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["k.keyword", {"literal": "%sequel%"}]}, {"in": ["mi.info", {"literal": "Bulgaria"}]}, {"gt": ["t.production_year", 2010]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}]}}', 0.735000014, 130.490005, 16516.1309);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (80, '3c.sql', 4, 'SELECT MIN(t.title) AS movie_title
FROM keyword AS k,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t
WHERE k.keyword LIKE ''%sequel%''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Denish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND t.production_year > 1990
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND mk.movie_id = mi.movie_id
  AND k.id = mk.keyword_id;

', '{"select": {"value": {"min": "t.title"}, "name": "movie_title"}, "from": [{"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["k.keyword", {"literal": "%sequel%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Denish", "Norwegian", "German", "USA", "American"]}]}, {"gt": ["t.production_year", 1990]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}]}}', 0.630999982, 513.270996, 17013.1504);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (81, '14a.sql', 8, 'SELECT MIN(mi_idx.info) AS rating,
       MIN(t.title) AS northern_dark_movie
FROM info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind = ''movie''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Denish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info < ''8.5''
  AND t.production_year > 2010
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "northern_dark_movie"}], "from": [{"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Denish", "Norwegian", "German", "USA", "American"]}]}, {"lt": ["mi_idx.info", {"literal": "8.5"}]}, {"gt": ["t.production_year", 2010]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}]}}', 3.41199994, 595.366028, 7446.7002);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (82, '31a.sql', 11, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS violent_liongate_movie
FROM cast_info AS ci,
     company_name AS cn,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND cn.name LIKE ''Lionsgate%''
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''violence'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'',
                    ''hospital'')
  AND mi.info IN (''Horror'',
                  ''Thriller'')
  AND n.gender = ''m''
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND ci.movie_id = mc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND mi_idx.movie_id = mc.movie_id
  AND mk.movie_id = mc.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id
  AND cn.id = mc.company_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "writer"}, {"value": {"min": "t.title"}, "name": "violent_liongate_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"like": ["cn.name", {"literal": "Lionsgate%"}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "violence", "blood", "gore", "death", "female-nudity", "hospital"]}]}, {"in": ["mi.info", {"literal": ["Horror", "Thriller"]}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cn.id", "mc.company_id"]}]}}', 35.5979996, 1298.90295, 9483.7002);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (93, '13d.sql', 9, 'SELECT MIN(cn.name) AS producing_company,
       MIN(miidx.info) AS rating,
       MIN(t.title) AS movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it,
     info_type AS it2,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS miidx,
     title AS t
WHERE cn.country_code =''[us]''
  AND ct.kind =''production companies''
  AND it.info =''rating''
  AND it2.info =''release dates''
  AND kt.kind =''movie''
  AND mi.movie_id = t.id
  AND it2.id = mi.info_type_id
  AND kt.id = t.kind_id
  AND mc.movie_id = t.id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id
  AND miidx.movie_id = t.id
  AND it.id = miidx.info_type_id
  AND mi.movie_id = miidx.movie_id
  AND mi.movie_id = mc.movie_id
  AND miidx.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "producing_company"}, {"value": {"min": "miidx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it"}, {"value": "info_type", "name": "it2"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "miidx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it.info", {"literal": "rating"}]}, {"eq": ["it2.info", {"literal": "release dates"}]}, {"eq": ["kt.kind", {"literal": "movie"}]}, {"eq": ["mi.movie_id", "t.id"]}, {"eq": ["it2.id", "mi.info_type_id"]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["miidx.movie_id", "t.id"]}, {"eq": ["it.id", "miidx.info_type_id"]}, {"eq": ["mi.movie_id", "miidx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["miidx.movie_id", "mc.movie_id"]}]}}', 6.125, 3414.59302, 19269.5098);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (83, '16b.sql', 8, 'SELECT MIN(an.name) AS cool_actor_pseudonym,
       MIN(t.title) AS series_named_after_char
FROM aka_name AS an,
     cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cn.country_code =''[us]''
  AND k.keyword =''character-name-in-title''
  AND an.person_id = n.id
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND an.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "cool_actor_pseudonym"}, {"value": {"min": "t.title"}, "name": "series_named_after_char"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["an.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 4.40500021, 21269.9648, 5345.83984);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (84, '6c.sql', 5, 'SELECT MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS marvel_movie
FROM cast_info AS ci,
     keyword AS k,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword = ''marvel-cinematic-universe''
  AND n.name LIKE ''%Downey%Robert%''
  AND t.production_year > 2014
  AND k.id = mk.keyword_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mk.movie_id
  AND n.id = ci.person_id;

', '{"select": [{"value": {"min": "k.keyword"}, "name": "movie_keyword"}, {"value": {"min": "n.name"}, "name": "actor_name"}, {"value": {"min": "t.title"}, "name": "marvel_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "marvel-cinematic-universe"}]}, {"like": ["n.name", {"literal": "%Downey%Robert%"}]}, {"gt": ["t.production_year", 2014]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}]}}', 0.814999998, 9.10400009, 3763.1499);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (85, '7b.sql', 8, 'SELECT MIN(n.name) AS of_person,
       MIN(t.title) AS biography_movie
FROM aka_name AS an,
     cast_info AS ci,
     info_type AS it,
     link_type AS lt,
     movie_link AS ml,
     name AS n,
     person_info AS pi,
     title AS t
WHERE an.name LIKE ''%a%''
  AND it.info =''mini biography''
  AND lt.link =''features''
  AND n.name_pcode_cf LIKE ''D%''
  AND n.gender=''m''
  AND pi.note =''Volker Boehm''
  AND t.production_year BETWEEN 1980 AND 1984
  AND n.id = an.person_id
  AND n.id = pi.person_id
  AND ci.person_id = n.id
  AND t.id = ci.movie_id
  AND ml.linked_movie_id = t.id
  AND lt.id = ml.link_type_id
  AND it.id = pi.info_type_id
  AND pi.person_id = an.person_id
  AND pi.person_id = ci.person_id
  AND an.person_id = ci.person_id
  AND ci.movie_id = ml.linked_movie_id;

', '{"select": [{"value": {"min": "n.name"}, "name": "of_person"}, {"value": {"min": "t.title"}, "name": "biography_movie"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it"}, {"value": "link_type", "name": "lt"}, {"value": "movie_link", "name": "ml"}, {"value": "name", "name": "n"}, {"value": "person_info", "name": "pi"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["an.name", {"literal": "%a%"}]}, {"eq": ["it.info", {"literal": "mini biography"}]}, {"eq": ["lt.link", {"literal": "features"}]}, {"like": ["n.name_pcode_cf", {"literal": "D%"}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"eq": ["pi.note", {"literal": "Volker Boehm"}]}, {"between": ["t.production_year", 1980, 1984]}, {"eq": ["n.id", "an.person_id"]}, {"eq": ["n.id", "pi.person_id"]}, {"eq": ["ci.person_id", "n.id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ml.linked_movie_id", "t.id"]}, {"eq": ["lt.id", "ml.link_type_id"]}, {"eq": ["it.id", "pi.info_type_id"]}, {"eq": ["pi.person_id", "an.person_id"]}, {"eq": ["pi.person_id", "ci.person_id"]}, {"eq": ["an.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "ml.linked_movie_id"]}]}}', 5.421, 393.768005, 1512.51001);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (86, '22c.sql', 11, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS western_violent_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code != ''[us]''
  AND it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind IN (''movie'',
                  ''episode'')
  AND mc.note NOT LIKE ''%(USA)%''
  AND mc.note LIKE ''%(200%)%''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Danish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info < ''8.5''
  AND t.production_year > 2005
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "western_violent_movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"neq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"in": ["kt.kind", {"literal": ["movie", "episode"]}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Danish", "Norwegian", "German", "USA", "American"]}]}, {"lt": ["mi_idx.info", {"literal": "8.5"}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}]}}', 25.8829994, 2481.65601, 7480.33984);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (90, '8c.sql', 7, 'SELECT MIN(a1.name) AS writer_pseudo_name,
       MIN(t.title) AS movie_title
FROM aka_name AS a1,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n1,
     role_type AS rt,
     title AS t
WHERE cn.country_code =''[us]''
  AND rt.role =''writer''
  AND a1.person_id = n1.id
  AND n1.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND a1.person_id = ci.person_id
  AND ci.movie_id = mc.movie_id;

', '{"select": [{"value": {"min": "a1.name"}, "name": "writer_pseudo_name"}, {"value": {"min": "t.title"}, "name": "movie_title"}], "from": [{"value": "aka_name", "name": "a1"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "movie_companies", "name": "mc"}, {"value": "name", "name": "n1"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["rt.role", {"literal": "writer"}]}, {"eq": ["a1.person_id", "n1.id"]}, {"eq": ["n1.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.role_id", "rt.id"]}, {"eq": ["a1.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}]}}', 2.22199988, 11079.3057, 620935.75);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (91, '4c.sql', 5, 'SELECT MIN(mi_idx.info) AS rating,
       MIN(t.title) AS movie_title
FROM info_type AS it,
     keyword AS k,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE it.info =''rating''
  AND k.keyword LIKE ''%sequel%''
  AND mi_idx.info > ''2.0''
  AND t.production_year > 1990
  AND t.id = mi_idx.movie_id
  AND t.id = mk.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND k.id = mk.keyword_id
  AND it.id = mi_idx.info_type_id;

', '{"select": [{"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "movie_title"}], "from": [{"value": "info_type", "name": "it"}, {"value": "keyword", "name": "k"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["it.info", {"literal": "rating"}]}, {"like": ["k.keyword", {"literal": "%sequel%"}]}, {"gt": ["mi_idx.info", {"literal": "2.0"}]}, {"gt": ["t.production_year", 1990]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it.id", "mi_idx.info_type_id"]}]}}', 0.953000009, 140.209, 16443.8105);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (92, '12c.sql', 8, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS mainstream_movie
FROM company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     title AS t
WHERE cn.country_code = ''[us]''
  AND ct.kind = ''production companies''
  AND it1.info = ''genres''
  AND it2.info = ''rating''
  AND mi.info IN (''Drama'',
                  ''Horror'',
                  ''Western'',
                  ''Family'')
  AND mi_idx.info > ''7.0''
  AND t.production_year BETWEEN 2000 AND 2010
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND mi.info_type_id = it1.id
  AND mi_idx.info_type_id = it2.id
  AND t.id = mc.movie_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id
  AND mc.movie_id = mi.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND mi.movie_id = mi_idx.movie_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "mainstream_movie"}], "from": [{"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["ct.kind", {"literal": "production companies"}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["mi.info", {"literal": ["Drama", "Horror", "Western", "Family"]}]}, {"gt": ["mi_idx.info", {"literal": "7.0"}]}, {"between": ["t.production_year", 2000, 2010]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["mi.info_type_id", "it1.id"]}, {"eq": ["mi_idx.info_type_id", "it2.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["mc.movie_id", "mi.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}]}}', 3.8829999, 1047.02502, 17208.9004);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (95, '25a.sql', 9, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS male_writer,
       MIN(t.title) AS violent_movie_title
FROM cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'')
  AND mi.info = ''Horror''
  AND n.gender = ''m''
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "male_writer"}, {"value": {"min": "t.title"}, "name": "violent_movie_title"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "blood", "gore", "death", "female-nudity"]}]}, {"eq": ["mi.info", {"literal": "Horror"}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}]}}', 8.63500023, 3351.0791, 8018.52979);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (96, '17e.sql', 7, 'SELECT MIN(n.name) AS member_in_charnamed_movie
FROM cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cn.country_code =''[us]''
  AND k.keyword =''character-name-in-title''
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": {"value": {"min": "n.name"}, "name": "member_in_charnamed_movie"}, "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 2.59899998, 12568.584, 4565.52002);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (97, '7a.sql', 8, 'SELECT MIN(n.name) AS of_person,
       MIN(t.title) AS biography_movie
FROM aka_name AS an,
     cast_info AS ci,
     info_type AS it,
     link_type AS lt,
     movie_link AS ml,
     name AS n,
     person_info AS pi,
     title AS t
WHERE an.name LIKE ''%a%''
  AND it.info =''mini biography''
  AND lt.link =''features''
  AND n.name_pcode_cf BETWEEN ''A'' AND ''F''
  AND (n.gender=''m''
       OR (n.gender = ''f''
           AND n.name LIKE ''B%''))
  AND pi.note =''Volker Boehm''
  AND t.production_year BETWEEN 1980 AND 1995
  AND n.id = an.person_id
  AND n.id = pi.person_id
  AND ci.person_id = n.id
  AND t.id = ci.movie_id
  AND ml.linked_movie_id = t.id
  AND lt.id = ml.link_type_id
  AND it.id = pi.info_type_id
  AND pi.person_id = an.person_id
  AND pi.person_id = ci.person_id
  AND an.person_id = ci.person_id
  AND ci.movie_id = ml.linked_movie_id;

', '{"select": [{"value": {"min": "n.name"}, "name": "of_person"}, {"value": {"min": "t.title"}, "name": "biography_movie"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it"}, {"value": "link_type", "name": "lt"}, {"value": "movie_link", "name": "ml"}, {"value": "name", "name": "n"}, {"value": "person_info", "name": "pi"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["an.name", {"literal": "%a%"}]}, {"eq": ["it.info", {"literal": "mini biography"}]}, {"eq": ["lt.link", {"literal": "features"}]}, {"between": ["n.name_pcode_cf", {"literal": "A"}, {"literal": "F"}]}, {"or": [{"eq": ["n.gender", {"literal": "m"}]}, {"and": [{"eq": ["n.gender", {"literal": "f"}]}, {"like": ["n.name", {"literal": "B%"}]}]}]}, {"eq": ["pi.note", {"literal": "Volker Boehm"}]}, {"between": ["t.production_year", 1980, 1995]}, {"eq": ["n.id", "an.person_id"]}, {"eq": ["n.id", "pi.person_id"]}, {"eq": ["ci.person_id", "n.id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ml.linked_movie_id", "t.id"]}, {"eq": ["lt.id", "ml.link_type_id"]}, {"eq": ["it.id", "pi.info_type_id"]}, {"eq": ["pi.person_id", "an.person_id"]}, {"eq": ["pi.person_id", "ci.person_id"]}, {"eq": ["an.person_id", "ci.person_id"]}, {"eq": ["ci.movie_id", "ml.linked_movie_id"]}]}}', 4.20499992, 2140.18701, 2010.81006);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (99, '9d.sql', 8, 'SELECT MIN(an.name) AS alternative_name,
       MIN(chn.name) AS voiced_char_name,
       MIN(n.name) AS voicing_actress,
       MIN(t.title) AS american_movie
FROM aka_name AS an,
     char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n,
     role_type AS rt,
     title AS t
WHERE ci.note IN (''(voice)'',
                  ''(voice: Japanese version)'',
                  ''(voice) (uncredited)'',
                  ''(voice: English version)'')
  AND cn.country_code =''[us]''
  AND n.gender =''f''
  AND rt.role =''actress''
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND ci.movie_id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND n.id = ci.person_id
  AND chn.id = ci.person_role_id
  AND an.person_id = n.id
  AND an.person_id = ci.person_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "alternative_name"}, {"value": {"min": "chn.name"}, "name": "voiced_char_name"}, {"value": {"min": "n.name"}, "name": "voicing_actress"}, {"value": {"min": "t.title"}, "name": "american_movie"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "movie_companies", "name": "mc"}, {"value": "name", "name": "n"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(voice)", "(voice: Japanese version)", "(voice) (uncredited)", "(voice: English version)"]}]}, {"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["n.gender", {"literal": "f"}]}, {"eq": ["rt.role", {"literal": "actress"}]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.role_id", "rt.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["an.person_id", "ci.person_id"]}]}}', 3.8269999, 2529.86206, 483845.625);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (100, '10a.sql', 7, 'SELECT MIN(chn.name) AS uncredited_voiced_character,
       MIN(t.title) AS russian_movie
FROM char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     company_type AS ct,
     movie_companies AS mc,
     role_type AS rt,
     title AS t
WHERE ci.note LIKE ''%(voice)%''
  AND ci.note LIKE ''%(uncredited)%''
  AND cn.country_code = ''[ru]''
  AND rt.role = ''actor''
  AND t.production_year > 2005
  AND t.id = mc.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mc.movie_id
  AND chn.id = ci.person_role_id
  AND rt.id = ci.role_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id;

', '{"select": [{"value": {"min": "chn.name"}, "name": "uncredited_voiced_character"}, {"value": {"min": "t.title"}, "name": "russian_movie"}], "from": [{"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "movie_companies", "name": "mc"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"like": ["ci.note", {"literal": "%(voice)%"}]}, {"like": ["ci.note", {"literal": "%(uncredited)%"}]}, {"eq": ["cn.country_code", {"literal": "[ru]"}]}, {"eq": ["rt.role", {"literal": "actor"}]}, {"gt": ["t.production_year", 2005]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["rt.id", "ci.role_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}]}}', 1.59399998, 549.716003, 40760.4102);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (101, '2d.sql', 5, 'SELECT MIN(t.title) AS movie_title
FROM company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code =''[us]''
  AND k.keyword =''character-name-in-title''
  AND cn.id = mc.company_id
  AND mc.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND mc.movie_id = mk.movie_id;

', '{"select": {"value": {"min": "t.title"}, "name": "movie_title"}, "from": [{"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["mc.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 0.879999995, 670.182007, 3862.43994);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (102, '25b.sql', 9, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS male_writer,
       MIN(t.title) AS violent_movie_title
FROM cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'')
  AND mi.info = ''Horror''
  AND n.gender = ''m''
  AND t.production_year > 2010
  AND t.title LIKE ''Vampire%''
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "male_writer"}, {"value": {"min": "t.title"}, "name": "violent_movie_title"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "blood", "gore", "death", "female-nudity"]}]}, {"eq": ["mi.info", {"literal": "Horror"}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"gt": ["t.production_year", 2010]}, {"like": ["t.title", {"literal": "Vampire%"}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}]}}', 8.47200012, 194.322998, 7993.4502);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (103, '6f.sql', 5, 'SELECT MIN(k.keyword) AS movie_keyword,
       MIN(n.name) AS actor_name,
       MIN(t.title) AS hero_movie
FROM cast_info AS ci,
     keyword AS k,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword IN (''superhero'',
                    ''sequel'',
                    ''second-part'',
                    ''marvel-comics'',
                    ''based-on-comic'',
                    ''tv-special'',
                    ''fight'',
                    ''violence'')
  AND t.production_year > 2000
  AND k.id = mk.keyword_id
  AND t.id = mk.movie_id
  AND t.id = ci.movie_id
  AND ci.movie_id = mk.movie_id
  AND n.id = ci.person_id;

', '{"select": [{"value": {"min": "k.keyword"}, "name": "movie_keyword"}, {"value": {"min": "n.name"}, "name": "actor_name"}, {"value": {"min": "t.title"}, "name": "hero_movie"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "keyword", "name": "k"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"in": ["k.keyword", {"literal": ["superhero", "sequel", "second-part", "marvel-comics", "based-on-comic", "tv-special", "fight", "violence"]}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}]}}', 1.023, 8589.20117, 15212.6201);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (105, '30c.sql', 12, 'SELECT MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(n.name) AS writer,
       MIN(t.title) AS complete_violent_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     cast_info AS ci,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE cct1.kind = ''cast''
  AND cct2.kind =''complete+verified''
  AND ci.note IN (''(writer)'',
                  ''(head writer)'',
                  ''(written by)'',
                  ''(story)'',
                  ''(story editor)'')
  AND it1.info = ''genres''
  AND it2.info = ''votes''
  AND k.keyword IN (''murder'',
                    ''violence'',
                    ''blood'',
                    ''gore'',
                    ''death'',
                    ''female-nudity'',
                    ''hospital'')
  AND mi.info IN (''Horror'',
                  ''Action'',
                  ''Sci-Fi'',
                  ''Thriller'',
                  ''Crime'',
                  ''War'')
  AND n.gender = ''m''
  AND t.id = mi.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = ci.movie_id
  AND t.id = mk.movie_id
  AND t.id = cc.movie_id
  AND ci.movie_id = mi.movie_id
  AND ci.movie_id = mi_idx.movie_id
  AND ci.movie_id = mk.movie_id
  AND ci.movie_id = cc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mk.movie_id
  AND mi.movie_id = cc.movie_id
  AND mi_idx.movie_id = mk.movie_id
  AND mi_idx.movie_id = cc.movie_id
  AND mk.movie_id = cc.movie_id
  AND n.id = ci.person_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND k.id = mk.keyword_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": [{"value": {"min": "mi.info"}, "name": "movie_budget"}, {"value": {"min": "mi_idx.info"}, "name": "movie_votes"}, {"value": {"min": "n.name"}, "name": "writer"}, {"value": {"min": "t.title"}, "name": "complete_violent_movie"}], "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "cast_info", "name": "ci"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cct1.kind", {"literal": "cast"}]}, {"eq": ["cct2.kind", {"literal": "complete+verified"}]}, {"in": ["ci.note", {"literal": ["(writer)", "(head writer)", "(written by)", "(story)", "(story editor)"]}]}, {"eq": ["it1.info", {"literal": "genres"}]}, {"eq": ["it2.info", {"literal": "votes"}]}, {"in": ["k.keyword", {"literal": ["murder", "violence", "blood", "gore", "death", "female-nudity", "hospital"]}]}, {"in": ["mi.info", {"literal": ["Horror", "Action", "Sci-Fi", "Thriller", "Crime", "War"]}]}, {"eq": ["n.gender", {"literal": "m"}]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "ci.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["ci.movie_id", "mi.movie_id"]}, {"eq": ["ci.movie_id", "mi_idx.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["ci.movie_id", "cc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mk.movie_id"]}, {"eq": ["mi.movie_id", "cc.movie_id"]}, {"eq": ["mi_idx.movie_id", "mk.movie_id"]}, {"eq": ["mi_idx.movie_id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 54.1310005, 4602.51318, 2561.05005);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (107, '23b.sql', 11, 'SELECT MIN(kt.kind) AS movie_kind,
       MIN(t.title) AS complete_nerdy_internet_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t
WHERE cct1.kind = ''complete+verified''
  AND cn.country_code = ''[us]''
  AND it1.info = ''release dates''
  AND k.keyword IN (''nerd'',
                    ''loner'',
                    ''alienation'',
                    ''dignity'')
  AND kt.kind IN (''movie'')
  AND mi.note LIKE ''%internet%''
  AND mi.info LIKE ''USA:% 200%''
  AND t.production_year > 2000
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND t.id = cc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = cc.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = cc.movie_id
  AND mc.movie_id = cc.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id
  AND cct1.id = cc.status_id;

', '{"select": [{"value": {"min": "kt.kind"}, "name": "movie_kind"}, {"value": {"min": "t.title"}, "name": "complete_nerdy_internet_movie"}], "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cct1.kind", {"literal": "complete+verified"}]}, {"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "release dates"}]}, {"in": ["k.keyword", {"literal": ["nerd", "loner", "alienation", "dignity"]}]}, {"in": ["kt.kind", {"literal": "movie"}]}, {"like": ["mi.note", {"literal": "%internet%"}]}, {"like": ["mi.info", {"literal": "USA:% 200%"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "cc.movie_id"]}, {"eq": ["mc.movie_id", "cc.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cct1.id", "cc.status_id"]}]}}', 23.8740005, 397.355988, 3875.53003);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (108, '9b.sql', 8, 'SELECT MIN(an.name) AS alternative_name,
       MIN(chn.name) AS voiced_character,
       MIN(n.name) AS voicing_actress,
       MIN(t.title) AS american_movie
FROM aka_name AS an,
     char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n,
     role_type AS rt,
     title AS t
WHERE ci.note = ''(voice)''
  AND cn.country_code =''[us]''
  AND mc.note LIKE ''%(200%)%''
  AND (mc.note LIKE ''%(USA)%''
       OR mc.note LIKE ''%(worldwide)%'')
  AND n.gender =''f''
  AND n.name LIKE ''%Angel%''
  AND rt.role =''actress''
  AND t.production_year BETWEEN 2007 AND 2010
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND ci.movie_id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND n.id = ci.person_id
  AND chn.id = ci.person_role_id
  AND an.person_id = n.id
  AND an.person_id = ci.person_id;

', '{"select": [{"value": {"min": "an.name"}, "name": "alternative_name"}, {"value": {"min": "chn.name"}, "name": "voiced_character"}, {"value": {"min": "n.name"}, "name": "voicing_actress"}, {"value": {"min": "t.title"}, "name": "american_movie"}], "from": [{"value": "aka_name", "name": "an"}, {"value": "char_name", "name": "chn"}, {"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "movie_companies", "name": "mc"}, {"value": "name", "name": "n"}, {"value": "role_type", "name": "rt"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["ci.note", {"literal": "(voice)"}]}, {"eq": ["cn.country_code", {"literal": "[us]"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"or": [{"like": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(worldwide)%"}]}]}, {"eq": ["n.gender", {"literal": "f"}]}, {"like": ["n.name", {"literal": "%Angel%"}]}, {"eq": ["rt.role", {"literal": "actress"}]}, {"between": ["t.production_year", 2007, 2010]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.role_id", "rt.id"]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["chn.id", "ci.person_role_id"]}, {"eq": ["an.person_id", "n.id"]}, {"eq": ["an.person_id", "ci.person_id"]}]}}', 4.22800016, 216.987, 84276.5234);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (109, '17b.sql', 7, 'SELECT MIN(n.name) AS member_in_charnamed_movie,
       MIN(n.name) AS a1
FROM cast_info AS ci,
     company_name AS cn,
     keyword AS k,
     movie_companies AS mc,
     movie_keyword AS mk,
     name AS n,
     title AS t
WHERE k.keyword =''character-name-in-title''
  AND n.name LIKE ''Z%''
  AND n.id = ci.person_id
  AND ci.movie_id = t.id
  AND t.id = mk.movie_id
  AND mk.keyword_id = k.id
  AND t.id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.movie_id = mc.movie_id
  AND ci.movie_id = mk.movie_id
  AND mc.movie_id = mk.movie_id;

', '{"select": [{"value": {"min": "n.name"}, "name": "member_in_charnamed_movie"}, {"value": {"min": "n.name"}, "name": "a1"}], "from": [{"value": "cast_info", "name": "ci"}, {"value": "company_name", "name": "cn"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_keyword", "name": "mk"}, {"value": "name", "name": "n"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["k.keyword", {"literal": "character-name-in-title"}]}, {"like": ["n.name", {"literal": "Z%"}]}, {"eq": ["n.id", "ci.person_id"]}, {"eq": ["ci.movie_id", "t.id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["mk.keyword_id", "k.id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mc.company_id", "cn.id"]}, {"eq": ["ci.movie_id", "mc.movie_id"]}, {"eq": ["ci.movie_id", "mk.movie_id"]}, {"eq": ["mc.movie_id", "mk.movie_id"]}]}}', 2.34100008, 10459.6113, 4393.58008);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (110, '15d.sql', 9, 'SELECT MIN(at.title) AS aka_title,
       MIN(t.title) AS internet_movie_title
FROM aka_title AS at,
     company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     keyword AS k,
     movie_companies AS mc,
     movie_info AS mi,
     movie_keyword AS mk,
     title AS t
WHERE cn.country_code = ''[us]''
  AND it1.info = ''release dates''
  AND mi.note LIKE ''%internet%''
  AND t.production_year > 1990
  AND t.id = at.movie_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = at.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = at.movie_id
  AND mc.movie_id = at.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND cn.id = mc.company_id
  AND ct.id = mc.company_type_id;

', '{"select": [{"value": {"min": "at.title"}, "name": "aka_title"}, {"value": {"min": "t.title"}, "name": "internet_movie_title"}], "from": [{"value": "aka_title", "name": "at"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "keyword", "name": "k"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "release dates"}]}, {"like": ["mi.note", {"literal": "%internet%"}]}, {"gt": ["t.production_year", 1990]}, {"eq": ["t.id", "at.movie_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "at.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "at.movie_id"]}, {"eq": ["mc.movie_id", "at.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}]}}', 10.8400002, 1174.41003, 180930.266);
INSERT INTO public.queries (id, file_name, relations_num, query, moz, planning, execution, cost) VALUES (111, '28a.sql', 14, 'SELECT MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS complete_euro_dark_movie
FROM complete_cast AS cc,
     comp_cast_type AS cct1,
     comp_cast_type AS cct2,
     company_name AS cn,
     company_type AS ct,
     info_type AS it1,
     info_type AS it2,
     keyword AS k,
     kind_type AS kt,
     movie_companies AS mc,
     movie_info AS mi,
     movie_info_idx AS mi_idx,
     movie_keyword AS mk,
     title AS t
WHERE cct1.kind = ''crew''
  AND cct2.kind != ''complete+verified''
  AND cn.country_code != ''[us]''
  AND it1.info = ''countries''
  AND it2.info = ''rating''
  AND k.keyword IN (''murder'',
                    ''murder-in-title'',
                    ''blood'',
                    ''violence'')
  AND kt.kind IN (''movie'',
                  ''episode'')
  AND mc.note NOT LIKE ''%(USA)%''
  AND mc.note LIKE ''%(200%)%''
  AND mi.info IN (''Sweden'',
                  ''Norway'',
                  ''Germany'',
                  ''Denmark'',
                  ''Swedish'',
                  ''Danish'',
                  ''Norwegian'',
                  ''German'',
                  ''USA'',
                  ''American'')
  AND mi_idx.info < ''8.5''
  AND t.production_year > 2000
  AND kt.id = t.kind_id
  AND t.id = mi.movie_id
  AND t.id = mk.movie_id
  AND t.id = mi_idx.movie_id
  AND t.id = mc.movie_id
  AND t.id = cc.movie_id
  AND mk.movie_id = mi.movie_id
  AND mk.movie_id = mi_idx.movie_id
  AND mk.movie_id = mc.movie_id
  AND mk.movie_id = cc.movie_id
  AND mi.movie_id = mi_idx.movie_id
  AND mi.movie_id = mc.movie_id
  AND mi.movie_id = cc.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND mc.movie_id = cc.movie_id
  AND mi_idx.movie_id = cc.movie_id
  AND k.id = mk.keyword_id
  AND it1.id = mi.info_type_id
  AND it2.id = mi_idx.info_type_id
  AND ct.id = mc.company_type_id
  AND cn.id = mc.company_id
  AND cct1.id = cc.subject_id
  AND cct2.id = cc.status_id;

', '{"select": [{"value": {"min": "cn.name"}, "name": "movie_company"}, {"value": {"min": "mi_idx.info"}, "name": "rating"}, {"value": {"min": "t.title"}, "name": "complete_euro_dark_movie"}], "from": [{"value": "complete_cast", "name": "cc"}, {"value": "comp_cast_type", "name": "cct1"}, {"value": "comp_cast_type", "name": "cct2"}, {"value": "company_name", "name": "cn"}, {"value": "company_type", "name": "ct"}, {"value": "info_type", "name": "it1"}, {"value": "info_type", "name": "it2"}, {"value": "keyword", "name": "k"}, {"value": "kind_type", "name": "kt"}, {"value": "movie_companies", "name": "mc"}, {"value": "movie_info", "name": "mi"}, {"value": "movie_info_idx", "name": "mi_idx"}, {"value": "movie_keyword", "name": "mk"}, {"value": "title", "name": "t"}], "where": {"and": [{"eq": ["cct1.kind", {"literal": "crew"}]}, {"neq": ["cct2.kind", {"literal": "complete+verified"}]}, {"neq": ["cn.country_code", {"literal": "[us]"}]}, {"eq": ["it1.info", {"literal": "countries"}]}, {"eq": ["it2.info", {"literal": "rating"}]}, {"in": ["k.keyword", {"literal": ["murder", "murder-in-title", "blood", "violence"]}]}, {"in": ["kt.kind", {"literal": ["movie", "episode"]}]}, {"nlike": ["mc.note", {"literal": "%(USA)%"}]}, {"like": ["mc.note", {"literal": "%(200%)%"}]}, {"in": ["mi.info", {"literal": ["Sweden", "Norway", "Germany", "Denmark", "Swedish", "Danish", "Norwegian", "German", "USA", "American"]}]}, {"lt": ["mi_idx.info", {"literal": "8.5"}]}, {"gt": ["t.production_year", 2000]}, {"eq": ["kt.id", "t.kind_id"]}, {"eq": ["t.id", "mi.movie_id"]}, {"eq": ["t.id", "mk.movie_id"]}, {"eq": ["t.id", "mi_idx.movie_id"]}, {"eq": ["t.id", "mc.movie_id"]}, {"eq": ["t.id", "cc.movie_id"]}, {"eq": ["mk.movie_id", "mi.movie_id"]}, {"eq": ["mk.movie_id", "mi_idx.movie_id"]}, {"eq": ["mk.movie_id", "mc.movie_id"]}, {"eq": ["mk.movie_id", "cc.movie_id"]}, {"eq": ["mi.movie_id", "mi_idx.movie_id"]}, {"eq": ["mi.movie_id", "mc.movie_id"]}, {"eq": ["mi.movie_id", "cc.movie_id"]}, {"eq": ["mc.movie_id", "mi_idx.movie_id"]}, {"eq": ["mc.movie_id", "cc.movie_id"]}, {"eq": ["mi_idx.movie_id", "cc.movie_id"]}, {"eq": ["k.id", "mk.keyword_id"]}, {"eq": ["it1.id", "mi.info_type_id"]}, {"eq": ["it2.id", "mi_idx.info_type_id"]}, {"eq": ["ct.id", "mc.company_type_id"]}, {"eq": ["cn.id", "mc.company_id"]}, {"eq": ["cct1.id", "cc.subject_id"]}, {"eq": ["cct2.id", "cc.status_id"]}]}}', 63.3759995, 4112.1499, 3265.54004);


--
-- Name: queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.queries_id_seq', 111, true);


--
-- PostgreSQL database dump complete
--

