import 'package:flutter/material.dart';
import 'dependencies.dart';

class Home2Route extends StatelessWidget {
  const Home2Route({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF101010)),
        child: Stack(
          children: [
            Positioned(
              left: -2,
              top: 47,
              child: Container(
                width: 392,
                height: 242,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(width: 390, height: 242),
                    ),
                    Positioned(
                      left: 298,
                      top: 150,
                      child: Container(
                        width: 92,
                        height: 92,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 2,
                              top: 0,
                              child: Opacity(
                                opacity: 0.25,
                                child: Container(
                                  width: 89,
                                  height: 89,
                                  decoration: const BoxDecoration(color: Color(0xFF444444)),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 6,
                              top: 46,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: NetworkImage("https://placehold.co/40x40"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 11,
                              top: 10,
                              child: SizedBox(
                                width: 72,
                                height: 24,
                                child: Text(
                                  'account',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Neue Regrade',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.42,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 242,
                      top: 0,
                      child: Container(
                        width: 148,
                        height: 149,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 1,
                              top: 1,
                              child: Opacity(
                                opacity: 0.25,
                                child: Container(
                                  width: 146,
                                  height: 146,
                                  decoration: ShapeDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment(0.50, -0.00),
                                      end: Alignment(0.50, 1.00),
                                      colors: [Color(0xFF101010), Color(0xFF444444)],
                                    ),
                                    shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              top: 17,
                              child: Container(
                                width: 130,
                                height: 130,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 93,
                                      child: Opacity(
                                        opacity: 0.90,
                                        child: Container(
                                          width: 130,
                                          height: 28,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF201E26),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 97,
                                      child: SizedBox(
                                        width: 100,
                                        height: 20,
                                        child: Text(
                                          'track library',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Neue Regrade',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.42,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 62,
                                      child: Opacity(
                                        opacity: 0.90,
                                        child: Container(
                                          width: 130,
                                          height: 28,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF201E26),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 66,
                                      child: SizedBox(
                                        width: 100,
                                        height: 20,
                                        child: Text(
                                          'liked playlists',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Neue Regrade',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.42,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 31,
                                      child: Opacity(
                                        opacity: 0.90,
                                        child: Container(
                                          width: 130,
                                          height: 28,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF201E26),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 35,
                                      child: SizedBox(
                                        width: 100,
                                        height: 20,
                                        child: Text(
                                          'your playlists',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Neue Regrade',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.42,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Opacity(
                                        opacity: 0.90,
                                        child: Container(
                                          width: 130,
                                          height: 28,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF201E26),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 4,
                                      child: SizedBox(
                                        width: 100,
                                        height: 20,
                                        child: Text(
                                          'smart playlists',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Neue Regrade',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.42,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 242,
                        height: 242,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 1,
                              top: 1,
                              child: Opacity(
                                opacity: 0.30,
                                child: Container(
                                  width: 240,
                                  height: 240,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.50, -0.00),
                                      end: Alignment(0.50, 1.79),
                                      colors: [Color(0xFF101010), Color(0xFF444444)],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              top: 15,
                              child: Container(
                                width: 223,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Opacity(
                                      opacity: 0.90,
                                      child: Container(
                                        width: double.infinity,
                                        height: 58,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF201E26),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 8,
                                              top: 8,
                                              child: Container(
                                                width: 43,
                                                height: 43,
                                                decoration: ShapeDecoration(
                                                  image: const DecorationImage(
                                                    image: NetworkImage("https://placehold.co/43x43"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 59,
                                              top: 10,
                                              child: SizedBox(
                                                width: 120,
                                                child: Text(
                                                  'Heavy Rotation',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Neue Regrade',
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.42,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 59,
                                              top: 30,
                                              child: Text(
                                                'i.e.',
                                                style: TextStyle(
                                                  color: const Color(0xFF5E6783),
                                                  fontSize: 14,
                                                  fontFamily: 'Neue Regrade',
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.42,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 58,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF201E26),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 7,
                                            top: 8,
                                            child: Container(
                                              width: 43,
                                              height: 43,
                                              decoration: ShapeDecoration(
                                                image: const DecorationImage(
                                                  image: NetworkImage("https://placehold.co/43x43"),
                                                  fit: BoxFit.cover,
                                                ),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 59,
                                            top: 20,
                                            child: SizedBox(
                                              width: 120,
                                              child: Text(
                                                'Listening History',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Neue Regrade',
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.42,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 58,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF201E26),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 8,
                                            top: 8,
                                            child: Container(
                                              width: 43,
                                              height: 43,
                                              decoration: ShapeDecoration(
                                                image: const DecorationImage(
                                                  image: NetworkImage("https://placehold.co/43x43"),
                                                  fit: BoxFit.cover,
                                                ),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 59,
                                            top: 10,
                                            child: SizedBox(
                                              width: 108,
                                              child: Text(
                                                'Human Robot',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Neue Regrade',
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.42,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 59,
                                            top: 30,
                                            child: Text(
                                              'i.e.',
                                              style: TextStyle(
                                                color: const Color(0xFF5E6783),
                                                fontSize: 14,
                                                fontFamily: 'Neue Regrade',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.42,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 4,
              top: 325,
              child: Opacity(
                opacity: 0.80,
                child: Container(
                  width: 52,
                  height: 326,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF201E26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 329,
              child: Container(
                width: 44.41,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.41,
                      height: 40.41,
                      child: Stack(
                        children: [
                          Icon(Icons.explore, color: Colors.white.withOpacity(0.7), size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 29),
                    Container(
                      width: 40.41,
                      height: 40.41,
                      child: Stack(
                        children: [
                          Icon(Icons.search, color: Colors.white.withOpacity(0.7), size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 29),
                    Container(
                      width: 40.41,
                      height: 40.41,
                      child: Stack(
                        children: [
                          Icon(Icons.favorite_border, color: Colors.white.withOpacity(0.7), size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 29),
                    Container(
                      width: 40.41,
                      height: 40.41,
                      child: Stack(
                        children: [
                          Icon(Icons.queue_music, color: Colors.white.withOpacity(0.7), size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 29),
                    Container(
                      width: 40.41,
                      height: 40.41,
                      child: Stack(
                        children: [
                          Icon(Icons.history, color: Colors.white.withOpacity(0.7), size: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 153,
              top: 625,
              child: Container(
                width: 200,
                height: 45,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.90,
                        child: Container(
                          width: 200,
                          height: 45,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF201E26),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 7,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage("https://placehold.co/30x30"),
                            fit: BoxFit.cover,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48,
                      top: 30,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Long Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48,
                      top: 17,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Die Lit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48,
                      top: 3,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Playboi Carti',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 157,
              top: 555,
              child: Container(
                width: 200,
                height: 60,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.90,
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF201E26),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 8,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage("https://placehold.co/45x45"),
                            fit: BoxFit.cover,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 59,
                      top: 41,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'They Who Must Die',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 59,
                      top: 24,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'We Are Sent Here ...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 59,
                      top: 7,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Shabaka and The ...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 157,
              top: 359,
              child: Container(
                width: 200,
                height: 60,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.90,
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF201E26),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 8,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage("https://placehold.co/45x45"),
                            fit: BoxFit.cover,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      top: 41,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Violence',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      top: 24,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Faith in Strangers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      top: 7,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Andy Stott',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 153,
              top: 300,
              child: Container(
                width: 200,
                height: 45,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.90,
                        child: Container(
                          width: 200,
                          height: 45,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF201E26),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 7,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage("https://placehold.co/30x30"),
                            fit: BoxFit.cover,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48,
                      top: 29,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Run It',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48,
                      top: 16,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'Dead Channel Sky',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48,
                      top: 2,
                      child: SizedBox(
                        width: 128,
                        height: 12,
                        child: Text(
                          'clipping.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 216,
              child: Container(
                width: 342,
                height: 342,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://placehold.co/542x542"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 68,
              top: 441,
              child: Container(
                width: 94,
                height: 94,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage("https://placehold.co/94x94"),
                    fit: BoxFit.cover,
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 166,
              top: 447,
              child: Container(
                width: 200,
                height: 80,
                child: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      top: 59,
                      child: SizedBox(
                        width: 210,
                        height: 15,
                        child: Text(
                          'Up next: Andy Stott - Violence ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 43,
                      child: SizedBox(
                        width: 180,
                        height: 15,
                        child: Text(
                          'Record: The Money Store',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 26,
                      child: SizedBox(
                        width: 180,
                        height: 15,
                        child: Text(
                          'Playlist: Human Robot',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 7,
                      child: SizedBox(
                        width: 180,
                        height: 15,
                        child: Text(
                          'Playing from:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Neue Regrade',
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 742,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hacker\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Neue Regrade',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.42,
                      ),
                    ),
                    TextSpan(
                      text: 'Death Grips',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Neue Regrade',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.42,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 186,
              top: 728,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 40.41,
                    height: 40.41,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 2,
                          child: Opacity(
                            opacity: 0.75,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const ShapeDecoration(
                                gradient: RadialGradient(
                                  center: Alignment(0.50, 0.50),
                                  radius: 1.34,
                                  colors: [Color(0xFF101010), Color(0xFFC9C9C9)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.skip_previous, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                  const SizedBox(width: 22),
                  Container(
                    width: 40.59,
                    height: 40.41,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 2,
                          child: Opacity(
                            opacity: 0.75,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const ShapeDecoration(
                                gradient: RadialGradient(
                                  center: Alignment(0.50, 0.50),
                                  radius: 1.34,
                                  colors: [Color(0xFF101010), Color(0xFFC9C9C9)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.pause, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                  const SizedBox(width: 22),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: OvalBorder(),
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.black, size: 28),
                  ),
                  const SizedBox(width: 22),
                  Container(
                    width: 40.41,
                    height: 40.41,
                    child: Stack(
                      children: [
                        Icon(Icons.skip_next, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 390,
                height: 47,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 35,
                              height: 14,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Text(
                                      '9:41',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF888888),
                                        fontSize: 17,
                                        fontFamily: 'SF Pro',
                                        fontWeight: FontWeight.w600,
                                        height: 0.82,
                                        letterSpacing: -0.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(width: 14, height: 14),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(width: 18, height: 14),
                            const SizedBox(width: 8),
                            Container(width: 18, height: 14),
                            const SizedBox(width: 8),
                            Container(
                              width: 27,
                              height: 14,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 5.75,
                                    top: 0,
                                    child: Text(
                                      '78',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF060606),
                                        fontSize: 11,
                                        fontFamily: 'SF Pro',
                                        fontWeight: FontWeight.w700,
                                        height: 1.27,
                                        letterSpacing: -0.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Harmony'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add navigation to your navigation routes from the original code
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 300,
                color: const Color(0xFF201E26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/playlists');
                      },
                      child: const Text('Playlists'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/artists');
                      },
                      child: const Text('Artists'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/albums');
                      },
                      child: const Text('Albums'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/songs');
                      },
                      child: const Text('Songs'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/downloads');
                      },
                      child: const Text('Downloads'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/currentlyPlaying');
                      },
                      child: const Text('Currently Playing'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: const Color(0xFF201E26),
        child: const Icon(Icons.menu),
      ),
    );
  }
}
