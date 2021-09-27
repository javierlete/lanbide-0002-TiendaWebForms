<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="PresentacionWebForms.Carrito" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <asp:GridView ID="ProductosGridView" runat="server" AutoGenerateColumns="true"></asp:GridView>
</asp:Content>
