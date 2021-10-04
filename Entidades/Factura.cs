using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Factura : IEquatable<Factura>
    {
        public long? Id { get; set; }
        public string Numero { get; set; }
        public DateTime Fecha { get; set; }
        public Cliente Cliente { get; set; }
        public Carrito Carrito { get; set; }

        public Factura(long? id, string numero, DateTime fecha, Cliente cliente, Carrito carrito)
        {
            Id = id;
            Numero = numero;
            Fecha = fecha;
            Cliente = cliente ?? throw new ArgumentNullException(nameof(cliente));
            Carrito = carrito;
        }

        public override bool Equals(object obj)
        {
            return Equals(obj as Factura);
        }

        public bool Equals(Factura other)
        {
            return other != null &&
                   Id == other.Id &&
                   Numero == other.Numero &&
                   Fecha == other.Fecha &&
                   EqualityComparer<Cliente>.Default.Equals(Cliente, other.Cliente) &&
                   EqualityComparer<Carrito>.Default.Equals(Carrito, other.Carrito);
        }

        public override int GetHashCode()
        {
            int hashCode = -218941431;
            hashCode = hashCode * -1521134295 + Id.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Numero);
            hashCode = hashCode * -1521134295 + Fecha.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<Cliente>.Default.GetHashCode(Cliente);
            hashCode = hashCode * -1521134295 + EqualityComparer<Carrito>.Default.GetHashCode(Carrito);
            return hashCode;
        }

        public static bool operator ==(Factura left, Factura right)
        {
            return EqualityComparer<Factura>.Default.Equals(left, right);
        }

        public static bool operator !=(Factura left, Factura right)
        {
            return !(left == right);
        }

        public override string ToString()
        {
            return $"{Id}, {Numero}, {Fecha}, {Cliente}, {Carrito}";
        }
    }
}
