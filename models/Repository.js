var Repository = function(user, name, lang, star) {
    this.user = user;
    this.name = name;
    this.lang = lang;
    this.star = star;

    this.getLink = () => {
        return this.user + "/" + this.name
    }
}

module.exports = Repository;
