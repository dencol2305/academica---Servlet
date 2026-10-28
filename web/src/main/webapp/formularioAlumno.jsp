<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.academica.Alumno" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Control Académico - Servlets</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 40px; 
            background-color: #f4f7f6; 
        }
        .tarjeta-modulo { 
            max-width: 850px; 
            margin: auto; 
            background: #ffffff; 
            padding: 25px; 
            border-radius: 8px; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        h2 { color: #333333; text-align: center; margin-bottom: 20px; }
        .formulario-grupo { 
            margin-bottom: 14px; 
            display: flex; 
            align-items: center; 
        }
        label { 
            width: 240px; 
            font-weight: 600; 
            color: #495057; 
        }
        input { 
            flex: 1; 
            padding: 8px; 
            border: 1px solid #ced4da; 
            border-radius: 5px; 
            font-size: 14px; 
        }
        .boton-enviar { 
            padding: 10px 20px; 
            background-color: #0d6efd; 
            color: white; 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; 
            font-size: 15px;
            font-weight: bold;
            width: 100%;
            margin-top: 10px;
        }
        .boton-enviar:hover { background-color: #0b5ed7; }
        
        /* Estilos de la Grilla/Rejilla SQL */
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 30px; 
            background: #ffffff; 
        }
        th, td { 
            border: 1px solid #dee2e6; 
            padding: 10px; 
            text-align: left; 
        }
        th { background-color: #212529; color: white; }
        tr:nth-child(even) { background-color: #f8f9fa; }
        .alerta-exito {
            padding: 12px;
            background-color: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="tarjeta-modulo">
    <h2>REGISTRO DE CONTROL ACADÉMICO</h2>
    
    <%-- Alerta dinámica de retroalimentación --%>
    <% if (request.getAttribute("mensajeAlerta") != null) { %>
        <div class="alerta-exito">
            <%= request.getAttribute("mensajeAlerta") %>
        </div>
    <% } %>
    
    <!-- El formulario envía los parámetros al AlumnoServlet -->
    <form action="AlumnoServlet" method="POST">
        <div class="formulario-grupo">
            <label>Código de Matrícula (codal):</label>
            <input type="text" name="txtCodigo" required>
        </div>
        <div class="formulario-grupo">
            <label>Nombre del Alumno (nomal):</label>
            <input type="text" name="txtNombre" required>
        </div>
        <div class="formulario-grupo">
            <label>Edad en Años (edadal):</label>
            <input type="number" name="txtEdad" required>
        </div>
        <div class="formulario-grupo">
            <label>Fecha Nacimiento (fechal):</label>
            <input type="date" name="txtFecha" required>
        </div>
        <div class="formulario-grupo">
            <label>Ciudad Residencial (ciudadal):</label>
            <input type="text" name="txtCiudad" required>
        </div>
        <div class="formulario-grupo">
            <label>Género Estudiantil (genal - M/F):</label>
            <input type="text" name="txtGenero" maxlength="1" placeholder="M o F" required>
        </div>
        <div class="formulario-grupo">
            <label>Código de Programa (codprog):</label>
            <input type="text" name="txtPrograma" required>
        </div>
        
        <button type="submit" class="boton-enviar">Guardar Registro en la Base de Datos</button>
    </form>

    <!-- GRILLA DINÁMICA DE REGISTROS (REJILLA SQL) -->
    <h3>--- GRILLA DINÁMICA DE REGISTROS (REJILLA SQL) ---</h3>
    <table>
        <thead>
            <tr>
                <th>Código</th>
                <th>Nombre</th>
                <th>Edad</th>
                <th>Fecha Nac.</th>
                <th>Ciudad</th>
                <th>Género</th>
                <th>Programa</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Recuperamos la colección usando el atributo exacto definido en el AlumnoServlet
                List<Alumno> lista = (List<Alumno>) request.getAttribute("listaAlumnosAtributo");
                if (lista != null && !lista.isEmpty()) {
                    for (Alumno al : lista) {
            %>
            <tr>
                <td><%= al.getCodigoAlumno() %></td>
                <td><%= al.getNombreAlumno() %></td>
                <td><%= al.getEdadAlumno() %></td>
                <td><%= al.getFechaNacimiento() %></td>
                <td><%= al.getCiudadAlumno() %></td>
                <td><%= al.getGeneroAlumno() %></td>
                <td><%= al.getCodigoPrograma() %></td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="7" style="text-align: center; color: #777;">
                    No hay registros cargados. Presione cargar o ingrese a la URL del Servlet.
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>