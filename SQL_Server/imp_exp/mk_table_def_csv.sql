-- table_def.csv

SELECT
  o.name
  , c.name
  , c.column_id
  , tp.name
-- , o.type_desc
-- , c.is_nullable
-- , c.max_length
-- , c.precision
-- , c.scale
FROM
  sys.all_objects o

INNER JOIN sys.all_columns c ON (c.object_id = o.object_id)

LEFT OUTER JOIN sys.types tp ON (tp.system_type_id = c.system_type_id)

WHERE
  (o.schema_id = 1) AND (tp.name <> 'sysname')
ORDER BY
  type_desc,
  o.name,
  c.column_id
