import 'package:flutter/material.dart';
import 'package:proyecto_erd/Controllers/question_controller.dart';
import 'package:proyecto_erd/models/question.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionPage createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {
  final QuestionController controller = QuestionController();

  @override
  Widget build(BuildContext context) {
    List<Question> questions = controller.getQuestions();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
        backgroundColor: const Color(0xFFDCE9FD),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: const Color(0xFFDCE9FD),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Hola! ¿En qué te podemos ayudar?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            // Usar Expanded para que ListView ocupe el espacio disponible
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    elevation: 0, // Sin sombra
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Borde redondeado suave
                      side: const BorderSide(color: Colors.transparent), // Sin borde visible
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent, // Elimina la línea divisoria
                      ),
                      child: ExpansionTile(
                        title: Text(
                          question.question,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        tilePadding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding para ajustar márgenes
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.transparent, // Color de fondo igual que el contenedor
                            child: Text(question.answer),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
