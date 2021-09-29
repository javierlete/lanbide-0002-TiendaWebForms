using Daos;
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
            if (IsValid)
            {
                Button b = sender as Button;
                long id = long.Parse(b.CommandArgument);
                Producto producto = dao.ObtenerPorId(id);

                Cantidad cantidad = (Cantidad)b.Parent.FindControl("Cantidad");
                int unidades = cantidad.Unidades;

                Entidades.Carrito carrito = Session["carrito"] as Entidades.Carrito;
                carrito.Agregar(producto, unidades);

                Response.Redirect("~/Carrito.aspx");
            }
        }

        protected void Cantidad_Click(object sender, EventArgs e)
        {
            LinkButton b = (LinkButton)sender;
            Debug.Print(b.CommandName);

            TextBox cantidadTextBox = (TextBox)b.Parent.FindControl("CantidadTextBox");
            Debug.Print(cantidadTextBox.Text);

            int cantidad = int.Parse(cantidadTextBox.Text);

            switch (b.CommandName)
            {
                case "menos": cantidad--; break;
                case "mas": cantidad++; break;
            }

            cantidadTextBox.Text = cantidad.ToString();
        }

        protected void ProductosRepeater_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            ScriptManager scriptMan = ScriptManager.GetCurrent(this);
            
            LinkButton menos = e.Item.FindControl("MenosButton") as LinkButton;
            LinkButton mas = e.Item.FindControl("MasButton") as LinkButton;
            
            if (menos != null)
            {
                menos.Click += Cantidad_Click;
                scriptMan.RegisterAsyncPostBackControl(menos);
            }

            if (mas != null)
            {
                mas.Click += Cantidad_Click;
                scriptMan.RegisterAsyncPostBackControl(mas);
            }
        }
    }
}