using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySqlConnector;

namespace Chronicle.Utils
{
    public static class TypeConverter<T>
    {
        public static T getData(MySqlDataReader reader, string columnName, T defaultRet)
        {
            object data = reader[columnName];
            if (data is not T tData)
            {
                return defaultRet;
            }

            return tData;
        }
    }
}
