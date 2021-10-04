﻿using Daos;
using Entidades;
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
        private readonly IDaoUsuario dao = DaoSqlServerUsuario.ObtenerDao();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["error"] != null)
            {
                ErrorLabel.Text = (string)Session["error"];
                ErrorLabel.Visible = true;

                Session.Remove("error");
            }
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
                        Session["error"] = "El usuario o la contraseña son incorrectos";
                        FormsAuthentication.RedirectToLoginPage();
                        return;
                    }

                    break;
                default:
                    throw new ArgumentException("No se reconoce el comando " + comando);
            }

            IDaoCliente daoCliente = DaoSqlServerCliente.ObtenerDao();
            Cliente cliente = daoCliente.ObtenerPorId(usuarioVerificado.Id.Value);

            Session["usuario"] = usuarioVerificado;
            Session["cliente"] = cliente;

            FormsAuthentication.RedirectFromLoginPage(usuarioVerificado.Email, false);
        }
    }
}