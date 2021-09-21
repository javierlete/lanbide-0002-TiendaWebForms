using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public interface IDao<T>
    {
        IEnumerable<T> ObtenerTodos();
        T ObtenerPorId(long id);
        T Insertar(T objeto);
        T Modificar(T objeto);
        void Borrar(long id);
    }
}
