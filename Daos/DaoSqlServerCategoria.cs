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
    public class DaoSqlServerCategoria : IDaoCategoria
    {
        private const string CADENA_CONEXION = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=mf0966;Integrated Security=True";
        private const string SQL_SELECT = @"SELECT * FROM Categorias";
        private const string SQL_SELECT_ID = SQL_SELECT + @" WHERE Id = @Id";
        private const string SQL_INSERT = @"INSERT INTO Categorias (Nombre) VALUES (@Nombre)";
        private const string SQL_UPDATE = @"UPDATE Categorias SET Nombre=@Nombre WHERE Id = @Id";
        private const string SQL_DELETE = @"DELETE FROM Categorias WHERE Id = @Id";

        #region Singleton
        private DaoSqlServerCategoria() { }

        private static DaoSqlServerCategoria dao = new DaoSqlServerCategoria();

        public static DaoSqlServerCategoria ObtenerDao()
        {
            return dao;
        }

        #endregion

        private static SqlConnection ObtenerConexion()
        {
            return new SqlConnection(CADENA_CONEXION);
        }

        public IEnumerable<Categoria> ObtenerTodos()
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_SELECT;

                    IDataReader dr = com.ExecuteReader();

                    List<Categoria> categorias = new List<Categoria>();

                    while (dr.Read())
                    {
                        categorias.Add(new Categoria((long)dr["Id"], (string)dr["Nombre"]));
                    }

                    return categorias;
                }
                catch (Exception e)
                {
                    throw new DaoException("Error al obtener todos los registros de categorías", e);
                }
            }
        }


        public Categoria ObtenerPorId(long id)
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

                    Categoria categoria = null;

                    if (dr.Read())
                    {
                        categoria = new Categoria((long)dr["Id"], (string)dr["Nombre"]);
                    }

                    return categoria;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al obtener el registro " + id, e);
                }
            }
        }

        public Categoria Insertar(Categoria categoria)
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
                    parNombre.Value = categoria.Nombre;
                    com.Parameters.Add(parNombre);

                    com.ExecuteNonQuery();

                    return categoria;
                }

                catch (Exception e)
                {
                    SqlException se = e as SqlException;

                    string texto = "Error al insertar el registro " + categoria.Nombre;

                    if (se != null)
                    {
                        switch (se.Number)
                        {
                            case 2601:
                                texto = "Ese nombre ya se está utilizando";
                                break;
                            case 2628:
                                texto = "El texto supera la capacidad del campo";
                                break;
                        }
                    }

                    throw new DaoException(texto, e);
                }
            }
        }

        public Categoria Modificar(Categoria categoria)
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
                    parId.Value = categoria.Id;
                    com.Parameters.Add(parId);

                    IDbDataParameter parNombre = com.CreateParameter();
                    parNombre.ParameterName = "Nombre";
                    parNombre.DbType = DbType.String;
                    parNombre.Value = categoria.Nombre;
                    com.Parameters.Add(parNombre);

                    numeroRegistrosModificados = com.ExecuteNonQuery();
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al modificar el registro " + categoria.Id, e);
                }

                if (numeroRegistrosModificados == 0)
                {
                    throw new DaoException("No se ha encontrado ese Id para modificar " + categoria.Id);
                }

                return categoria;
            }
        }

        public void Borrar(Categoria categoria)
        {
            if (categoria.Id.HasValue)
            {
                Borrar(categoria.Id.Value);
            }
            else
            {
                throw new NotImplementedException();
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
