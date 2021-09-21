using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Producto : IEquatable<Producto>
    {
        public long? Id { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public Categoria Categoria { get; set; }

        public Producto(long? id, string nombre, decimal precio, Categoria categoria)
        {
            Id = id;
            Nombre = nombre;
            Precio = precio;
            Categoria = categoria;
        }

        public Producto() { }

        public override bool Equals(object obj)
        {
            return Equals(obj as Producto);
        }

        public bool Equals(Producto other)
        {
            return other != null &&
                   Id == other.Id &&
                   Nombre == other.Nombre &&
                   Precio == other.Precio &&
                   EqualityComparer<Categoria>.Default.Equals(Categoria, other.Categoria);
        }

        public override int GetHashCode()
        {
            int hashCode = -1876611217;
            hashCode = hashCode * -1521134295 + Id.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Nombre);
            hashCode = hashCode * -1521134295 + Precio.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<Categoria>.Default.GetHashCode(Categoria);
            return hashCode;
        }

        public static bool operator ==(Producto left, Producto right)
        {
            return EqualityComparer<Producto>.Default.Equals(left, right);
        }

        public static bool operator !=(Producto left, Producto right)
        {
            return !(left == right);
        }

        public override string ToString()
        {
            return $"{Id}, {Nombre}, {Precio}, {Categoria}";
        }
    }
}
