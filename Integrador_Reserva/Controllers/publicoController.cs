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
    public class publicoController : Controller
    {
        // GET: publico
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult RegistroReserva()
        {
            return View();
        }

        public ActionResult TerminosYCondiciones()
        {
            return View();
        }

        public ActionResult ResultadoBusqueda(UsuarioCanchaViewModel objUCVM)
        {
            UsuarioBusinessLogic uBL = new UsuarioBusinessLogic();
            UsuarioCanchaViewModel objUsuarioCancha = new UsuarioCanchaViewModel();
            objUsuarioCancha.cancha = new Cancha();
            objUsuarioCancha.cancha.cancha_distrito_id = objUCVM.cancha.cancha_distrito_id;
            if (objUCVM.cancha.cancha_distrito == null)
            {
                objUsuarioCancha.cancha.cancha_distrito = "";
            }
            else
            {
                objUsuarioCancha.cancha.cancha_distrito = objUCVM.cancha.cancha_distrito;
            }

            objUsuarioCancha.listaCancha = uBL.ListaCanchasxSearch(objUsuarioCancha.cancha);
            return View(objUsuarioCancha);
        }

        public ActionResult busqueda(UsuarioCanchaViewModel objUCVM)
        {
            return View(objUCVM);
        }

        public ActionResult RegistroCliente()
        {
            return View();
        }

        public ActionResult AñadirCancha()
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

        [HttpPost]
        public ActionResult AñadirCancha(UsuarioCanchaViewModel objUCVM, HttpPostedFileBase file)
        {

            if (file != null) {

                string archivo = (file.FileName).ToLower();
                string prefijo = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + objUCVM.cancha.cancha_nombre;
                string pic = System.IO.Path.GetFileName(file.FileName).ToLower();
                string ext = System.IO.Path.GetExtension(pic);
                string path = System.IO.Path.Combine(
                    Server.MapPath("~/Sources/img/") + prefijo + "_" + pic);
                bool msj;

                if (ext == ".png" || ext == ".jpg")
                {
                    file.SaveAs(path);
                    msj = true;
                }
                else { msj = false; }
                objUCVM.cancha.cancha_ImagenUrl = (msj) ? prefijo + "_" + pic : "image_no_found.png";
                objUCVM.cancha.cancha_usuario_id = 1;
                string msg = String.Empty;

                if (ModelState.IsValid)
                {
                    msg = new UsuarioBusinessLogic().registrarCancha(objUCVM.cancha);
                }

            }


            return RedirectToAction("Index", "Home");
        }

        public ActionResult VerCalendarioCancha(int idCancha)
        {
            UsuarioBusinessLogic usuarioBusinessLogic = new UsuarioBusinessLogic();
            CalendarioViewModel oCalendarioViewModel = new CalendarioViewModel();
            oCalendarioViewModel.Cancha = usuarioBusinessLogic.ObtenerCanchaPorID(idCancha);
            //Lo siguiente obtener de BD, enviándole el idCancha
            //oCalendarioViewModel.Cancha.cancha_id = idCancha;
            //oCalendarioViewModel.Cancha.cancha_descripcion = "La mejor cancha de Lima";
            //oCalendarioViewModel.Cancha.cancha_distrito = "Lince";
            //oCalendarioViewModel.Cancha.cancha_nombre = "La Bombonera";
            //oCalendarioViewModel.Cancha.cancha_tipo = "6x6";
            //oCalendarioViewModel.Cancha.Precio = 160;
            //oCalendarioViewModel.Cancha.UrlImagen = "2.jpg";
            oCalendarioViewModel.Cliente = new Cliente();
            oCalendarioViewModel.Reserva = new Reserva();

            return View(oCalendarioViewModel);
        }

        public JsonResult GetDiaryEvents(int? cancha_id, string start, string end)
        {
            UsuarioBusinessLogic uBL = new UsuarioBusinessLogic();
            if (!String.IsNullOrWhiteSpace(start) && !String.IsNullOrWhiteSpace(end))
            {
                start = start.Replace("-", "");
                end = end.Replace("-", "");
            }
            List<DiaryEvent> listaEventos = uBL.Obtiene_Reservas_New(cancha_id, start, end);
            var eventList = from e in listaEventos
                            select new
                            {
                                id = e.IdReserva,
                                title = e.Title + " - " + e.ClienteNombre,
                                ClienteNombre = e.ClienteNombre,
                                start = e.StartDateString,
                                end = e.EndDateString,
                                IdCancha = e.IdCancha.ToString(),
                                IdEstado = e.IdEstado.ToString(),
                                color = e.Color,
                                editable = e.Editar,
                                allDay = false
                            };
            var rows = eventList.ToArray();
            return Json(rows, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GuardarReserva(CalendarioViewModel oCalendarioViewModel)
        {
            string msg = String.Empty;
            //if (ModelState.IsValid)
            //{
                msg = new UsuarioBusinessLogic().GuardarReserva(oCalendarioViewModel);
            //}
            return Json(msg, JsonRequestBehavior.AllowGet);
        }
    }
}