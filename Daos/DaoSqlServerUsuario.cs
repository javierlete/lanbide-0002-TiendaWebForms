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
    public class DaoSqlServerUsuario : IDaoUsuario
    {
        private const string CADENA_CONEXION = @"Data Source=localhost\SQLEXPRESS;Initial Catalog=mf0966;Integrated Security=True";
        private const string SQL_INSERT = @"INSERT INTO Usuarios (Email, Password) VALUES (@Email, @Password)";

        #region Singleton
        private DaoSqlServerUsuario() { }

        private static DaoSqlServerUsuario dao = new DaoSqlServerUsuario();

        public static DaoSqlServerUsuario ObtenerDao()
        {
            return dao;
        }

        private static SqlConnection ObtenerConexion()
        {
            return new SqlConnection(CADENA_CONEXION);
        }
        #endregion
        public void Borrar(Usuario usuario)
        {
            throw new NotImplementedException();
        }

        public void Borrar(long id)
        {
            throw new NotImplementedException();
        }

        public Usuario Insertar(Usuario usuario)
        {
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_INSERT;

                    IDbDataParameter parEmail = com.CreateParameter();
                    parEmail.ParameterName = "Email";
                    parEmail.DbType = DbType.String;
                    parEmail.Value = usuario.Email;
                    com.Parameters.Add(parEmail);

                    IDbDataParameter parPassword = com.CreateParameter();
                    parPassword.ParameterName = "Password";
                    parPassword.DbType = DbType.String;
                    parPassword.Value = BCrypt.Net.BCrypt.HashPassword(usuario.Password);
                    com.Parameters.Add(parPassword);

                    com.ExecuteNonQuery();

                    return usuario;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al insertar el registro " + usuario.Email, e);
                }
            }
        }

        public Usuario Modificar(Usuario usuario)
        {
            throw new NotImplementedException();
        }

        public Usuario ObtenerPorEmail(string email)
        {
            throw new NotImplementedException();
        }

        public Usuario ObtenerPorId(long id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Usuario> ObtenerTodos()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Usuario> ObtenerTodosPorCategoria(long id)
        {
            throw new NotImplementedException();
        }
    }
}
