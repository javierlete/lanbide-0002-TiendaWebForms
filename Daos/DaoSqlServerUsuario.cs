using Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Daos
{
    public class DaoSqlServerUsuario : IDaoUsuario
    {
        private static readonly string CADENA_CONEXION = ConfigurationManager.AppSettings["CadenaConexion"];
        private const string SQL_SELECT_BY_EMAIL = "SELECT * FROM Usuarios WHERE Email=@Email";
        private const string SQL_INSERT = @"INSERT INTO Usuarios (Email, Password) OUTPUT INSERTED.ID  VALUES (@Email, @Password)";

        #region Singleton
        private DaoSqlServerUsuario() { }

        private static readonly DaoSqlServerUsuario dao = new DaoSqlServerUsuario();

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

                    usuario.Id = (long)com.ExecuteScalar();

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
            using (IDbConnection con = ObtenerConexion())
            {
                try
                {
                    con.Open();

                    IDbCommand com = con.CreateCommand();

                    com.CommandText = SQL_SELECT_BY_EMAIL;

                    IDbDataParameter parEmail = com.CreateParameter();
                    parEmail.ParameterName = "Email";
                    parEmail.DbType = DbType.String;
                    parEmail.Value = email;
                    com.Parameters.Add(parEmail);

                    IDataReader dr = com.ExecuteReader();

                    Usuario usuario = null;

                    if (dr.Read())
                    {
                        usuario = new Usuario(dr["Id"] as long?, dr["Email"] as string, dr["Password"] as string);
                    }

                    return usuario;
                }

                catch (Exception e)
                {
                    throw new DaoException("Error al buscar por email " + email, e);
                }
            }
        }

        // TODO: Debería estar en una lógica de negocio
        public Usuario VerificarUsuario(Usuario usuario)
        {
            Usuario usuarioBdd = ObtenerPorEmail(usuario.Email);

            if(usuarioBdd != null && BCrypt.Net.BCrypt.Verify(usuario.Password, usuarioBdd.Password))
            {
                return usuarioBdd;
            }

            return null;
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
