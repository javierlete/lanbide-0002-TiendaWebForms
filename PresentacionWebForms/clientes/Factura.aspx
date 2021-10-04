<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Factura.aspx.cs" Inherits="PresentacionWebForms.clientes.Factura" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="card" style="width: 18rem;">
        <div class="card-body">
            <h5 id="NumeroFactura" runat="server" class="card-title"></h5>
            <p id="DatosFactura" runat="server" class="card-text"></p>
        </div>
    </div>

    <asp:GridView OnRowDataBound="ProductosGridView_RowDataBound" ShowFooter="true" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" ID="ProductosGridView" runat="server">
        <headerstyle cssclass="table-dark" />
        <columns>
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad"></asp:BoundField>
            <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto"></asp:BoundField>
            <asp:BoundField DataField="Producto.Precio" HeaderText="Precio unidad" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:c}"></asp:BoundField>
            <asp:BoundField DataField="Iva" HeaderText="Iva" DataFormatString="{0:c}"></asp:BoundField>
            <asp:TemplateField HeaderText="Total + Iva">
                <ItemTemplate>
                    <%# Eval("TotalConIva", "{0:c}") %>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label id="TotalConIvaLabel" runat="server"/>
                </FooterTemplate>
            </asp:TemplateField>
        </columns>
        <footerstyle cssclass="table-dark" />
    </asp:GridView>
</asp:Content>
