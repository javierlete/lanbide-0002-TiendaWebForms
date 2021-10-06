using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentacionWebForms.clientes
{
    public partial class Factura : System.Web.UI.Page
    {
        private Entidades.Factura factura;
        protected void Page_Load(object sender, EventArgs e)
        {
            long id = long.Parse(Request["id"]);

            factura = Global.daoFactura.ObtenerPorId(id);

            NumeroFactura.InnerText = factura.Numero;

            DatosFactura.InnerHtml = factura.Fecha.ToString("d") + "<br/>" + factura.Cliente.Nombre + "<br/>" + factura.Cliente.Apellidos + "<br />";

            ProductosGridView.DataSource = factura.Carrito.Lineas;
            ProductosGridView.DataBind();
        }

        protected void ProductosGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[5].Text = factura.Carrito.TotalConIva.ToString("c");
            }
        }
    }
}