class Repo {
  final String? repo_name;
  final DateTime? created_date;
  final String? branch;
  final String? language;
  final DateTime? last_pushed;
  final String? url;
  final int? stars;
  final String? description;

  Repo({
    this.repo_name,
    String? created_date,
    this.branch,
    this.language,
    String? last_pushed,
    this.url,
    this.stars,
    this.description,
  })  : created_date = created_date != null ? DateTime.parse(created_date) : null,
        last_pushed = last_pushed != null ? DateTime.parse(last_pushed) : null;
}
