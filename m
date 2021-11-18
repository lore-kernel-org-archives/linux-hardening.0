Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF7C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB17611BF
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhKRUeQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhKRUeQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 15:34:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA142C06173E
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:31:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h24so6112805pjq.2
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcLB7MvG3K4Ke10h1bINRCs3q+QDRcCT3lfYvCR0Icg=;
        b=eF6YFsU21ZNpUT9ttG8va6xfpqx992IvMr6iI4uWNx3Pi4DmcbDIos4Wu0d7fCnbOa
         2i0Q2JaqJO6RFFFu7I3C9jpN+/7Gfho/SD4r6QgMcQxBKiyIpei3Irq/AsGzMdTeNNPi
         qsXM+DEypZ3V0IH04X71UaBa7n7L2U77ZXVyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcLB7MvG3K4Ke10h1bINRCs3q+QDRcCT3lfYvCR0Icg=;
        b=qzKkM14gHEIUXJSxi7XyELIB75QXFu0JordO3DgkQOsCvmEiOBLFk5BnBHF0IB7YT3
         GWHp3+nnHSxo06hlXFY1zgFF+SgW0o76bUBFyiGEkBFg0M50SFFgNt38ggdvSpAvnKuR
         FnJXaeB5hXycPApXY+nJD7pXHXg1hHMWjuDbFc42C1WYspn6w0CxHpbawbZvsHhANlFd
         yPcGnCKJSZi+vH2/358GHcoxPNdOJBWZbZrAiiecbZYnzBQ9To8S3Xk/cj50/4kwTBWV
         j0NWVZPFtNqKi8B5+Gubu6kofb4/JXkITqLT4ZDbV5NNHLhHm/NHf06WchGHM7QIOJW/
         6OHA==
X-Gm-Message-State: AOAM532VY1xpKpp/YoLCgp9FIjeI1y2CVQAJdI56MT620F+hAMLMXhqj
        reqmeLMtj/ue3+R4nm9d4ZfIGQ==
X-Google-Smtp-Source: ABdhPJzRya15wHW2UAKLnXUjjo2OcJuImXw4tuyrV18/sEsTXSQY7dn3QqXgLgUi5g6uysZtaiNrKA==
X-Received: by 2002:a17:90a:df83:: with SMTP id p3mr13827388pjv.145.1637267475336;
        Thu, 18 Nov 2021 12:31:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm453059pfv.136.2021.11.18.12.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:31:15 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] netfilter: conntrack: Use memset_startat() to zero struct nf_conn
Date:   Thu, 18 Nov 2021 12:31:13 -0800
Message-Id: <20211118203113.1286928-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; h=from:subject; bh=8G8ELxCaYyImypCEBWdgERqa1W0PnBKrxOA03FjrnuI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrgQ81go+amAV4Ra130N28YvcOlvVMevTi2OsK0V PP+vTgmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa4EAAKCRCJcvTf3G3AJhlGEA CjA7esHrkQXRc1xiiREdoZsmG60wWX92CFRgE+X8+C993iK8CaPdrfi+8Rhz2iOksVsnAYaNX8DR3T jKd0zhYJMa7TtVHL8OMDF3GCDJib0UYXjG1ocqe/hwTOyyANGytLztehRyHb7B7Kb1b02ea+gw65wW xjiAan5E9RVw90+50uTGqkK9d2GfBsv2XcF3HEXzhktA0zkH4Aurk6CtKXr8Xprwysw32Xc9Omk8Su ARAP1kfq+qgC+vKE/wCvXvSEJ0xYbq959PtCQW41dbwGQTYiPvCNBc2zs/lnuNEwqr+D7ZJ7oFg5ct 6ftzPlVwPlX5ij7oit5cn9nSXzMlvAu2MCBlQnRij4gi0VTWmbdUNh5q1tQGnEk90rLXrfom5OGd66 /F46gyg6mlZi0u6cv51ZtnacUdXkjVSZfaguaj3I4owqxrNcw4LzyemNqfAHEcLAR/Ra5feQB8Ovjx jZe/OEwgFXlP+LeVKvotPY45hztqforSJyNLWlWsCopwG7wyt0uZKXVApXDKR39N+mMy41d1nRitT9 Cvb3wb5aH6OPXhaQ6BfWwRAzWtnvOmVSd9K/CHbQtRw/g55Qt0jT2raJQQlGD9oCarRkGQeA2wfy1o JNg+0TmqxKV1SHFoj+KWXJbJvzv9wT6Bt4kbwdO1rEkoaojBo8A7ObRgzmeQ==
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/netfilter/nf_conntrack_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 770a63103c7a..cdfb63509501 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1562,9 +1562,7 @@ __nf_conntrack_alloc(struct net *net,
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

