/*
* Autor: Benjamín Galarce
* Fecha: 08-10-2022
* Version: 1.0
* Nombre: sp_seleccionarproductos
*
* Parámetros:
*	_IDPROVEEDOR: identificador de proveedor
*	_INVENTARIOFECHA: fecha de realización de inventario
*	_CODIGOINVENTARIO: codigo de cada inventario realizado
*/

/* 
* Primera consulta: Mostrar todos los productos correspondiente a un proveedor, filtrando por su identificador.
* Mostrando las siguientes tablas:
*	- NOMBREPROVEEDOR
*	- RUTPROVEEDOR
*	- DIRECCIONPROVEEDOR
*	- CONTACTOPROVEEDOR
*	- CODIGOPRODUCTO
*	- DESCRIPCIONPRODUCTO
*	- CANTIDADPRODUCTO
*	- VALORPRODUCTO
*/

delimiter $$
create procedure SP_SELECCIONARPRODUCTOSXPROVEEDOR(
	_IDPROVEEDOR INT
)
begin
	Select
		A.NOMBREPROVEEDOR as Nombre_Proveedor,
        A.RUTPROVEEDOR as RUT,
        A.DIRECCIONPROVEEDOR as Dirección,
        A.CONTACTOPROVEEDOR as Contacto,
        B.CODIGOPRODUCTO as Código_Producto,
        B.DESCRIPCIONPRODUCTO as Nombre_Producto,
        B.CANTIDADPRODUCTO as Stock_Producto,
        B.VALORPRODUCTO as Precio
	from PROVEEDOR A
	left join PRODUCTOS B
    on A.IDPROVEEDOR = B.IDPROVEEDOR
    where A.IDPROVEEDOR = _IDPROVEEDOR;
end;
$$

call SP_SELECCIONARPRODUCTOSXPROVEEDOR ('5');

/*
* Segunda consulta: Verificar estado de productos, filtrando por código de inventario.
* Debe mostrar las siguentes tablas:
*	- IDPROVEEDOR
*	- NOMBREPROVEEDOR
*	- RUTPROVEEDOR
*	- TELEFONOPROVEEDOR
*	- CONTACTOPROVEEDOR
*	- DIRECCIONPROVEEDOR
*	- CODIGOPRODUCTO
*	- DESCRIPCIONPRODUCTO
*	- INVENTARIOFECHA
*	- INVENTARIOSTOCK
*	- ESTADOPRODUCTOID
*	- ESTADOPRODUCTODESCRIPCION
*/

delimiter $$
create procedure SP_SELECCIONARINVETARIOXFECHA(
	_CODIGOINVENTARIO varchar(30)
)
begin
	select 
		A.IDPROVEEDOR as ID_Proveedor,
		A.NOMBREPROVEEDOR as Nombre_Proveedor,
		A.RUTPROVEEDOR as RUT,
		A.TELEFONOPROVEEDOR as Teléfono,
		A.CONTACTOPROVEEDOR as Contacto,
		A.DIRECCIONPROVEEDOR as Dirección,
		B.CODIGOPRODUCTO as Código_Producto,
		B.DESCRIPCIONPRODUCTO as Nombre_Producto,
		C.INVENTARIOFECHA as Fecha,
		C.INVENTARIOSTOCK as Stock_Disponible,
		D.ESTADOPRODUCTOID as ID_Estado,
		D.ESTADOPRODUCTODESCRIPCION as Estado
	from PROVEEDOR A
	left join PRODUCTOS B
    on A.IDPROVEEDOR = B.IDPROVEEDOR
    left join INVENTARIO C
    on B.CODIGOPRODUCTO = C.CODIGOPRODUCTO
    left join ESTADOPRODUCTO D
    on C.ESTADOPRODUCTOID = D.ESTADOPRODUCTOID
    where CODIGOINVENTARIO = _CODIGOINVENTARIO;
end;
$$

CALL SP_SELECCIONARINVETARIOXFECHA ("340007780012301");