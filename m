Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14BC678DD
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 21:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355201AbjHQVPu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355218AbjHQVPj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 17:15:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B4D3594
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 14:15:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bee82fad0fso2026505ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306938; x=1692911738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1xDe42Zb4O1g25la6ZbpuaxP3YQAxL+qM/43yhn7u4=;
        b=aAnD+yQ6IXIXvqgfxPjHa3eQuh0LMSjOgvcikD2gU4WhmPjmZ5UKGdPLx9zVjdMWq/
         htAwgtscCm+le+2XgzbGGyAu0u0v25DSSdxStSrMki6Vmy7v4V9iAZSwWRcg46VgRUC6
         GBsKGsdXMR9I4jsHBGhPuW1cOm7H1PO49iZ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306938; x=1692911738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1xDe42Zb4O1g25la6ZbpuaxP3YQAxL+qM/43yhn7u4=;
        b=RRCsFsDPQhayoVln9Z5pVbPXJKUmXIQlIOSqmxIBPzJ6I7AmdC/kzBiMwfrwbhVNdf
         6uHjnCtwfwQAaJrjFYoqNGvFz7lFJ3ZxZGXxH4G0dhcimbBOol747eHug7eghuG/CoZi
         uqGOPGEVOxyCvfn8JQME9gDXeXEmXmEMxPPCOVMLUkUf0pCepYVCbnFTyRDbZ9N/dTZk
         jhtu8xIZphZizCKlkmn9F9m4UgUda6UL0TfSFIlpENpb/XfGufhxO4z9DIFCxUjwvTwu
         DCt9/xz3kLJx3prU34/LGPt3golqNfcC6bv/0xDpLKJngXSDGXVFIjQzrgJq1mOxKtHa
         YoSQ==
X-Gm-Message-State: AOJu0YyZEFjnQxZJcmJLwoPE7lvVW0Oimx6q/ho3IiW9OeLEpuGLjagf
        0tDqPrz07igMPgWz2p4ORjf9BQ==
X-Google-Smtp-Source: AGHT+IFi8O0i9RK0CHXGKeQfJM6qFoojgbvsRcV1oh+MbrP9SdGULKDsRCDtwXu5ebU7gX5iSPej4A==
X-Received: by 2002:a17:902:aa4a:b0:1b9:ea60:cd91 with SMTP id c10-20020a170902aa4a00b001b9ea60cd91mr614626plr.7.1692306938249;
        Thu, 17 Aug 2023 14:15:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b531e8a000sm212760pli.157.2023.08.17.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 6/7] wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by
Date:   Thu, 17 Aug 2023 14:15:28 -0700
Message-Id: <20230817211531.4193219-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=keescook@chromium.org;
 h=from:subject; bh=B1om6kzjnM+KYttPuLCv8qgp2sSo5I5ukw0vuIq7IR4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3x6e3yCDOyg/CnRvaTxYnwKpLSGmq9jMXbu
 Lj6hWgVrwmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 JuPqEACvZBjYWwE9vVsmWQaH0PScoxmrFrBmcCJVAXE9aU4a7P770PtzaGYD5I4idLwYuQstxsu
 hyy8i9VRnSI4ZhovMyvONu4Oa5vSGx30KKqu+EgYLel4gougy5ljNd62Ma1JJQwq/tl3Ib5VvtG
 b4/+4/CP1NIhwdhZGpdOCu9K6sbcBy/VllCKVkuohkOsR/LZWmQbOxapbM5l99ZKMlMtRi5Y4J6
 ZyNkLPFv5UCoX0UNCoOwjIf8TX7Re1URAq6OK74mYIj2KLLBcQQb6WtzVhqlhEy69NV6s9mG4zw
 aN7Um7gzgf/969aG7t0K+Bg7sMaFVyl4Q5j2/ibGo3dLnxRjo8NcXeI7nFByEoZzCr0D1pLlnvE
 WyiFXEPJpE888qd74gajJKkFm/VVR8Aa+rcay3qko/HJACbC7MlDGKVmfbYWDentPVIeYfLpBAK
 0zKQV4vVA+8Ni+4/N/CcXyEOVIoIEXU9gl3aOVSKME20mJd2/uEV+jkDQvzz3l2O3q3vg0iebeW
 oMZpUFHphqMXnfO+ecIAtyviIuuQ90a8AIu5ZFBzcnRmj44QZlSnICV33GdmCz1azq7xOUMe2Lg
 Nbedjr4+NY+tfEx20wxse70y+NoN5qmNSjxe027lWYKy1MuBHxZMamCWXthTi8bDNtm15bGhHWG GVGAyzyr9T5ndYg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cfg80211_scan_request.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6efe216c01d2..a2afc94a5408 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2544,7 +2544,7 @@ struct cfg80211_scan_request {
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params;
 
 	/* keep last */
-	struct ieee80211_channel *channels[];
+	struct ieee80211_channel *channels[] __counted_by(n_channels);
 };
 
 static inline void get_random_mask_addr(u8 *buf, const u8 *addr, const u8 *mask)
-- 
2.34.1

