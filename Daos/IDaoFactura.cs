using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public interface IDaoFactura: IDao<Factura>
    {
        string ObtenerSiguienteNumeroFactura();
        new IEnumerable<Factura> ObtenerTodos();
        new Factura ObtenerPorId(long id);
        new Factura Insertar(Factura factura);
        new Factura Modificar(Factura factura);
        new void Borrar(Factura factura);
        new void Borrar(long id);
    }
}
