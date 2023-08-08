Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9630FC41513
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Aug 2023 22:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjHHWsk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjHHWsj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 18:48:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63114103
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 15:48:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57320c10635so73806887b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534917; x=1692139717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+19GBVsvDAVjAStBWUAxMG4PPU/OGJ0H5JL5ZuTDef8=;
        b=33XuWQ+JZacYiunpRf/VpLL+ieGu6gFKhP/kfQt/A/PUBZLTtlxm2/2ie17ypqdLXY
         XZ7+ymtQ1v237YLPLscwE4bYYZtLPGAUnvBPdCwgT4CADDloYMGmBTI1DA7qAvS1R5dj
         X5875/w1a0yhqtAQvxC6fc6uFKRhNLsFUanyAesrsxo13nRi2pfWJejJ9tJxOcxd8dpF
         ueY3fqdWb4iOeEX+HcwPaNrfJYa2/TrdvsAEOpb205dHLWqEOgdL1jjKWHfUJjZd2v2z
         9oPx/UHQiuz+JRfRFEOY0zAGyBLscrLc721CcjSFpnolkANjOiG1ia1lj7+HQvcd3e7U
         YNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534917; x=1692139717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+19GBVsvDAVjAStBWUAxMG4PPU/OGJ0H5JL5ZuTDef8=;
        b=fxLRFdTVUQbYI6zNnyfnBGXTtXh+u5pU7Rq5vIcJyOvJnOuS7bJa90tz2KrocpB8jz
         TkYejJH3M/d/dvGNhYJTjfhmplsZF3iZ51FKBv+WaJ9BEJcewztyQ+9Lv+aKhpXywEow
         4SI9GKzuAeukekmZgygyDrL1k3rjGgUIlChBAjggPJpeTh3LKzCTgu6sV8u867D0q4qp
         I1+A/dpKxBPjCvK5+kJh6jCtCacvovcBMt45Fwo86wZtTfXI8BNmocJTNPVSDmarbtiC
         /pE1HCp7gkxeyDs9DFYq9EN1IJl3uKnW44d7X7SlT6PYgR+lI6iXl6z4v7hmAYmXOy9u
         oJpg==
X-Gm-Message-State: AOJu0YzzYwb8AA7VykBVRu3CtbbUkpfc+fhbMLywJm0z5bDQw326hD0v
        IM+4fHjzbhqT2ArVrURM+e8L5ALflPPMzL5eew==
X-Google-Smtp-Source: AGHT+IFmi1uCoUT8+dYsT7cZBMlrh5k6XVkXA76elJmMnRkNeuD4fuUb4fXU9XUyJeJrtDUUPIvD3QYnLXeDP+3YLw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:414c:0:b0:583:a3c1:6b5a with SMTP
 id f12-20020a81414c000000b00583a3c16b5amr23219ywk.4.1691534917623; Tue, 08
 Aug 2023 15:48:37 -0700 (PDT)
Date:   Tue, 08 Aug 2023 22:48:09 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=1607;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=GBQjyBthg5dmrMfaCEkr5QXSIAmXCZ5owhSbCo8Ik6c=; b=l4qPLd4+/BNAz/Lm7D/syXKR78TObwPJdYwbnpE7ksVaBVJA3lf0WqxSNnU3hcPfzO6VTlbM+
 dgb9SEDK59NATnse+FDklDxWNo24X2WOTSFQSKlQggwoEor3t6oFjrl
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-4-efbbe4ec60af@google.com>
Subject: [PATCH 4/7] netfilter: nft_meta: refactor deprecated strncpy
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

Prefer `strscpy` to `strncpy` since it's more robust and less ambiguous.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note:
I wasn't able to tell what the expected size of
`out->rtnl_link_ops->kind` is. If it is less than or equal to `IFNAMSIZ`
then there was no bug present and a bug present otherwise. Nonetheless,
let's swap over to strscpy.
---
 net/netfilter/nft_meta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 8fdc7318c03c..de8ced05a273 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -185,12 +185,12 @@ static noinline bool nft_meta_get_eval_kind(enum nft_meta_keys key,
 	case NFT_META_IIFKIND:
 		if (!in || !in->rtnl_link_ops)
 			return false;
-		strncpy((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
+		strscpy((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	case NFT_META_OIFKIND:
 		if (!out || !out->rtnl_link_ops)
 			return false;
-		strncpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
+		strscpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	default:
 		return false;
@@ -206,7 +206,7 @@ static void nft_meta_store_ifindex(u32 *dest, const struct net_device *dev)
 
 static void nft_meta_store_ifname(u32 *dest, const struct net_device *dev)
 {
-	strncpy((char *)dest, dev ? dev->name : "", IFNAMSIZ);
+	strscpy((char *)dest, dev ? dev->name : "", IFNAMSIZ);
 }
 
 static bool nft_meta_store_iftype(u32 *dest, const struct net_device *dev)

-- 
2.41.0.640.ga95def55d0-goog

