import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'countries_model.dart';
import 'countries_detail.dart';
import 'covid_data_source.dart';

class DetailCountries extends StatefulWidget {
  const DetailCountries({Key? key}) : super(key: key);
  @override
  _DetailCountriesState createState() => _DetailCountriesState();
}
class _DetailCountriesState extends State<DetailCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
      ),
      body: _buildDetailCountriesBody(),
    );
  }
  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(), //future harus menerima data
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
            CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }
  Widget _buildErrorSection() {
    return Text("Error");
  }
  Widget _buildEmptySection() {
    return Text("Empty");
  }
  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _buildSuccessSection(CountriesModel data) {
    return ListView.builder(
      itemCount: data.countries?.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailCountry();
            }));
          },
          child: Card(
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(
                child: Text("${data.countries?[index].name}"),
              ),
            ),
          ),
        );

      },
    );
  }
  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}

