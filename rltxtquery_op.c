/*
 * txtquery operations with rltree
 * Teodor Sigaev <teodor@stack.net>
 * contrib/rltree/rltxtquery_op.c
 */
#include "postgres.h"

#include <ctype.h>

#include "rltree.h"

PG_FUNCTION_INFO_V1(rltxtq_exec);
PG_FUNCTION_INFO_V1(rltxtq_rexec);

/*
 * check for boolean condition
 */
bool
rltree_execute(ITEM *curitem, void *checkval, bool calcnot, bool (*chkcond) (void *checkval, ITEM *val))
{
	if (curitem->type == VAL)
		return (*chkcond) (checkval, curitem);
	else if (curitem->val == (int32) '!')
	{
		return (calcnot) ?
			((rltree_execute(curitem + 1, checkval, calcnot, chkcond)) ? false : true)
			: true;
	}
	else if (curitem->val == (int32) '&')
	{
		if (rltree_execute(curitem + curitem->left, checkval, calcnot, chkcond))
			return rltree_execute(curitem + 1, checkval, calcnot, chkcond);
		else
			return false;
	}
	else
	{							/* |-operator */
		if (rltree_execute(curitem + curitem->left, checkval, calcnot, chkcond))
			return true;
		else
			return rltree_execute(curitem + 1, checkval, calcnot, chkcond);
	}
}

typedef struct
{
	rltree	   *node;
	char	   *operand;
} CHKVAL;

static bool
checkcondition_str(void *checkval, ITEM *val)
{
	rltree_level *level = LTREE_FIRST(((CHKVAL *) checkval)->node);
	int			tlen = ((CHKVAL *) checkval)->node->numlevel;
	char	   *op = ((CHKVAL *) checkval)->operand + val->distance;
	int			(*cmpptr) (const char *, const char *, size_t);

	cmpptr = (val->flag & LVAR_INCASE) ? rltree_strncasecmp : strncmp;
	while (tlen > 0)
	{
		if (val->flag & LVAR_SUBLEXEME)
		{
			if (compare_subnode(level, op, val->length, cmpptr, (val->flag & LVAR_ANYEND)))
				return true;
		}
		else if (
				 (
				  val->length == level->len ||
				  (level->len > val->length && (val->flag & LVAR_ANYEND))
				  ) &&
				 (*cmpptr) (op, level->name, val->length) == 0)
			return true;

		tlen--;
		level = LEVEL_NEXT(level);
	}

	return false;
}

Datum
rltxtq_exec(PG_FUNCTION_ARGS)
{
	rltree	   *val = PG_GETARG_LTREE(0);
	rltxtquery  *query = PG_GETARG_LTXTQUERY(1);
	CHKVAL		chkval;
	bool		result;

	chkval.node = val;
	chkval.operand = GETOPERAND(query);

	result = rltree_execute(
						   GETQUERY(query),
						   &chkval,
						   true,
						   checkcondition_str
		);

	PG_FREE_IF_COPY(val, 0);
	PG_FREE_IF_COPY(query, 1);
	PG_RETURN_BOOL(result);
}

Datum
rltxtq_rexec(PG_FUNCTION_ARGS)
{
	PG_RETURN_DATUM(DirectFunctionCall2(rltxtq_exec,
										PG_GETARG_DATUM(1),
										PG_GETARG_DATUM(0)
										));
}
