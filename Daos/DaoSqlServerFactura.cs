using Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public class DaoSqlServerFactura : IDaoFactura
    {
        private const string CADENA_CONEXION = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=mf0966;Integrated Security=True";
        private const string SQL_SELECT_ID = @"SELECT * FROM Facturas WHERE Id=@Id";
        private const string SQL_SELECT_LINEAS = @"SELECT p.Id AS ProductoId, p.Nombre AS ProductoNombre, p.Precio AS ProductoPrecio, Cantidad FROM FacturasProductos fp JOIN Productos p ON p.Id = fp.ProductoId WHERE FacturaId=@FacturaId";
        private const string SQL_ULTIMA_FACTURA = @"SELECT TOP 1 Numero FROM Facturas WHERE YEAR(Fecha) = @Year ORDER BY Numero DESC";
        private const string SQL_INSERT = @"INSERT INTO Facturas (Numero, Fecha, ClienteId) OUTPUT INSERTED.ID VALUES (@Numero, @Fecha, @ClienteId)";
        private const string SQL_INSERT_LINEA = @"INSERT INTO FacturasProductos (FacturaId, ProductoId, Cantidad) VALUES (@FacturaId, @ProductoId, @Cantidad)";

        #region Singleton
        private DaoSqlServerFactura() { }

        private static readonly DaoSqlServerFactura dao = new DaoSqlServerFactura();

        public static DaoSqlServerFactura ObtenerDao()
        {
            return dao;
        }

        #endregion

        private static SqlConnection ObtenerConexion()
        {
            return new SqlConnection(CADENA_CONEXION);
        }
        public void Borrar(Factura factura)
        {
            throw new NotImplementedException();
        }

        public void Borrar(long id)
        {
            throw new NotImplementedException();
        }

        public Factura Insertar(Factura factura)
        {
            factura.Numero = ObtenerSiguienteNumeroFactura();

            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    SqlCommand com = (SqlCommand)con.CreateCommand();

                    com.CommandText = SQL_INSERT;

                    IDbDataParameter parNumero = com.CreateParameter();
                    parNumero.ParameterName = "Numero";
                    parNumero.DbType = DbType.String;
                    parNumero.Value = factura.Numero;
                    com.Parameters.Add(parNumero);

                    IDbDataParameter parFecha = com.CreateParameter();
                    parFecha.ParameterName = "Fecha";
                    parFecha.DbType = DbType.Date;
                    parFecha.Value = factura.Fecha;
                    com.Parameters.Add(parFecha);

                    IDbDataParameter parClienteId = com.CreateParameter();
                    parClienteId.ParameterName = "ClienteId";
                    parClienteId.DbType = DbType.Int64;
                    parClienteId.Value = factura.Cliente.Id;
                    com.Parameters.Add(parClienteId);

                    factura.Id = (long)com.ExecuteScalar();

                    com = (SqlCommand)con.CreateCommand();

                    com.CommandText = SQL_INSERT_LINEA;

                    IDbDataParameter parFacturaId = com.CreateParameter();
                    parFacturaId.ParameterName = "FacturaId";
                    parFacturaId.DbType = DbType.Int64;
                    parFacturaId.Value = factura.Id;
                    com.Parameters.Add(parFacturaId);

                    IDbDataParameter parProductoId = com.CreateParameter();
                    parProductoId.ParameterName = "ProductoId";
                    parProductoId.DbType = DbType.Int64;
                    com.Parameters.Add(parProductoId);

                    IDbDataParameter parCantidad = com.CreateParameter();
                    parCantidad.ParameterName = "Cantidad";
                    parCantidad.DbType = DbType.Int32;
                    com.Parameters.Add(parCantidad);

                    foreach (Carrito.Linea linea in factura.Carrito.Lineas)
                    {
                        parProductoId.Value = linea.Producto.Id;
                        parCantidad.Value = linea.Cantidad;

                        com.ExecuteNonQuery();
                    }

                    return factura;
                }

                catch (Exception e)
                {
                    throw new DaoException("No se ha podido insertar la factura", e);
                }
            }

        }

        public Factura Modificar(Factura factura)
        {
            throw new NotImplementedException();
        }

        public Factura ObtenerPorId(long id)
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_SELECT_ID;

                    IDbDataParameter parId = com.CreateParameter();
                    parId.ParameterName = "Id";
                    parId.DbType = DbType.Int32;
                    parId.Value = id;
                    com.Parameters.Add(parId);

                    IDataReader dr = com.ExecuteReader();

                    Factura factura = null;
                    Cliente cliente = null;

                    if (dr.Read())
                    {
                        cliente = DaoSqlServerCliente.ObtenerDao().ObtenerPorId((long)dr["ClienteId"]);
                        factura = new Factura(dr["Id"] as long?, dr["Numero"] as string, (DateTime)dr["Fecha"], cliente, null);

                        dr.Close();

                        Carrito carrito = new Carrito();

                        IDbCommand comLineas = con.CreateCommand();

                        comLineas.CommandText = SQL_SELECT_LINEAS;

                        IDbDataParameter parFacturaId = comLineas.CreateParameter();
                        parFacturaId.ParameterName = "FacturaId";
                        parFacturaId.DbType = DbType.Int32;
                        parFacturaId.Value = id;
                        comLineas.Parameters.Add(parFacturaId);

                        IDataReader drLineas = comLineas.ExecuteReader();

                        Producto producto = null;

                        while (drLineas.Read())
                        {
                            producto = new Producto(drLineas["ProductoId"] as long?, drLineas["ProductoNombre"] as string, (decimal)drLineas["ProductoPrecio"], null);
                            carrito.Agregar(producto, (int)drLineas["Cantidad"]);
                        }

                        factura.Carrito = carrito;
                    }

                    return factura;
                }
                catch (Exception e)
                {
                    throw new DaoException("Error al obtener la última factura ", e);
                }
            }
        }

        public IEnumerable<Factura> ObtenerTodos()
        {
            throw new NotImplementedException();
        }

        public string ObtenerSiguienteNumeroFactura()
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_ULTIMA_FACTURA;

                    IDbDataParameter parYear = com.CreateParameter();
                    parYear.ParameterName = "Year";
                    parYear.DbType = DbType.Int32;
                    parYear.Value = DateTime.Today.Year;
                    com.Parameters.Add(parYear);

                    string numero = com.ExecuteScalar() as string;

                    if (numero != null)
                    {
                        numero = (int.Parse(numero) + 1).ToString();
                    }
                    else
                    {
                        numero = DateTime.Today.Year + "0001";
                    }

                    return numero;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al obtener la última factura ", e);
                }
            }
        }
    }
}
