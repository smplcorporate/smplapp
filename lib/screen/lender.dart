import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SelectLenderPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SelectLenderPage extends StatefulWidget {
  const SelectLenderPage({super.key});

  @override
  State<SelectLenderPage> createState() => _SelectLenderPageState();
}

class _SelectLenderPageState extends State<SelectLenderPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> lenders = [
    {'name': 'Muthoot Finance', 'asset': 'assets/mutooth.png'},
    {'name': 'Bajaj Finance', 'asset': 'assets/baj.png'},
    {'name': 'HDFC Finance', 'asset': 'assets/hdfc1.png'},
    {'name': 'DMI Finance', 'asset': 'assets/dmi.png'},
    {'name': 'TVS Credit', 'asset': 'assets/tvs.png'},
    {'name': 'IDFC Bank', 'asset': 'assets/dmi.png'},
    {'name': 'Axis Bank', 'asset': 'assets/dmi.png'},
  ];

  List<Map<String, dynamic>> filteredLenders = [];
  String selectedFilter = 'All';

  final List<String> filterOptions = [
    'All',
    'Muthoot',
    'Bajaj',
    'HDFC',
    'DMI',
    'TVS',
    'IDFC',
    'Axis',
  ];

  @override
  void initState() {
    super.initState();
    filteredLenders = lenders;
    _searchController.addListener(_applyFilters);
  }

  void _applyFilters() {
    setState(() {
      filteredLenders = lenders.where((lender) {
        final searchText = _searchController.text.toLowerCase();
        final matchesSearch = lender['name'].toLowerCase().contains(searchText);
        final matchesFilter = selectedFilter == 'All'
            ? true
            : lender['name']
                .toLowerCase()
                .startsWith(selectedFilter.toLowerCase());
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: mediaHeight,
        width: mediaWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.yellow.shade100,
              Colors.green.shade100,
              Colors.lightBlue.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Back Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Select Your Lender',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Search Bar and Filter Dropdown in Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    // Search Bar
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search by Lender',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Filter Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedFilter,
                          items: filterOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedFilter = newValue!;
                              _applyFilters();
                            });
                          },
                          icon: const Icon(Icons.filter_list),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Lenders List
              Expanded(
                child: Container(
                  width: mediaWidth,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'All Lender',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredLenders.length,
                          itemBuilder: (context, index) {
                            final lender = filteredLenders[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                              leading: Image.asset(
                                lender['asset'],
                                width: 50,
                                height: 50,
                              ),
                              title: Text(lender['name']),
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
