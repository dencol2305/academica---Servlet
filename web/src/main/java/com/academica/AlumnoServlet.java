package com.academica;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet encargado de interceptar las peticiones HTTP del formulario web.
 * Actúa como el controlador intermedio entre la vista web y el backend JDBC.
 */
@WebServlet("/AlumnoServlet")
public class AlumnoServlet extends HttpServlet {
    
    // Instancia del controlador CRUD que interactúa directamente con MySQL
    private AlumnoCrud gestorCrud = new AlumnoCrud();

    /**
     * Método GET: Se activa automáticamente al cargar la página o solicitar lecturas.
     * Recupera la grilla de alumnos y la despacha al formulario visual.
     */
    @Override
    protected void doGet(HttpServletRequest peticionWeb, HttpServletResponse respuestaWeb) 
            throws ServletException, IOException {
        
        // Obtenemos la lista actualizada de estudiantes de la base de datos
        List<Alumno> listaAlumnos = gestorCrud.consultarAlumnos();
        
        // Empaquetamos la colección dentro del objeto de petición HTTP
        peticionWeb.setAttribute("listaAlumnosAtributo", listaAlumnos);
        
        // Despachamos el flujo hacia la página JSP para renderizar la grilla tabular
        peticionWeb.getRequestDispatcher("formularioAlumno.jsp").forward(peticionWeb, respuestaWeb);
    }

    /**
     * Método POST: Se activa cuando el usuario presiona el botón de envío en el formulario.
     * Captura los parámetros del cliente.
     */
    @Override
    protected void doPost(HttpServletRequest peticionWeb, HttpServletResponse respuestaWeb) 
            throws ServletException, IOException {
        
        // Extracción de variables provenientes de las cajas de texto HTML usando su atributo 'name'
        String codigoAlumno = peticionWeb.getParameter("txtCodigo");
        String nombreAlumno = peticionWeb.getParameter("txtNombre");
        int edadAlumno = Integer.parseInt(peticionWeb.getParameter("txtEdad"));
        Date fechaNacimiento = Date.valueOf(peticionWeb.getParameter("txtFecha"));
        String ciudadAlumno = peticionWeb.getParameter("txtCiudad");
        String generoAlumno = peticionWeb.getParameter("txtGenero");
        String codigoPrograma = peticionWeb.getParameter("txtPrograma");

        // Construcción del objeto de tipo Alumno con los datos capturados
        Alumno objetoAlumno = new Alumno(codigoAlumno, nombreAlumno, edadAlumno, fechaNacimiento, ciudadAlumno, generoAlumno, codigoPrograma);
        
        // Ejecución de la consulta de inserción en la base de datos academica
        boolean resultadoInsercion = gestorCrud.insertarAlumno(objetoAlumno);
        
        // Almacenamos un mensaje de retroalimentación según el éxito de la consulta
        if (resultadoInsercion) {
            peticionWeb.setAttribute("mensajeAlerta", "¡Estudiante registrado de forma exitosa desde la Web!");
        } else {
            peticionWeb.setAttribute("mensajeAlerta", "Error crítico: Compruebe las restricciones de llaves del programa.");
        }
        
        // Forzamos la recarga de la grilla llamando de manera interna al doGet
        doGet(peticionWeb, respuestaWeb);
    }

}    