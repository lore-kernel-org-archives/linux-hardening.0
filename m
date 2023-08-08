Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2D9C04FDF
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Aug 2023 22:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjHHWsi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjHHWsh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 18:48:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573CC10E
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 15:48:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942442eb0so73698097b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534916; x=1692139716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB/bxoqLSL/ZtMTZ8dV/jChYqo6p+fCOGWCHHtspAU=;
        b=l0+YZUWT9MVORUoAKyZtIiSvH9yjrNYKYquI4h6G3Bw2EZqzd31uHqgRU63WUeJiTY
         CpJguIuWZtSwCxzXZL7m605eZS8Es5f38S3flkVmk3kM8LB0HvSqtkdI1c7Z2AyBkGtq
         5NfO/1zVNGQ5YGvx0dhjCckfQkOwM8SuFYDezhYuUQtB+xJ3JKUpKSCYccD2Z2qKxi22
         OO6RsTdtADjOReVX0UY1bUfshvROIJWuQWuJYZtqakkYY3FJ3grYtZbKyVjGMV37v+ur
         OCp34anb+2N2Kvfjr0/rniDTTRMNJAKTjeHOC8KCmX2XwY+Iinw733StNw48QbzrItoa
         QVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534916; x=1692139716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB/bxoqLSL/ZtMTZ8dV/jChYqo6p+fCOGWCHHtspAU=;
        b=eNE5EKbA/ZA3SDYmuvnSCPYx+1lWpzoMtKH+fs/uWj9CHpVmOVIvtKg+EhxbTQyHau
         lrRXVgeahDUfWk8dcQ6jJqYaoBtxGWAZrO3V1uE21zG+CYLP+or/AuCmKMr80vbB/CTC
         bVa1OSMavFsb+pjhlmUfLsqclFaL0+b/aLT4WYnSKkF1r47gAwluIRdOFf2QKxUNK9A7
         uYMdnIEOR1I+oJ9bWHSNC7Yj74fLIRSseyw2NWdW1BsFEjcwSh0RFv/RGCzmkoUQsk2x
         zp87VIttOF5WXlKfBONd1i15+da6YBJ4+fn7KbM29wkdDuDE60xKRGgNL0TSF+xRMWgD
         5jWg==
X-Gm-Message-State: AOJu0YwSq2/xsxhhpLosqouTvQfa6s6M+rbC8d41412XwvBh29jxOX3+
        /HXQtPiNRWPVbLUZ8iN8niGXYYvvpkZg58+jYQ==
X-Google-Smtp-Source: AGHT+IEZqIi+KfXakktMR77yvcqvv7E79OwhtWF6B0zRs21LhdiLRA3ymZOhLEcubECjKuLZCFe6Vy5Az1cpq5gVng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ae05:0:b0:579:f832:74b with SMTP
 id m5-20020a81ae05000000b00579f832074bmr22779ywh.10.1691534916696; Tue, 08
 Aug 2023 15:48:36 -0700 (PDT)
Date:   Tue, 08 Aug 2023 22:48:08 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=968;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ql8BKCTJsc3POKLEq/ADab6DF9AYOTL/azd4EamUBcI=; b=P3R80qBBGIzHAbifBNpGmUCEncCAPqmEwus6LSS+QDg9lMvg2IHe2edYrrt/QOZp2p4frMdd+
 ACoDi+vL9tDBW4ezE6keUa+9XyhIWr0M32IT7a0qKJXdIEfk7Y9a0tM
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-3-efbbe4ec60af@google.com>
Subject: [PATCH 3/7] netfilter: nf_tables: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prefer `strscpy` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note:
`strscpy` is generally preferred to `strncpy` for use on NUL-terminated
destination strings. In this case, however, it is hard for me to tell if
the dest buffer wants to be NUL-terminated or not. If NUL-termination is
not needed behavior here, let's use `strtomem`.
---
 net/netfilter/nft_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 6e049fd48760..f1a3692f2dbd 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -150,7 +150,7 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 		if (priv->flags & NFTA_FIB_F_PRESENT)
 			*dreg = !!dev;
 		else
-			strncpy(reg, dev ? dev->name : "", IFNAMSIZ);
+			strscpy(reg, dev ? dev->name : "", IFNAMSIZ);
 		break;
 	default:
 		WARN_ON_ONCE(1);

-- 
2.41.0.640.ga95def55d0-goog

