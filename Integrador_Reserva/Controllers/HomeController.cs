using Integrador_Reserva.Models;
using Integrador_Reserva.Sources.Entities;
using Integrador_Reserva.Sources.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Integrador_Reserva.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            UsuarioBusinessLogic usuarioBusinessLogic = new UsuarioBusinessLogic();
            UsuarioCanchaViewModel objUsuarioCancha = new UsuarioCanchaViewModel();
            objUsuarioCancha.usuario = new Usuario();
            objUsuarioCancha.cancha = new Cancha();
            objUsuarioCancha.usuario.usuario_id = 1;
            objUsuarioCancha.usuario.usuario_nombre = "controlador";
            objUsuarioCancha.usuario.usuario_razonsocial = "controlador.SAC";
            objUsuarioCancha.cancha.cancha_usuario_id = 1;
            objUsuarioCancha.listaTipos = usuarioBusinessLogic.listaTipo();
            objUsuarioCancha.listaDistritos = usuarioBusinessLogic.listaDistrito();
            objUsuarioCancha.listaServicios = usuarioBusinessLogic.listaServicio();

            return View(objUsuarioCancha);
        }
    }
}