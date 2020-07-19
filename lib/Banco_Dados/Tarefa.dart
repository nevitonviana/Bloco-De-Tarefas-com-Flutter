class Tarefa{
 int id;
 int id_Lista;
 String tarefa;
 String data;

 Tarefa(this.id_Lista, this.tarefa,this.data);

 Tarefa.froMap(Map map){
   this.id = map["id"];
   this.id_Lista = map["id_lista"];
   this.tarefa = map["tarefa"];
   this.data = map["data"];
 }
 Map toMap(){
   Map<String, dynamic>map={
     "id_lista":this.id_Lista,
     "tarefa":this.tarefa,
     "data":this.data
   };
   if(this.id != null){
     map["id"] = this.id;
   }
   return map;
 }

}