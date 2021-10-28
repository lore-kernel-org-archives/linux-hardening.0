Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18422C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 00:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99AD610CA
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhJ1AiC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1AiB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 20:38:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF846C061570;
        Wed, 27 Oct 2021 17:35:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v16so3191695ple.9;
        Wed, 27 Oct 2021 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3UTHkAsYPEB52f7zz17R8yc9UXkkpLLy9VQI7Ai275w=;
        b=g7gWwpxrpAjLZub1aBALSl+itvh+KuKGGlFvXmzADflMh5wsnGZjR/I1alqmy2qALL
         AYMs7yharJz2u/37nMbLrSjNgLnM4+ivDXzDp0/ZrNUsXSM/VRDYWqg/D5llL2/lHVkj
         cmVU+yRTzlSIxxN3Z+Y+G1+cf/lmxLMkRNQB5pjsHzgE5X0GHESTbXi8DyngptgNSETR
         1qAhCvCxgrd4JYrXPU1/e0j0wFNRGcej68HbTQq7j6PS4qHCEOJ6EbYPmKOoyQFZ1nZ7
         cirpVipcR0JuQ9BAxSdClnWN/O6JALxeRapxy/8kgLn8yFaHlQ44OWm7+7v9+XAHT4eh
         ZTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3UTHkAsYPEB52f7zz17R8yc9UXkkpLLy9VQI7Ai275w=;
        b=zxmYqKsAl0a28x2JGMvDjvA4aAV1SkBph99PLer98AqbxgRngyJQFECdwNsNIIndub
         VIeNcfFbrutY8XJLl4h1Vpr+wiMtYLt7QtZo8hFh0pKgPPsiE679AlrfncWmE1Tz5lPq
         OKCEiuvqre2lYDo9I5oDWEgAdDn566zaV39mtWnBgnrBdc3vk5fL4cfdYfzrHHYkmqzt
         8DD2ioNxkoOfq4zHt4UPOxxgPEPrYneooQgzQFHKOrdBjfmm1fS3mw9sC/R+yq7g9f2+
         UXCeg6Chhll2rGZ60UHx7N81V6qpC3pZ3kyp8AYBuKGdXRtM1RdlPGRzUJwJkWVQNsmx
         DblQ==
X-Gm-Message-State: AOAM533b2gk1B2RXRt2DeT23nVExGEfukoOgFuK10jmeCEu8R/xEgX+n
        i2fxXF+b2pXlPhSAf6B9BmA=
X-Google-Smtp-Source: ABdhPJzKiXxM74Zu2RbieygcX+4cu/ZPHrI2bJ6FHwS60+w0cGs3FspRFSJLdyLk3rkXrE7/De+NDA==
X-Received: by 2002:a17:90a:ae18:: with SMTP id t24mr1038803pjq.92.1635381335317;
        Wed, 27 Oct 2021 17:35:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id on17sm5546605pjb.47.2021.10.27.17.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:35:35 -0700 (PDT)
From:   Yang Guang <cgel.zte@gmail.com>
X-Google-Original-From: Yang Guang <yang.guang5@zte.com.cn>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: use swap() to make code cleaner
Date:   Thu, 28 Oct 2021 00:35:26 +0000
Message-Id: <20211028003526.7117-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Using swap() make it more readable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 334741a31d0a..feee5ba8fa2b 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -244,11 +244,8 @@ static void full_shuffle(tree *newtree, unsigned long length, ranctx *prng_state
 	unsigned long i, randnum;
 
 	for (i = length - 1; i > 0; i--) {
-		tree tmp;
 		randnum = ranval(prng_state) % (i + 1);
-		tmp = newtree[i];
-		newtree[i] = newtree[randnum];
-		newtree[randnum] = tmp;
+		swap(newtree[i], newtree[randnum]);
 	}
 }
 
-- 
2.30.2

