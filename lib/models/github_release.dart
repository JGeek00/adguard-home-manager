class GitHubRelease {
  final String url;
  final String assetsUrl;
  final String uploadUrl;
  final String htmlUrl;
  final int id;
  final Author author;
  final String nodeId;
  final String tagName;
  final String targetCommitish;
  final String name;
  final bool draft;
  final bool prerelease;
  final DateTime createdAt;
  final DateTime publishedAt;
  final List<Asset> assets;
  final String tarballUrl;
  final String zipballUrl;
  final String body;

  GitHubRelease({
    required this.url,
    required this.assetsUrl,
    required this.uploadUrl,
    required this.htmlUrl,
    required this.id,
    required this.author,
    required this.nodeId,
    required this.tagName,
    required this.targetCommitish,
    required this.name,
    required this.draft,
    required this.prerelease,
    required this.createdAt,
    required this.publishedAt,
    required this.assets,
    required this.tarballUrl,
    required this.zipballUrl,
    required this.body,
  });


  factory GitHubRelease.fromJson(Map<String, dynamic> json) => GitHubRelease(
    url: json["url"],
    assetsUrl: json["assets_url"],
    uploadUrl: json["upload_url"],
    htmlUrl: json["html_url"],
    id: json["id"],
    author: Author.fromJson(json["author"]),
    nodeId: json["node_id"],
    tagName: json["tag_name"],
    targetCommitish: json["target_commitish"],
    name: json["name"],
    draft: json["draft"],
    prerelease: json["prerelease"],
    createdAt: DateTime.parse(json["created_at"]),
    publishedAt: DateTime.parse(json["published_at"]),
    assets: List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
    tarballUrl: json["tarball_url"],
    zipballUrl: json["zipball_url"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "assets_url": assetsUrl,
    "upload_url": uploadUrl,
    "html_url": htmlUrl,
    "id": id,
    "author": author.toJson(),
    "node_id": nodeId,
    "tag_name": tagName,
    "target_commitish": targetCommitish,
    "name": name,
    "draft": draft,
    "prerelease": prerelease,
    "created_at": createdAt.toIso8601String(),
    "published_at": publishedAt.toIso8601String(),
    "assets": List<dynamic>.from(assets.map((x) => x.toJson())),
    "tarball_url": tarballUrl,
    "zipball_url": zipballUrl,
    "body": body,
  };
}

class Asset {
  final String url;
  final int id;
  final String nodeId;
  final String name;
  final dynamic label;
  final Author uploader;
  final String contentType;
  final String state;
  final int size;
  final int downloadCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String browserDownloadUrl;

  Asset({
    required this.url,
    required this.id,
    required this.nodeId,
    required this.name,
    required this.label,
    required this.uploader,
    required this.contentType,
    required this.state,
    required this.size,
    required this.downloadCount,
    required this.createdAt,
    required this.updatedAt,
    required this.browserDownloadUrl,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    url: json["url"],
    id: json["id"],
    nodeId: json["node_id"],
    name: json["name"],
    label: json["label"],
    uploader: Author.fromJson(json["uploader"]),
    contentType: json["content_type"],
    state: json["state"],
    size: json["size"],
    downloadCount: json["download_count"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    browserDownloadUrl: json["browser_download_url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "id": id,
    "node_id": nodeId,
    "name": name,
    "label": label,
    "uploader": uploader.toJson(),
    "content_type": contentType,
    "state": state,
    "size": size,
    "download_count": downloadCount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "browser_download_url": browserDownloadUrl,
  };
}

class Author {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final bool siteAdmin;

  Author({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    login: json["login"],
    id: json["id"],
    nodeId: json["node_id"],
    avatarUrl: json["avatar_url"],
    gravatarId: json["gravatar_id"],
    url: json["url"],
    htmlUrl: json["html_url"],
    followersUrl: json["followers_url"],
    followingUrl: json["following_url"],
    gistsUrl: json["gists_url"],
    starredUrl: json["starred_url"],
    subscriptionsUrl: json["subscriptions_url"],
    organizationsUrl: json["organizations_url"],
    reposUrl: json["repos_url"],
    eventsUrl: json["events_url"],
    receivedEventsUrl: json["received_events_url"],
    type: json["type"],
    siteAdmin: json["site_admin"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
    "node_id": nodeId,
    "avatar_url": avatarUrl,
    "gravatar_id": gravatarId,
    "url": url,
    "html_url": htmlUrl,
    "followers_url": followersUrl,
    "following_url": followingUrl,
    "gists_url": gistsUrl,
    "starred_url": starredUrl,
    "subscriptions_url": subscriptionsUrl,
    "organizations_url": organizationsUrl,
    "repos_url": reposUrl,
    "events_url": eventsUrl,
    "received_events_url": receivedEventsUrl,
    "type": type,
    "site_admin": siteAdmin,
  };
}
