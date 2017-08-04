using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Integrador_Reserva.Sources.Logic;
using Integrador_Reserva.Models;
using Integrador_Reserva.Sources.Entities;

namespace Integrador_Reserva.Controllers
{
    public class UsuarioController : Controller
    {
        // GET: Usuario
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ListaUsuarios()
        {
            UsuarioBusinessLogic usuarioBusinessLogic = new UsuarioBusinessLogic();

            UsuarioViewModel usuarioViewModel = new UsuarioViewModel();

            usuarioViewModel.listaUsuarios = usuarioBusinessLogic.listaUsuario();
            return View(usuarioViewModel);
        }

        public ActionResult ListaCanchas()
        {
            UsuarioBusinessLogic uBL = new UsuarioBusinessLogic();
            UsuarioViewModel uVM = new UsuarioViewModel();

            return View();
        }

        [HttpGet]
        public ActionResult Registrar()
        {
            UsuarioViewModel usuarioViewModel = new UsuarioViewModel();
            usuarioViewModel.usuario = new Usuario();

            return View(usuarioViewModel);
        }

        
        public ActionResult RegistrarCancha(int usuario_id, string usuario_nombre, string usuario_razonsocial)
        {
            UsuarioBusinessLogic usuarioBusinessLogic = new UsuarioBusinessLogic();
            UsuarioCanchaViewModel objUsuarioCancha = new UsuarioCanchaViewModel();
            objUsuarioCancha.usuario = new Usuario();
            objUsuarioCancha.cancha = new Cancha();
            objUsuarioCancha.usuario.usuario_id = usuario_id;
            objUsuarioCancha.usuario.usuario_nombre = usuario_nombre;
            objUsuarioCancha.usuario.usuario_razonsocial = usuario_razonsocial;
            objUsuarioCancha.cancha.cancha_usuario_id = usuario_id;
            objUsuarioCancha.listaTipos = usuarioBusinessLogic.listaTipo();
            objUsuarioCancha.listaDistritos = usuarioBusinessLogic.listaDistrito();
            objUsuarioCancha.listaServicios = usuarioBusinessLogic.listaServicio();

            return View(objUsuarioCancha);
        }
        [HttpPost]
        public ActionResult RegistrarCancha(UsuarioCanchaViewModel usuarioCanchaViewModel)
        {
            string msg = String.Empty;
            if (ModelState.IsValid)
            {
                usuarioCanchaViewModel.cancha.cancha_PrecioxHora = 0.0M;
                usuarioCanchaViewModel.cancha.cancha_ImagenUrl = "";
                msg = new UsuarioBusinessLogic().registrarCancha(usuarioCanchaViewModel.cancha);
            }
            return Content(msg);
        }

        [HttpPost]
        public ActionResult Registrar(UsuarioViewModel usuarioViewModel)
        {
            string msg = String.Empty;
            if (ModelState.IsValid)
            {
                msg = new UsuarioBusinessLogic().registrarUsuario(usuarioViewModel.usuario);
            }
            return Content(msg);
        }

        public ActionResult Edit(int usuario_id, string usuario_nombre, string usuario_razonsocial)
        {
            UsuarioBusinessLogic uBL = new UsuarioBusinessLogic();
            UsuarioCanchaViewModel objUsuarioCancha = new UsuarioCanchaViewModel();
            objUsuarioCancha.usuario = new Usuario();
            objUsuarioCancha.usuario.usuario_id = usuario_id;
            objUsuarioCancha.usuario.usuario_nombre = usuario_nombre;
            objUsuarioCancha.usuario.usuario_razonsocial= usuario_razonsocial;

            objUsuarioCancha.cancha = new Cancha();
            objUsuarioCancha.listaCancha = uBL.ListaCanchasxIdUsuario(Convert.ToInt32(usuario_id));

            return View(objUsuarioCancha);
        }
    }
}