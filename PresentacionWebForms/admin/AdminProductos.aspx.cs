using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentacionWebForms.admin
{
    public partial class AdminProductos : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ListadoDataSource_ObjectCreating(object sender, ObjectDataSourceEventArgs e)
        {
            e.ObjectInstance = Daos.DaoSqlServerCategoria.ObtenerDao();
        }

        protected void RefrescarListado(object sender, ObjectDataSourceStatusEventArgs e)
        {
            GestionarExcepciones(sender, e);
            ListadoGridView.DataBind();
        }

        protected void RefrescarFormulario(object sender, ObjectDataSourceStatusEventArgs e)
        {
            GestionarExcepciones(sender, e);
            CategoriaFormView.DataBind();
        }

        protected void GestionarExcepciones(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if(e.Exception != null)
            {
                Exception ex = e.Exception.InnerException;

                //if(!(ex is Daos.DaoException))
                //{
                //    ex = ex.InnerException;
                //}

                MensajeLabel.Text += ex.Message + ". ";

                Debug.WriteLine(e.Exception);

                Trace.Warn("DAO", "Excepción del DAO", e.Exception);

                e.ExceptionHandled = true;
            }
        }

        protected void ProductosDataSource_ObjectCreating(object sender, ObjectDataSourceEventArgs e)
        {
            e.ObjectInstance = Daos.DaoSqlServerProducto.ObtenerDao();
        }

        protected void ProductosDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            Debug.Print(e.ReturnValue.ToString());
        }

        protected override void InitializeCulture()
        {
            var clonedCulture = (System.Globalization.CultureInfo)new System.Globalization.CultureInfo("es-ES").Clone();

            clonedCulture.NumberFormat.NumberDecimalSeparator = ".";
            clonedCulture.NumberFormat.NumberGroupSeparator = "";

            System.Threading.Thread.CurrentThread.CurrentCulture = clonedCulture;
        }

        protected void NuevoButton_Click(object sender, EventArgs e)
        {
            CategoriaFormView.ChangeMode(FormViewMode.Insert);
        }

        protected void NuevoProductoButton_Click(object sender, EventArgs e)
        {
            ProductoFormView.ChangeMode(FormViewMode.Insert);
        }
    }
}