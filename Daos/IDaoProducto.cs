using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public interface IDaoProducto: IDao<Producto>
    {
        new IEnumerable<Producto> ObtenerTodos();
        IEnumerable<Producto> ObtenerTodosPorCategoria(long id);
        new Producto ObtenerPorId(long id);
        new Producto Insertar(Producto producto);
        new Producto Modificar(Producto producto);
        new void Borrar(Producto producto);
        new void Borrar(long id);
    }
}
