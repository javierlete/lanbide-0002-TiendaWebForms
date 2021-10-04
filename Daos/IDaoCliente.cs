using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public interface IDaoCliente: IDao<Cliente>
    {
        new IEnumerable<Cliente> ObtenerTodos();
        new Cliente ObtenerPorId(long id);
        new Cliente Insertar(Cliente cliente);
        new Cliente Modificar(Cliente cliente);
        new void Borrar(Cliente cliente);
        new void Borrar(long id);
        
    }
}
