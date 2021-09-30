using Entidades;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentacionWebForms
{
    public partial class Carrito : System.Web.UI.Page
    {
        public Entidades.Carrito Modelo => Session["carrito"] as Entidades.Carrito;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Cantidad.Click += Cantidad_Click;

            ProductosGridView.DataSource = Modelo.Lineas;
            ProductosGridView.DataBind();

            TotalConIvaLabel.Text = Modelo.TotalConIva.ToString("c");
        }

        protected void ProductosGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            long id = (long)e.Keys[0];
            (Session["carrito"] as Entidades.Carrito).Eliminar(id);
            ProductosGridView.DataBind();
            TotalConIvaLabel.Text = Modelo.TotalConIva.ToString("c");
        }

        protected void Cantidad_Click(object sender, EventArgs e)
        {
            Debug.Print(sender.ToString());
            Debug.Print(e?.ToString());

            Cantidad cantidad = (Cantidad)sender;

            Modelo[cantidad.IdRelacionado.Value].Cantidad = cantidad.Unidades;
            ProductosGridView.DataBind();
            TotalConIvaLabel.Text = Modelo.TotalConIva.ToString("c");

            Response.Redirect("~/Carrito.aspx");
        }
    }
}
