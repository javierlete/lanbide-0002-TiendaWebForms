﻿using Daos;
using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace PresentacionWebForms
{
    public class Global : System.Web.HttpApplication
    {
        public static readonly IDaoProducto daoProducto = DaoSqlServerProducto.ObtenerDao();
        public static readonly IDaoCategoria daoCategoria = DaoSqlServerCategoria.ObtenerDao();
        public static readonly IDaoCliente daoCliente = DaoSqlServerCliente.ObtenerDao();
        public static readonly IDaoFactura daoFactura = DaoSqlServerFactura.ObtenerDao();
        public static readonly IDaoUsuario daoUsuario = DaoSqlServerUsuario.ObtenerDao();

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["carrito"] = new Entidades.Carrito();
        }
        protected void Application_Start(object sender, EventArgs e)
        {
            if(!Roles.RoleExists("ADMIN")) Roles.CreateRole("ADMIN");
            if (!Roles.RoleExists("USUARIO")) Roles.CreateRole("USUARIO");
            if (!Roles.RoleExists("CLIENTE")) Roles.CreateRole("CLIENTE");

            string JQueryVer = "3.6.0";
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-" + JQueryVer + ".min.js",
                DebugPath = "~/Scripts/jquery-" + JQueryVer + ".js",
                CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-" + JQueryVer + ".min.js",
                CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-" + JQueryVer + ".js",
                CdnSupportsSecureConnection = true,
                LoadSuccessExpression = "window.jQuery"
            });
        }
    }
}