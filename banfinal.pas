program cajero;
uses
    Crt;
const
    ruta = 'c:\clientes.dat';

type

cliente = record
          cedula: longint;
          nombre: string [30];
          apellido: string [30];
          direccion: string [50];
          telefono: string [25];
          saldo: longint;
        end;


VAR
    DBarchivo : file of cliente;
      archivo : file of cliente;
      deposito: file of cliente;
        datos : cliente;


            i : longint;
       existe : boolean;
          ced : longint;
           sw : boolean;



//************************************************************************************************
//********************      BUSCA EL CLIENTE SI ESTA EN EL ARCHIVO     ***************************
//************************************************************************************************

     procedure consultarcliente (var ced : longint);

    begin

         assign(archivo, ruta);
         {$I-}reset(archivo);{$I+}
              if IOresult  <> 0 then
                  sw := true
              else
                  begin
                  while not eof(archivo) do
                        begin
                           read(archivo,datos);
                           if datos.cedula = ced then
                              begin
                                   existe := true;
                                    break;
                               end;
                        end;

                  end;
                   close(archivo);

    end;

//************************************************************************************************
//*********************      MODIFICAR  CLIENTE EN EL ARCHIVO    ************************
//************************************************************************************************


    procedure modificarcliente;
     var
           campos : cliente;
        respuesta : char;
           retiro : longint;
    begin

       repeat
          clrscr;
          ced := 0;

          existe:= false;
          writeln ('     ______________________________________________________ ');
          writeln ('    |                                                      |');
          writeln ('    |               MODIFICAR SALDO CLIENTE                |');
          writeln ('    |             ---------------------------              |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |______________________________________________________|');

          gotoxy(14,6);write('CEDULA: ');
          gotoxy(22,6);readln(campos.cedula);
          ced := campos.cedula;

          assign(archivo, ruta);
          {$I-}reset(archivo);{$I+}
          if IOresult  <> 0 then
             begin
                  gotoxy(15,10);write ('NO SE HA CREADO EL ARCHIVO PRINCIPAL');
             end
          else
                  begin

                   while not eof(archivo) do
                        begin
                           existe := true;

                           read(archivo,campos);
                           if campos.cedula = ced then
                              begin
                                    existe := false;


                                    gotoxy(16,10);writeln('SALDO DISPONIBLE: ',campos.saldo);
                                    gotoxy(16,12);writeln('     NUEVO MONTO:');

                                    gotoxy(34,12);readln(retiro);
                                   campos.saldo := retiro;
                                   seek(archivo,filepos(archivo)-1);
                                   write(archivo,campos);
                                   close(archivo);
                                   break;
                               end;
                        end;
                  end;
          if existe = true then
              begin
                existe:= false;
                gotoxy(24,10);writeln('CEDULA NO REGISTRADA');
                close(archivo);
              end;
           gotoxy(14,20);write('¨DESEA MODIFICAR OTRO CLIENTE ( S ¢ N )?');
           respuesta := upcase (readkey);
       until respuesta = 'N';
    end;




//************************************************************************************************
//****************************      MOSTRAR UN  CLIENTE EN EL ARCHIVO    ************************
//************************************************************************************************


    procedure mostrarcliente;
     var
           campos : cliente;
        respuesta : char;
    begin

       repeat
          clrscr;
          ced := 0;

          existe:= false;
          writeln ('     ______________________________________________________ ');
          writeln ('    |                                                      |');
          writeln ('    |                  CONSULTAR CLIENTE                   |');
          writeln ('    |                --------------------                  |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |______________________________________________________|');

          gotoxy(14,6);write('CEDULA: ');
          gotoxy(22,6);readln(campos.cedula);
          ced := campos.cedula;

          assign(archivo, ruta);
          {$I-}reset(archivo);{$I+}
          if IOresult  <> 0 then
             begin
                gotoxy(15,10);write ('NO SE HA CREADO EL ARCHIVO PRINCIPAL');
             end
          else
                  begin

                   while not eof(archivo) do
                        begin
                           existe := true;

                           read(archivo,campos);
                           if campos.cedula = ced then
                              begin
                                   existe := false;
                                   gotoxy(14,8);writeln('NOMBRE:');
                                   gotoxy(12,10);writeln('APELLIDO:');
                                   gotoxy(11,12);writeln('DIRECCION:');
                                   gotoxy(12,14);writeln('TELEFONO:');
                                   gotoxy(15,16);writeln('SALDO:');
                                   gotoxy(22,6);writeln(campos.cedula);
                                   gotoxy(22,8);writeln(campos.nombre);
                                   gotoxy(22,10);writeln(campos.apellido);
                                   gotoxy(22,12);writeln(campos.direccion);
                                   gotoxy(22,14);writeln(campos.telefono);
                                   gotoxy(22,16);writeln(campos.saldo);


                                   close(archivo);
                                   break;
                               end;
                        end;
                  end;
          if existe = true then
              begin
                existe:= false;
                gotoxy(24,10);writeln('CEDULA NO REGISTRADA');
                close(archivo);
              end;
          gotoxy(14,20);write('¨DESEA MOSTRAR OTRO CLIENTE ( S ¢ N )?');
          respuesta := upcase (readkey);
       until respuesta = 'N';
    end;

//************************************************************************************************
//**********************      CREAR EL ARCHIVO CON EL PRIMER CLIENTE      ************************
//************************************************************************************************


    procedure creararchivodelientes;
    var
        campos : cliente;

    begin

          clrscr;

                 writeln ('     ______________________________________________________ ');
                 writeln ('    |                                                      |');
                 writeln ('    |           CREAR ARCHIVO CON PRIMER CLIENTE           |');
                 writeln ('    |         -------------------------------------        |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |______________________________________________________|');

          gotoxy(14,6);write('CEDULA: ');
          gotoxy(22,6);readln(campos.cedula);
          ced := campos.cedula;

                 campos.nombre :='';
                 campos.apellido := '';
                 campos.direccion := '';
                 campos.telefono := '';
                 campos.saldo := 0;
                 gotoxy(14,8);write('NOMBRE: ');
                 gotoxy(12,10);write('APELLIDO: ');
                 gotoxy(11,12);write('DIRECCION:');
                 gotoxy(12,14);write('TELEFONO: ');
                 gotoxy(15,16);write('SALDO: ');
                 gotoxy(22,8);readln(campos.nombre);
                 gotoxy(22,10);readln(campos.apellido);
                 gotoxy(22,12);readln(campos.direccion);
                 gotoxy(22,14);readln(campos.telefono);
                 gotoxy(22,16);readln(campos.saldo);



                 assign(DBarchivo,ruta);
                 {$I-} reset(DBarchivo); {$I+}
                 if ioresult <> 0 then
                     begin
                         rewrite(DBarchivo);
                         seek(DBarchivo,0);
                         write(DBarchivo,campos);
                         close(DBarchivo);
                    end;

         gotoxy(22,18);writeln('PROCESANDO INFORMACION');
         gotoxy(25,20);writeln('ESPERE POR FAVOR...');
         delay(5000);

    end;




//************************************************************************************************
//**********************      INGRESA A UN NUEVO CLIENTE EN EL ARCHIVO    ************************
//************************************************************************************************



    procedure guradarcliente;
     var
        respuesta : char;
        campos : cliente;

    begin

       repeat
          clrscr;
          ced := 0;
          sw := false;
          existe:= false;
                 writeln ('     ______________________________________________________ ');
                 writeln ('    |                                                      |');
                 writeln ('    |                   AGREGAR CLIENTE                    |');
                 writeln ('    |                --------------------                  |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |                                                      |');
                 writeln ('    |______________________________________________________|');

          gotoxy(14,6);write('CEDULA: ');
          gotoxy(22,6);readln(campos.cedula);
          ced := campos.cedula;

          consultarcliente (ced);

          if existe = false then
             begin

                 campos.nombre :='';
                 campos.apellido := '';
                 campos.direccion := '';
                 campos.telefono := '';
                 campos.saldo := 0;
                 gotoxy(14,8);write('NOMBRE: ');
                 gotoxy(12,10);write('APELLIDO: ');
                 gotoxy(11,12);write('DIRECCION:');
                 gotoxy(12,14);write('TELEFONO: ');
                 gotoxy(15,16);write('SALDO: ');
                 gotoxy(22,8);readln(campos.nombre);
                 gotoxy(22,10);readln(campos.apellido);
                 gotoxy(22,12);readln(campos.direccion);
                 gotoxy(22,14);readln(campos.telefono);
                 gotoxy(22,16);readln(campos.saldo);



                 assign(DBarchivo,ruta);
                 {$I-} reset(DBarchivo); {$I+}
                 if ioresult <> 0 then
                     begin
                         rewrite(DBarchivo);
                         seek(DBarchivo,0);
                         write(DBarchivo,campos);
                         close(DBarchivo);
                      end
                 else
                      begin
                          Seek(DBarchivo,fileSize(DBarchivo));
                          write(DBarchivo,campos);
                          close(DBarchivo);
                       end;
             end
          else
             begin
                existe:= false;
                gotoxy(19,10);writeln('LA CEDULA YA ESTA REGISTRADA');

             end;

          gotoxy(14,20);write('¨DESEA AGREAGAR OTRO CLIENTE ( S ¢ N )?');
          respuesta := upcase (readkey);
       until respuesta = 'N';
    end;

//************************************************************************************************
//****************      RETIRO OTRO MONTO CAJERO AUTOMATICO    ************************
//************************************************************************************************


    procedure depositocajero (var pin : longint);
     var
           campos : cliente;
        respuesta : char;
         anterior : longint;
           actual : longint;
     montodeposito: longint;

    begin


          clrscr;
                 ced := 0;
            anterior := 0;
              actual := 0;
              existe := false;
       montodeposito := 0;

       writeln ('     ______________________________________________________ ');
       writeln ('    |                                                      |');
       writeln ('    |                   BANCO BANESCO                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |                                                      |');
       writeln ('    |______________________________________________________|');

          assign(archivo, ruta);
          {$I-}reset(archivo);{$I+}
          if IOresult  <> 0 then
             begin
                 gotoxy(19,10); write ('CAJERO FUERA DE SERVICIO');
             end
          else
                  begin

                   while not eof(archivo) do
                        begin
                           existe := true;

                           read(archivo,campos);
                           if campos.cedula = pin then
                              begin
                                   existe := false;
                                   anterior := campos.saldo;

                                    gotoxy(16,7);write('INDIQUE EL MONTO: ');gotoxy(34,7);readln(montodeposito);
                                    campos.saldo := campos.saldo + montodeposito;
                                    actual := campos.saldo;

                                    gotoxy(18,10);writeln('SALDO ANTERIOR: ',anterior);
                                    gotoxy(16,12);writeln('SALDO DISPONIBLE: ',actual);
                                    seek(archivo,filepos(archivo)-1);
                                    write(archivo,campos);
                                    close(archivo);
                                    break;
                               end;
                        end;
                  end;
          if existe = true then
              begin
                existe:= false;
                gotoxy(24,9);writeln('CEDULA NO REGISTRADA');
                close(archivo);
              end;
         gotoxy(22,17);writeln('PROCESANDO INFORMACION');
         gotoxy(25,19);writeln('ESPERE POR FAVOR...');
         delay(5000);
     end;


//************************************************************************************************
//*********************      PAGOS CAJEROAUTOMATICO    ************************
//************************************************************************************************

 procedure actualizardestino (var montodestino : longint; var cuentadestino : longint; var pos2 : integer);
    var
       destino : cliente;
    begin


                  while not eof(archivo) do
                        begin
                           read(archivo,destino);
                           if destino.cedula = cuentadestino then
                              begin
                                  destino.saldo := montodestino;
                                  seek(archivo,pos2);
                                  write(archivo,destino);
                                  break;
                               end;
                        end;
       end;

//************************************************************************************************
//*********************      PAGOS CAJEROAUTOMATICO    ************************
//************************************************************************************************


    procedure pagosclientecajero(var pin : longint);
    var
           origen : cliente;
          destino : cliente;
   anteriororigen : longint;
     actualorigen : longint;
    cuentadestino : longint;
     montodestino : longint;
      montoorigen : longint;
    montodeposito : longint;
             pos1 : integer;
             pos2 : integer;

    begin


         clrscr;
              pos1 := 0;
              pos2 := 0;
     montodeposito := 0;
      montodestino := 0;
       montoorigen := 0;
    anteriororigen := 0;
      actualorigen := 0;
      cuentadestino:= 0;
            existe := false;

          writeln ('     ______________________________________________________ ');
           writeln ('    |                                                      |');
           writeln ('    |                   BANCO BANESCO                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |                                                      |');
           writeln ('    |______________________________________________________|');

          assign(archivo, ruta);
          {$I-}reset(archivo);{$I+}
          if IOresult  <> 0 then
             begin
                 gotoxy(19,10);write ('CAJERO FUERA DE SERVICIO');
             end
          else
              begin

                   while not eof(archivo) do
                        begin
                           existe := true;
                             pos1 := pos1 + 1;
                           read(archivo,origen);
                           if origen.cedula = pin then
                              begin
                                   existe := false;
                                   anteriororigen := origen.saldo;
                                   montoorigen := origen.saldo;
                                   writeln;writeln;
                                   gotoxy(11,8);write('INDIQUE N§ DE CUENTA DESTINO: ');
                                   gotoxy(41,8);readln(cuentadestino);
                                           seek(archivo,0);
                                           while not eof(archivo) do
                                               begin
                                                   pos2 := pos2 + 1;
                                                   read(archivo,destino);
                                                   if destino.cedula = cuentadestino then
                                                      begin
                                                         montodestino := destino.saldo;
                                                         existe := false;

                                                        gotoxy(11,11);write('INDIQUE EL MONTO A PAGAR: ');
                                                        gotoxy(37,11);readln(montodeposito);
                                                         if montoorigen >= montodeposito then
                                                            begin
                                                                montoorigen := montoorigen - montodeposito;
                                                               montodestino := montodestino + montodeposito;
                                                               existe := true;
                                                            end
                                                         else
                                                           begin
                                                             gotoxy(15,13);writeln('EL MONTO SUPERA AL SALDO DISPONIBLE');
                                                          end;
                                                      end; {fin verif. cedula destino}
                                               end; {fin while 2}

                                          if existe = true then
                                             begin
                                                existe := false;
                                                actualorigen  := montoorigen;

                                                gotoxy(11,11);write('                                       ');
                                                gotoxy(18,6);writeln('<<  P A G O   E X I T O S O  >>');
                                                gotoxy(18,10);writeln('SALDO ANTERIOR: ',anteriororigen);
                                                gotoxy(16,12);writeln('SALDO DISPONIBLE: ',actualorigen);


                                                pos1 := pos1 - 1;
                                                pos2 := pos2 - 1;
                                                origen.saldo := montoorigen;
                                                seek(archivo,pos1);
                                                write(archivo,origen);
                                                seek(archivo,0);
                                                while not eof(archivo) do
                                                      begin
                                                          read(archivo,destino);
                                                          if destino.cedula = cuentadestino then
                                                             begin
                                                                destino.saldo := montodestino;
                                                                seek(archivo,filepos(archivo)-1);
                                                                write(archivo,destino);
                                                             end;
                                                      end;
                                               //actualizardestino (montodestino,cuentadestino,pos2);
                                              end;
                                              close(archivo);
                                              break;
                                     // end;{fin verificacion archivo 2}
                              end; {fin verif. cedula}
                        end; {fin while}
              end; {fin verificacion archivo}
              if existe = true then
                 begin
                    existe:= false;
                    gotoxy(24,9);writeln('CEDULA NO REGISTRADA');
                    close(archivo);
               end; {fin existe}
         gotoxy(22,17);writeln('PROCESANDO INFORMACION');
         gotoxy(25,19);writeln('ESPERE POR FAVOR...');
         delay(5000);
    end; {fin procedure}




//************************************************************************************************
//*********************      RETIRO CAJEROAUTOMATICO    ************************
//************************************************************************************************


    procedure retirofijocajero(var pin : longint;var  opcion : char);
     var
           campos : cliente;
        respuesta : char;
         anterior : longint;
           actual : longint;
        otromonto : longint;

    begin


          clrscr;
          ced := 0;
          anterior := 0;
            actual := 0;
          existe:= false;
          writeln ('     ______________________________________________________ ');
          writeln ('    |                                                      |');
          writeln ('    |                   BANCO BANESCO                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |______________________________________________________|');

          assign(archivo, ruta);
          {$I-}reset(archivo);{$I+}
          if IOresult  <> 0 then
             begin
                 gotoxy(19,10); write ('CAJERO FUERA DE SERVICIO');
             end
          else
                  begin

                   while not eof(archivo) do
                        begin
                           existe := true;

                           read(archivo,campos);
                           if campos.cedula = pin then
                              begin
                                   existe := false;
                                   anterior := campos.saldo;
                                   case opcion of
                                       '1' :  begin

                                                 if campos.saldo > 1000 then
                                                    begin
                                                      campos.saldo := campos.saldo - 1000;
                                                      existe := true;
                                                    end
                                                 else
                                                  begin
                                                    gotoxy(15,13);writeln('EL MONTO SUPERA AL SALDO DISPONIBLE');
                                                  end;
                                               end;

                                        '2' :  begin
                                                 if campos.saldo > 2000 then
                                                    begin
                                                       campos.saldo := campos.saldo - 2000;
                                                       existe := true;
                                                    end
                                                 else
                                                    begin
                                                      gotoxy(15,13);writeln('EL MONTO SUPERA AL SALDO DISPONIBLE');
                                                   end;
                                               end;

                                        '3' :  begin
                                                 if campos.saldo > 10000 then
                                                    begin
                                                       campos.saldo := campos.saldo - 10000;
                                                       existe := true;
                                                    end
                                                 else
                                                    begin
                                                      gotoxy(15,13);writeln('EL MONTO SUPERA AL SALDO DISPONIBLE');
                                                    end;
                                               end;

                                        '4' :  begin
                                                 if campos.saldo > 20000 then
                                                    begin
                                                       campos.saldo := campos.saldo - 20000;
                                                       existe := true;
                                                    end
                                                 else
                                                    begin
                                                      gotoxy(15,13);writeln('EL MONTO SUPERA AL SALDO DISPONIBLE');
                                                    end;
                                               end;

                                        '5' :  begin
                                                 if campos.saldo > 50000 then
                                                    begin
                                                        campos.saldo := campos.saldo - 50000;
                                                        existe := true;
                                                    end
                                                 else
                                                    begin
                                                       gotoxy(15,13);writeln('EL MONTO SUPERA AL SALDO DISPONIBLE');
                                                    end;
                                               end;

                                        '6' :  begin
                                                     gotoxy(11,11);write('INDIQUE EL MONTO: ');
                                                     gotoxy(29,11); readln(otromonto);
                                                     if campos.saldo > otromonto then
                                                        begin
                                                          campos.saldo := campos.saldo - otromonto;
                                                          existe := true;
                                                        end
                                                      else
                                                        begin
                                                          gotoxy(15,13);writeln('EL MONTO SUPERA AL SALDO DISPONIBLE');
                                                       end;
                                               end;


                                   end;
                                   if existe = true then
                                      begin
                                          existe := false;
                                          actual := campos.saldo;

                                          gotoxy(11,11);write('                                            ');
                                          gotoxy(13,6);writeln('POR FAVOR TOME SUS DINERO DE LA BANDEJA');
                                          gotoxy(21,7);writeln('DE SALIDA DEL CAJERO');
                                          gotoxy(18,10);writeln('SALDO ANTERIOR: ',anterior);
                                          gotoxy(16,12);writeln('SALDO DISPONIBLE: ',actual);
                                          seek(archivo,filepos(archivo)-1);
                                          write(archivo,campos);
                                      end;
                                       close(archivo);
                                       break;
                               end;
                        end;
                  end;
          if existe = true then
              begin
                existe:= false;
               gotoxy(24,10);writeln('CEDULA NO REGISTRADA');
                close(archivo);
              end;
         gotoxy(22,17);writeln('PROCESANDO INFORMACION');
         gotoxy(25,19);writeln('ESPERE POR FAVOR...');
         delay(5000);
     end;



//************************************************************************************************
//**********************    MENU RETIRO DE CAJERO AUTOMATICO    *******************************
//************************************************************************************************


 procedure menuretirocajero(var pin : longint);
    var
       opcion : char;
    begin

        repeat

            clrscr;
            writeln ('     ______________________________________________________');
            writeln ('    |                                                      |');
            writeln ('    |                   BANCO BANESCO                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                POR  FAVOR  SELECCIONES               |');
            writeln ('    |             LA CANTIDAD DE SU PREFERENCIA            |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |     1 - 1.000 Bs.              4 - 20.000 Bs.        |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |     2 - 2.000 Bs.              5 - 50.000 Bs.        |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |     3 - 10.000 Bs.             6 -OTRO MONTO         |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                    7 - SALIR                         |');
            writeln ('    |______________________________________________________|');
            writeln ('                                                        ');
            repeat
               write('               SELECCIONES UNA OPCION: ');opcion := readkey;
            until opcion in ['1'..'7'];

        clrscr;
        case opcion of
             '1'..'6' :  retirofijocajero(pin,opcion);
        end
        until opcion = '7';
     end;



// *******************************************************************************************
//******************* CONSULTAR SALDO CAJERO AUTOMATICO   *********************************
//************************************************************************************************
  procedure consultarsaldocajero(var pin : longint);

     var
           campos : cliente;
    begin

          assign(archivo, ruta);
          {$I-}reset(archivo);{$I+}
          if IOresult  <> 0 then
             begin
                 gotoxy(19,10); write ('CAJERO FUERA DE SERVICIO');
             end
          else
               begin

                   while not eof(archivo) do
                        begin

                           read(archivo,campos);
                           if campos.cedula = pin then
                              begin
                                 clrscr;
            writeln ('     ______________________________________________________');
            writeln ('    |                                                      |');
            writeln ('    |                   BANCO BANESCO                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                 CONSULTA DE SALDO                    |');
            writeln ('    |            ___________________________               |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |              PPROCESANDO INFORMACION                 |');
            writeln ('    |                                                      |');
            writeln ('    |                 ESPERE POR FAVOR...                  |');
            writeln ('    |                                                      |');
            writeln ('    |______________________________________________________|');

            gotoxy(12,12);writeln ('SU SALDO ACTUAL ES : ',campos.saldo,' Bs');
           close(archivo);
           delay(5000);
           break;
                               end;
                        end;
               end;
    end;

//************************************************************************************************
//********************************    MENU DE OPCIONES CAJERO     *******************************
//************************************************************************************************


 procedure menuoperacionescajero(var pin : longint);
    var
       opcion : char;
    begin

        repeat

            clrscr;
            writeln ('     ______________________________________________________');
            writeln ('    |                                                      |');
            writeln ('    |                   BANCO BANESCO                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |              POR  FAVOR  SELECCIONES SU              |');
            writeln ('    |           TRANSACCION  DE  SU  PREFERENCIA           |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |     1 - CONSUTAR SALDO         2 - RETIRO            |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |     3 - PAGO                   4 - DEPOSITOS         |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                     5 - SALIR                        |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |              SELECCIONES UNA OPCION:                 |');
            writeln ('    |______________________________________________________|');

            repeat
               gotoxy(44,20);opcion := readkey;
            until opcion in ['1'..'5'];

        clrscr;
        case opcion of
             '1' : consultarsaldocajero(pin);

             '2' : menuretirocajero(pin);

             '3' : pagosclientecajero(pin);

             '4' : depositocajero (pin);
        end
        until opcion = '5';
     end;



//************************************************************************************************
//*******************************   MENU CAJERO AUTOMATICO   *********************************
//************************************************************************************************
  procedure menuprincipalcajero;

     var
           campos : cliente;
        respuesta : char;
              pin : longint;
    begin

      repeat

          ced := 0;
          pin := 0;
          existe:= false;
          clrscr;
          writeln ('     ______________________________________________________ ');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                 B I E N V E N I D O                  |');
          writeln ('    |            ----------------------------              |');
          writeln ('    |              CAJERO AUTOMATICO BANESCO               |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |             POR  FAVOR  INGRESE  SU  PIN             |');
          writeln ('    |                                                      |');
          writeln ('    |                 Y  PULSE << ENTER >>                 |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |               INGRESE SU PIN:                        |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |______________________________________________________|');

          gotoxy(37,15);read(campos.cedula);

          ced := campos.cedula;

          assign(archivo, ruta);
          {$I-}reset(archivo);{$I+}
          if IOresult  <> 0 then
             begin
                 gotoxy(19,19);write ('CAJERO FUERA DE SERVICIO');
             end
          else
                  begin

                   while not eof(archivo) do
                        begin
                           existe := true;

                           read(archivo,campos);
                           if campos.cedula = ced then
                              begin
                                   existe := false;
                                   pin := campos.cedula;
                                   close(archivo);
                                   menuoperacionescajero(pin);
                                   break;
                               end;

                        end;
                  end;
          if existe = true then
              begin
                existe:= false;
                clrscr;
                writeln ('     ______________________________________________________ ');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |                 B I E N V E N I D O                  |');
                writeln ('    |            ----------------------------              |');
                writeln ('    |              CAJERO AUTOMATICO BANESCO               |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |              <<<<  PIN INCORRECTO >>>>               |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |          PULSE << ENTER >> PARA CONTINUAR            |');
                writeln ('    |                                                      |');
                writeln ('    |                                                      |');
                writeln ('    |______________________________________________________|');

                gotoxy(55,18);readkey;
                close(archivo);
              end;
          clrscr;
          writeln ('     ______________________________________________________ ');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                 B I E N V E N I D O                  |');
          writeln ('    |            ----------------------------              |');
          writeln ('    |              CAJERO AUTOMATICO BANESCO               |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |             GRACIAS POR UTILIZAR NUESTRO             |');
          writeln ('    |                                                      |');
          writeln ('    |            <<<   CARJERO AUTOMATICO   >>>            |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |      ¨DESEA CONSULTAR OTRO CLIENTE ( S ¢ N ? )?      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |                                                      |');
          writeln ('    |______________________________________________________|');

          gotoxy(55,17);respuesta := upcase (readkey);

      until respuesta = 'N';
    end;


//************************************************************************************************
//********************************    CRACION DEL ARCHIVO CLIENTE  *******************************
//************************************************************************************************


 procedure creararchivo;
    var
       opcion : char;
    begin

        repeat
        clrscr;
            writeln ('     ______________________________________________________ ');
            writeln ('    |                                                      |');
            writeln ('    |         USO SOLO DEL ADMINISTRADOR DEL SISTEMA       |');
            writeln ('    |    -----------------------------------------------   |');
            writeln ('    |   ESTA SECCION DEL SISTEMA PERMITE CREAR EL ARCHIVO  |');
            writeln ('    |                                                      |');
            writeln ('    |    DEL SISTEMA, INGRESANDO SOLO AL PRIMER CLIENTE    |');
            writeln ('    |                                                      |');
            writeln ('    |    PARA SU POSTERIOR CONTROL DE CLIENTE DUPLICADOS   |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                1 - CREAR NUEVO ARCHIVO               |');
            writeln ('    |                                                      |');
            writeln ('    |                2 - SALIR                             |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |                                                      |');
            writeln ('    |              SELECCIONE SU OPCION:                   |');
            writeln ('    |                                                      |');
            writeln ('    |______________________________________________________|');


            repeat
              GOTOXY(42,19); opcion := readkey

            until opcion in ['1'..'2'];

        clrscr;
        case opcion of

             '1' : creararchivodelientes;
        end
       until opcion = '2';

    end;



//************************************************************************************************
//********************************    MENU DEL ADMINISTRADOR     *******************************
//************************************************************************************************


 procedure AdminCliente;
    var
       opcion : char;
    begin

        repeat
        clrscr;
            writeln ('     _____________________________________________________ ');
            writeln ('    |                                                     |');
            writeln ('    |        M  E N U     A D M I N I S T R D O R         |');
            writeln ('    |     ------------------------------------------      |');
            writeln ('    |                                                     |');
            writeln ('    |             1 - AGREGAR CLIENTE                     |');
            writeln ('    |                                                     |');
            writeln ('    |             2 - CONSULTAR CLIENTE                   |');
            writeln ('    |                                                     |');
            writeln ('    |             3 - MODIFICAR CLIENTE                   |');
            writeln ('    |                                                     |');
            writeln ('    |             4 - SALIR                               |');
            writeln ('    |                                                     |');
            writeln ('    |                                                     |');
            writeln ('    |                                                     |');
            writeln ('    |                                                     |');
            writeln ('    |               INGRESE SU OPCION:                    |');
            writeln ('    |_____________________________________________________|');


            repeat
              GOTOXY(40,17); opcion := readkey
            until opcion in ['1'..'4'];

        clrscr;
        case opcion of
             '1' : guradarcliente;

             '2' : mostrarcliente;

             '3' : modificarcliente;
        end
        until opcion = '4';

    end;


//************************************************************************************************
//******************************     MENU PRINCIPAL DEL SISTEMA    *******************************
//************************************************************************************************



    procedure menu;
    var
       opcion : char;
    begin

        repeat
        clrscr;
            writeln ('     _____________________________________________________ ');
            writeln ('    |                                                     |');
            writeln ('    |             M E N U   P R I N C I P A L             |');
            writeln ('    |     ------------------------------------------      |');
            writeln ('    |                                                     |');
            writeln ('    |             1 - ADMINISTRADOR                       |');
            writeln ('    |                                                     |');
            writeln ('    |             2 - DATOS DEL CLIENTER                  |');
            writeln ('    |                                                     |');
            writeln ('    |             3 - IR AL CAJERO AUTOMATICO             |');
            writeln ('    |                                                     |');
            writeln ('    |             4 - SALIR DEL SISTEMA                   |');
            writeln ('    |                                                     |');
            writeln ('    |                                                     |');
            writeln ('    |                                                     |');
            writeln ('    |                                                     |');
            writeln ('    |               INGRESE SU OPCION:                    |');
            writeln ('    |_____________________________________________________|');

            repeat
              GOTOXY(40,17); opcion := readkey
            until opcion in ['1'..'4'];

        clrscr;
        case opcion of
             '1' : creararchivo;

             '2' : AdminCliente;

             '3' : menuprincipalcajero;
        end
        until opcion = '4';

    end;


//************************************************************************************************
//********************************      PRINCIPAL DEL SISTEMA      *******************************
//************************************************************************************************


 BEGIN

        clrscr;

        menu;

    END.
