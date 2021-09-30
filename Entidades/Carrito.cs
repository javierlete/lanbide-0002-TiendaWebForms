using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Carrito
    {
        private const decimal IVA = 0.21m;
        private readonly Dictionary<long, Linea> lineas = new Dictionary<long, Linea>();
        public IEnumerable<Linea> Lineas => lineas.Values;
        public Linea this[long id] => lineas[id];
        public decimal Total
        {
            get
            {
                return lineas.Sum(linea => linea.Value.Total);
                //Func<Linea, decimal> func = calcularTotal;
                //return Lineas.Sum(func);
            }
        }

        //decimal calcularTotal(Linea linea)
        //{
        //    return linea.Total;
        //}

        //decimal Sum(Func<Linea, decimal> funcion)
        //{
        //    decimal total = 0m;
            
        //    foreach(Linea linea in Lineas)
        //    {
        //        total += funcion(linea);
        //    }

        //    return total;
        //}

        public decimal Iva => lineas.Sum(linea => linea.Value.Iva);

        public decimal TotalConIva => lineas.Sum(linea => linea.Value.TotalConIva);

        public void Agregar(Producto producto, int cantidad = 1)
        {
            long id = producto.Id.Value;

            if (lineas.ContainsKey(id))
            {
                lineas[id].Cantidad += cantidad;
                
                if (lineas[id].Cantidad <= 0)
                {
                    throw new ArgumentOutOfRangeException("No admitimos valores 0 o inferiores para la cantidad");
                }
            }
            else
            {
                if (cantidad <= 0)
                {
                    throw new ArgumentOutOfRangeException("No admitimos valores 0 o inferiores para la cantidad");
                }

                lineas.Add(id, new Linea(producto, cantidad));
            }
        }

        public void Eliminar(long id)
        {
            lineas.Remove(id);
        }
        public class Linea
        {
            public long Id => Producto.Id.Value;
            public Producto Producto { get; set; }
            public int Cantidad { get; set; }
            public decimal Total => Producto.Precio * Cantidad;

            public decimal Iva => Total * IVA;

            public decimal TotalConIva => Total + Iva;

            public Linea(Producto producto, int cantidad)
            {
                Producto = producto;
                Cantidad = cantidad;
            }
        }
    }
}
