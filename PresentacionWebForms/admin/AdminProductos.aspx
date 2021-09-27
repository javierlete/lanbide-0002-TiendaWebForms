<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminProductos.aspx.cs" Inherits="PresentacionWebForms.admin.AdminProductos" EnableViewState="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="MensajeLabel" runat="server"></asp:Label>
            <asp:GridView DataKeyNames="Id" ID="ListadoGridView" runat="server" DataSourceID="ListadoDataSource" AllowPaging="True">
                <Columns>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ShowSelectButton="True"></asp:CommandField>
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource OnSelected="GestionarExcepciones" OnInserted="RefrescarFormulario" OnUpdated="RefrescarFormulario" OnDeleted="RefrescarFormulario" OnObjectCreating="ListadoDataSource_ObjectCreating" runat="server" ID="ListadoDataSource" DataObjectTypeName="Entidades.Categoria" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerTodos" TypeName="Daos.IDaoCategoria" UpdateMethod="Modificar">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int64"></asp:Parameter>
                </DeleteParameters>
            </asp:ObjectDataSource>

            <asp:Button OnClick="NuevoButton_Click" ID="NuevoButton" runat="server" Text="Nueva categoría" />

            <asp:FormView ID="CategoriaFormView" DataKeyNames="Id" runat="server" DataSourceID="FormularioDataSource">
                <EditItemTemplate>
                    Id:
                    <asp:TextBox ReadOnly="true" Text='<%# Eval("Id") %>' runat="server" ID="IdTextBox" /><br />
                    Nombre:
                    <asp:TextBox Text='<%# Bind("Nombre") %>' runat="server" ID="NombreTextBox" /><br />
                    <asp:LinkButton runat="server" Text="Actualizar" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    Nombre:
                    <asp:TextBox Text='<%# Bind("Nombre") %>' runat="server" ID="NombreTextBox" /><br />
                    <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="NombreTextBox" ID="NombreRegularExpressionValidator" runat="server" ErrorMessage="La categoría tiene que tener 3 o más caracteres" ValidationExpression="\w{3,}"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="NombreTextBox" ID="NombreRequiredValidator" runat="server" ErrorMessage="Es obligatorio rellenar algún nombre"></asp:RequiredFieldValidator><br />
                    <asp:LinkButton runat="server" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                </InsertItemTemplate>
                <ItemTemplate>
                    Id:
                    <asp:Label Text='<%# Bind("Id") %>' runat="server" ID="IdLabel" /><br />
                    Nombre:
                    <asp:Label Text='<%# Bind("Nombre") %>' runat="server" ID="NombreLabel" /><br />
                    <asp:LinkButton runat="server" Text="Editar" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Eliminar" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Nuevo" CommandName="New" ID="NewButton" CausesValidation="False" />
                </ItemTemplate>
            </asp:FormView>
            <asp:ObjectDataSource OnSelected="GestionarExcepciones" OnInserted="RefrescarListado" OnUpdated="RefrescarListado" OnDeleted="RefrescarListado" OnObjectCreating="ListadoDataSource_ObjectCreating" runat="server" ID="FormularioDataSource" DataObjectTypeName="Entidades.Categoria" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerPorId" TypeName="Daos.IDaoCategoria" UpdateMethod="Modificar">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ListadoGridView" PropertyName="SelectedValue" Name="id" Type="Int64"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:GridView DataKeyNames="Id" ID="ProductosGridView" runat="server" DataSourceID="ProductosDataSource" AutoGenerateColumns="False" AllowPaging="True">
                <Columns>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ShowSelectButton="True"></asp:CommandField>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id"></asp:BoundField>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre"></asp:BoundField>
                    <asp:BoundField DataField="Precio" DataFormatString="{0:n2}" ApplyFormatInEditMode="true" HeaderText="Precio" SortExpression="Precio"></asp:BoundField>
                    <%--<asp:BoundField DataField="CategoriaId" HeaderText="Categoria ID" SortExpression="CategoriaId"></asp:BoundField>--%>
                    <%--<asp:BoundField DataField="Categoria.Nombre" HeaderText="Categoria" SortExpression="Categoria.Nombre"></asp:BoundField>--%>
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource OnUpdated="ProductosDataSource_Updated" OnObjectCreating="ProductosDataSource_ObjectCreating" runat="server" ID="ProductosDataSource" DataObjectTypeName="Entidades.Producto" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerTodosPorCategoria" TypeName="Daos.DaoSqlServerProducto" UpdateMethod="Modificar">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ListadoGridView" PropertyName="SelectedValue" Name="id" Type="Int64"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Button OnClick="NuevoProductoButton_Click" ID="NuevoProductoButton" runat="server" Text="Nuevo producto" />

            <asp:FormView ID="ProductoFormView" runat="server" DataSourceID="ProductoDataSource">
                <EditItemTemplate>
                    Id:
                    <asp:TextBox Text='<%# Bind("Id") %>' runat="server" ID="IdTextBox" /><br />
                    Nombre:
                    <asp:TextBox Text='<%# Bind("Nombre") %>' runat="server" ID="NombreTextBox" /><br />
                    Precio:
                    <asp:TextBox Text='<%# Bind("Precio") %>' runat="server" ID="PrecioTextBox" /><br />
                    Categoria:
                    <asp:DropDownList ID="CategoriaDropDownList" SelectedValue='<%# Bind("CategoriaId") %>' runat="server" DataSourceID="ListadoDataSource" DataTextField="Nombre" DataValueField="Id"></asp:DropDownList>
                    <asp:LinkButton runat="server" Text="Actualizar" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    Nombre:
                    <asp:TextBox Text='<%# Bind("Nombre") %>' runat="server" ID="NombreTextBox" /><br />
                    Precio:
                    <asp:TextBox Text='<%# Bind("Precio") %>' TextMode="Number" runat="server" ID="PrecioTextBox" /><br />
                    Categoria:
                    <asp:DropDownList ID="CategoriaDropDownList" SelectedValue='<%# Bind("CategoriaId") %>' runat="server" DataSourceID="ListadoDataSource" DataTextField="Nombre" DataValueField="Id"></asp:DropDownList>
                    <asp:LinkButton runat="server" Text="Insertar" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
                </InsertItemTemplate>
                <ItemTemplate>
                    Id:
                    <asp:Label Text='<%# Bind("Id") %>' runat="server" ID="IdLabel" /><br />
                    Nombre:
                    <asp:Label Text='<%# Bind("Nombre") %>' runat="server" ID="NombreLabel" /><br />
                    Precio:
                    <asp:Label Text='<%# Bind("Precio") %>' runat="server" ID="PrecioLabel" /><br />
                    <%--Categoria:
                    <asp:Label Text='<%# Bind("Categoria") %>' runat="server" ID="CategoriaLabel" /><br />--%>
                    <asp:LinkButton runat="server" Text="Editar" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Eliminar" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Nuevo" CommandName="New" ID="NewButton" CausesValidation="False" />
                </ItemTemplate>
            </asp:FormView>
            <asp:ObjectDataSource OnObjectCreating="ProductosDataSource_ObjectCreating" runat="server" ID="ProductoDataSource" DataObjectTypeName="Entidades.Producto" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerPorId" TypeName="Daos.DaoSqlServerProducto" UpdateMethod="Modificar">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ProductosGridView" PropertyName="SelectedValue" Name="id" Type="Int64"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </form>
</body>

</html>
