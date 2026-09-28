package com.pcdoctor.backend.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table(name = "sintomas")
public class Sintoma {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sintoma")
    @JsonProperty("idSintoma")
    private Long idSintoma;

    @Column(nullable = false, length = 150)
    @JsonProperty("nombre")
    private String nombre;

    @Column(columnDefinition = "TEXT")
    @JsonProperty("descripcion")
    private String descripcion;

    @Column(nullable = false, length = 100)
    @JsonProperty("categoria")
    private String categoria;

    public Sintoma() {}

    public Long getIdSintoma() { return idSintoma; }
    public void setIdSintoma(Long idSintoma) { this.idSintoma = idSintoma; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
}