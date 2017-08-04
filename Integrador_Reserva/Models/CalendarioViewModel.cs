using Integrador_Reserva.Sources.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Integrador_Reserva.Models
{
    public class CalendarioViewModel
    {
        public Reserva Reserva { get; set; }
        public Cliente Cliente { get; set; }
        public Cancha Cancha { get; set; }
    }
}