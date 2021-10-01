using System;
using System.Collections.Generic;

namespace Entidades
{
    public class Cliente : IEquatable<Cliente>
    {
        public long? Id { get; set; }
        public string Nombre { get; set; }
        public string Apellidos { get; set; }
        public DateTime? FechaNacimiento { get; set; }

        public Cliente(long? id, string nombre, string apellidos, DateTime? fechaNacimiento)
        {
            Id = id;
            Nombre = nombre ?? throw new ArgumentNullException(nameof(nombre));
            Apellidos = apellidos ?? throw new ArgumentNullException(nameof(apellidos));
            FechaNacimiento = fechaNacimiento;
        }

        public override bool Equals(object obj)
        {
            return Equals(obj as Cliente);
        }

        public bool Equals(Cliente other)
        {
            return other != null &&
                   Id == other.Id &&
                   Nombre == other.Nombre &&
                   Apellidos == other.Apellidos &&
                   FechaNacimiento == other.FechaNacimiento;
        }

        public override int GetHashCode()
        {
            int hashCode = 1438354543;
            hashCode = hashCode * -1521134295 + Id.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Nombre);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Apellidos);
            hashCode = hashCode * -1521134295 + FechaNacimiento.GetHashCode();
            return hashCode;
        }

        public static bool operator ==(Cliente left, Cliente right)
        {
            return EqualityComparer<Cliente>.Default.Equals(left, right);
        }

        public static bool operator !=(Cliente left, Cliente right)
        {
            return !(left == right);
        }

        public override string ToString()
        {
            return $"{Id}, {Nombre}, {Apellidos}, {FechaNacimiento}";
        }
    }
}