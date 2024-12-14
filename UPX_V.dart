import 'package:flutter/material.dart';

void main() {
  runApp(AirTravelApp());
}

class AirTravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viagens Aéreas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DestinationSelectionScreen(),
    );
  }
}

class DestinationSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {
      'name': 'Paris',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/e/e6/Paris_Night.jpg'
    },
    {
      'name': 'Nova York',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Manhattan_from_Hoboken.jpg'
    },
    {
      'name': 'Tokyo',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/1/1e/Tokyo_Tower_and_Skyscrapers.jpg'
    },
    {
      'name': 'Londres',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/c/cd/Big_Ben_London_2007-1.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha seu Destino'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(10),
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DestinationDetailScreen(destination: destination),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            destination['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            destination['name']!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PriceComparisonScreen(),
                  ),
                );
              },
              child: Text('Comparar Preços'),
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationDetailScreen extends StatelessWidget {
  final Map<String, String> destination;

  DestinationDetailScreen({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination['name']!),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            destination['image']!,
            fit: BoxFit.cover,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Explore ${destination['name']}! Aproveite sua estadia com as melhores experiências culturais, gastronômicas e históricas.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentScreen(destination: destination['name']!),
                  ),
                );
              },
              child: Text('Comprar Passagem'),
            ),
          ),
        ],
      ),
    );
  }
}

class PriceComparisonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final priceComparison = [
      {'site': 'Site A', 'price': 'R\$ 3000'},
      {'site': 'Site B', 'price': 'R\$ 2800'},
      {'site': 'Site C', 'price': 'R\$ 3500'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Comparar Preços'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: priceComparison.length,
        itemBuilder: (context, index) {
          final comparison = priceComparison[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(comparison['site']!),
              subtitle: Text('Preço: ${comparison['price']}'),
            ),
          );
        },
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final String destination;

  PaymentScreen({required this.destination});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Destino: $destination', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome completo';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Número do Cartão'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número do cartão';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pagamento realizado com sucesso!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Pagar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}