Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF735C001DB
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 01:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjHIBHx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 21:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHIBHq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C41BCD
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 18:07:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d4e1be2dd10so4264637276.0
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543265; x=1692148065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9SxK9VuBhH23JZNfwlmHxFJB2H3YTPscUMoMvn8rbc=;
        b=APutyrGHq0YTWRW12pm4MFQuMqAXqr+kMsiQqH/8WklaM3Xjxt0HiR27YbGJXqvEjY
         6eEjM3eABJspnPyTNt2jI/9l9gN7s6Apj1V2bXUTaQ9tTsvddYK9toOP4z76HqRLSZRt
         YGmlC9Xkgtbj7ra6sGK/3pWh9mFaoc2xFXx4337GwtDA5PKpGMb1+DX0ndI/f5JOPxAW
         HMPJIJzRPp5qesMCm+caWpzVA0W6/0vT9s9rwk6lxg1NsIvYmVYxdiqFK9rq1it2FYIe
         /pU54CocziwXtDHFJpS/JtamqtFWIYrqhcgDztGeQ4O9gGhnrH7m3upujJELrSf8X8L/
         U8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543265; x=1692148065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9SxK9VuBhH23JZNfwlmHxFJB2H3YTPscUMoMvn8rbc=;
        b=VqlPQVjZZ1AsJ1wZAFNwZbR5s7ciwFFWw6+UDadLB/KdR+muE5jLJVRzJyZ8WMH1Su
         v+1fyUZHVj+V/rvM4rDrghg4Opp0u3PiPN7VaHZUVhk0jxW+/AAzSYqRFDOQQ/NkK7RW
         Hlsz+LE/zL9E0FD1u0QaemFnben6jLk0aAMANkBFjOjkU4yjQzAfgUqTzgMUb/SiGUTI
         G6QSBe4vFG+WxKzPFRFdEgFCmxnt/OKtAUyQAbMsGcOCNg4BwAClnbqYNp0gFHX0IZyY
         X48yqq4pGJqHB846vS2yuRw9NMQyHSlqJbVCowS/mLX5CwEIolltmTCpnurZxeniG+Dn
         ZIRA==
X-Gm-Message-State: AOJu0Yw52zYC162IrBrskiyhiY4j20moszNgU9CVxKAujNGLnAMBbzwi
        zqYPRpNZG4xciRQZ5+bP3hY3oAbefohzZgAxew==
X-Google-Smtp-Source: AGHT+IEY4ztdjT7PWj1HLsFFH4GzdFYJKZG/8yNdDtgyLo6Kn1SWa4ceZv423UysbgranQwQ/B7QY6TfJ/WFPP5Njg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3288:0:b0:d44:585f:dfa8 with SMTP
 id y130-20020a253288000000b00d44585fdfa8mr25516yby.0.1691543265492; Tue, 08
 Aug 2023 18:07:45 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:09 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=1226;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MYwDvvyMzq/6Jbwjo4fUCw6xEkwFFEE6felLK1tQBvc=; b=WeXXNFVuxmL2/RZ5Dpc6W99h2eU2abWzCTXFBENisuaDRhmkxGJ3LkZOTBNdDDy6FyfR6PlS8
 bEW3jArRu3JAcBUw2APr+XvWRQsMcU+uQodYXJbL14BITjI/xUBTb+t
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-6-5847d707ec0a@google.com>
Subject: [PATCH v2 6/7] netfilter: x_tables: refactor deprecated strncpy
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

Prefer `strscpy_pad` to `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 net/netfilter/x_tables.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 470282cf3fae..21624d68314f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -768,7 +768,7 @@ void xt_compat_match_from_user(struct xt_entry_match *m, void **dstptr,
 	m->u.user.match_size = msize;
 	strscpy(name, match->name, sizeof(name));
 	module_put(match->me);
-	strncpy(m->u.user.name, name, sizeof(m->u.user.name));
+	strscpy_pad(m->u.user.name, name, sizeof(m->u.user.name));
 
 	*size += off;
 	*dstptr += msize;
@@ -1148,7 +1148,7 @@ void xt_compat_target_from_user(struct xt_entry_target *t, void **dstptr,
 	t->u.user.target_size = tsize;
 	strscpy(name, target->name, sizeof(name));
 	module_put(target->me);
-	strncpy(t->u.user.name, name, sizeof(t->u.user.name));
+	strscpy_pad(t->u.user.name, name, sizeof(t->u.user.name));
 
 	*size += off;
 	*dstptr += tsize;
@@ -2014,4 +2014,3 @@ static void __exit xt_fini(void)
 
 module_init(xt_init);
 module_exit(xt_fini);
-

-- 
2.41.0.640.ga95def55d0-goog

