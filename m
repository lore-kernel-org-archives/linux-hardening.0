Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED2C3DA7A
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 21:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjAEV5W (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 16:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjAEV5P (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 16:57:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38FD67BEF
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 13:57:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c2so13193320plc.5
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 13:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1UYEX8MsU4bEwMmiObVLxS4IPZo14Y0LIp/cyznldk=;
        b=HeOcmUiOtWV1+8PfRES0oRY+JONWF763kwgst44lTtXBPkP94fxrZ/VZYs1Kc/dGHr
         ikhnYe/UZqdVoOyCKb1taN3k4XST0BroOrYGU8yLnocvufrCNNLpQTbYCBoEgN37hKxW
         iBVkl02D5ywyFnBpZBmIPNf9xAzVMYo6varak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1UYEX8MsU4bEwMmiObVLxS4IPZo14Y0LIp/cyznldk=;
        b=PzLiSBjuxS19OCMnsyr4jd8Ru++CdCOVO52xB/qtM8tt//NxVmtBh6W5KT2Fy91WGY
         hZexdSDoIwedIwXFqgZvlZnH4CG1t5v2uht+9EpaLS01ASGr6YqUuZHshU+XVzQHCvm6
         MdwZOfgqZnaLE/TkXGU/TfjV8LSPh6vEnjXJXjc9rcyinWm9T+gH/dzqW8/80iYpJKYU
         P7G0wBnjvsHR47dK5NAWoBZvSXbLNvoGa76JqBu5iXcmWqsqzUwVFlSk+vCx4vKf+sf5
         pAkEYYTGiE2ymh6ILhLAUVqCUwM22GKXJPU9gU1yNmjENfbOmrJsTIirbCFgzwqUi7o6
         ivSw==
X-Gm-Message-State: AFqh2krIPU75VI82avDu/X04PWEbVYZAPkC9MRn6fzDnWktB8NHZH9fe
        NLUsLuHCPFAJCvmOQW7jVs9/Gw==
X-Google-Smtp-Source: AMrXdXueJ1DVqXdVd9VL++Pz2qLYn1lYHEjbYN+F/piHplyn9OgKa+typNH8nRU+fQOu7q7m7eM5YQ==
X-Received: by 2002:a17:902:c10d:b0:186:8568:be7e with SMTP id 13-20020a170902c10d00b001868568be7emr58800196pli.15.1672955833062;
        Thu, 05 Jan 2023 13:57:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b00182a9c27acfsm26530709plh.227.2023.01.05.13.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:57:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: ixp4xx: Replace 0-length arrays with flexible arrays
Date:   Thu,  5 Jan 2023 13:57:10 -0800
Message-Id: <20230105215706.never.027-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; h=from:subject:message-id; bh=SvmvBLYwxKSOzLUuSIXZGbFL0TR/DpojohZSWMIMbSc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt0e2mOhkRvq1+sLpEol9eP3fGihD+cgpRMXX3kfQ mo/fQ/CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dHtgAKCRCJcvTf3G3AJmNKEA CoyZFzSYOZhQ5WleBkgUiHN1VwMNfMDvAmZvHcBNNPrnJYotSJw/QQscXFATgy5YPR9siAsQmysnZF HgoeHixgu4YBzaWQFZqk6+WQ3AzzY/8ynXTLwYv5uT0bSVtbJZIGl0xA2PJB407F1hfKb9h2BVtYlN 08nrxwdoEroAyxJC+S/PUA+F+DJ3v6x3u5ZgljnOWKmsg7s5MtzqRY8Ohd5r2dr/qbznZEfruhpcis mNwAq5oeoI0GwY3SoLHsF+O86GxNJA4T2DwHVzuMWU4C5Mor/uFA+RBzx8E5704CxeTAjtJMaZl7Ua Lj8VMJNKCHJo+gByL2l8wCZ1F5eGGuYFGDXHwCJO6V1edVAEpIqu9aOjqTc3WgLRtvfJlN0ISpwwDi bURxiAyLk0K09+01tJ1G0G2SmHvdZ2fDX1k89aI1J/Yi6wDAicfVEpDl6sCblrWQBpQLwJIeVGho4O v10LrSl5ZOcTLttRbKsyXXpVeqYymYq0kd1WiuM3QG3AYh6oZ5/kOA2BCICN2fSAWjCqX6W9GMlTkg XSjO4kRcAVimU4UMA+d+J7hidWAAtzPz1UyoHXBRbpKSa5MKGPoINK+CU14ahy3X5n/8BzbfJAnXmU W4UJFUYV6h2qUPgjFxg9h3e/1VrLS+cPWCCoJ0gd07CzarY77tjsCnBf0L1A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace npe_load_firmware's
union of 0-length arrays with flexible arrays. Detected with GCC 13,
using -fstrict-flex-arrays=3:

drivers/soc/ixp4xx/ixp4xx-npe.c: In function 'npe_load_firmware':
drivers/soc/ixp4xx/ixp4xx-npe.c:570:60: warning: array subscript i is outside array bounds of 'u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
  570 |                         image->data[i] = swab32(image->data[i]);
include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
  115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
      |                                                      ^
drivers/soc/ixp4xx/ixp4xx-npe.c:570:42: note: in expansion of macro 'swab32'
  570 |                         image->data[i] = swab32(image->data[i]);
      |                                          ^~~~~~
drivers/soc/ixp4xx/ixp4xx-npe.c:522:29: note: while referencing 'data'
  522 |                         u32 data[0];
      |                             ^~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/soc/ixp4xx/ixp4xx-npe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index 58240e320c13..5be9988f30ce 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -519,15 +519,15 @@ int npe_load_firmware(struct npe *npe, const char *name, struct device *dev)
 		u32 id;
 		u32 size;
 		union {
-			u32 data[0];
-			struct dl_block blocks[0];
+			DECLARE_FLEX_ARRAY(u32, data);
+			DECLARE_FLEX_ARRAY(struct dl_block, blocks);
 		};
 	} *image;
 
 	struct dl_codeblock {
 		u32 npe_addr;
 		u32 size;
-		u32 data[0];
+		u32 data[];
 	} *cb;
 
 	int i, j, err, data_size, instr_size, blocks, table_end;
-- 
2.34.1

