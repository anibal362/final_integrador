using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Integrador_Reserva.Sources.Entities;
using System.Data.SqlClient;
using System.Data;
using Integrador_Reserva.Sources.Connection;
using Integrador_Reserva.Sources.Logic;
using Integrador_Reserva.Models;

namespace Integrador_Reserva.Sources.DataAccess
{
    public class UsuarioDataAccess:Conexion
    {
        private SqlCommand command;
        
        public UsuarioDataAccess()
        {
            asignarBaseDatos();
        }

        public List<Usuario> listaUsuario()
        {
            List<Usuario> lista = new List<Usuario>();
            Usuario usuario;
            iniciarConexion();

            command = new SqlCommand(Constante.USP_SEL_LISTAUSUARIO, getCon());
            command.CommandType = CommandType.StoredProcedure;

            using (IDataReader iDataReader = command.ExecuteReader())
            {
                int iUsuario_id = iDataReader.GetOrdinal("usuario_id");
                int iUsuario_nombre = iDataReader.GetOrdinal("usuario_nombre");
                int iUsuario_contraseña = iDataReader.GetOrdinal("usuario_contraseña");
                int iUsuario_razonsocial = iDataReader.GetOrdinal("usuario_razonsocial");
                int iUsuario_ruc = iDataReader.GetOrdinal("usuario_ruc");
                int iUsuario_email = iDataReader.GetOrdinal("usuario_email");
                int iUsuario_telefono = iDataReader.GetOrdinal("usuario_telefono");
                int iUsuario_foto_url = iDataReader.GetOrdinal("usuario_foto_url");
                int iUsuario_presentacion = iDataReader.GetOrdinal("usuario_presentacion");

                while (iDataReader.Read())
                {
                    usuario = new Usuario();
                    usuario.usuario_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iUsuario_id]);
                    usuario.usuario_nombre = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_nombre]);
                    usuario.usuario_contraseña = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_contraseña]);
                    usuario.usuario_razonsocial = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_razonsocial]);
                    usuario.usuario_ruc = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_ruc]);
                    usuario.usuario_email = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_email]);
                    usuario.usuario_telefono = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_telefono]);
                    usuario.usuario_foto_url = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_foto_url]);
                    usuario.usuario_presentacion = DataUtil.ValueOfDataBase<string>(iDataReader[iUsuario_presentacion]);
                    
                    lista.Add(usuario);
                }
            }
            cerrarConexion();
            return lista;
        }

        internal List<Cancha> ListaCanchasxSearch(Cancha objCancha)
        {
            List<Cancha> listaCanchas = new List<Cancha>();
            Cancha cancha;
            iniciarConexion();
            string procedimiento = "";

            command = new SqlCommand();
            command.Connection = getCon();
            command.CommandType = CommandType.StoredProcedure;

            if (objCancha.cancha_distrito_id == 0)
            {
                if (objCancha.cancha_distrito.Equals("")  )
                {
                    procedimiento = Constante.USP_SEL_LISTACANCHA;
                }
                else
                {
                    procedimiento = Constante.USP_SEL_ALLCANCHAxCANCHA_DISTRITO;
                    command.Parameters.Add("@cancha_nombre", SqlDbType.VarChar).Value = objCancha.cancha_nombre;
                }

            }
            else
            {
                    command.Parameters.Add("@cancha_distrito_id", SqlDbType.Int).Value = objCancha.cancha_distrito_id;

                if (objCancha.cancha_distrito.Equals("") )
                {
                    procedimiento = Constante.USP_SEL_ALLCANCHAxCANCHA_DISTRITO_ID;
                    
                }
                else
                {
                    procedimiento = Constante.USP_SEL_ALLCANCHAxCANCHA_DISTRITO_ID_DISTRITO_NAME;
                    command.Parameters.Add("@cancha_nombre", SqlDbType.VarChar).Value = objCancha.cancha_nombre;
                }
            }

            command.CommandText = procedimiento;
            try
            {
                using (IDataReader iDataReader = command.ExecuteReader())
                {
                    int iCancha_id = iDataReader.GetOrdinal("cancha_id");
                    int iCancha_usuario_id = iDataReader.GetOrdinal("cancha_usuario_id");
                    int iCancha_nombre = iDataReader.GetOrdinal("cancha_nombre");
                    int iCancha_descripcion = iDataReader.GetOrdinal("cancha_descripcion");
                    int iCancha_distrito = iDataReader.GetOrdinal("cancha_distrito");
                    int iCancha_distrito_id = iDataReader.GetOrdinal("cancha_distrito_id");
                    int iCancha_tipo = iDataReader.GetOrdinal("cancha_tipo");
                    int iCancha_tipo_id = iDataReader.GetOrdinal("cancha_tipo_id");
                    int iCancha_PrecioxHora = iDataReader.GetOrdinal("Cancha_PrecioxHora");
                    int iCancha_ImagenUrl = iDataReader.GetOrdinal("Cancha_ImagenUrl");

                    while (iDataReader.Read())
                    {
                        cancha = new Cancha();
                        cancha.cancha_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iCancha_id]);
                        cancha.cancha_usuario_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iCancha_usuario_id]);
                        cancha.cancha_nombre = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_nombre]);
                        cancha.cancha_descripcion = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_descripcion]);
                        cancha.cancha_tipo = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_tipo]);
                        cancha.cancha_tipo_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iCancha_tipo_id]);
                        cancha.cancha_distrito = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_distrito]);
                        cancha.cancha_distrito_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iCancha_distrito_id]);
                        cancha.cancha_PrecioxHora = DataUtil.ValueOfDataBase<decimal>(iDataReader[iCancha_PrecioxHora]);
                        cancha.cancha_ImagenUrl = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_ImagenUrl]);
                        listaCanchas.Add(cancha);
                    }
                }
            }
            catch { }
            cerrarConexion();
            return listaCanchas;
        }

        public List<Servicio> listaServicio()
        {
            List<Servicio> lista = new List<Servicio>();
            Servicio servicio;
            iniciarConexion();

            command = new SqlCommand(Constante.USP_SEL_ALLSERVICIO, getCon());
            command.CommandType = CommandType.StoredProcedure;

            using (IDataReader iDataReader = command.ExecuteReader())
            {
                int iServicioId = iDataReader.GetOrdinal("cancha_servicio_id");
                int iServicio = iDataReader.GetOrdinal("cancha_servicio");

                while (iDataReader.Read())
                {
                    servicio = new Servicio();
                    servicio.servicioId = DataUtil.ValueOfDataBase<Int32>(iDataReader[iServicioId]);
                    servicio.servicio = DataUtil.ValueOfDataBase<string>(iDataReader[iServicio]);

                    lista.Add(servicio);
                }
            }
            cerrarConexion();
            return lista;
        }

        public List<Distrito> listaDistrito()
        {
            List<Distrito> lista = new List<Distrito>();
            Distrito distrito;
            iniciarConexion();

            command = new SqlCommand(Constante.USP_SEL_ALLDISTRITO, getCon());
            command.CommandType = CommandType.StoredProcedure;

            using (IDataReader iDataReader = command.ExecuteReader())
            {
                int iDistrito_id = iDataReader.GetOrdinal("cancha_distrito_id");
                int iDistrito = iDataReader.GetOrdinal("cancha_distrito");

                while (iDataReader.Read())
                {
                    distrito = new Distrito();
                    distrito.distrito_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iDistrito_id]);
                    distrito.distrito = DataUtil.ValueOfDataBase<string>(iDataReader[iDistrito]);

                    lista.Add(distrito);
                }
            }
            cerrarConexion();
            return lista;
        }

        public List<TipoCancha> listaTipoCancha()
        {
            List<TipoCancha> lista = new List<TipoCancha>();
            TipoCancha tipoCancha;
            iniciarConexion();

            command = new SqlCommand(Constante.USP_SEL_ALLTIPOCANCHA, getCon());
            command.CommandType = CommandType.StoredProcedure;

            using (IDataReader iDataReader = command.ExecuteReader())
            {
                int iTipo_id = iDataReader.GetOrdinal("cancha_tipo_id");
                int iTipo = iDataReader.GetOrdinal("cancha_tipo");

                while (iDataReader.Read())
                {
                    tipoCancha = new TipoCancha();
                    tipoCancha.tipo_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iTipo_id]);
                    tipoCancha.tipo = DataUtil.ValueOfDataBase<string>(iDataReader[iTipo]);

                    lista.Add(tipoCancha);
                }
            }
            cerrarConexion();
            return lista;
        }

        public bool RegistrarUsuario(Usuario usuario)
        {
            iniciarConexion();

            command = new SqlCommand(Constante.USP_INS_USUARIO, getCon());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@usuario_nombre", SqlDbType.VarChar).Value = usuario.usuario_nombre;
            command.Parameters.Add("@usuario_contraseña", SqlDbType.VarChar).Value = usuario.usuario_contraseña;
            command.Parameters.Add("@usuario_razonsocial", SqlDbType.VarChar).Value = usuario.usuario_razonsocial;
            command.Parameters.Add("@usuario_ruc", SqlDbType.VarChar).Value = usuario.usuario_ruc;
            command.Parameters.Add("@usuario_email", SqlDbType.VarChar).Value = usuario.usuario_email;
            command.Parameters.Add("@usuario_telefono", SqlDbType.VarChar).Value = usuario.usuario_telefono;
            command.Parameters.Add("@usuario_foto_url", SqlDbType.VarChar).Value = usuario.usuario_foto_url;
            command.Parameters.Add("@usuario_presentacion", SqlDbType.VarChar).Value = usuario.usuario_presentacion;
            var resultado = command.ExecuteNonQuery();
            cerrarConexion();
            return resultado == 0 ? false : true;
        }

        public bool registrarCancha(Cancha cancha)
        {
            iniciarConexion();

            command = new SqlCommand(Constante.USP_INS_CANCHA, getCon());
            
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.Add("@cancha_usuario_id", SqlDbType.Int).Value=cancha.cancha_usuario_id;
            command.Parameters.Add("@cancha_nombre", SqlDbType.VarChar).Value=cancha.cancha_nombre;
            command.Parameters.Add("@cancha_descripcion", SqlDbType.VarChar).Value=cancha.cancha_descripcion;
            command.Parameters.Add("@cancha_tipo_id", SqlDbType.Int).Value=cancha.cancha_tipo_id;
            command.Parameters.Add("@cancha_distrito_id", SqlDbType.Int).Value=cancha.cancha_distrito_id;
            command.Parameters.Add("@cancha_precio", SqlDbType.Decimal).Value = cancha.cancha_PrecioxHora;
            command.Parameters.Add("@cancha_url_imagen", SqlDbType.VarChar).Value = cancha.cancha_ImagenUrl;
            var resultado = command.ExecuteNonQuery();
            cerrarConexion();
            return resultado == 0 ? false : true;
        }

        public List<Cancha> ListaCanchasxIdUsuario(int id)
        {
            List<Cancha> listaCanchas = new List<Cancha>();
            Cancha cancha;
            iniciarConexion();

            command = new SqlCommand(Constante.USP_SEL_ALLCANCHAxUSUARIO_ID, getCon());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@cancha_usuario_id", SqlDbType.Int).Value=id;

            using (IDataReader iDataReader = command.ExecuteReader())
            {
                int iCancha_id = iDataReader.GetOrdinal("cancha_id");
                int iCancha_usuario_id = iDataReader.GetOrdinal("cancha_usuario_id");
                int iCancha_nombre = iDataReader.GetOrdinal("cancha_nombre");
                int iCancha_descripcion = iDataReader.GetOrdinal("cancha_descripcion");
                int iCancha_distrito = iDataReader.GetOrdinal("cancha_distrito");
                int iCancha_tipo = iDataReader.GetOrdinal("cancha_tipo");

                while (iDataReader.Read())
                {
                    cancha = new Cancha();
                    cancha.cancha_id = DataUtil.ValueOfDataBase<Int32>(iDataReader[iCancha_id]);
                    cancha.cancha_usuario_id= DataUtil.ValueOfDataBase<Int32>(iDataReader[iCancha_usuario_id]);
                    cancha.cancha_nombre = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_nombre]);
                    cancha.cancha_descripcion = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_descripcion]);
                    cancha.cancha_tipo = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_tipo]);
                    cancha.cancha_distrito = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_distrito]);
                    listaCanchas.Add(cancha);
                }
            }
            cerrarConexion();
            return listaCanchas;
        }

        public List<DiaryEvent> Obtiene_Reservas_New(int? cancha_id, string start, string end)
        {
            List<DiaryEvent> lista = new List<DiaryEvent>();
            DiaryEvent obj;
            iniciarConexion();

            command = new SqlCommand(Constante.USP_SEL_EVENTOS, getCon());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@cancha_Id", SqlDbType.Int).Value = cancha_id;
            command.Parameters.Add("@Fecha_Inicio", SqlDbType.VarChar).Value = start;
            command.Parameters.Add("@Fecha_Fin", SqlDbType.VarChar).Value = end;

            using (IDataReader iDataReader = command.ExecuteReader())
            {
                int iIdReserva = iDataReader.GetOrdinal("IdReserva");
                int iFechaInicio = iDataReader.GetOrdinal("FechaInicio");
                int iFechaFin = iDataReader.GetOrdinal("FechaFin");
                int iTitulo = iDataReader.GetOrdinal("Titulo");
                int iIdEstado = iDataReader.GetOrdinal("IdEstado");
                int iClienteNombre = iDataReader.GetOrdinal("ClienteNombre");
                int iIdCancha = iDataReader.GetOrdinal("IdCancha");

                while (iDataReader.Read())
                {
                    obj = new DiaryEvent();
                    obj.IdReserva = DataUtil.ValueOfDataBase<Int32>(iDataReader[iIdReserva]);
                    obj.IdCancha = DataUtil.ValueOfDataBase<Int32>(iDataReader[iIdCancha]);
                    obj.StartDateString = DataUtil.ValueOfDataBase<string>(iDataReader[iFechaInicio]);
                    obj.EndDateString = DataUtil.ValueOfDataBase<string>(iDataReader[iFechaFin]);
                    obj.Title = DataUtil.ValueOfDataBase<string>(iDataReader[iTitulo]);
                    obj.IdEstado = DataUtil.ValueOfDataBase<Int32>(iDataReader[iIdEstado]);
                    obj.ClienteNombre = DataUtil.ValueOfDataBase<string>(iDataReader[iClienteNombre]);
                    lista.Add(obj);
                }
            }
            cerrarConexion();
            return lista;
        }

        public string GuardarReserva(CalendarioViewModel oCalendarioVM)
        {
            iniciarConexion();
            command = new SqlCommand(Constante.USP_INS_RESERVA, getCon());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@reserva_fecha_inicio", SqlDbType.DateTime).Value = oCalendarioVM.Reserva.Reserva_FechaInicio;
            command.Parameters.Add("@reserva_fecha_fin", SqlDbType.DateTime).Value = oCalendarioVM.Reserva.Reserva_FechaFin;
            command.Parameters.Add("@reserva_canchaid", SqlDbType.Int).Value = oCalendarioVM.Cancha.cancha_id;
            command.Parameters.Add("@reserva_descripcion", SqlDbType.VarChar).Value = oCalendarioVM.Reserva.Descripcion;
            command.Parameters.Add("@reserva_cliente_dni", SqlDbType.VarChar).Value = oCalendarioVM.Cliente.DNI;
            command.Parameters.Add("@reserva_cliente_nombre", SqlDbType.VarChar).Value = oCalendarioVM.Cliente.Nombre;
            command.Parameters.Add("@reserva_cliente_email", SqlDbType.VarChar).Value = oCalendarioVM.Cliente.Email;
            command.Parameters.Add("@reserva_cliente_celular", SqlDbType.VarChar).Value = oCalendarioVM.Cliente.Celular;
            command.Parameters.Add("@reserva_acepta_terminos", SqlDbType.Bit).Value = oCalendarioVM.Reserva.AceptaTerminos;
            command.Parameters.Add("@reserva_tipo_pago", SqlDbType.VarChar).Value = oCalendarioVM.Reserva.TipoPago;
            command.Parameters.Add("@reserva_precio_total", SqlDbType.Decimal).Value = oCalendarioVM.Reserva.PrecioTotal;
            var resultado = command.ExecuteNonQuery();
            cerrarConexion();
            return resultado.ToString();
        }

        public Cancha ObtenerCanchaPorID(int idCancha)
        {
            Cancha cancha = new Cancha();
            iniciarConexion();

            command = new SqlCommand(Constante.USP_GETCANCHABYID, getCon());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@cancha_id", SqlDbType.Int).Value = idCancha;

            using (IDataReader iDataReader = command.ExecuteReader())
            {
                int iCancha_nombre = iDataReader.GetOrdinal("cancha_nombre");
                int iCancha_descripcion = iDataReader.GetOrdinal("cancha_descripcion");
                int iCancha_distrito = iDataReader.GetOrdinal("cancha_distrito");
                int iCancha_tipo = iDataReader.GetOrdinal("tipocancha");
                int iCancha_URL = iDataReader.GetOrdinal("cancha_imagenurl");
                int iCancha_Precio = iDataReader.GetOrdinal("cancha_precioxhora");

                while (iDataReader.Read())
                {
                    cancha.cancha_id = idCancha;
                    cancha.cancha_nombre = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_nombre]);
                    cancha.cancha_descripcion = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_descripcion]);
                    cancha.cancha_tipo = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_tipo]);
                    cancha.cancha_distrito = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_distrito]);
                    cancha.UrlImagen = DataUtil.ValueOfDataBase<string>(iDataReader[iCancha_URL]);
                    cancha.Precio =Convert.ToDouble( DataUtil.ValueOfDataBase<decimal>(iDataReader[iCancha_Precio]));
                }
            }
            cerrarConexion();
            return cancha;
        }
    }
}