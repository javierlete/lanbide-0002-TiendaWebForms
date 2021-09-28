<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="PresentacionWebForms.Carrito" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <asp:GridView ID="ProductosGridView" runat="server"></asp:GridView>
    <asp:Button CssClass="btn btn-primary" PostBackUrl="~/Default.aspx" runat="server" Text="Seguir comprando" />
</asp:Content>
