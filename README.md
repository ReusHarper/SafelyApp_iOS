# Safely App - iOS

**Creado por:** ***Arturo Espinosa Guadarrama***

[Objetivo](#objetivo)
[Descripción](#descripcion)
[Justificación técnica](#justificacion-tecnica)
[Credenciales de acceso](#credenciales-de-acceso)
[Dependencias ](#dependencias)

<a name="objetivo"></a>
## Objetivo

<div class="text">

Nuestro objetivo principal es crear una aplicación que permita a los usuarios salvaguardar su vida y la de sus amigos, familiares o seres cercanos mediante un botón de emergencia que permite enviar la ubicación en tiempo real sin importar el lugar en donde se encuentre asi también de poder recibir notificaciones de los contactos que se encuentren en peligro.<br><br>

Actualmente la situación de seguridad se encuentra en serios problemas con una alza en números de personas desaparecidas y en muchas ocasiones la falta de comunicación con nuestros familiares o amigos puede generar incertidumbre o desinformación sobre nuestro estado o el lugar donde nos encontremos. <br>

</div>

[Más información sobre de la propuesta del proyecto](https://docs.google.com/presentation/d/1I9Y2ny49bHF0kFdfeRoh9FCffL0Vxi7Y3NZOp8vvkkc/edit?usp=sharing)

<a name="descripcion"></a>
## Descripción

<div class="title">
	Logotipo de Safely App
</div>

<div class="text">

El logotipo principal de Safely trata sobre un perro doméstico con rasgos similares a las razas Akita Inu y Shiba Inu, con el que se busca transmitir a los usuarios seguridad, confianza y lealtad. Algunas caracteristica importantes de estas razas son el hecho de que generalmente son tranquilos y no son ladradores, a no ser que tenga alguna razon especifica para serlo, esto debido a que fueron originariamente criados para seguir las mismas técnicas de acecho que los gatos por lo que cuando alguna de estas razas genera un ladrido, hay que prestarle atención.

</div>

![safely_logo](./resources/img/uikit/logo.png)

<div class="text">

Ademas de ello se emplea como color principal de fondo una tonalidad morada con un degradado lineal violeta ya que lo que se busca transmitir con ello es un ambiente de tranquilidad y armonia, esto debido a que esta app fue creada con el propósito de servir como ayuda para enviar la geolocalización del dispositivo en tiempo real en caso de alguna emergencia. <br><br>

En cuanto a la visualización de cada una de las pantallas se busco realizar un diseño minimalista debido a que el objetivo de la aplicación es hacer que los usuarios puedan utilizarla solamente para situaciones de emergencia y cuando esto suceda sea intuitiva y sencilla de manejar. <br><br>

A continuación se muestra cada una de las pantallas que conforman a la aplicación, mencionando que por el momento solo es posible visualizar el contenido en modo claro para una correcta visualización:

</div>

<div class="title">
	Inicio de Sesión
</div>

<div class="container">
	<img class="container__img container__img--login">
</div>

<br><br>
<div class="title">
	Creación de cuenta
</div>

<div class="container">
	<img class="container__img container__img--signup">
</div>

<br><br>
<div class="title">
	Mapa 2D
</div>

<div class="container">
	<img class="container__img container__img--maps">
</div>

<br><br>
<div class="title">
	Mapa 3D
</div>

<div class="container">
	<img class="container__img container__img--maps3d">
</div>

<br><br>
<div class="title">
	Notificaciones
</div>

<div class="container">
	<img class="container__img container__img--notifications">
</div>

<br><br>
<div class="title">
	Menu lateral
</div>

<div class="container">
	<img class="container__img container__img--sidemenu">
</div>

<br><br>
<div class="title">
	Contactos
</div>

<div class="container">
	<img class="container__img container__img--contacts">
</div>

<br><br>
<div class="title">
	Añadir
</div>

<div class="container">
	<img class="container__img container__img--add">
</div>

<br><br>
<div class="title">
	Solicitudes
</div>

<div class="container">
	<img class="container__img container__img--requests">
</div>


[Más información sobre de la propuesta visual](https://docs.google.com/presentation/d/1GldHZZU80CWDQWvX90tkmaZ1dej5sDvDBgK3R9N4z8s/edit?usp=sharing)

[Más información sobre el UI Kit desarrollado e implementado](https://www.figma.com/file/bBb5Vce50pqWe7A6gxMhll/UI-KIT?node-id=0%3A1&t=6SsoxeR9WqMUQW1z-1)

<a name="justificacion-tecnica"></a>
## Justificación técnica

<div class="text">

Para poder utilizar la applicación es necesario contar con una versión del sistema operativo <span>iOS 13 en adelante</span> debido a que se implemento para su creación algunas dependencias como version 7.3.0 de la API de Google Maps y la versión 10.4.0 de Firestore. <br><br>

Un punto a destacar sobre ello es que actualmente en las estadística oficiales de Apple, hasta inicio de 2021 se contaba con iOS 13 instalado en más del 80% de los dispositivos iPhone por lo que es muy posible que esa estadística haya incrementado en los últimos meses. <br><br>

</div>

<a name="credenciales-de-acceso"></a>
## Credenciales de Acceso

Para este proyecto es posible crear una cuenta simplemente proporcionando una dirección de email así también como una contraseña. <br><br>

<div class="container">
	<img class="container__img container__img--signup">
</div>

<div class="subtitle">
	Pantalla de Sign up
</div>

En dado caso que se quiera utilizar alguna cuenta de prueba, se puede implementar las siguientes:<br><br>

- ***Usuario de prueba 1:*** **Email:** prueba@gmail.com - **Password:** 123456
- ***Usuario de prueba 2:*** **Email:** yepeto@gmail.com - **Password:** 123456
- ***Usuario de prueba 3:*** **Email:** pepe@gmail.com - **Password:** 123456

<a name="dependencias"></a>
## Dependencias

- **Google Maps:** Permite agregar un map con la ubicación actual de cada usuario en tiempo real.
- **Firebase Auth:** Brinda un servicio de autenticación mediante los servicios de Google Firebase, utilizando únicamente la autenticación por medio de un email y una contraseña.
- **Firebase Firestore:** Brinda soporte de Backend el cual fue nesario para poder almacenar información básica de cada usuario como su email, nombre, dirección, teléfono, imagen o fotografía personal y una lista de contactos.
- **Lottie:** Se implemento con el fin de poder agregar imágenes y animaciones sencillas para las pantallas de carga (aunque por el momento no fueron agregadas debido a una falta de tiempo para su desarrollo, por lo que se planea lanzar una versión con estas herramientas más adelante).
- **TinyConstraints:** Para poder desplazar e interactuar en la parte del desarrollo de una forma sencilla cada una de las sub vistas creadas, empleando propiedades como Autolayout.

<style>
	.title, .subtitle {
		font-size: 20px;
		font-weight: 900;
		text-align: center; 
		margin: 20px 0;
	}
	
	.subtitle {
		font-size: 15px;
		font-weight: 700;
	}
	
	.text {
		text-align: justify;
	}
	
	.container{
		width: 100%;
	 	height: 700px;
	  	display: flex;
	   justify-content: center;
	}
	
	.container__img {
		width: 55%;
	   height: 100%;
	}
	
	.container__img--login {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/login.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--signup {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/signup.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--account {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/account.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--add {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/add.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--contacts {
        https://github.com/ReusHarper/SafelyApp_iOS/blob/maihttps://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/account.png
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/contacts.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--maps {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/maps.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--maps3d {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/maps3d.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--notifications {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/notifications.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--requests {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/requests.png);
		background-position: center center;
		background-size: cover;
	}
	
	.container__img--sidemenu {
		background: url(https://github.com/ReusHarper/SafelyApp_iOS/blob/main/resources/img/pantallas/sidemenu.png);
		background-position: center center;
		background-size: cover;
	}
</style>
