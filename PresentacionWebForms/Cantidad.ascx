<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Cantidad.ascx.cs" Inherits="PresentacionWebForms.Cantidad" %>
<asp:UpdatePanel class='<%# Inline ? "d-inline-block": "" %>' runat="server">
    <ContentTemplate>
        <div class="input-group mb-3">
            <asp:LinkButton OnClick="Cantidad_Click" ID="MenosButton" CommandName="menos" CssClass="btn btn-outline-secondary" runat="server" Text='<i class="fas fa-minus"></i>' />
            <asp:TextBox CssClass="form-control text-center" runat="server" ID="CantidadTextBox" Text="1" />
            <asp:LinkButton OnClick="Cantidad_Click" ID="MasButton" CommandName="mas" CssClass="btn btn-outline-secondary" runat="server" Text='<i class="fas fa-plus"></i>' />
        </div>
        <asp:RangeValidator Display="Dynamic" ControlToValidate="CantidadTextBox" ID="CantidadTextBoxRangeValidator" MinimumValue="1" Type="Integer" MaximumValue="1000" runat="server" ErrorMessage="Sólo se admiten valores de cantidad iguales o superiores a 1"></asp:RangeValidator>
    </ContentTemplate>
</asp:UpdatePanel>
