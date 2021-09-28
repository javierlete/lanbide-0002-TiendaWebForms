<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="PresentacionWebForms.Carrito" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <asp:GridView ShowFooter="true" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" ID="ProductosGridView" runat="server">
        <HeaderStyle CssClass="table-dark" />
        <Columns>
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad"></asp:BoundField>
            <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto"></asp:BoundField>
            <asp:BoundField DataField="Producto.Precio" HeaderText="Precio unidad" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="Iva" HeaderText="Iva" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="TotalConIva" HeaderText="Total + Iva" DataFormatString="{0:c}"></asp:BoundField>
        </Columns>
    </asp:GridView>

    <asp:Label ID="TotalConIvaLabel" runat="server"/>
    <asp:Button CssClass="btn btn-primary" PostBackUrl="~/Default.aspx" runat="server" Text="Seguir comprando" />
</asp:Content>
