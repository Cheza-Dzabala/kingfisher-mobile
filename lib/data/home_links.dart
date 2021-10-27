List<Link> homeLinks() => [
      Link(
        label: 'Claims',
        icon: 'assets/icons/icon-book.svg',
        route: '/',
      ),
      Link(
        label: 'Policies',
        icon: 'assets/icons/icon-policies.svg',
        route: '/',
      ),
      Link(
        label: 'Calculator',
        icon: 'assets/icons/icon-calculator.svg',
        route: '/',
      ),
      Link(
        label: 'Quotations',
        icon: 'assets/icons/icon-document.svg',
        route: '/',
      ),
      Link(
        label: 'Contact Us',
        icon: 'assets/icons/icon-contact.svg',
        route: '/',
      ),
    ];

class Link {
  String label;
  String icon;
  String route;

  Link({this.label, this.icon, this.route});
}
