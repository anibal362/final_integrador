using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Integrador_Reserva.Sources.Entities
{
    public class Usuario
    {
        public int usuario_id { get; set; }
        public string usuario_nombre { get; set; }
        public string usuario_contraseña { get; set; }
        public string usuario_razonsocial { get; set; }
        public string usuario_ruc { get; set; }
        public string usuario_email { get; set; }
        public string usuario_telefono { get; set; }
        public string usuario_foto_url { get; set; }
        public string usuario_presentacion { get; set; }
        public Boolean activo { get; set; }
    }
}