-- table_def.csv

SELECT
  o.name
  , c.name
  , c.column_id
-- , ic.column_id AS PK
  , tp.name
-- , o.type_desc
-- , c.is_nullable
-- , c.max_length
-- , c.precision
-- , c.scale
FROM
  sys.all_objects o

INNER JOIN sys.all_columns c ON (c.object_id = o.object_id)

INNER JOIN sys.types tp ON (tp.system_type_id = c.system_type_id)

LEFT OUTER JOIN sys.key_constraints AS kc ON (kc.parent_object_id = c.object_id) AND (kc.type='PK')  

LEFT OUTER JOIN sys.index_columns AS ic ON (ic.object_id = c.object_id) AND (ic.object_id = kc.parent_object_id) AND (ic.index_id = kc.unique_index_id) AND (ic.column_id = c.column_id)


WHERE
  (o.schema_id = 1) AND (tp.name <> 'sysname')
ORDER BY
  type_desc,
  o.name,
  c.column_id
