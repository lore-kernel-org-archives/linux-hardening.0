Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBCEC43216
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6630F61220
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhHVH5j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhHVH5i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7751C061757
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a5so8384001plh.5
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KeRymW7dpjbPF0p3gK+nxzTW84+DhIw7kOz+lQywMZ0=;
        b=GtqbJu9GeClCLuX9kKSu6AhRGxUvezMUT8vQo9fmVoFBFpFdDwLQeC9w7zVGHzwZVs
         fm2cFLchpTTPvW/jKqNYwBKtia6/BEPXlsXB2QK4X/r/kVuB3K05kOGWQ0AItq116wzt
         5YEVQMp/JqDaE2i4NCCQOiVmK7J78FfNN3xTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeRymW7dpjbPF0p3gK+nxzTW84+DhIw7kOz+lQywMZ0=;
        b=cPkv1bmAaPflPvJ7tdxPi7wLTzRZnFS+/e+FnZn0XhaKPxHF7gZzP+TP09rkQ4xy4F
         qN9GyA0SBOZ4i/auQJWtW6xnsy3v24DGs2ZnyMZzZ8ChuSLsKqt9RwB3eya1iuh05ROq
         nM4wb0VmcOOQBRrQc8fiVLCe7zD+Durj5EycHfZmEOHavFyAG5q7Svj0BdyDYka7zRS7
         wmgyFN5VdMSm6CuSXBifY3jc+hpzjyIVS19p2k8BGZnTzgJc46UChe1efwnB2ezc6wZs
         7Q+PGjFxJXkIZ0bwpHlD9AlG+o7FG5zufCKghgiJO24QYMYS+Fkb6jMk256hhnp4j09l
         tYrw==
X-Gm-Message-State: AOAM5304/GIexFjXbXQ+CnKa8SS17autHt61d8RYQJwmS+4nUi2MZ1ML
        /iM5TFFUTDw8PWySxW5j7w1qL4Qlh+wZjw==
X-Google-Smtp-Source: ABdhPJw5qqLxbeIMdz9bpb1faLEb3miaokOsGudL8vTF5FOOAvB47FOTI+E5A51WIiKfocd9oLdolA==
X-Received: by 2002:a17:902:ed8d:b0:132:39c7:2e1b with SMTP id e13-20020a170902ed8d00b0013239c72e1bmr5655204plj.78.1629619017358;
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e26sm12137313pfj.46.2021.08.22.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 23/25] xfrm: Use memset_after() to clear padding
Date:   Sun, 22 Aug 2021 00:51:20 -0700
Message-Id: <20210822075122.864511-24-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; h=from:subject; bh=U7PaWYEfsXfIcToHk3c5jWu69loxq4nonTzrBaorlEM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH5KReKo4xPiA+igvESV/+YjCKmaMo7h3r3peg5 oUkpUq6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+QAKCRCJcvTf3G3AJm2UD/ 98c2p0Ikiqsfy0j09gDXjeb7uKt0hgg7w53Nm+FtEIpYiAbu2CuvI+bHrR+SD7yUMm1+vjr0vc4kcd kZF7jPP29ob7jRgTAFK21qeVCgV4H6OnLOuMGLybTf+p2Z+NTI5pBMwPKdPH1xsMWx+g1eOje4vvFl l0yXN7kbBmP1M+Ra6Ag+4zagN1Ev6Laj3DgeUP/bTFZ8EA7g5kpRr7c+geKPv1VVuyAcVJ+nep0Q/b KYL/q5ggAniSaDOdrr8b2MLWPZ1lrZQEI80Ou6KpNLFSwDdYwFWK250WDmwvSpUPsr5+YPkIapRC89 Jr4Ent2s1dBrTvzGdA/vNUbxWTBYFhYu1+7Ddch+R9FEjI0ePfXW7UhAoXszw1pxzSTd9u2wpyNzW1 i99sojhrSCSWj2+6efx7Ibsm/MPHcA8Ufy5Zd0YX5kjFwE2ZTgoY9FqOuPowQ4nPwXNOhi2ncSuJ49 +FHMc8nTHMmxpRxPcvv01N2GiFUy+iQiXXh9a65TVwmOuxSlOPlYfRUJQ2Gq8nzBOnfzodozrzRVNg mx56HetgdfRArbIMBbUaPP4/eP655rDJIJt9SCjxvLO+flWZkKsMn9hDOno6/nZGQcqqWhoaq1coCe FoDJiZU5nJHDzMdZhRBY57wuh+PEm24MXBWCaRW25xVtt1qVqUQbnw2Vyb0w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Clear trailing padding bytes using the new helper so that memset()
doesn't get confused about writing "past the end" of the last struct
member. There is no change to the resulting machine code.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/xfrm/xfrm_policy.c | 4 +---
 net/xfrm/xfrm_user.c   | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 827d84255021..a21af241a2bb 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2494,9 +2494,7 @@ static inline struct xfrm_dst *xfrm_alloc_dst(struct net *net, int family)
 	xdst = dst_alloc(dst_ops, NULL, 1, DST_OBSOLETE_NONE, 0);
 
 	if (likely(xdst)) {
-		struct dst_entry *dst = &xdst->u.dst;
-
-		memset(dst + 1, 0, sizeof(*xdst) - sizeof(*dst));
+		memset_after(xdst, 0, u.dst);
 	} else
 		xdst = ERR_PTR(-ENOBUFS);
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b47d613409b7..880d260541c9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2845,7 +2845,7 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
 	copy_to_user_state(x, &ue->state);
 	ue->hard = (c->data.hard != 0) ? 1 : 0;
 	/* clear the padding bytes */
-	memset(&ue->hard + 1, 0, sizeof(*ue) - offsetofend(typeof(*ue), hard));
+	memset_after(ue, 0, hard);
 
 	err = xfrm_mark_put(skb, &x->mark);
 	if (err)
-- 
2.30.2

