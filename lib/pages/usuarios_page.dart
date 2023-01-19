import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPage extends StatefulWidget {
  

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

   RefreshController _refreshController = RefreshController(initialRefresh: false);
  

  final usuarios = [
    
    Usuario(online: true, email: 'test1@test.com', nombre: 'Maria',uid: '1'),
    Usuario(online: false, email: 'test2@test.com', nombre: 'Melissa',uid: '2'),
    Usuario(online: true, email: 'test3@test.com', nombre: 'Fernando',uid: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nombre', style: TextStyle(color: Colors. black87),),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon
          (Icons.exit_to_app,color:Colors. black87),
          onPressed: () {},
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle, color: Colors.blue[400]),
              // child: Icon(Icons.offline_bolt, color: Colors.red,),
            )
          ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue,
        ),
        child: _listViewUsuarios(),
        
        ),
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
     itemBuilder: (_, i) =>  _usuarioListTile(usuarios[i]),
     separatorBuilder: (_, i) => const Divider(), 
      itemCount: usuarios.length
      
      );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child:  Text(usuario.nombre.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100)
        ),
      ),
     );
  }


  _cargarUsuarios() async{
    

    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  }
