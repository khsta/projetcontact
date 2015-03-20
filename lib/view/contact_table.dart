part of ondart;

class ContactTable {
  Contacts contacts; 
  Reaction react;
  InputElement telephoneInput;
  InputElement emailInput;
  InputElement nomInput;
  InputElement prenomInput;
  ButtonElement addContact;
  TableElement contactTable;
  ButtonElement clearContacts;
  ButtonElement loadContacts;
  ButtonElement saveContacts;
  
  ContactTable() {
    contacts = new ContactModel().contacts;
    react = (Action action, [Contact contact, String propertyName, Object oldValue]) {
      switch (action) {
        case Action.ADD:
          addRowData(contact.telephone, contact.email,contact.prenom,contact.nom);
          emailInput.select();
          return true;
        case Action.CLEAR:
          contactTable.children.clear();
          telephoneInput.value = '';
          nomInput.value = '';
          prenomInput.value = '';
          emailInput.value = '';
          addTableCaption('Contacts');
          addColumnTitles();
          return true;
        case Action.REMOVE: 
          var row = findRow(contact.email);
          row.remove();
          telephoneInput.value = '';
          emailInput.value = '';
          prenomInput.value = '';
          nomInput.value = '';
          return true;
        case Action.UPDATE:
          var row = findRow(contact.email);
          if (propertyName == "telephone"||propertyName == "nom"||propertyName == "prenom") {
            row.children[0].text = contact.telephone;
            row.children[1].text = contact.email;
            row.children[2].text = contact.nom;
            row.children[3].text = contact.prenom;
            return true;
          }
        return false;
      }
    };
    contacts.startReaction(react);
    telephoneInput = document.querySelector('#telephone-input');
    nomInput = document.querySelector('#nom-input');
    prenomInput = document.querySelector('#prenom-input');
    telephoneInput.onChange.listen((e) {
      var value = emailInput.value;
      var c = contacts.find(value);
      if (c != null) {
        c.telephone = telephoneInput.value;
      
      }
    });
    
    nomInput.onChange.listen((e) {
       var value = emailInput.value;
       var c = contacts.find(value);
       if (c != null) {
         c.nom = nomInput.value;
       
       }
     });
    
    prenomInput.onChange.listen((e) {
          var value = emailInput.value;
          var c = contacts.find(value);
          if (c != null) {
            c.prenom = prenomInput.value;
          
          }
        });
    emailInput = document.querySelector('#email-input');
    nomInput=document.querySelector('#nom-input');
    prenomInput=document.querySelector('#prenom-input');
    addContact = document.querySelector('#ajouter-contact');
    addContact.onClick.listen((e) {
      var contact = new Contact();
      contact.telephone = telephoneInput.value;
      contact.email = emailInput.value;
      contact.nom = nomInput.value;
      contact.prenom = prenomInput.value;
      contact.startReaction(react);
      contacts.add(contact);
    });
    contactTable = document.querySelector('#contact-table');
    clearContacts = document.querySelector('#effacer-contacts');
    clearContacts.onClick.listen((e) {
      contacts.clear();
    });
    loadContacts = document.querySelector('#charger-contacts');
    loadContacts.onClick.listen((e) {
      if (contacts.isEmpty) {
        contacts.fromJson(JSON.decode(window.localStorage['contacts']));
        contacts.forEach((c) => c.startReaction(react));
      }
    });
    saveContacts = document.querySelector('#enregistrer-contacts');
    saveContacts.onClick.listen((e) {
      window.localStorage['contacts'] = JSON.encode(contacts.toJson());
    });
    addTableCaption('Contacts');
    addColumnTitles();
  }
  
  addTableCaption(String title) {
    var contactTableCaption = contactTable.createCaption();
    contactTableCaption.text = title;
    contactTable.caption = contactTableCaption;
  }
  
  addColumnTitles() {
    var row = new Element.tr();   
    contactTable.children.add(row);
    addColumnTitle(row, 'Telephone', 24);
    addColumnTitle(row, 'Email', 24);
    addColumnTitle(row, 'Nom', 24);
    addColumnTitle(row, 'Prenom', 70);
    addColumnTitle(row, 'Effacer', 6);
  }
  
  addColumnTitle(row, String title, num width) {
    var columnHeader = new Element.th();
    columnHeader.text = title; 
    columnHeader.style.width = '${width}%';
    row.children.add(columnHeader);
  }
  
  addRowData(String telephone, String email,String prenom, String nom) { 
    var emailRow = new Element.tr(); 
    var telephoneCell = new Element.td(); 
    var emailCell = new Element.td();
    var nomCell = new Element.td();
    var prenomCell = new Element.td();
    var removeCell = new Element.td();
    telephoneCell.style.width = '24%';
    nomCell.style.width = '24%';
    prenomCell.style.width = '24%';
    emailCell.style.width = '70%';
    removeCell.style.width = '6%';
    telephoneCell.text = telephone;
    nomCell.text = nom;
    prenomCell.text = prenom;
    emailCell.text = email;
    removeCell.text = 'X';
    contactTable.children.add(emailRow);
    emailRow.children.add(telephoneCell);
    emailRow.children.add(emailCell);
   
    emailRow.children.add(nomCell);
    emailRow.children.add(prenomCell);
    emailRow.children.add(removeCell);
    emailCell.onClick.listen((e) {
     telephoneInput.value = telephoneCell.text;
      emailInput.value = emailCell.text;
      nomInput.value=nomCell.text;
      prenomInput.value=prenomCell.text;
            
    });
    removeCell.onClick.listen((e) {    
      contacts.remove(contacts.find(emailCell.text));
    });
  }
  
  TableRowElement findRow(String email) {
    var r = 0;
    for (var row in contactTable.children) {
      if (row is TableRowElement && r++ > 0) {
        if (row.children[1].text == email) {
          return row;
        }
      }
    }
    return null;
  }
}



