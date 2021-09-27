<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PresentacionWebForms.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <h1>Tienda</h1>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-4">
        <asp:Repeater ID="ProductosRepeater" runat="server" DataSourceID="ProductosDataSource">
            <ItemTemplate>
                <div class="col">
                    <div class="card h-100">
                        <img src="https://picsum.photos/320?<%# Eval("Id") %>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("Nombre") %></h5>
                            <p class="card-text"><%# Eval("Categoria.Nombre") %></p>
                        </div>
                        <div class="card-footer">
                            <small class="text-muted"><%# Eval("Precio", "{0:c}") %></small>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:ObjectDataSource OnObjectCreating="ProductosDataSource_ObjectCreating" runat="server" ID="ProductosDataSource" DataObjectTypeName="Entidades.Producto" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerTodos" TypeName="Daos.DaoSqlServerProducto" UpdateMethod="Modificar"></asp:ObjectDataSource>
    </div>
</asp:Content>
