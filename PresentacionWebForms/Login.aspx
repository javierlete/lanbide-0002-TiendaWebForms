<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PresentacionWebForms.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <h1>Login</h1>

    <div class="row mb-3">
        <label for="Email" class="col-sm-2 col-form-label">Email</label>
        <div class="col-sm-10">
            <input runat="server" type="email" class="form-control" id="Email">
        </div>
    </div>
    <div class="row mb-3">
        <label for="Password" class="col-sm-2 col-form-label">Contraseña</label>
        <div class="col-sm-10">
            <input runat="server" type="password" class="form-control" id="Password">
        </div>
    </div>    
    
    <button OnServerClick="Login_Click" data-nombre="Login" runat="server" id="LoginButton" type="submit" class="btn btn-primary">Login</button>
   
    <button OnServerClick="Login_Click" data-nombre="Alta" runat="server" id="AltaButton" type="submit" class="btn btn-outline-primary">Alta</button>
</asp:Content>
