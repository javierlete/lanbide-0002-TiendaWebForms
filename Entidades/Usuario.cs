using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Usuario : IEquatable<Usuario>
    {
        public long? Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }

        public Usuario(long? id, string email, string password)
        {
            Id = id;
            Email = email ?? throw new ArgumentNullException(nameof(email));
            Password = password ?? throw new ArgumentNullException(nameof(password));
        }

        public override bool Equals(object obj)
        {
            return Equals(obj as Usuario);
        }

        public bool Equals(Usuario other)
        {
            return other != null &&
                   Id == other.Id &&
                   Email == other.Email &&
                   Password == other.Password;
        }

        public override int GetHashCode()
        {
            int hashCode = -190816841;
            hashCode = hashCode * -1521134295 + Id.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Email);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Password);
            return hashCode;
        }

        public static bool operator ==(Usuario left, Usuario right)
        {
            return EqualityComparer<Usuario>.Default.Equals(left, right);
        }

        public static bool operator !=(Usuario left, Usuario right)
        {
            return !(left == right);
        }

        public override string ToString()
        {
            return $"{Id}, {Email}, {Password}";
        }
    }
}
