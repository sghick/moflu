// https://git.aishepin8.com/server/aries_doc/blob/master/api/C%E7%AB%AF/page_jump.md
// =================================================== //
// ============== Page Jump Config  ================== //
// =================================================== //

import 'package:rego/base_core/routes/page_jump.dart';

PageJumpHandler globalWebJumpHandler =
    PageJumpHandler("/web", parser: (url, parameters) {
  if (url.startsWith('http') || url.startsWith('https')) {
    return {'url': url};
  } else {
    return parameters;
  }
});

Map<String, PageJumpHandler> globalJumpHandlers = {
  // TODO:add jump here
  // web页
  // bds-bvlgari://web?url=%s&login=%d
  "web": globalWebJumpHandler,
};
