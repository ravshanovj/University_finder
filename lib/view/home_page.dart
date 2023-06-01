import 'package:flutter/material.dart';
import 'package:university_find/data/model/university_model.dart';
import 'package:university_find/data/service/get_info_service.dart';
import 'package:university_find/view/add_country.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  final String country;
  const HomePage({super.key, this.country = 'Uzbekistan'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetInformationRepository api = GetInformationRepository();
  List<UniversityModel> listOfUniversity = [];
  bool isLoading = true;

  Future<void> getInformation() async {
    isLoading = true;
    setState(() {});
    dynamic data = await api.getInformation(name: widget.country);

    data.forEach((element) {
      listOfUniversity.add(UniversityModel.fromJson(element));
    });
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          /* // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: ((context) => const AddingCountry()),
          //   ),
          // ); */
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddingCountry(),
            ),
          );
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: const Icon(Icons.search_outlined),
        ),
      ),
      appBar: AppBar(
        title: Text('Universities of ${widget.country}'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: listOfUniversity.length,
              itemBuilder: ((context, index) => Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          listOfUniversity[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          onPressed: () async {
                            final launchUri = Uri.parse(
                              listOfUniversity[index].webPages?.first ?? "",
                            );
                            await url_launcher.launchUrl(
                              launchUri,
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Text(
                            listOfUniversity[index].webPages?.first ?? "",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}
