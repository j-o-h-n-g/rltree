/* contrib/rltree/rltree--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION rltree" to load this file. \quit

CREATE FUNCTION rltree_in(cstring)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_out(rltree)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE rltree (
	INTERNALLENGTH = -1,
	INPUT = rltree_in,
	OUTPUT = rltree_out,
	STORAGE = extended
);


--Compare function for rltree
CREATE FUNCTION rltree_cmp(rltree,rltree)
RETURNS int4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_lt(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_le(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_eq(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_ge(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_gt(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_ne(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;


CREATE OPERATOR < (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_lt,
        COMMUTATOR = '>',
	NEGATOR = '>=',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <= (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_le,
        COMMUTATOR = '>=',
	NEGATOR = '>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR >= (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_ge,
        COMMUTATOR = '<=',
	NEGATOR = '<',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR > (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_gt,
        COMMUTATOR = '<',
	NEGATOR = '<=',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR = (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_eq,
        COMMUTATOR = '=',
	NEGATOR = '<>',
        RESTRICT = eqsel,
	JOIN = eqjoinsel,
        SORT1 = '<',
	SORT2 = '<'
);

CREATE OPERATOR <> (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_ne,
        COMMUTATOR = '<>',
	NEGATOR = '=',
        RESTRICT = neqsel,
	JOIN = neqjoinsel
);

--util functions

CREATE FUNCTION subrltree(rltree,int4,int4)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION subpath(rltree,int4,int4)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION subpath(rltree,int4)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION index(rltree,rltree)
RETURNS int4
AS 'MODULE_PATHNAME', 'rltree_index'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION index(rltree,rltree,int4)
RETURNS int4
AS 'MODULE_PATHNAME', 'rltree_index'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION nlevel(rltree)
RETURNS int4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree2text(rltree)
RETURNS text
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION text2rltree(text)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(_rltree)
RETURNS rltree
AS 'MODULE_PATHNAME','_lca'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(rltree,rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(rltree,rltree,rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(rltree,rltree,rltree,rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(rltree,rltree,rltree,rltree,rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(rltree,rltree,rltree,rltree,rltree,rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lca(rltree,rltree,rltree,rltree,rltree,rltree,rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_isparent(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_risparent(rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_addrltree(rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_addtext(rltree,text)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_textadd(text,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltreeparentsel(internal, oid, internal, integer)
RETURNS float8
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR @> (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_isparent,
        COMMUTATOR = '<@',
        RESTRICT = rltreeparentsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@> (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_isparent,
        COMMUTATOR = '^<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <@ (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_risparent,
        COMMUTATOR = '@>',
        RESTRICT = rltreeparentsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^<@ (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_risparent,
        COMMUTATOR = '^@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR || (
        LEFTARG = rltree,
	RIGHTARG = rltree,
	PROCEDURE = rltree_addrltree
);

CREATE OPERATOR || (
        LEFTARG = rltree,
	RIGHTARG = text,
	PROCEDURE = rltree_addtext
);

CREATE OPERATOR || (
        LEFTARG = text,
	RIGHTARG = rltree,
	PROCEDURE = rltree_textadd
);


-- B-tree support

CREATE OPERATOR CLASS rltree_ops
    DEFAULT FOR TYPE rltree USING btree AS
        OPERATOR        1       < ,
        OPERATOR        2       <= ,
        OPERATOR        3       = ,
        OPERATOR        4       >= ,
        OPERATOR        5       > ,
        FUNCTION        1       rltree_cmp(rltree, rltree);


--rlquery type
CREATE FUNCTION rlquery_in(cstring)
RETURNS rlquery
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rlquery_out(rlquery)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE rlquery (
	INTERNALLENGTH = -1,
	INPUT = rlquery_in,
	OUTPUT = rlquery_out,
	STORAGE = extended
);

CREATE FUNCTION ltq_regex(rltree,rlquery)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION ltq_rregex(rlquery,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR ~ (
        LEFTARG = rltree,
	RIGHTARG = rlquery,
	PROCEDURE = ltq_regex,
	COMMUTATOR = '~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~ (
        LEFTARG = rlquery,
	RIGHTARG = rltree,
	PROCEDURE = ltq_rregex,
	COMMUTATOR = '~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--not-indexed
CREATE OPERATOR ^~ (
        LEFTARG = rltree,
	RIGHTARG = rlquery,
	PROCEDURE = ltq_regex,
	COMMUTATOR = '^~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^~ (
        LEFTARG = rlquery,
	RIGHTARG = rltree,
	PROCEDURE = ltq_rregex,
	COMMUTATOR = '^~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE FUNCTION lt_q_regex(rltree,_rlquery)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION lt_q_rregex(_rlquery,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR ? (
        LEFTARG = rltree,
	RIGHTARG = _rlquery,
	PROCEDURE = lt_q_regex,
	COMMUTATOR = '?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ? (
        LEFTARG = _rlquery,
	RIGHTARG = rltree,
	PROCEDURE = lt_q_rregex,
	COMMUTATOR = '?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--not-indexed
CREATE OPERATOR ^? (
        LEFTARG = rltree,
	RIGHTARG = _rlquery,
	PROCEDURE = lt_q_regex,
	COMMUTATOR = '^?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^? (
        LEFTARG = _rlquery,
	RIGHTARG = rltree,
	PROCEDURE = lt_q_rregex,
	COMMUTATOR = '^?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE FUNCTION rltxtq_in(cstring)
RETURNS rltxtquery
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltxtq_out(rltxtquery)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE rltxtquery (
	INTERNALLENGTH = -1,
	INPUT = rltxtq_in,
	OUTPUT = rltxtq_out,
	STORAGE = extended
);

-- operations WITH rltxtquery

CREATE FUNCTION rltxtq_exec(rltree, rltxtquery)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltxtq_rexec(rltxtquery, rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR @ (
        LEFTARG = rltree,
	RIGHTARG = rltxtquery,
	PROCEDURE = rltxtq_exec,
	COMMUTATOR = '@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @ (
        LEFTARG = rltxtquery,
	RIGHTARG = rltree,
	PROCEDURE = rltxtq_rexec,
	COMMUTATOR = '@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--not-indexed
CREATE OPERATOR ^@ (
        LEFTARG = rltree,
	RIGHTARG = rltxtquery,
	PROCEDURE = rltxtq_exec,
	COMMUTATOR = '^@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@ (
        LEFTARG = rltxtquery,
	RIGHTARG = rltree,
	PROCEDURE = rltxtq_rexec,
	COMMUTATOR = '^@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--GiST support for rltree
CREATE FUNCTION rltree_gist_in(cstring)
RETURNS rltree_gist
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION rltree_gist_out(rltree_gist)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE rltree_gist (
	internallength = -1,
	input = rltree_gist_in,
	output = rltree_gist_out,
	storage = plain
);


CREATE FUNCTION rltree_consistent(internal,internal,int2,oid,internal)
RETURNS bool as 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION rltree_compress(internal)
RETURNS internal as 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION rltree_decompress(internal)
RETURNS internal as 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION rltree_penalty(internal,internal,internal)
RETURNS internal as 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION rltree_picksplit(internal, internal)
RETURNS internal as 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION rltree_union(internal, internal)
RETURNS int4 as 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION rltree_same(internal, internal, internal)
RETURNS internal as 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR CLASS gist_rltree_ops
    DEFAULT FOR TYPE rltree USING gist AS
	OPERATOR	1	< ,
	OPERATOR	2	<= ,
	OPERATOR	3	= ,
	OPERATOR	4	>= ,
	OPERATOR	5	> ,
	OPERATOR	10	@> ,
	OPERATOR	11	<@ ,
	OPERATOR	12	~ (rltree, rlquery) ,
	OPERATOR	13	~ (rlquery, rltree) ,
	OPERATOR	14	@ (rltree, rltxtquery) ,
	OPERATOR	15	@ (rltxtquery, rltree) ,
	OPERATOR	16	? (rltree, _rlquery) ,
	OPERATOR	17	? (_rlquery, rltree) ,
	FUNCTION	1	rltree_consistent (internal, internal, int2, oid, internal),
	FUNCTION	2	rltree_union (internal, internal),
	FUNCTION	3	rltree_compress (internal),
	FUNCTION	4	rltree_decompress (internal),
	FUNCTION	5	rltree_penalty (internal, internal, internal),
	FUNCTION	6	rltree_picksplit (internal, internal),
	FUNCTION	7	rltree_same (internal, internal, internal),
	STORAGE		rltree_gist;


-- arrays of rltree

CREATE FUNCTION _rltree_isparent(_rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _rltree_r_isparent(rltree,_rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _rltree_risparent(_rltree,rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _rltree_r_risparent(rltree,_rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _ltq_regex(_rltree,rlquery)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _ltq_rregex(rlquery,_rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _lt_q_regex(_rltree,_rlquery)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _lt_q_rregex(_rlquery,_rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _rltxtq_exec(_rltree, rltxtquery)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION _rltxtq_rexec(rltxtquery, _rltree)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR @> (
        LEFTARG = _rltree,
	RIGHTARG = rltree,
	PROCEDURE = _rltree_isparent,
        COMMUTATOR = '<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <@ (
        LEFTARG = rltree,
	RIGHTARG = _rltree,
	PROCEDURE = _rltree_r_isparent,
        COMMUTATOR = '@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <@ (
        LEFTARG = _rltree,
	RIGHTARG = rltree,
	PROCEDURE = _rltree_risparent,
        COMMUTATOR = '@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @> (
        LEFTARG = rltree,
	RIGHTARG = _rltree,
	PROCEDURE = _rltree_r_risparent,
        COMMUTATOR = '<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~ (
        LEFTARG = _rltree,
	RIGHTARG = rlquery,
	PROCEDURE = _ltq_regex,
        COMMUTATOR = '~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~ (
        LEFTARG = rlquery,
	RIGHTARG = _rltree,
	PROCEDURE = _ltq_rregex,
        COMMUTATOR = '~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ? (
        LEFTARG = _rltree,
	RIGHTARG = _rlquery,
	PROCEDURE = _lt_q_regex,
        COMMUTATOR = '?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ? (
        LEFTARG = _rlquery,
	RIGHTARG = _rltree,
	PROCEDURE = _lt_q_rregex,
        COMMUTATOR = '?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @ (
        LEFTARG = _rltree,
	RIGHTARG = rltxtquery,
	PROCEDURE = _rltxtq_exec,
        COMMUTATOR = '@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @ (
        LEFTARG = rltxtquery,
	RIGHTARG = _rltree,
	PROCEDURE = _rltxtq_rexec,
        COMMUTATOR = '@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);


--not indexed
CREATE OPERATOR ^@> (
        LEFTARG = _rltree,
	RIGHTARG = rltree,
	PROCEDURE = _rltree_isparent,
        COMMUTATOR = '^<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^<@ (
        LEFTARG = rltree,
	RIGHTARG = _rltree,
	PROCEDURE = _rltree_r_isparent,
        COMMUTATOR = '^@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^<@ (
        LEFTARG = _rltree,
	RIGHTARG = rltree,
	PROCEDURE = _rltree_risparent,
        COMMUTATOR = '^@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@> (
        LEFTARG = rltree,
	RIGHTARG = _rltree,
	PROCEDURE = _rltree_r_risparent,
        COMMUTATOR = '^<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^~ (
        LEFTARG = _rltree,
	RIGHTARG = rlquery,
	PROCEDURE = _ltq_regex,
        COMMUTATOR = '^~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^~ (
        LEFTARG = rlquery,
	RIGHTARG = _rltree,
	PROCEDURE = _ltq_rregex,
        COMMUTATOR = '^~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^? (
        LEFTARG = _rltree,
	RIGHTARG = _rlquery,
	PROCEDURE = _lt_q_regex,
        COMMUTATOR = '^?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^? (
        LEFTARG = _rlquery,
	RIGHTARG = _rltree,
	PROCEDURE = _lt_q_rregex,
        COMMUTATOR = '^?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@ (
        LEFTARG = _rltree,
	RIGHTARG = rltxtquery,
	PROCEDURE = _rltxtq_exec,
        COMMUTATOR = '^@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@ (
        LEFTARG = rltxtquery,
	RIGHTARG = _rltree,
	PROCEDURE = _rltxtq_rexec,
        COMMUTATOR = '^@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

--extractors
CREATE FUNCTION _rltree_extract_isparent(_rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR ?@> (
        LEFTARG = _rltree,
	RIGHTARG = rltree,
	PROCEDURE = _rltree_extract_isparent
);

CREATE FUNCTION _rltree_extract_risparent(_rltree,rltree)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR ?<@ (
        LEFTARG = _rltree,
	RIGHTARG = rltree,
	PROCEDURE = _rltree_extract_risparent
);

CREATE FUNCTION _ltq_extract_regex(_rltree,rlquery)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR ?~ (
        LEFTARG = _rltree,
	RIGHTARG = rlquery,
	PROCEDURE = _ltq_extract_regex
);

CREATE FUNCTION _rltxtq_extract_exec(_rltree,rltxtquery)
RETURNS rltree
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR ?@ (
        LEFTARG = _rltree,
	RIGHTARG = rltxtquery,
	PROCEDURE = _rltxtq_extract_exec
);

--GiST support for rltree[]
CREATE FUNCTION _rltree_consistent(internal,internal,int2,oid,internal)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION _rltree_compress(internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION _rltree_penalty(internal,internal,internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION _rltree_picksplit(internal, internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION _rltree_union(internal, internal)
RETURNS int4
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION _rltree_same(internal, internal, internal)
RETURNS internal
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR CLASS gist__rltree_ops
    DEFAULT FOR TYPE _rltree USING gist AS
	OPERATOR	10	<@ (_rltree, rltree),
	OPERATOR	11	@> (rltree, _rltree),
	OPERATOR	12	~ (_rltree, rlquery),
	OPERATOR	13	~ (rlquery, _rltree),
	OPERATOR	14	@ (_rltree, rltxtquery),
	OPERATOR	15	@ (rltxtquery, _rltree),
	OPERATOR	16	? (_rltree, _rlquery),
	OPERATOR	17	? (_rlquery, _rltree),
	FUNCTION	1	_rltree_consistent (internal, internal, int2, oid, internal),
	FUNCTION	2	_rltree_union (internal, internal),
	FUNCTION	3	_rltree_compress (internal),
	FUNCTION	4	rltree_decompress (internal),
	FUNCTION	5	_rltree_penalty (internal, internal, internal),
	FUNCTION	6	_rltree_picksplit (internal, internal),
	FUNCTION	7	_rltree_same (internal, internal, internal),
	STORAGE		rltree_gist;
