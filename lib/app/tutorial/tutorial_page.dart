import 'package:flutter/material.dart';

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

  // Base del tutorial. Más adelante puedes agregar, quitar o modificar páginas.
  final List<Map<String, String>> _pages = [
    {
      'title': 'Tutorial de Prometix',
      'image': 'lib/app/assets/botones.jpg',
      'description':
          'Acontinuación, te mostraremos cómo usar la aplicación y sus funciones principales.',
    },
    {
      'title': 'Nombre de la materia',
      'image': 'lib/app/assets/name.jpg',
      'description':
          'Aquí puedes ingresar el nombre de la materia o asignatura.',
    },
    {
      'title': 'Notas',
      'image': 'lib/app/assets/grade.jpg',
      'description':
          'La columna Izquierda es donde se ingresan las notas.',
    },
    {
      'title': 'Porcentajes',
      'image': 'lib/app/assets/porcentaje.jpg',
      'description':
          'La columna Derecha es donde se ingresan los porcentajes.',
    },
    {
      'title': 'Agregar más filas',
      'image': 'lib/app/assets/addGrade.jpg',
      'description':
          'El boton "+" permite agregar más filas para ingresar más notas y porcentajes.',
    },
    {
      'title': 'Botón de Color',
      'image': 'lib/app/assets/colorButon.jpg',
      'description':
          'El botón de color permite cambiar el color relacionado con la materia, para una mejor organización visual.',
    },
    {
      'title': 'Colores',
      'image': 'lib/app/assets/colores.jpg',
      'description':
          'Puedes elegir entre 9 colores para personalizar la apariencia de la materia.',
    },
    {
      'title': 'Botón de Reset',
      'image': 'lib/app/assets/reset.jpg',
      'description':
          'Este botón permite reiniciar la calculadora, borrando todos los datos ingresados y restableciendo la aplicación a su estado inicial.',
    },
    {
      'title': 'Subnotas',
      'image': 'lib/app/assets/subnotasboton.jpg',
      'description':
          'Este botón de fecha hacia abajo permite agregar subnotas a una nota principal, lo que es útil para desglosar una nota en componentes más pequeños.',
    },
    {
      'title': 'Ejemplo',
      'image': 'lib/app/assets/subjet.jpg',
      'description':
          'Aquí puedes ver un ejemplo de cómo se vería una materia con nombre, color , notas y subnotas agregadas.',
    },
    {
      'title': 'Ejemplo de subnotas',
      'image': 'lib/app/assets/subnotas.jpg',
      'description':
          'Las notas con flecha hacia arriba son subnotas que componen la nota principal hacia la que apuntan. La nota principal no se puede editar, ya que depende de las subnotas que la componen.',
    },
    {
      'title': 'Botones de acción',
      'image': 'lib/app/assets/botones 2.jpg',
      'description':
          'El boton rojo permite elminar la ultima fila de nota y porcentaje, mientras que el boton azul permite calcular el promedio de todas las notas ingresadas y el boton verde permite guardar la materia con su nombre, color y todas sus notas y subnotas para poder consultarla más tarde.',
    },
    {
      'title': 'Materias guardadas',
      'image': 'lib/app/assets/saved.jpg',
      'description':
          'Aquí puedes ver todas las materias que has guardado, junto con sus notas y subnotas.',
    },
    {
      'title': 'Eliminar materia guardada',
      'image': 'lib/app/assets/delete.jpg',
      'description':
          'Para eliminar una materia guardada, simplemente desliza hacia la izquierda sobre la materia que deseas eliminar.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
                          page['title']!,
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
                          page['description']!,
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

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _currentPage == 0 ? null : _previousPage,
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _currentPage == _pages.length - 1 ? null : _nextPage,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
