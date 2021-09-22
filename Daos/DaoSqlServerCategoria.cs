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
        private const string SQL_DELETE = "DELETE FROM Categorias WHERE Id = @Id";

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
                con.Open();

                IDbCommand com = con.CreateCommand();

                com.CommandText = SQL_SELECT;

                IDataReader dr = com.ExecuteReader();

                List<Categoria> categorias = new List<Categoria>();

                while(dr.Read())
                {
                    categorias.Add(new Categoria((long)dr["Id"], (string)dr["Nombre"]));
                }

                return categorias;
            }
        }


        public Categoria ObtenerPorId(long id)
        {
            using (IDbConnection con = ObtenerConexion())
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
        }
        
        public Categoria Insertar(Categoria categoria)
        {
            throw new NotImplementedException();
        }

        public Categoria Modificar(Categoria categoria)
        {
            throw new NotImplementedException();
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
                con.Open();

                IDbCommand com = con.CreateCommand();

                com.CommandText = SQL_DELETE;

                IDbDataParameter parId = com.CreateParameter();
                parId.ParameterName = "Id";
                parId.DbType = DbType.Int64;
                parId.Value = id;
                com.Parameters.Add(parId);

                int numeroRegistrosModificados = com.ExecuteNonQuery();

                if(numeroRegistrosModificados == 0)
                {
                    throw new DaoException("No se ha encontrado ese Id para borrar " + id);
                }
            }
        }
    }
}
