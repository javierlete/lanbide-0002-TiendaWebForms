<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PresentacionWebForms.Default" %>

<%@ Register Src="~/Cantidad.ascx" TagPrefix="jl" TagName="Cantidad" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <h1>Tienda</h1>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4">
        <asp:Repeater OnItemCreated="ProductosRepeater_ItemCreated" ID="ProductosRepeater" runat="server" DataSourceID="ProductosDataSource">
            <ItemTemplate>
                <div class="col">
                    <div class="card h-100">
                        <img src="https://picsum.photos/320?<%# Eval("Id") %>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("Nombre") %></h5>
                            <p class="card-text"><%# Eval("Categoria.Nombre") %></p>
                            <%# Eval("Precio", "{0:c}") %>
                            <jl:Cantidad runat="server" id="Cantidad" />
                        </div>
                        <div class="card-footer">
                            <asp:Button OnClick="CarritoButton_Click" CommandArgument='<%# Eval("Id") %>' CssClass="btn w-100 btn-primary" ID="CarritoButton" runat="server" Text="Añadir al carrito" />
                            <small class="text-muted"></small>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:ObjectDataSource OnObjectCreating="ProductosDataSource_ObjectCreating" runat="server" ID="ProductosDataSource" DataObjectTypeName="Entidades.Producto" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerTodos" TypeName="Daos.DaoSqlServerProducto" UpdateMethod="Modificar"></asp:ObjectDataSource>
    </div>
</asp:Content>
