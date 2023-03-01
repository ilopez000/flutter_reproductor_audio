import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class Song {
  final String title;
  final String artist;
  final String audioUrl;

  Song({
    required this.title,
    required this.artist,
    required this.audioUrl,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer _player;
  late List<Song> _songs;
  int _currentSongIndex = 0;

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer();
    _songs = [
      Song(
        title: 'Song 1',
        artist: 'Artist 1',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      ),
      Song(
        title: 'Song 2',
        artist: 'Artist 2',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      ),
      Song(
        title: 'Song 3',
        artist: 'Artist 3',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      ),
    ];
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _playSong(int index) async {
    _currentSongIndex = index;
    await _player.stop();
    await _player.play(_songs[_currentSongIndex].audioUrl);
    setState(() {});
  }

  void _playNextSong() {
    _currentSongIndex = (_currentSongIndex + 1) % _songs.length;
    _playSong(_currentSongIndex);
  }

  void _playPreviousSong() {
    _currentSongIndex = (_currentSongIndex - 1) % _songs.length;
    if (_currentSongIndex < 0) {
      _currentSongIndex = _songs.length - 1;
    }
    _playSong(_currentSongIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Music Player'),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _songs[_currentSongIndex].title,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                _songs[_currentSongIndex].artist,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                child: Text('Play'),
                onPressed: () async {
                  await _player.play(_songs[_currentSongIndex].audioUrl);
                },
              ),
              ElevatedButton(
                child: Text('Pause'),
                onPressed: () async {
                  await _player.pause();
                },
              ),
              ElevatedButton(
                child: Text('Stop'),
                onPressed: () async {
                  await _player.stop();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: _playPreviousSong,
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: _playNextSong,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}