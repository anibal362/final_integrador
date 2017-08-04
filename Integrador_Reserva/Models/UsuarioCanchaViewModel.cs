using Integrador_Reserva.Sources.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Integrador_Reserva.Sources.Logic;

namespace Integrador_Reserva.Models
{
    public class UsuarioCanchaViewModel
    {
        public List<TipoCancha> listaTipos { get; set; }
        public List<Distrito> listaDistritos { get; set; }
        public List<Servicio> listaServicios { get; set; }

        public Usuario usuario { get; set; }
        public Cancha cancha { get; set; }
        public List<Cancha> listaCancha { get; set; }
    }
}