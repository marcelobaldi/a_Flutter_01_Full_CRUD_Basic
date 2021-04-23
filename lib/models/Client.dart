class Client{
    String  id;
    String name;
    int    age;
    final  String country = "Brazil";

    Client();
    Client.Create(this.name, this.age);
    Client.Edit(this.id, this.name, this.age);

    String convertToString() {
        if(this.id == null){
            return 'Client{name: $name, age: $age, country: $country}';
        }
        return 'Client{id: $id, name: $name, age: $age, country: $country}';
    }

    Map convertToMap(){
        if(this.id == null){
            Map<String, dynamic> mapClient = {
                'name': this.name, 'age': this.age, 'country' : this.country
            };
            return mapClient;
        }

        Map<String, dynamic> mapClient = {
           'id': this.id, 'name': this.name, 'age': this.age, 'country': this.country
        };
        return mapClient;
    }

    Client.mapToClass(Map map){
        this.id = map["id"];
        this.name = map["nome"];
        this.age = map["idade"];
    }
}