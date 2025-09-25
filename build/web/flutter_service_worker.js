'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a27625eab961af28a78b49fc75f17edc",
"assets/AssetManifest.bin.json": "6051d5019a16cadd47faff10dd17449e",
"assets/AssetManifest.json": "b553cc22b811fe827765b450aee2fea4",
"assets/assets/destinations/attabad.jpg": "61b2887edab8948503ef62162405d3f9",
"assets/assets/destinations/deosai.jpg": "dcbf629c7385a5e96577063553f8a847",
"assets/assets/destinations/fairy_meadows.jpg": "101085b99447511e3b460ee64ad9d5f0",
"assets/assets/destinations/gilgit.jpg": "48a936166cd8c63dc02a7ff97b49e5d5",
"assets/assets/destinations/hunza.jpg": "15663847069f0bcf247966e888fc415a",
"assets/assets/destinations/murree.jpg": "2732417fee8c0ead93e2b2f5d23298e0",
"assets/assets/destinations/naran_kaghan.jpg": "5f41c764a00a03c6bc511075b5ca2b20",
"assets/assets/destinations/neelum.jpg": "a779fcdfef2f94a057de2844bb7bacd7",
"assets/assets/destinations/rama.jpg": "452af69a780ee5adca79bebc5eb4e430",
"assets/assets/destinations/shogran.jpg": "3f6b16048fbe042e96df391bf4fd4b4f",
"assets/assets/destinations/skardu.jpg": "c9ea48f6c29e1c74176342e66e3d9508",
"assets/assets/destinations/swat.jpg": "744a4b47bcb60234d8e8751d583458f4",
"assets/assets/gallery/attabad.jpg": "356aef731f25af1109d9c12a3a162e32",
"assets/assets/gallery/chitral.jpg": "e6994380e2477c4f8066a96b42007961",
"assets/assets/gallery/deosai.jpeg": "e081fd2a279f50b65c777c17de9de810",
"assets/assets/gallery/fairy_meadows.jpeg": "3ba2974a841ab94d924ea4bfbca9e15c",
"assets/assets/gallery/gilgit.jpg": "b2004a1ac0be81464a88c5714142e8ef",
"assets/assets/gallery/hunza.jpeg": "e7ff9e2d6d4a6c8793e1a6cbbecbe6e7",
"assets/assets/gallery/kaghan.jpg": "1a131070892296992f880f0e75d5bac9",
"assets/assets/gallery/khunjerab.jpg": "5e2839f4c6bfa4ddc5de5fc0919423a7",
"assets/assets/gallery/naran.jpg": "640202b8395531f6f3dfce3e52c14aa3",
"assets/assets/gallery/phander.jpg": "2a10dcd8f8f3834270d43761c67b7b41",
"assets/assets/gallery/pussu_cones.jpeg": "99a957e18dd1e821234c15f42289f4f2",
"assets/assets/gallery/rama.jpg": "f647827a9be82a32834f08248e8ceb3f",
"assets/assets/gallery/shandur.jpg": "158baacb315dbce749bcb4efd2e1621a",
"assets/assets/gallery/skardu.jpg": "23f4be5f5bd63475f5450b50ca88c29a",
"assets/assets/gallery/swat.jpg": "2eff7d8e8d5ee3efd7145e0d2cf491bc",
"assets/assets/logo.png": "3f1b223a42a3d382977960127810c4ed",
"assets/assets/team/aqib.jpeg": "c0d67a749c12a0110e6300ebdbcc1bac",
"assets/assets/team/mustafa.jpeg": "386e9a973ea1d246d851a854cdb5bf1b",
"assets/assets/team/rana.jpeg": "ba096cce70f7e67c05d263e8f207b900",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "dbe20ced5b122c5f7d2feda700ed6ff6",
"assets/NOTICES": "6fd3576a5ddee4499c88bf1e98fa0986",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "3f1b223a42a3d382977960127810c4ed",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "f2eb16362fd13715fc877ec8fe4ca645",
"icons/Icon-192.png": "3f1b223a42a3d382977960127810c4ed",
"icons/Icon-512.png": "3f1b223a42a3d382977960127810c4ed",
"icons/Icon-maskable-192.png": "3f1b223a42a3d382977960127810c4ed",
"icons/Icon-maskable-512.png": "3f1b223a42a3d382977960127810c4ed",
"index.html": "9108bbe153d42dc2b1edd1372be25a7b",
"/": "9108bbe153d42dc2b1edd1372be25a7b",
"main.dart.js": "45b80e756fbbb7f36582e98026c4b9d2",
"manifest.json": "4563bec1681daa05c7da33cc92439dbb",
"version.json": "b6c14de5f49783f3b56e9b7c28b5f0d7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
