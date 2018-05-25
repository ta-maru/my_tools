using System.Collections.Generic;
using System.Data.SqlClient;

namespace TMT.Test.Utility
{
    /// <summary>
    /// Table's enum
    /// </summary>
    public enum TableTypes
    {
        TableA,
        TableB
    }

    /// <summary>
    /// BulkInserter Class
    /// </summary>
    public static class BulkInserter
    {
        public static void Insert(TableTypes table, string dataFilePath, bool hasHeader = true)
        {
            string formatFilePath = string.Format("{0}.xml", table.ToString());

            Insert(table, dataFilePath, formatFilePath, hasHeader);
        }

        public static void Insert(TableTypes table, string dataFilePath, string formatFilePath, bool hasHeader = true)
        {
            Execute(new string[] { CreateInsertQuery(table.ToString(), dataFilePath, formatFilePath, hasHeader) });
        }
        
        public static void CreanInsert(TableTypes table, string dataFilePath, bool hasHeader = true)
        {
            string formatFilePath = string.Format("{0}.xml", table.ToString());

            CleanInsert(table, dataFilePath, formatFilePath, hasHeader);
        }

        public static void CleanInsert(TableTypes table, string dataFilePath, string formatFilePath, bool hasHeader = true)
        {
            var queries = new List<string>();

            queries.Add(CreateTruncateQuery(table.ToString()));
            queries.Add(CreateInsertQuery(table.ToString(), dataFilePath, formatFilePath, hasHeader));

            Execute(queries);
        }

        public static void Clean(TableTypes table)
        {
            Clean(table.ToString());
        }

        public static void Clean(string tableName)
        {
            Execute(new string[] { CreateTruncateQuery(tableName) });
        }

        private static string CreateInsertQuery(string tableName, string dataFilePath, string formatFilePath, bool hasHeader)
        {
            string setDFilePath = string.Format("{0}{1}{2}", "", "", dataFilePath);
            string setFFilePath = string.Format("{0}{1}{2}", "", "", formatFilePath);

            return string.Format("BULK INSERT {0} FROM '{1}' WITH (KEEPIDENTITY, FORMATFILE='{2}', FIRSTROW={3})",
                tableName, setDFilePath, setFFilePath, hasHeader ? 2 : 1);
        }

        private static string CreateTruncateQuery(string tableName)
        {
            return string.Format("DELETE FROM {0}", tableName);
        }

        private static void Execute(ICollection<string> queries)
        {
            using (var conn = new SqlConnection(""))
            {
                try
                {
                    conn.Open();

                    using (var tx = conn.BeginTransaction())
                    {
                        using (var cmd = new SqlCommand())
                        {
                            bool isCommit = false;

                            try
                            {
                                cmd.Transaction = tx;
                                cmd.Connection = conn;

                                foreach (var q in queries)
                                {
                                    cmd.CommandText = q;
                                    cmd.ExecuteNonQuery();
                                }
                                isCommit = true;
                            }
                            finally
                            {
                                if (isCommit)
                                    tx.Commit();
                                else
                                    tx.Rollback();
                            }
                        }
                    }
                }
                catch(SqlException ex)
                {
                    throw ex;
                }
            }
        }
    }
}
