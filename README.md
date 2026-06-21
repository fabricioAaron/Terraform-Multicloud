# Multi-Cloud Storage Deployment (AWS & Azure)

Este proyecto nació de mi curiosidad por comprobar cómo gestionar infraestructura en múltiples nubes de forma simultánea. Quería ver en la práctica si era posible (y qué tan complejo resultaba) desplegar recursos en AWS y Azure al mismo tiempo utilizando un único código de Terraform.

Para mantener la prueba limpia y enfocarme al 100% en el concepto "multi-cloud", decidí desplegar los servicios de almacenamiento de objetos más básicos y equivalentes en ambas plataformas.

## 🚀 Arquitectura

El código levanta la siguiente infraestructura en paralelo:

- **En Azure**: Crea un Resource Group, una Storage Account y un Blob Container.
- **En AWS**: Crea un bucket de S3 clásico.

## 🛠️ Requisitos Previos

Si quieres clonar este repo y probarlo por tu cuenta, vas a necesitar:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) instalado en tu equipo.
- AWS CLI configurado con tus credenciales (`aws configure`).
- Azure CLI instalado y logueado en tu cuenta (`az login`).

## 💻 Cómo desplegarlo

1. Clona este repositorio y entra en la carpeta.
2. Inicializa el proyecto para que descargue los providers de AWS y Azure:
   ```bash
   terraform init
   ```
3. Comprueba el plan de ejecución para ver qué se va a levantar:
   ```bash
   terraform plan
   ```
4. ¡Lanza el despliegue a ambas nubes a la vez!
   ```bash
   terraform apply
   ```

Cuando termine, la consola te devolverá mediante los `outputs` configurados los nombres exactos tanto del bucket de S3 generado como de la cuenta de almacenamiento de Azure.

## 🧹 Limpieza

Para no llevarte sorpresas en la factura a final de mes, recuerda siempre destruir la infraestructura cuando termines de jugar con ella:

```bash
terraform destroy
```
