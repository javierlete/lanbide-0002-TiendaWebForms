<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="PresentacionWebForms.Carrito" %>

<%@ Register Src="~/Cantidad.ascx" TagPrefix="jl" TagName="Cantidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <asp:GridView DataKeyNames="Id" OnRowDeleting="ProductosGridView_RowDeleting" ShowFooter="true" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" ID="ProductosGridView" runat="server">
        <HeaderStyle CssClass="table-dark" />
        <Columns>
            <asp:TemplateField HeaderText="Cantidad">
                <ItemTemplate>
                    <jl:Cantidad Inline="true" IdRelacionado='<%# Bind("Id") %>' OnClick="Cantidad_Click" runat="server" VisibleNumero="false" Unidades='<%# Bind("Cantidad") %>' ID="Cantidad" />
                    <asp:Label Text='<%# Bind("Cantidad") %>' runat="server" ID="CantidadLabel" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto"></asp:BoundField>
            <asp:BoundField DataField="Producto.Precio" HeaderText="Precio unidad" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="Iva" HeaderText="Iva" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="TotalConIva" HeaderText="Total + Iva" DataFormatString="{0:c}"></asp:BoundField>
            <asp:CommandField ControlStyle-CssClass="btn btn-danger" ShowDeleteButton="True"></asp:CommandField>
        </Columns>
    </asp:GridView>

    <asp:Label ID="TotalConIvaLabel" runat="server" />
    <asp:Button CssClass="btn btn-primary" PostBackUrl="~/Default.aspx" runat="server" Text="Seguir comprando" />
    <asp:Button ID="Facturar" CssClass="btn btn-primary" OnClick="Facturar_Click" runat="server" Text="Facturar" />
</asp:Content>
