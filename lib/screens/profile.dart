import 'package:flutter/material.dart';
// Removed unused imports

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            
          ),
          ),
      ),
      body:
       SingleChildScrollView(
        child: Center(
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text(
                'example@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Orders',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey[300],
                      )
                    ],
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Expenses',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey[300],
                      )
                    ],
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Returns',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey[300],
                      )
                    ],
                  ),
              ),

              const SizedBox(height: 32),

              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Achor Ugochukwu Nelson',
                        prefixIcon: const Icon(Icons.person),
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'example@gmail.com',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          hintText: '09034211239',
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Delivery Address',
          hintText: 'No. 1 Agi Close, Port Harcourt, Rivers State, Nigeria',
          prefixIcon: Icon(Icons.location_on_outlined),
          border: OutlineInputBorder(),
        ),
      ),

      const SizedBox(height: 32),
      const Divider(),
      const Text(
        'Preferences',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      ListTile(
        title: const Text('Turn on notifications'),
        subtitle: const Text('Be informed about all decisions'),
        leading: const Icon(Icons.location_on_outlined),
        trailing: Switch(
          value: true,
          onChanged: (value) {
            // Handle the switch toggle here
          },
        ),
      ),

      ListTile(
        title: const Text('Location Services'),
        subtitle: const Text('Allow Access to location for better delivery'),
        leading: const Icon(Icons.notifications),
        trailing: Switch(
          value: true,
          onChanged: (value) {
            // Handle the switch toggle here
          },
        ),
      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}