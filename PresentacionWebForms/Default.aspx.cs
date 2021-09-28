using Daos;
using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentacionWebForms
{
    public partial class Default : System.Web.UI.Page
    {
        private static readonly IDaoProducto dao = Daos.DaoSqlServerProducto.ObtenerDao();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ProductosDataSource_ObjectCreating(object sender, ObjectDataSourceEventArgs e)
        {
            e.ObjectInstance = dao;
        }

        protected void CarritoButton_Click(object sender, EventArgs e)
        {
            Button b = sender as Button;
            long id = long.Parse(b.CommandArgument);
            Producto producto = dao.ObtenerPorId(id);

            Entidades.Carrito carrito = Session["carrito"] as Entidades.Carrito;
            carrito.Agregar(producto);

            Response.Redirect("~/Carrito.aspx");
        }
    }
}