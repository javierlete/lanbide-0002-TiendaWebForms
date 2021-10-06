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
    public class DaoSqlServerProducto : IDaoProducto
    {
        private const string CADENA_CONEXION = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=mf0966;Integrated Security=True";
        private const string SQL_SELECT = @"SELECT p.Id, p.Nombre, p.Precio, c.Id AS cId, c.Nombre AS cNombre FROM Productos p JOIN Categorias c ON p.CategoriaId = c.Id";
        private const string SQL_SELECT_ID = SQL_SELECT + @" WHERE p.Id = @Id";
        private const string SQL_SELECT_CATID = SQL_SELECT + @" WHERE c.Id = @Id";
        private const string SQL_INSERT = @"INSERT INTO Productos (Nombre, Precio, CategoriaId) VALUES (@Nombre, @Precio, @CategoriaId)";
        private const string SQL_UPDATE = @"UPDATE Productos SET Nombre=@Nombre, Precio=@Precio, CategoriaId=@CategoriaId WHERE Id = @Id";
        private const string SQL_DELETE = @"DELETE FROM Productos WHERE Id = @Id";

        #region Singleton
        private DaoSqlServerProducto() { }

        private static DaoSqlServerProducto dao = new DaoSqlServerProducto();

        public static DaoSqlServerProducto ObtenerDao()
        {
            return dao;
        }

        #endregion

        private static SqlConnection ObtenerConexion()
        {
            return new SqlConnection(CADENA_CONEXION);
        }

        public IEnumerable<Producto> ObtenerTodos()
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_SELECT;

                    IDataReader dr = com.ExecuteReader();

                    List<Producto> productos = new List<Producto>();
                    Categoria categoria;
                    Producto producto;

                    IDictionary<long, Categoria> categorias = new Dictionary<long, Categoria>();
                    long categoriaId;

                    while (dr.Read())
                    {
                        categoriaId = (long)dr["cId"];

                        if (categorias.ContainsKey(categoriaId))
                        {
                            categoria = categorias[categoriaId];
                        }
                        else
                        {
                            categoria = new Categoria((long)dr["cId"], (string)dr["cNombre"]);
                        }

                        producto = new Producto((long)dr["Id"], (string)dr["Nombre"], (decimal)dr["Precio"], categoria);
                        productos.Add(producto);
                    }

                    return productos;
                }
                catch (Exception e)
                {
                    throw new DaoException("Error al obtener todos los registros de productos", e);
                }
            }
        }


        public Producto ObtenerPorId(long id)
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
                    parId.DbType = DbType.Int64;
                    parId.Value = id;
                    com.Parameters.Add(parId);

                    IDataReader dr = com.ExecuteReader();

                    Categoria categoria;
                    Producto producto = null;
                    
                    long categoriaId;

                    if (dr.Read())
                    {
                        categoriaId = (long)dr["cId"];

                        categoria = new Categoria((long)dr["cId"], (string)dr["cNombre"]);
                        
                        producto = new Producto((long)dr["Id"], (string)dr["Nombre"], (decimal)dr["Precio"], categoria);
                    }

                    return producto;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al obtener el registro " + id, e);
                }
            }
        }

        public IEnumerable<Producto> ObtenerTodosPorCategoria(long id)
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_SELECT_CATID;

                    IDbDataParameter parId = com.CreateParameter();
                    parId.ParameterName = "Id";
                    parId.DbType = DbType.Int64;
                    parId.Value = id;
                    com.Parameters.Add(parId);

                    IDataReader dr = com.ExecuteReader();

                    List<Producto> productos = new List<Producto>();
                    Categoria categoria = null;
                    Producto producto;

                    while (dr.Read())
                    {
                        if (categoria == null)
                        {
                            categoria = new Categoria((long)dr["cId"], (string)dr["cNombre"]);
                        }
                        producto = new Producto((long)dr["Id"], (string)dr["Nombre"], (decimal)dr["Precio"], categoria);
                        productos.Add(producto);
                    }

                    return productos;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al obtener los registros de categoría " + id, e);
                }
            }
        }

        public Producto Insertar(Producto producto)
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_INSERT;

                    IDbDataParameter parNombre = com.CreateParameter();
                    parNombre.ParameterName = "Nombre";
                    parNombre.DbType = DbType.String;
                    parNombre.Value = producto.Nombre;
                    com.Parameters.Add(parNombre);

                    IDbDataParameter parPrecio = com.CreateParameter();
                    parPrecio.ParameterName = "Precio";
                    parPrecio.DbType = DbType.Decimal;
                    parPrecio.Value = producto.Precio;
                    com.Parameters.Add(parPrecio);

                    IDbDataParameter parCategoriaId = com.CreateParameter();
                    parCategoriaId.ParameterName = "CategoriaId";
                    parCategoriaId.DbType = DbType.Int64;
                    parCategoriaId.Value = producto.Categoria.Id;
                    com.Parameters.Add(parCategoriaId);

                    com.ExecuteNonQuery();

                    return producto;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al insertar el registro " + producto.Nombre, e);
                }
            }
        }

        public Producto Modificar(Producto producto)
        {
            using (IDbConnection con = ObtenerConexion())
            {
                int numeroRegistrosModificados;

                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_UPDATE;

                    IDbDataParameter parId = com.CreateParameter();
                    parId.ParameterName = "Id";
                    parId.DbType = DbType.Int64;
                    parId.Value = producto.Id;
                    com.Parameters.Add(parId);

                    IDbDataParameter parNombre = com.CreateParameter();
                    parNombre.ParameterName = "Nombre";
                    parNombre.DbType = DbType.String;
                    parNombre.Value = producto.Nombre;
                    com.Parameters.Add(parNombre);

                    IDbDataParameter parPrecio = com.CreateParameter();
                    parPrecio.ParameterName = "Precio";
                    parPrecio.DbType = DbType.Decimal;
                    parPrecio.Value = producto.Precio;
                    com.Parameters.Add(parPrecio);

                    IDbDataParameter parCategoriaId = com.CreateParameter();
                    parCategoriaId.ParameterName = "CategoriaId";
                    parCategoriaId.DbType = DbType.Int64;
                    parCategoriaId.Value = producto.Categoria.Id;
                    com.Parameters.Add(parCategoriaId);

                    numeroRegistrosModificados = com.ExecuteNonQuery();
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al modificar el registro " + producto.Id, e);
                }

                if (numeroRegistrosModificados == 0)
                {
                    throw new DaoException("No se ha encontrado ese Id para modificar " + producto.Id);
                }

                return producto;
            }
        }

        public void Borrar(Producto producto)
        {
            if (producto.Id.HasValue)
            {
                Borrar(producto.Id.Value);
            }
            else
            {
                throw new DaoException("Has intentado borrar un producto con el id null");
            }
        }
        public void Borrar(long id)
        {
            using (IDbConnection con = ObtenerConexion())
            {
                int numeroRegistrosModificados;

                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_DELETE;

                    IDbDataParameter parId = com.CreateParameter();
                    parId.ParameterName = "Id";
                    parId.DbType = DbType.Int64;
                    parId.Value = id;
                    com.Parameters.Add(parId);

                    numeroRegistrosModificados = com.ExecuteNonQuery();
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al borrar el registro " + id, e);
                }

                if (numeroRegistrosModificados == 0)
                {
                    throw new DaoException("No se ha encontrado ese Id para borrar " + id);
                }
            }
        }
    }
}
