using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public interface IDaoCategoria: IDao<Categoria>
    {
        new IEnumerable<Categoria> ObtenerTodos();
        new Categoria ObtenerPorId(long id);
        new Categoria Insertar(Categoria categoria);
        new Categoria Modificar(Categoria categoria);
        new void Borrar(Categoria categoria);
        new void Borrar(long id);
    }
}
