using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Categoria : IEquatable<Categoria>
    {
        public long? Id { get; set; }
        public string Nombre { get; set; }
        public IEnumerable<Producto> Productos { get; set; }

        public Categoria(long? id, string nombre)
        {
            Id = id;
            Nombre = nombre;
        }

        public Categoria() { }

        public override bool Equals(object obj)
        {
            return Equals(obj as Categoria);
        }

        public bool Equals(Categoria other)
        {
            return other != null &&
                   Id == other.Id &&
                   Nombre == other.Nombre &&
                   EqualityComparer<IEnumerable<Producto>>.Default.Equals(Productos, other.Productos);
        }

        public override int GetHashCode()
        {
            int hashCode = -1546776674;
            hashCode = hashCode * -1521134295 + Id.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Nombre);
            hashCode = hashCode * -1521134295 + EqualityComparer<IEnumerable<Producto>>.Default.GetHashCode(Productos);
            return hashCode;
        }

        public static bool operator ==(Categoria left, Categoria right)
        {
            return EqualityComparer<Categoria>.Default.Equals(left, right);
        }

        public static bool operator !=(Categoria left, Categoria right)
        {
            return !(left == right);
        }

        public override string ToString()
        {
            return $"{Id}, {Nombre}";
        }
    }
}
