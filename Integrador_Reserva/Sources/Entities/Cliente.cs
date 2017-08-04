using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Integrador_Reserva.Sources.Entities
{
    public class Cliente
    {
        public int ClienteId { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Email { get; set; }
        public string DNI { get; set; }
        public string Telefono { get; set; }
        public string Celular { get; set; }
        public string RUC { get; set; }
    }
}