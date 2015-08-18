CREATE EXTENSION rltree;

SELECT ''::rltree;
SELECT '1'::rltree;
SELECT '1.2'::rltree;
SELECT '1.2._3'::rltree;

SELECT rltree2text('1.2.3.34.sdf');
SELECT text2rltree('1.2.3.34.sdf');

SELECT subrltree('Top.Child1.Child2',1,2);
SELECT subpath('Top.Child1.Child2',1,2);
SELECT subpath('Top.Child1.Child2',-1,1);
SELECT subpath('Top.Child1.Child2',0,-2);
SELECT subpath('Top.Child1.Child2',0,-1);
SELECT subpath('Top.Child1.Child2',0,0);
SELECT subpath('Top.Child1.Child2',1,0);
SELECT subpath('Top.Child1.Child2',0);
SELECT subpath('Top.Child1.Child2',1);


SELECT index('1.2.3.4.5.6','1.2');
SELECT index('a.1.2.3.4.5.6','1.2');
SELECT index('a.1.2.3.4.5.6','1.2.3');
SELECT index('a.1.2.3.4.5.6','1.2.3.j');
SELECT index('a.1.2.3.4.5.6','1.2.3.j.4.5.5.5.5.5.5');
SELECT index('a.1.2.3.4.5.6','1.2.3');
SELECT index('a.1.2.3.4.5.6','6');
SELECT index('a.1.2.3.4.5.6','6.1');
SELECT index('a.1.2.3.4.5.6','5.6');
SELECT index('0.1.2.3.5.4.5.6','5.6');
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',3);
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',6);
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',7);
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',-7);
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',-4);
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',-3);
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',-2);
SELECT index('0.1.2.3.5.4.5.6.8.5.6.8','5.6',-20000);


SELECT 'Top.Child1.Child2'::rltree || 'Child3'::text;
SELECT 'Top.Child1.Child2'::rltree || 'Child3'::rltree;
SELECT 'Top_0'::rltree || 'Top.Child1.Child2'::rltree;
SELECT 'Top.Child1.Child2'::rltree || ''::rltree;
SELECT ''::rltree || 'Top.Child1.Child2'::rltree;

SELECT lca('{la.2.3,1.2.3.4.5.6,""}') IS NULL;
SELECT lca('{la.2.3,1.2.3.4.5.6}') IS NULL;
SELECT lca('{1.la.2.3,1.2.3.4.5.6}');
SELECT lca('{1.2.3,1.2.3.4.5.6}');
SELECT lca('1.la.2.3','1.2.3.4.5.6');
SELECT lca('1.2.3','1.2.3.4.5.6');
SELECT lca('1.2.2.3','1.2.3.4.5.6');
SELECT lca('1.2.2.3','1.2.3.4.5.6','');
SELECT lca('1.2.2.3','1.2.3.4.5.6','2');
SELECT lca('1.2.2.3','1.2.3.4.5.6','1');


SELECT '1'::lquery;
SELECT '4|3|2'::lquery;
SELECT '1.2'::lquery;
SELECT '1.4|3|2'::lquery;
SELECT '1.0'::lquery;
SELECT '4|3|2.0'::lquery;
SELECT '1.2.0'::lquery;
SELECT '1.4|3|2.0'::lquery;
SELECT '1.*'::lquery;
SELECT '4|3|2.*'::lquery;
SELECT '1.2.*'::lquery;
SELECT '1.4|3|2.*'::lquery;
SELECT '*.1.*'::lquery;
SELECT '*.4|3|2.*'::lquery;
SELECT '*.1.2.*'::lquery;
SELECT '*.1.4|3|2.*'::lquery;
SELECT '1.*.4|3|2'::lquery;
SELECT '1.*.4|3|2.0'::lquery;
SELECT '1.*.4|3|2.*{1,4}'::lquery;
SELECT '1.*.4|3|2.*{,4}'::lquery;
SELECT '1.*.4|3|2.*{1,}'::lquery;
SELECT '1.*.4|3|2.*{1}'::lquery;
SELECT 'qwerty%@*.tu'::lquery;

SELECT nlevel('1.2.3.4');
SELECT '1.2'::rltree  < '2.2'::rltree;
SELECT '1.2'::rltree  <= '2.2'::rltree;
SELECT '2.2'::rltree  = '2.2'::rltree;
SELECT '3.2'::rltree  >= '2.2'::rltree;
SELECT '3.2'::rltree  > '2.2'::rltree;

SELECT '1.2.3'::rltree @> '1.2.3.4'::rltree;
SELECT '1.2.3.4'::rltree @> '1.2.3.4'::rltree;
SELECT '1.2.3.4.5'::rltree @> '1.2.3.4'::rltree;
SELECT '1.3.3'::rltree @> '1.2.3.4'::rltree;

SELECT 'a.b.c.d.e'::rltree ~ 'a.b.c.d.e';
SELECT 'a.b.c.d.e'::rltree ~ 'A.b.c.d.e';
SELECT 'a.b.c.d.e'::rltree ~ 'A@.b.c.d.e';
SELECT 'aa.b.c.d.e'::rltree ~ 'A@.b.c.d.e';
SELECT 'aa.b.c.d.e'::rltree ~ 'A*.b.c.d.e';
SELECT 'aa.b.c.d.e'::rltree ~ 'A*@.b.c.d.e';
SELECT 'aa.b.c.d.e'::rltree ~ 'A*@|g.b.c.d.e';
SELECT 'g.b.c.d.e'::rltree ~ 'A*@|g.b.c.d.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.b.c.d.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{3}.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{2}.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{4}.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{,4}.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{2,}.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{2,4}.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{2,3}.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{2,3}';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{2,4}';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*{2,5}';
SELECT 'a.b.c.d.e'::rltree ~ '*{2,3}.e';
SELECT 'a.b.c.d.e'::rltree ~ '*{2,4}.e';
SELECT 'a.b.c.d.e'::rltree ~ '*{2,5}.e';
SELECT 'a.b.c.d.e'::rltree ~ '*.e';
SELECT 'a.b.c.d.e'::rltree ~ '*.e.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.d.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.a.*.d.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!d.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!d';
SELECT 'a.b.c.d.e'::rltree ~ '!d.*';
SELECT 'a.b.c.d.e'::rltree ~ '!a.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!e';
SELECT 'a.b.c.d.e'::rltree ~ '*.!e.*';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*.!e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*.!d';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*.!d.*';
SELECT 'a.b.c.d.e'::rltree ~ 'a.*.!f.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.a.*.!f.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.a.*.!d.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.a.!d.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.a.!d';
SELECT 'a.b.c.d.e'::rltree ~ 'a.!d.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.a.*.!d.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!b.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!b.c.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!b.*.c.*';
SELECT 'a.b.c.d.e'::rltree ~ '!b.*.c.*';
SELECT 'a.b.c.d.e'::rltree ~ '!b.b.*';
SELECT 'a.b.c.d.e'::rltree ~ '!b.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '!b.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '!b.*.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '*{2}.!b.*.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '*{1}.!b.*.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '*{1}.!b.*{1}.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ 'a.!b.*{1}.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '!b.*{1}.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '*.!b.*{1}.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '*.!b.*.!c.*.e';
SELECT 'a.b.c.d.e'::rltree ~ '!b.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ '!b.*.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ '*{2}.!b.*.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ '*{1}.!b.*.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ '*{1}.!b.*{1}.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ 'a.!b.*{1}.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ '!b.*{1}.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!b.*{1}.!c.*';
SELECT 'a.b.c.d.e'::rltree ~ '*.!b.*.!c.*';


SELECT 'QWER_TY'::rltree ~ 'q%@*';
SELECT 'QWER_TY'::rltree ~ 'Q_t%@*';
SELECT 'QWER_GY'::rltree ~ 'q_t%@*';

--rltxtquery
SELECT '!tree & aWdf@*'::rltxtquery;
SELECT 'tree & aw_qw%*'::rltxtquery;
SELECT 'rltree.awdfg'::rltree @ '!tree & aWdf@*'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ '!tree & aWdf@*'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ '!tree | aWdf@*'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ 'tree | aWdf@*'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ 'tree & aWdf@*'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ 'tree & aWdf@'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ 'tree & aWdf*'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ 'tree & aWdf'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ 'tree & awdf*'::rltxtquery;
SELECT 'tree.awdfg'::rltree @ 'tree & aWdfg@'::rltxtquery;
SELECT 'tree.awdfg_qwerty'::rltree @ 'tree & aw_qw%*'::rltxtquery;
SELECT 'tree.awdfg_qwerty'::rltree @ 'tree & aw_rw%*'::rltxtquery;

--arrays

SELECT '{1.2.3}'::rltree[] @> '1.2.3.4';
SELECT '{1.2.3.4}'::rltree[] @> '1.2.3.4';
SELECT '{1.2.3.4.5}'::rltree[] @> '1.2.3.4';
SELECT '{1.3.3}'::rltree[] @> '1.2.3.4';
SELECT '{5.67.8, 1.2.3}'::rltree[] @> '1.2.3.4';
SELECT '{5.67.8, 1.2.3.4}'::rltree[] @> '1.2.3.4';
SELECT '{5.67.8, 1.2.3.4.5}'::rltree[] @> '1.2.3.4';
SELECT '{5.67.8, 1.3.3}'::rltree[] @> '1.2.3.4';
SELECT '{1.2.3, 7.12.asd}'::rltree[] @> '1.2.3.4';
SELECT '{1.2.3.4, 7.12.asd}'::rltree[] @> '1.2.3.4';
SELECT '{1.2.3.4.5, 7.12.asd}'::rltree[] @> '1.2.3.4';
SELECT '{1.3.3, 7.12.asd}'::rltree[] @> '1.2.3.4';
SELECT '{rltree.asd, tree.awdfg}'::rltree[] @ 'tree & aWdfg@'::rltxtquery;
SELECT '{j.k.l.m, g.b.c.d.e}'::rltree[] ~ 'A*@|g.b.c.d.e';
SELECT 'a.b.c.d.e'::rltree ? '{A.b.c.d.e}';
SELECT 'a.b.c.d.e'::rltree ? '{a.b.c.d.e}';
SELECT 'a.b.c.d.e'::rltree ? '{A.b.c.d.e, a.*}';
SELECT '{a.b.c.d.e,B.df}'::rltree[] ? '{A.b.c.d.e}';
SELECT '{a.b.c.d.e,B.df}'::rltree[] ? '{A.b.c.d.e,*.df}';

--exractors
SELECT ('{3456,1.2.3.34}'::rltree[] ?@> '1.2.3.4') is null;
SELECT '{3456,1.2.3}'::rltree[] ?@> '1.2.3.4';
SELECT '{3456,1.2.3.4}'::rltree[] ?<@ '1.2.3';
SELECT ('{3456,1.2.3.4}'::rltree[] ?<@ '1.2.5') is null;
SELECT '{rltree.asd, tree.awdfg}'::rltree[] ?@ 'tree & aWdfg@'::rltxtquery;
SELECT '{j.k.l.m, g.b.c.d.e}'::rltree[] ?~ 'A*@|g.b.c.d.e';

CREATE TABLE rltreetest (t rltree);
\copy rltreetest FROM 'data/rltree.data'

SELECT * FROM rltreetest WHERE t <  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t <= '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t =  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t >= '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t >  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t @> '1.1.1' order by t asc;
SELECT * FROM rltreetest WHERE t <@ '1.1.1' order by t asc;
SELECT * FROM rltreetest WHERE t @ '23 & 1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '1.1.1.*' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '*.1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '23.*{1}.1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '23.*.1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '23.*.2' order by t asc;
SELECT * FROM rltreetest WHERE t ? '{23.*.1,23.*.2}' order by t asc;

create unique index tstidx on rltreetest (t);
set enable_seqscan=off;

SELECT * FROM rltreetest WHERE t <  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t <= '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t =  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t >= '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t >  '12.3' order by t asc;

drop index tstidx;
create index tstidx on rltreetest using gist (t);
set enable_seqscan=off;

SELECT * FROM rltreetest WHERE t <  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t <= '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t =  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t >= '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t >  '12.3' order by t asc;
SELECT * FROM rltreetest WHERE t @> '1.1.1' order by t asc;
SELECT * FROM rltreetest WHERE t <@ '1.1.1' order by t asc;
SELECT * FROM rltreetest WHERE t @ '23 & 1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '1.1.1.*' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '*.1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '23.*{1}.1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '23.*.1' order by t asc;
SELECT * FROM rltreetest WHERE t ~ '23.*.2' order by t asc;
SELECT * FROM rltreetest WHERE t ? '{23.*.1,23.*.2}' order by t asc;

create table _rltreetest (t rltree[]);
\copy _rltreetest FROM 'data/_rltree.data'

SELECT count(*) FROM _rltreetest WHERE t @> '1.1.1' ;
SELECT count(*) FROM _rltreetest WHERE t <@ '1.1.1' ;
SELECT count(*) FROM _rltreetest WHERE t @ '23 & 1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '1.1.1.*' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '*.1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '23.*{1}.1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '23.*.1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '23.*.2' ;
SELECT count(*) FROM _rltreetest WHERE t ? '{23.*.1,23.*.2}' ;

create index _tstidx on _rltreetest using gist (t);
set enable_seqscan=off;

SELECT count(*) FROM _rltreetest WHERE t @> '1.1.1' ;
SELECT count(*) FROM _rltreetest WHERE t <@ '1.1.1' ;
SELECT count(*) FROM _rltreetest WHERE t @ '23 & 1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '1.1.1.*' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '*.1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '23.*{1}.1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '23.*.1' ;
SELECT count(*) FROM _rltreetest WHERE t ~ '23.*.2' ;
SELECT count(*) FROM _rltreetest WHERE t ? '{23.*.1,23.*.2}' ;
