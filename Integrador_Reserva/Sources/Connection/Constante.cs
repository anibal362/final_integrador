using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Integrador_Reserva.Sources.Connection
{
    public static class Constante
    {
        public const string USP_SEL_LISTAUSUARIO = "selectAllUsuario";
        public const string USP_SEL_ALLTIPOCANCHA = "selectAllTipoCancha";
        public const string USP_SEL_ALLDISTRITO = "selectAllDistrito";
        public const string USP_SEL_ALLSERVICIO = "selectAllServicio";
        public const string USP_INS_USUARIO = "insertUsuario";
        public const string USP_INS_RESERVA = "usp_InsertaReserva";
        public const string USP_UPD_USUARIO = "updateUsuario";
        public const string CON_DATABASE5 = "Data Source = THINK362-PC\\SQLEXPRESS; Initial Catalog = reserva; User ID = sa; Password = 3545409";
        //public const string CON_DATABASE = "Data Source = NM05LEN; Initial Catalog = reserva; User ID = sa; Password = S0p0rt3s";
        public const string CON_DATABASE = @"Data Source = joelpanocca\joel; Initial Catalog = reserva; User ID = sa; Password = lqs";
        public const string CON_DATABASE2 = "Data Source = UTP061509; Initial Catalog = reserva; User ID = sa; Password = alumno";
        public const string CON_DATABASE3 = "Data Source = UTP097174; Initial Catalog = reserva; User ID = sa; Password = alumno";
        
        public const string USP_INS_CANCHA = "insertCancha";
        public const string USP_SEL_ALLCANCHAxUSUARIO_ID = "selectAllCanchaxUsuarioId";
        public const string USP_GETCANCHABYID = "getCanchaPorId";
        public const string USP_SEL_ALLCANCHAxCANCHA_DISTRITO_ID = "selectAllCanchaxDistritoId";
        public const string USP_SEL_ALLCANCHAxCANCHA_DISTRITO = "selectAllCanchaxNombreCancha";
        public const string USP_SEL_ALLCANCHAxCANCHA_DISTRITO_ID_DISTRITO_NAME = "selectAllCanchaxDistritoIdDistritoName";
        public const string USP_SEL_LISTACANCHA = "selectAllCancha";
        public const string USP_SEL_EVENTOS = "ListarReservasByCalendar";
    }
}