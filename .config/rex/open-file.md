# Abrir archivos con cmd+click en Rex

Cuando hacés cmd+click en una ruta de archivo dentro de Rex, el archivo se abre en la tab que
tenés en pantalla:

- Código (`.go`, `.ts`, `.css`, `.vue`, `.json`): en el nvim de la tab. Si la tab no tiene un
  nvim, en un pane nuevo a la derecha con nvim.
- Markdown (`.md`): con la función `md` de `~/.aliases`, en un pane nuevo a la derecha.
- HTML (`.html`): en el navegador, con Velja, que es la app por defecto del sistema.

## Cómo funciona

Rex decide qué hacer con el clic según el tipo que macOS le asigna al archivo:

- Si el tipo es un script (`public.script`), Rex muestra "Couldn't open link" y no hace nada
  más. Ninguna opción de Rex lo cambia.
- Si no es un script, Rex abre el archivo con la app por defecto de macOS.

Rex no tiene un evento ni un hook de Lua para el clic, y su API no le dice a un proceso externo
qué tab está en pantalla. En cambio, una tecla asociada a una acción corre con el contexto de la
tab visible. Por eso el flujo pasa por una tecla:

1. macOS abre el archivo con **Rex Open**, que es la app por defecto para esos tipos.
2. Rex Open guarda la ruta en `~/.local/state/rex/open-file` y presiona `F18` en Rex.
3. `F18` ejecuta la acción `open_file` de `init.lua`, que lee la ruta y abre el archivo.

## Piezas

| Pieza | Ubicación | Qué hace |
|---|---|---|
| Acción `open_file` y tecla `F18` | `init.lua` | Abre los archivos encolados en la tab visible. |
| Script de Rex Open | `open-file.applescript` | Encola los archivos y presiona `F18`. |
| Rex Open | `~/Applications/Rex Open.app` | Ejecuta `open-file.applescript`. No está en el repo. |
| Rex Open Types | `~/Applications/Rex Open Types.app` | Registra tipos para `.go` y `.vue`, que macOS no trae. Su `Info.plist` es `rex-open-types.plist`. |
| Errores | `~/.local/state/rex/open-file.log` | Guarda los errores de Rex Open, que corre sin ventana. |

Rex Open solo ejecuta `open-file.applescript` desde el repo. Si editás el script, la firma de
la app no cambia y el permiso de Accesibilidad se mantiene. Si volvés a generar la app, macOS
invalida el permiso y tenés que darlo de nuevo.

## Instalación en una Mac nueva

Para instalarlo, seguí estos pasos:

1. Instalá `duti`:

   ```sh
   brew install duti
   ```

2. Generá Rex Open, ponele un identificador y firmala:

   ```sh
   app="$HOME/Applications/Rex Open.app"
   osacompile -o "$app" -e 'on open theFiles' -e 'run script (POSIX file ((POSIX path of (path to home folder)) & ".config/rex/open-file.applescript")) with parameters {theFiles}' -e 'end open'
   /usr/libexec/PlistBuddy -c 'Add :CFBundleIdentifier string com.thepante.rex-open' -c 'Add :LSUIElement bool true' "$app/Contents/Info.plist"
   codesign --force --deep -s - "$app"
   ```

3. Generá Rex Open Types y registrá las dos apps:

   ```sh
   types="$HOME/Applications/Rex Open Types.app"
   mkdir -p "$types/Contents"
   cp ~/.config/rex/rex-open-types.plist "$types/Contents/Info.plist"
   lsregister=/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister
   "$lsregister" -f "$HOME/Applications/Rex Open.app" "$types"
   ```

4. Poné Rex Open como app por defecto:

   ```sh
   for t in org.golang.go-source public.mpeg-2-transport-stream public.css org.vuejs.vue-source public.json net.daringfireball.markdown; do
     duti -s com.thepante.rex-open "$t" all
   done
   ```

5. En **Configuración del Sistema > Privacidad y seguridad > Accesibilidad**, agregá
   `~/Applications/Rex Open.app` y activala. Si el panel no aparece, abrilo con
   `open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"`.
6. La primera vez que Rex Open presiona la tecla, macOS pregunta si puede controlar
   **System Events**. Aceptá.

## Limitaciones

- Rex bloquea `.php`, `.py`, `.js`, `.tsx` y `.sh`, porque macOS los toma como scripts. Hay un
  pedido abierto en el foro de Rex:
  [Script code links in agentic output](https://discord.com/channels/1546797889009881158/1565800836100001923).
- macOS toma `.ts` como video MPEG-2 (`public.mpeg-2-transport-stream`). Por eso Rex no lo
  bloquea, pero los videos `.ts` también abren con Rex Open.
- La app por defecto vale para todo macOS: un doble clic en Finder también abre el archivo en
  Rex.
- `F18` queda reservada para Rex Open.

## Volver a las apps de antes

Antes de Rex Open, cada tipo abría con estas apps:

| Tipo | App | Identificador |
|---|---|---|
| `org.golang.go-source`, `public.mpeg-2-transport-stream`, `org.vuejs.vue-source` | Warp | `dev.warp.Warp-Stable` |
| `public.css`, `public.json` | Sublime Text | `com.sublimetext.4` |
| `net.daringfireball.markdown` | Xcode | `com.apple.dt.Xcode` |

Para restaurar una, corré `duti -s IDENTIFICADOR TIPO all`, por ejemplo
`duti -s com.sublimetext.4 public.css all`.

`.go` y `.vue` dependen de Rex Open Types: si borrás esa app, vuelven a ser tipos dinámicos y
`duti` no les puede asignar una app.
