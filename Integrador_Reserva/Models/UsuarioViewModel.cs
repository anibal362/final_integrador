using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Integrador_Reserva.Sources.Entities;
namespace Integrador_Reserva.Models
{
    public class UsuarioViewModel
    {
        public Usuario usuario { get; set; }
        public List<Usuario> listaUsuarios { get; set; }

    }
    
}