using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentacionWebForms
{
    public partial class Carrito : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Producto> productos = Session["carrito"] as List<Producto>;
            ProductosGridView.DataSource = productos;
            ProductosGridView.DataBind();
        }
    }
}