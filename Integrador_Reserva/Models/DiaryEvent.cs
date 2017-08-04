using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Integrador_Reserva.Models
{
    public class DiaryEvent
    {
        public int? ID { get; set; }
        public string Title { get; set; }
        public string StartDateString { get; set; }
        public string EndDateString { get; set; }
        public string StatusString { get; set; }
        public string StatusColor { get; set; }
        public string ClassName { get; set; }
        public int? IdReserva { get; set; }
        public int? IdCancha { get; set; }
        public int IdEstado { get; set; }
        public string UsuarioRegistro { get; set; }
        public string ClienteNombre { get; set; }
        public string Color { get; set; }
        public bool Editar { get; set; }



    }
}