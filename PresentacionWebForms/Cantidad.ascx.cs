﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PresentacionWebForms
{
    public partial class Cantidad : System.Web.UI.UserControl
    {
        public int Unidades => int.Parse(CantidadTextBox.Text);
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager scriptMan = ScriptManager.GetCurrent(Page);

            scriptMan.RegisterAsyncPostBackControl(MenosButton);
            scriptMan.RegisterAsyncPostBackControl(MasButton);
        }

        protected void Cantidad_Click(object sender, EventArgs e)
        {
            LinkButton b = (LinkButton)sender;
            Debug.Print(b.CommandName);

            Debug.Print(CantidadTextBox.Text);

            int cantidad = int.Parse(CantidadTextBox.Text);

            switch (b.CommandName)
            {
                case "menos":
                    if (cantidad > 1)
                    {
                        cantidad--;
                    }
                    else
                    {
                        cantidad = 1;
                    }
                    break;
                case "mas": cantidad++; break;
            }

            CantidadTextBox.Text = cantidad.ToString();

            CantidadTextBoxRangeValidator.Validate();
        }
    }
}