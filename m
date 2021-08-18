Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA1C432BE
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259D3610C7
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 06:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhHRGP4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhHRGPw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 02:15:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C09C0363DE
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 23:14:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a5so1150417plh.5
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8hLOmyndrZpbH3W//YQN6YJRgGYlYr4YiBW+Lc3AF4=;
        b=ClJUrT6ApBH0phA65aDisj5+kyHerJF2/GgwYf6sYImzafPzHckhYzZodOxI7uhCpI
         vpe004kdrf64A0lB+HxzctUtSU11uTF4QZRwPZLG5yLy/UjnyJdf52u/HU6dj4zxkdJI
         26TEVOy51sB8cue9oxYDxzhyCi71TMoiQfP2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8hLOmyndrZpbH3W//YQN6YJRgGYlYr4YiBW+Lc3AF4=;
        b=q7ZZVgEomKMMLDWC73AFVJWHAkJTNBlvaACekThVDmRz6T6D0LLX+bx4KFpLkdCVtY
         7DpSSXZ3tUNjOwlXR/syD7kKoUSSt4zTgxHMwxEH5s3Rqiy9VBKG9r6Ma3ffU/eWQGct
         4B+V87KAKN02fZGwGx5AdZrlxncJp1HE8KMpnMPHD3EJsmkWyQANx6wPyJ6bX/uhqksA
         RHXyU/Da6pcjD2rmooGJtisKSiCfgNhnLNku/xzbIx3v3LdYOxfpXXs4PLVpKf2ZSUjS
         vVITc08fcdWgLSzhQkOOJblyKjQYldB3VTKy8e9HDPC+kbuBFfGIXtIHWGQYB4Tyi7hz
         jHPg==
X-Gm-Message-State: AOAM530b2XFC0fBWj0Qg1uX815ublTa95bD0z6/WPHUVyq9YXyeVsylP
        Ls3sEiGG0zHrfp2jc4MyGrpRRg==
X-Google-Smtp-Source: ABdhPJwRPPIhR63YQCS3nZeOodK84yxk6DTCJU5/GeqbIYAqZWORFkCkpfMsUc8DkqkxWPqp6Ivd9w==
X-Received: by 2002:a17:90a:3d4d:: with SMTP id o13mr7935552pjf.34.1629267255044;
        Tue, 17 Aug 2021 23:14:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f5sm4570524pfn.134.2021.08.17.23.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:14:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 40/63] netfilter: conntrack: Use memset_startat() to zero struct nf_conn
Date:   Tue, 17 Aug 2021 23:05:10 -0700
Message-Id: <20210818060533.3569517-41-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; h=from:subject; bh=fE+HPCTs14JsaXA0VZ1+azTXm9sRPSgAjXFdw5wZMQo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMn9jUxUjmhnSM6V4Tc0qU7XODXJhF3t5WIJd3Y koV1FpKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjJwAKCRCJcvTf3G3AJhk3D/ 9Y7TD9jWlZ06v+vvdPdc8QlSMediOUFC1q3DoYi7bvc4YyEqXGUCbEBONwNQLvsK3hI4ED3PL+2IhD hz/Dbx5DT2T40OMCMycZbUmvAgn6pOBBpw2q5g7L1MPBPiZjTMXq8E4ovppbe62BM08pHEnfAugWsL Vg8PPE0Mpa5a+QOsrBwIXi58FdhL+TgFoZSeBzbJm+KmZX4h++dF5E6mfecc7iWTRI8x9S8/YHdEh9 ZIb37NLdJeVivXFEuz3DfGGLCuGfbSDNomkElBmWe2yPoHWjEkJTWn6RNq+MEAjA9TJ5TJ3HDso1/K sKW9g8e4L1L/rtxaFXF9BV/xpTwz0kRs0XsBqZ+kJVDfducMf0ve5e9o39+ZRvnlGz1cBPnku+/z+w 0bwBKb/ZheH0vYU+K8EWpKneqiHfpTz4StFzfiQRwhbiGP3RgP5fcXs0kJTQd7Pb2ELVtqLcT+gjk9 6GhJhWeDD/p/qHw7tNmVAq61F9fgKxmA+c7cUPkuWqkaozXqUnyya2WLhQ5LvSbSIIu7/NC2yfZ+vB 5nw/neLBHyCcwQZyeBRVjmkcwXCcmWSOAeUgya9iGsWYJAEHUAkIzm1Hk4kcF6HSJmjPw9ayH8RBkV zBGERJvvVpyPFtl03OuHfjGRW4wn6Zs+wzWO0oB8CiPowPcXXUv7O9y+3+xA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() to avoid confusing memset() about writing beyond
the target struct member.

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/netfilter/nf_conntrack_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d31dbccbe7bd..060503230519 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1500,9 +1500,7 @@ __nf_conntrack_alloc(struct net *net,
 	ct->status = 0;
 	ct->timeout = 0;
 	write_pnet(&ct->ct_net, net);
-	memset(&ct->__nfct_init_offset, 0,
-	       offsetof(struct nf_conn, proto) -
-	       offsetof(struct nf_conn, __nfct_init_offset));
+	memset_after(ct, 0, __nfct_init_offset);
 
 	nf_ct_zone_add(ct, zone);
 
-- 
2.30.2

