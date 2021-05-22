
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_perfeito/home/page/configuration.dart';
import 'package:match_perfeito/home/page/dashboard.dart';
import 'package:match_perfeito/user/user.api.dart';

class MyHomePage extends StatefulWidget {
    MyHomePage({Key? key, required this.title}) : super(key: key);
    final String title;
    
    @override
    _MyHomePageState createState() {
        return _MyHomePageState();
    }
}


class _MyHomePageState extends State<MyHomePage> {
    int currentPageIndex = 0;
    late Dashboard dashboard;
    late Configuration configuration;
    late Widget currentPage;
    
    late List<Widget> pages;
    
    @override
    void initState() {
        super.initState();
        dashboard = Dashboard();
        configuration = Configuration();
        pages = [dashboard, configuration];
        currentPage = dashboard;
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: currentPage,
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentPageIndex,
                fixedColor: Colors.black38,
                type: BottomNavigationBarType.shifting,
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.all_inclusive, color: Colors.blueAccent),
                        title: new Text('Principal')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu, color: Colors.blueAccent),
                        title: new Text('Configuração'))
                ],
                onTap: (int index) {
                    setState(() {
                        currentPageIndex = index;
                        currentPage = pages[index];
                        
                        //print(getUsers());
                    });
                },
            ));
    }
}
