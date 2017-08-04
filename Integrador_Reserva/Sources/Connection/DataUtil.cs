using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Integrador_Reserva.Sources.Connection
{
    public class DataUtil
    {
        

        public static generic ValueOfDataBase<generic>(object obj)
        {
            if (obj == null || obj == DBNull.Value) return default(generic);
            else { return (generic)obj; }
        }
    }

}