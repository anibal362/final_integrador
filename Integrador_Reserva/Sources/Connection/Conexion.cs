using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace Integrador_Reserva.Sources.Connection
{
    public class Conexion
    {

        private SqlConnection con;

        public Conexion()
        {
            

        }

        public SqlConnection getCon()
        {
            return con;
        }

        public void iniciarConexion()
        {
            con.Open();
        }

        public void cerrarConexion()
        {
            con.Close();
        }

        public void asignarBaseDatos()
        {
            con = new SqlConnection(Constante.CON_DATABASE5);
        }
    }
}