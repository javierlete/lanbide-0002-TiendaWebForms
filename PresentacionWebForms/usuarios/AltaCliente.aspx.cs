using Daos;
using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentacionWebForms.usuarios
{
    public partial class AltaCliente : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AltaButton_ServerClick(object sender, EventArgs e)
        {
            long? id = (Session["usuario"] as Entidades.Usuario)?.Id;
            string nombre = Nombre.Value;
            string apellidos = Apellidos.Value;
            DateTime fechaNacimiento = DateTime.Parse(FechaNacimiento.Value);

            Cliente cliente = new Cliente(id, nombre, apellidos, fechaNacimiento);

            Global.daoCliente.Insertar(cliente);

            Session["cliente"] = cliente;

            Response.Redirect("~/Default.aspx");
        }
    }
}