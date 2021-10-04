<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="AltaCliente.aspx.cs" Inherits="PresentacionWebForms.usuarios.AltaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <h1>Alta de cliente</h1>

    <div class="row mb-3">
        <label for="Nombre" class="col-sm-2 col-form-label">Nombre</label>
        <div class="col-sm-10">
            <input runat="server" type="text" class="form-control" id="Nombre">
        </div>
    </div>
    <div class="row mb-3">
        <label for="Apellidos" class="col-sm-2 col-form-label">Apellidos</label>
        <div class="col-sm-10">
            <input runat="server" type="text" class="form-control" id="Apellidos">
        </div>
    </div>
    <div class="row mb-3">
        <label for="FechaNacimiento" class="col-sm-2 col-form-label">Fecha de nacimiento</label>
        <div class="col-sm-10">
            <input runat="server" type="date" class="form-control" id="FechaNacimiento">
        </div>
    </div>
    
    <button id="AltaButton" onserverclick="AltaButton_ServerClick" runat="server" type="submit" class="btn btn-primary">Dar de alta</button>
</asp:Content>
