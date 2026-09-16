import 'package:flutter/material.dart';
import 'package:average_calculator/app/options/option.dart';

class TutorialPage extends StatefulWidget {
  final Color background;
  final Color icon;

  const TutorialPage({
    super.key,
    required this.background,
    required this.icon,
  });

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String get _idioma => AppPreferences.idioma;

  final List<Map<String, String>> _pages = [
    {'title_es':'Tutorial de Prometix','title_en':'Prometix Tutorial','image':'lib/app/assets/botones.jpg','description_es':'A continuación, te mostraremos cómo usar la aplicación y sus funciones principales.','description_en':'Next, we will show you how to use the app and its main features.'},
    {'title_es':'Nombre de la materia','title_en':'Subject name','image':'lib/app/assets/name.jpg','description_es':'Aquí puedes ingresar el nombre de la materia o asignatura.','description_en':'Here you can enter the name of the subject or course.'},
    {'title_es':'Notas','title_en':'Grades','image':'lib/app/assets/grade.jpg','description_es':'La columna izquierda es donde se ingresan las notas.','description_en':'The left column is where you enter the grades.'},
    {'title_es':'Porcentajes','title_en':'Percentages','image':'lib/app/assets/porcentaje.jpg','description_es':'La columna derecha es donde se ingresan los porcentajes.','description_en':'The right column is where you enter the percentages.'},
    {'title_es':'Agregar más filas','title_en':'Add more rows','image':'lib/app/assets/addGrade.jpg','description_es':'El botón "+" permite agregar más filas para ingresar más notas y porcentajes.','description_en':'The "+" button lets you add more rows to enter additional grades and percentages.'},
    {'title_es':'Botón de color','title_en':'Color button','image':'lib/app/assets/colorButon.jpg','description_es':'El botón de color permite cambiar el color relacionado con la materia para una mejor organización visual.','description_en':'The color button lets you change the color associated with the subject for better visual organization.'},
    {'title_es':'Colores','title_en':'Colors','image':'lib/app/assets/colores.jpg','description_es':'Puedes elegir entre 9 colores para personalizar la apariencia de la materia.','description_en':'You can choose from 9 colors to customize the appearance of the subject.'},
    {'title_es':'Botón de restablecer','title_en':'Reset button','image':'lib/app/assets/reset.jpg','description_es':'Este botón permite reiniciar la calculadora, borrando todos los datos ingresados y restableciendo la aplicación a su estado inicial.','description_en':'This button resets the calculator, clearing all entered data and returning it to its initial state.'},
    {'title_es':'Subnotas','title_en':'Subgrades','image':'lib/app/assets/subnotasboton.jpg','description_es':'Este botón de flecha hacia abajo permite agregar subnotas a una nota principal, lo que es útil para desglosar una nota en componentes más pequeños.','description_en':'This down-arrow button lets you add subgrades to a main grade, which is useful for breaking a grade into smaller components.'},
    {'title_es':'Ejemplo','title_en':'Example','image':'lib/app/assets/subjet.jpg','description_es':'Aquí puedes ver un ejemplo de cómo se vería una materia con nombre, color, notas y subnotas agregadas.','description_en':'Here you can see an example of a subject with a name, color, grades, and subgrades.'},
    {'title_es':'Ejemplo de subnotas','title_en':'Subgrade example','image':'lib/app/assets/subnotas.jpg','description_es':'Las notas con flecha hacia arriba son subnotas que componen la nota principal hacia la que apuntan. La nota principal no se puede editar, ya que depende de las subnotas que la componen.','description_en':'Grades with an upward arrow are subgrades that make up the main grade they point to. The main grade cannot be edited because it depends on its subgrades.'},
    {'title_es':'Botones de acción','title_en':'Action buttons','image':'lib/app/assets/botones 2.jpg','description_es':'El botón rojo permite eliminar la última fila de nota y porcentaje, el botón azul permite calcular el promedio de todas las notas ingresadas y el botón verde permite guardar la materia con su nombre, color, notas y subnotas para consultarla más tarde.','description_en':'The red button removes the last grade and percentage row, the blue button calculates the average of all entered grades, and the green button saves the subject with its name, color, grades, and subgrades so you can view it later.'},
    {'title_es':'Materias guardadas','title_en':'Saved subjects','image':'lib/app/assets/saved.jpg','description_es':'Aquí puedes ver todas las materias que has guardado, junto con sus notas y subnotas.','description_en':'Here you can see all your saved subjects along with their grades and subgrades.'},
    {'title_es':'Eliminar materia guardada','title_en':'Delete a saved subject','image':'lib/app/assets/delete.jpg','description_es':'Para eliminar una materia guardada, simplemente desliza hacia la izquierda sobre la materia que deseas eliminar.','description_en':'To delete a saved subject, simply swipe left on the subject you want to remove.'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.background,
      appBar: AppBar(
        backgroundColor: widget.background,
        elevation: 0,
        iconTheme: IconThemeData(color: widget.icon),
        // No se agrega ningún otro botón al AppBar.
        // La flecha vuelve automáticamente a la página anterior (fp_page).
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          _idioma == 'Español' ? page['title_es']! : page['title_en']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.icon,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Espacio reservado para la imagen de cada diapositiva.
                        Expanded(
                          child: Center(
                            child: page['image']!.isEmpty
                                ? Container(
                                    width: double.infinity,
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: widget.icon.withValues(alpha: 0.25),
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: widget.icon.withValues(alpha: 0.45),
                                        size: 70,
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    page['image']!,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _idioma == 'Español' ? page['description_es']! : page['description_en']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.icon,
                            fontSize: 17,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Indicadores de página.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  width: index == _currentPage ? 18 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index == _currentPage
                        ? widget.icon
                        : widget.icon.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
