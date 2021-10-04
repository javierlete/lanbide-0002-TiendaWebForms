using Daos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace PresentacionWebForms
{
    public partial class Login : System.Web.UI.Page
    {
        private IDaoUsuario dao = DaoSqlServerUsuario.ObtenerDao();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            HtmlButton b = (HtmlButton)sender;

            string email = Email.Value;
            string password = Password.Value;

            Entidades.Usuario usuario = new Entidades.Usuario(null, email, password);
            Entidades.Usuario usuarioVerificado;

            string comando = b.Attributes["data-nombre"];

            switch (comando)
            {
                case "Alta": 
                    usuarioVerificado = dao.Insertar(usuario);
                    break;
                case "Login": 
                     usuarioVerificado = dao.VerificarUsuario(usuario); 

                    if(usuarioVerificado == null)
                    {
                        FormsAuthentication.RedirectToLoginPage();
                        return;
                    }

                    break;
                default:
                    throw new ArgumentException("No se reconoce el comando " + comando);
            }

            Session["usuario"] = usuarioVerificado;
            FormsAuthentication.RedirectFromLoginPage(usuarioVerificado.Email, false);
        }
    }
}