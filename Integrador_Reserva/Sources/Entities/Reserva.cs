using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Integrador_Reserva.Sources.Entities
{
    public class Reserva
    {
        public int ReservaId { get; set; }
        public DateTime Reserva_FechaInicio { get; set; }
        public DateTime Reserva_FechaFin { get; set; }
        public string Descripcion { get; set; }
        public bool ConFactura { get; set; }
        public bool AceptaTerminos { get; set; }
        public string TipoPago { get; set; }
        public int IdEstado { get; set; }
        public decimal PrecioTotal { get; set; }
    }
}