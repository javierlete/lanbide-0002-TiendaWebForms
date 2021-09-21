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
            <asp:ObjectDataSource OnObjectCreating="ListadoDataSource_ObjectCreating" runat="server" ID="ListadoDataSource" DataObjectTypeName="Entidades.Categoria" DeleteMethod="Borrar" InsertMethod="Insertar" SelectMethod="ObtenerTodos" TypeName="Daos.IDaoCategoria" UpdateMethod="Modificar">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int64"></asp:Parameter>
                </DeleteParameters>
            </asp:ObjectDataSource>
        </div>
    </form>
</body>
</html>
