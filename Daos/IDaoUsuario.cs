using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public interface IDaoUsuario: IDao<Usuario>
    {
        new IEnumerable<Usuario> ObtenerTodos();
        Usuario ObtenerPorEmail(string email);
        Usuario VerificarUsuario(Usuario usuario);
        new Usuario ObtenerPorId(long id);
        new Usuario Insertar(Usuario usuario);
        new Usuario Modificar(Usuario usuario);
        new void Borrar(Usuario usuario);
        new void Borrar(long id);
        
    }
}
