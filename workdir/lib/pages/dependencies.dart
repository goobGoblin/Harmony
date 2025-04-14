export 'package:flutter/material.dart';
export 'package:firebase_core/firebase_core.dart';
export '../firebase/firebase_utils.dart';
export 'utils/list_of_items.dart';
export 'utils/bottomPlayer.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'dart:developer' hide Flow;

import 'globals.dart';
import '../audio/audioHandler.dart';
import '../apis/spotify_api.dart';
import '../apis/LastFM_parser.dart';
import '../apis/soundcloud_api.dart';
//import 'package:bottom_navbar_player/bottom_navbar_player.dart';

var globals = Globals();
var audioHandler = MyAudioHandler();
var spotifyConnection = SpotifyAPI();
LastFMParser lastFMConnection = LastFMParser();
var soundcloudConnection = SoundCloudAPI();
//final thisBottomPlayer = BottomNavBarPlayer();
