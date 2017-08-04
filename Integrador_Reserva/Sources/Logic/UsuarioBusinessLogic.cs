using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Integrador_Reserva.Sources.Entities;
using Integrador_Reserva.Sources.DataAccess;
using System.Net.Mail;
using System.Net;

namespace Integrador_Reserva.Sources.Logic
{
    public class UsuarioBusinessLogic
    {
        UsuarioDataAccess usuarioDataAccess = new UsuarioDataAccess();


        public List<Usuario> listaUsuario()
        {
            return usuarioDataAccess.listaUsuario();
        }

        public string registrarUsuario(Usuario usuario)
        {
            string msg = String.Empty;

            try
            {
                bool flag = usuarioDataAccess.RegistrarUsuario(usuario);

                msg = flag ? "Se registró correctamente" : "Sucedio un error";
            }
            catch (Exception)
            {
                msg = "Error de logica";
                throw;
            }

            return msg;
        }

        public List<Cancha> ListaCanchasxIdUsuario(int id)
        {
            return usuarioDataAccess.ListaCanchasxIdUsuario(id);
        }

        public string registrarCancha(Cancha cancha)
        {
            string msg = String.Empty;

            try
            {
                bool flag = usuarioDataAccess.registrarCancha(cancha);

                msg = flag ? "Se registró correctamente" : "Sucedio un error";
            }
            catch (Exception)
            {
                msg = "Error de logica";
                throw;
            }

            return msg;
        }

        public List<Cancha> ListaCanchasxSearch(Cancha cancha)
        {
            return usuarioDataAccess.ListaCanchasxSearch(cancha);
        }

        public List<TipoCancha> listaTipo()
        {
            return usuarioDataAccess.listaTipoCancha();
        }

        public List<Distrito> listaDistrito()
        {
            return usuarioDataAccess.listaDistrito();
        }

        public List<Servicio> listaServicio()
        {
            return usuarioDataAccess.listaServicio();
        }

        public List<Models.DiaryEvent> Obtiene_Reservas_New(int? cancha_id, string start, string end)
        {
            return usuarioDataAccess.Obtiene_Reservas_New(cancha_id, start, end);
        }

        public string GuardarReserva(Models.CalendarioViewModel oCalendarioViewModel)
        {
            int CantidadHoras = (oCalendarioViewModel.Reserva.Reserva_FechaFin - oCalendarioViewModel.Reserva.Reserva_FechaInicio).Hours;
            oCalendarioViewModel.Reserva.PrecioTotal = Convert.ToDecimal(oCalendarioViewModel.Cancha.Precio * CantidadHoras);
            string result = usuarioDataAccess.GuardarReserva(oCalendarioViewModel);
            if (result == "1")
            {
                EnviarCorreo(oCalendarioViewModel);
            }
            return result;
        }

        public void EnviarCorreo(Models.CalendarioViewModel oCalendarioViewModel)
        {
            var fromAddress = new MailAddress("reservatucanchape@gmail.com", "De ReservaTuCanchaPe");
            var toAddress = new MailAddress(oCalendarioViewModel.Cliente.Email, "Para " + oCalendarioViewModel.Cliente.Nombre);
            string fromPassword = "S0p0rt3s";
            string subject = "Reservación de Cancha Deportiva";
            string body = "Hola " + oCalendarioViewModel.Cliente.Nombre + ", ud. ha reservado correctamente la cancha " +
                oCalendarioViewModel.Cancha.cancha_nombre + " para el turno de: " +
                oCalendarioViewModel.Reserva.Reserva_FechaInicio.ToShortDateString() + " " + oCalendarioViewModel.Reserva.Reserva_FechaInicio.ToShortTimeString()
                + " hasta las: " +
                oCalendarioViewModel.Reserva.Reserva_FechaFin.ToShortDateString() + " " + oCalendarioViewModel.Reserva.Reserva_FechaFin.ToShortTimeString();
            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };
            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body
            })
            {
                smtp.Send(message);
            }
        }

        public Cancha ObtenerCanchaPorID(int idCancha)
        {
            return usuarioDataAccess.ObtenerCanchaPorID(idCancha);
        }
    }
}