// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ComplainModel {
  final String title;
  final String description;
  final String location;
  final String contactNumber;
  final List<String> imageLinks;
  final String currentLocation;
  final String uid;
  final DateTime complainedAt;
  final List<String> upvotes;
  final List<String> downvotes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  ComplainModel({
    required this.title,
    required this.description,
    required this.location,
    required this.contactNumber,
    required this.imageLinks,
    required this.currentLocation,
    required this.uid,
    required this.complainedAt,
    required this.upvotes,
    required this.downvotes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
  });

  ComplainModel copyWith({
    String? title,
    String? description,
    String? location,
    String? contactNumber,
    List<String>? imageLinks,
    String? currentLocation,
    String? uid,
    DateTime? complainedAt,
    List<String>? upvotes,
    List<String>? downvotes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
  }) {
    return ComplainModel(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      contactNumber: contactNumber ?? this.contactNumber,
      imageLinks: imageLinks ?? this.imageLinks,
      currentLocation: currentLocation ?? this.currentLocation,
      uid: uid ?? this.uid,
      complainedAt: complainedAt ?? this.complainedAt,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'location': location,
      'contactNumber': contactNumber,
      'imageLinks': imageLinks,
      'currentLocation': currentLocation,
      'uid': uid,
      'complainedAt':
          complainedAt.millisecondsSinceEpoch ~/ 1000, // Convert to seconds
      'upvotes': upvotes,
      'downvotes': downvotes,
      'commentIds': commentIds,
      'reshareCount': reshareCount,
    };
  }

  factory ComplainModel.fromMap(Map<String, dynamic> map) {
    return ComplainModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      currentLocation: map['currentLocation'] ?? '',
      uid: map['uid'] ?? '',
      complainedAt: DateTime.fromMillisecondsSinceEpoch(map['complainedAt'] *
          1000), // Convert from seconds back to milliseconds
      upvotes: List<String>.from(map['upvotes']),
      downvotes: List<String>.from(map['downvotes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['\$id'] ?? '',
      reshareCount: map['reshareCount']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'ComplainModel(title: $title, description: $description, location: $location, contactNumber: $contactNumber, imageLinks: $imageLinks, currentLocation: $currentLocation, uid: $uid, complainedAt: $complainedAt, upvotes: $upvotes, downvotes: $downvotes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount)';
  }

  @override
  bool operator ==(covariant ComplainModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.location == location &&
        other.contactNumber == contactNumber &&
        listEquals(other.imageLinks, imageLinks) &&
        other.currentLocation == currentLocation &&
        other.uid == uid &&
        other.complainedAt == complainedAt &&
        listEquals(other.upvotes, upvotes) &&
        listEquals(other.downvotes, downvotes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.reshareCount == reshareCount;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        location.hashCode ^
        contactNumber.hashCode ^
        imageLinks.hashCode ^
        currentLocation.hashCode ^
        uid.hashCode ^
        complainedAt.hashCode ^
        upvotes.hashCode ^
        downvotes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        reshareCount.hashCode;
  }
}
