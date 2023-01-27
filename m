Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A312FC38142
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 22:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjA0Wle (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 17:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjA0Wld (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 17:41:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4217CDC
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 14:41:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jl3so6401484plb.8
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 14:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbdmC1vtTeNkMV/JDNk6jpfYAsIwfc685zUxtxSiBBw=;
        b=NrN7vxLTGyvO6uVWeymoBbvSZChgu0wl3/4eS81NaeK5nKnOEwqh7tWUGSFzLTiYoY
         ToqsDJVrkOe6tHI3NMHl4iHOPvIvOslTsEh5lE8QzPg9jf1PhGZ59AMg3TcN9XUPiekX
         84RrrbFSIa/dEB66Ge+4IqrE1gXKvXbKCPJzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbdmC1vtTeNkMV/JDNk6jpfYAsIwfc685zUxtxSiBBw=;
        b=oE1diCtZNKDCoBxyOzncp5hBMe6DaGM0HGF2gsR6xRgHA1vcmuuofccQbvL2PSv16o
         hlwCSbYMy+Cr26ntJHkwHcI4CPi/XYROvdkBLC0PJzvl5uRkGnb82BOwRZznhjoOjLRB
         kmGuQWoCZ5Y/1BBAlKRNg47rHzO+eZGQL8deW44qW4MYtmu33zwddQmnD0QwhAWoybK/
         23V4oQKW4b/0aE1K8fdYejllQfGVC9gNqdMASCmLwZTRDdFApDgQ5jEdUggGPhvZJGzc
         bl07apO+YY5doUEHS7lQfVeP0nXZXufFNAFnIMB0beYHTw/k+1m9JK2RWrlhYr74vgfx
         a8Mw==
X-Gm-Message-State: AO0yUKU/2JoZglkyGGhpWbEXO2pbNQftcUU2LDz20zW92LJwkDfzJblj
        WfsVXkG0ihIyziKJN9m9s0OsbT8hzH6635ir
X-Google-Smtp-Source: AK7set9LJOkOn4dsUKb0StuHaEgdZ/trComh6kyrxrN3czUiG6SjF/GeYmB55aksjq40ff0ywVthVg==
X-Received: by 2002:a17:903:200a:b0:196:63c8:6aab with SMTP id s10-20020a170903200a00b0019663c86aabmr531198pla.40.1674859291321;
        Fri, 27 Jan 2023 14:41:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902740b00b0019608291564sm3347808pll.134.2023.01.27.14.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:41:30 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: kirkwood: Iterate over array indexes instead of using pointer math
Date:   Fri, 27 Jan 2023 14:41:29 -0800
Message-Id: <20230127224128.never.410-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; h=from:subject:message-id; bh=Xu8o9SUYE0MOFc6AyoZrAkbURoocAqE9mPE+RS6SAFE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FMZvw7JrK+Hre1S3J0c2nerchfvDVjsKmG/daEA pKJu5WWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RTGQAKCRCJcvTf3G3AJoe0EA CEZJVtR7O3OZgY1TGui2btSTO+vJSmKSXn0g5hN1UTnz3/qSCcE21HjE4yWkAUS6CQZEGm5gEc0d1E U4ztzIz9g5wm+u3WnhCWFLNv1/UIE/I/5XDFRgQWnqYrTG3liPv7GUokFPgmT04tdSfNiwMlYI0kMH J/PUp1J1sURLT+3mBROpqar0kzR0MN1qV94+RcwEUkLPMHxFzcQtza7WfbKXLvhRo62UdCbDU0YSfX n6ShZoREPOPRHLLPiqwcbkyii/Djxc6mrya8BiKRhTFLxExIjiDyUgu99OLnf5JDiSow0+WRCk+wp4 tA1HSiPXz5kvsYQTMHwawn4A92PehZYWu7k2krTl8Ushlq6ih2jRgBLtPxOjw26j2jsu914Kvro0ad fuL/z7hqSoLTExjTdomgGOEhdmcLO5RBA3ZSX5X8K+VJwZBKjk8CMe/9f0ndgwcgCIk0P4DMu7eIJx CPMJyQSu+bkQPGM4mPNx2DALfpHd6QJ9bMnJCcwtW30eAfcXvcN9VrIqbad/Lia3nMFslib2Tbt5O6 33PM0OMcUiGbvz6luZ/agAtGtOI2gN+Ud7DkQafxloBfI1eV3Q6gv7PNWYHcXdRqv1kgIu9X6qO7qz HBoOBABUc8IIi0D/LebAFBUx7zCIWndRPt3a7If+2K73mECdg9UQop6Gh7Xw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Walking the dram->cs array was seen as accesses beyond the first array
item by the compiler. Instead, use the array index directly. This allows
for run-time bounds checking under CONFIG_UBSAN_BOUNDS as well. Seen
with GCC 13 with -fstrict-flex-arrays:

../sound/soc/kirkwood/kirkwood-dma.c: In function
'kirkwood_dma_conf_mbus_windows.constprop':
../sound/soc/kirkwood/kirkwood-dma.c:90:24: warning: array subscript 0 is outside array bounds of 'const struct mbus_dram_window[0]' [-Warray-bounds=]
   90 |                 if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
      |                      ~~^~~~~~

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/soc/kirkwood/kirkwood-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 700a18561a94..640cebd2983e 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -86,7 +86,7 @@ kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
 
 	/* try to find matching cs for current dma address */
 	for (i = 0; i < dram->num_cs; i++) {
-		const struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = &dram->cs[i];
 		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
 			writel(cs->base & 0xffff0000,
 				base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
-- 
2.34.1

