<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminProductos.aspx.cs" Inherits="PresentacionWebForms.admin.AdminProductos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView DataKeyNames="Id" ID="ListadoGridView" runat="server" DataSourceID="ListadoDataSource" AllowPaging="True">
                <Columns>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ShowSelectButton="True"></asp:CommandField>
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource OnUpdated="RefrescarFormulario" OnObjectCreating="ListadoDataSource_ObjectCreating" runat="server" ID="ListadoDataSource" DataObjectTypeName="Entidades.Categoria" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerTodos" TypeName="Daos.IDaoCategoria" UpdateMethod="Modificar">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int64"></asp:Parameter>
                </DeleteParameters>
            </asp:ObjectDataSource>
            <asp:FormView ID="CategoriaFormView" DataKeyNames="Id" runat="server" DataSourceID="FormularioDataSource">
                <EditItemTemplate>
                    Id:
                    <asp:TextBox Text='<%# Bind("Id") %>' runat="server" ID="IdTextBox" /><br />
                    Nombre:
                    <asp:TextBox Text='<%# Bind("Nombre") %>' runat="server" ID="NombreTextBox" /><br />
                    Productos:
                    <asp:TextBox Text='<%# Bind("Productos") %>' runat="server" ID="ProductosTextBox" /><br />
                    <asp:LinkButton runat="server" Text="Actualizar" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    Id:
                    <asp:TextBox Text='<%# Bind("Id") %>' runat="server" ID="IdTextBox" /><br />
                    Nombre:
                    <asp:TextBox Text='<%# Bind("Nombre") %>' runat="server" ID="NombreTextBox" /><br />
                    Productos:
                    <asp:TextBox Text='<%# Bind("Productos") %>' runat="server" ID="ProductosTextBox" /><br />
                    <asp:LinkButton runat="server" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                </InsertItemTemplate>
                <ItemTemplate>
                    Id:
                    <asp:Label Text='<%# Bind("Id") %>' runat="server" ID="IdLabel" /><br />
                    Nombre:
                    <asp:Label Text='<%# Bind("Nombre") %>' runat="server" ID="NombreLabel" /><br />
                    Productos:
                    <asp:Label Text='<%# Bind("Productos") %>' runat="server" ID="ProductosLabel" /><br />
                    <asp:LinkButton runat="server" Text="Editar" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Eliminar" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Nuevo" CommandName="New" ID="NewButton" CausesValidation="False" />
                </ItemTemplate>
            </asp:FormView>
            <asp:ObjectDataSource OnUpdated="RefrescarListado" OnObjectCreating="ListadoDataSource_ObjectCreating" runat="server" ID="FormularioDataSource" DataObjectTypeName="Entidades.Categoria" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerPorId" TypeName="Daos.DaoSqlServerCategoria" UpdateMethod="Modificar">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ListadoGridView" PropertyName="SelectedValue" Name="id" Type="Int64"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </form>
</body>

</html>
