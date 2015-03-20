part of ondart;

class Contact extends ConceptEntity<Contact> {
  String _telephone;
  String _email;
  String _nom;
  String _prenom;
  
  
  String get telephone => _telephone;
  String get nom => _nom;
  String get prenom => _prenom;
  set telephone(String telephone) {
    var oldValue = _telephone;
    _telephone = telephone;
    notifyReactions(Action.UPDATE, this, "telephone", oldValue);
  }
  
  
  set nom(String nom) {
     var oldValue = _nom;
     _nom = nom;
     notifyReactions(Action.UPDATE, this, "nom", oldValue);
   }
  set prenom(String prenom) {
     var oldValue = _prenom;
     _prenom = prenom;
     notifyReactions(Action.UPDATE, this, "prenom", oldValue);
   }
  
  
  
  String get email => _email;
  set email(String email) {
    if (code == null) {
      code = email;
    }
    if (code == email) {
      _email = email;
    }
  }

  Contact newEntity() => new Contact();

  Map<String, Object> toJson() {
    Map<String, Object> entityMap = super.toJson();
    entityMap['telephone'] = telephone;
    entityMap['email'] = email;
    entityMap['nom'] = nom;
    entityMap['prenom'] = prenom;
    return entityMap;
  }

  fromJson(Map<String, Object> entityMap) {
    super.fromJson(entityMap);
    telephone = entityMap['telephone'];
    email = entityMap['email'];
    nom = entityMap['nom'];
    prenom = entityMap['prenom'];
  }
}

class Contacts extends ConceptEntities<Contact> {
  Contacts newEntities() => new Contacts();
  Contact newEntity() => new Contact();
}