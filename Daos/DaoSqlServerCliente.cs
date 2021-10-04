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
    public class DaoSqlServerCliente : IDaoCliente
    {
        private const string CADENA_CONEXION = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=mf0966;Integrated Security=True";
        private const string SQL_SELECT_ID = @"SELECT * FROM Clientes WHERE Id=@Id";
        private const string SQL_INSERT = @"INSERT INTO Clientes (Id, Nombre, Apellidos, FechaNacimiento) VALUES (@Id, @Nombre, @Apellidos, @FechaNacimiento)";

        #region Singleton
        private DaoSqlServerCliente() { }

        private static DaoSqlServerCliente dao = new DaoSqlServerCliente();

        public static DaoSqlServerCliente ObtenerDao()
        {
            return dao;
        }

        private static SqlConnection ObtenerConexion()
        {
            return new SqlConnection(CADENA_CONEXION);
        }
        #endregion
        public void Borrar(Cliente cliente)
        {
            throw new NotImplementedException();
        }

        public void Borrar(long id)
        {
            throw new NotImplementedException();
        }

        public Cliente Insertar(Cliente cliente)
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_INSERT;

                    IDbDataParameter parId = com.CreateParameter();
                    parId.ParameterName = "Id";
                    parId.DbType = DbType.Int64;
                    parId.Value = cliente.Id;
                    com.Parameters.Add(parId);

                    IDbDataParameter parNombre = com.CreateParameter();
                    parNombre.ParameterName = "Nombre";
                    parNombre.DbType = DbType.String;
                    parNombre.Value = cliente.Nombre;
                    com.Parameters.Add(parNombre);

                    IDbDataParameter parApellidos = com.CreateParameter();
                    parApellidos.ParameterName = "Apellidos";
                    parApellidos.DbType = DbType.String;
                    parApellidos.Value = cliente.Apellidos;
                    com.Parameters.Add(parApellidos);

                    IDbDataParameter parFechaNacimiento = com.CreateParameter();
                    parFechaNacimiento.ParameterName = "FechaNacimiento";
                    parFechaNacimiento.DbType = DbType.Date;
                    parFechaNacimiento.Value = cliente.FechaNacimiento;
                    com.Parameters.Add(parFechaNacimiento);

                    com.ExecuteNonQuery();

                    return cliente;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al insertar el registro " + cliente.Nombre, e);
                }
            }
        }

        public Cliente Modificar(Cliente cliente)
        {
            throw new NotImplementedException();
        }

        public Cliente ObtenerPorId(long id)
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

                    Cliente cliente = null;

                    if (dr.Read())
                    {
                        cliente = new Cliente(dr["Id"] as long?, dr["Nombre"] as string, dr["Apellidos"] as string, dr["FechaNacimiento"] as DateTime?);
                    }

                    return cliente;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al obtener el registro " + id, e);
                }
            }
        }

        public IEnumerable<Cliente> ObtenerTodos()
        {
            throw new NotImplementedException();
        }
    }
}
