Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A8C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 11 May 2022 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiEKABW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 10 May 2022 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiEKABS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 10 May 2022 20:01:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A8663E8
        for <linux-hardening@vger.kernel.org>; Tue, 10 May 2022 17:01:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso583720pjg.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 May 2022 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQmAuOYXmnd9R6pgw1MBHX8mjNOUZA8M09MP8VBXtO4=;
        b=keHsAlL6n7GQLoOOgNL8UMpOfUaonSG7oLWW5qink/s8+VHXzHBEJHf95wwVAFnI9L
         CbBwI+3J0KPzTBg9hq2wVgqIwBpafU92lLVg+BUzw3PC1KopXjzzAcXuxMV8sZdMrgXX
         9+XmFwWSIdu3ZMdVpmC5oTOxWHE4IifnE6NpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQmAuOYXmnd9R6pgw1MBHX8mjNOUZA8M09MP8VBXtO4=;
        b=Nakz8M8kkR04docPmfHgFUTwY5bCFKa8hh2ye5wyfkqhajeW+MDvf5MX1wxYmcEWFH
         lbFAnfF6x7Lvo+toFu5BvTUlWBa6soDB1CyvE69QqmWN4nXZw5LEjADMsHBgw5WrIw0D
         3SkPDQa0SRa41spu4QMcs3HT+OmB+OClg4yc+Q+TTK0i1mhzDIjo5d2AKpggOsSb/+7m
         CMHmI+Jg8JgMThfhDH64F6OXqrQClkREd4FSh+mZ8yAE82uyhxXRpXl3h3Vm7TDTkvag
         ybT5rNKzOkQORtjM3jVkuZOv5n/6uNMhBrAlbX+Pg9XOXBFn3aJ7qQQscm1t8JBvohsM
         qO0Q==
X-Gm-Message-State: AOAM532zM8Z240VzCnAWmjwnKf6C9i0yA5FX2rYqH+zLcaSKaUTToH2P
        ass+O7EEj9hULnIkFtr5KuZIpEKaZwdRnQ==
X-Google-Smtp-Source: ABdhPJzNW5iDVbDMLzx4HJCAwT94LGijR/seDI0Qc6zeiGzxgPthp1FNwcZ9bgZx+kF2n6QycIi1Jg==
X-Received: by 2002:a17:903:2288:b0:15e:8da2:fcc0 with SMTP id b8-20020a170903228800b0015e8da2fcc0mr23502263plh.125.1652227276336;
        Tue, 10 May 2022 17:01:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b005107da0f34csm140350pfm.20.2022.05.10.17.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 17:01:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] af_unix: Silence randstruct GCC plugin warning
Date:   Tue, 10 May 2022 17:01:09 -0700
Message-Id: <20220511000109.3628404-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; h=from:subject; bh=2qqmG5mf2TH4QC6jnO0oEV+/qqCppk0f1iQ+9SL2+LA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBievzE4lce9slhXthS9Kpqhswewam15D4zkW2Qsbu5 eBZyYo2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnr8xAAKCRCJcvTf3G3AJgmZD/ 9s0zTUejiTGXFUobnI2W1wICbOcu4zqOLwG+V6XJCkprUDW+bqWrVU5//Ea0S82bZLyEYzr+V0sHxJ 1kqVOFhMKN3EMwXPTcLhIZupUys3LjRQzyq0JBEHpCYxZEJ3JYJ7EI7vJo5AJhOyJjXxDaFTosd3ei V5vGR5pVeXdEjp3yWEf9+Me27ZPjCrLYB3tDBHOG5Gxlts17WZwD2s1nnA9Syvak+bGuKjeLABjHkY w2IyVQlyvq8rZX91KzhYYq/ulFBTZjspifqj7TRycyiBUp+ltrmKXkLX+8OkjhrFNOt2x8U6N8Zgn5 hOWcMeeqCdsZNYZhz7mj0EvjJIj3PGKSjWm+KTHIxo8C7pIGUWD1O+V+ioJBiEhlxrNqq5qV6HmfJq 20wl97cY6ynkV4lhBTuumCvt0yPc27/0DNjlK/D8bAVPER+GdbYg4uHvNTqGkg2At7drZYP0yZfZJe H9h+63jvxbQ+pTk/gWE2y7CEhUTdfsmluiV/Hp4s0XX1BaLT7mRB0cIQ0rrKb3ADlWvawFrGhkXqjW 6117F2oBxHNOlKhxHXDP0s3a0/QErj0mP1YwjsLX6/t7gUkW0q7H17ivWL1JiL581HM0r9a1kytS/m tNSc9pzN+1WmiXPxoFIcuDHruHOvWP3BqE2646Gb/ezRvKuCHxMnmsNbxDrQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While preparing for Clang randstruct support (which duplicated many of
the warnings the randstruct GCC plugin warned about), one strange one
remained only for the randstruct GCC plugin. Eliminating this rids
the plugin of the last exception.

It seems the plugin is happy to dereference individual members of
a cross-struct cast, but it is upset about casting to a whole object
pointer. This only manifests in one place in the kernel, so just replace
the variable with individual member accesses. There is no change in
executable instruction output.

Drop the last exception from the randstruct GCC plugin.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Cong Wang <cong.wang@bytedance.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
If someone can Ack this, I can carry it in the gcc-plugins tree,
as I'm trying to remove all its exceptions so I can drop that code.
---
 net/unix/af_unix.c                            | 8 +++-----
 scripts/gcc-plugins/randomize_layout_plugin.c | 2 --
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e71a312faa1e..36367e7e3e0a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1808,11 +1808,9 @@ static int maybe_init_creds(struct scm_cookie *scm,
 static bool unix_skb_scm_eq(struct sk_buff *skb,
 			    struct scm_cookie *scm)
 {
-	const struct unix_skb_parms *u = &UNIXCB(skb);
-
-	return u->pid == scm->pid &&
-	       uid_eq(u->uid, scm->creds.uid) &&
-	       gid_eq(u->gid, scm->creds.gid) &&
+	return UNIXCB(skb).pid == scm->pid &&
+	       uid_eq(UNIXCB(skb).uid, scm->creds.uid) &&
+	       gid_eq(UNIXCB(skb).gid, scm->creds.gid) &&
 	       unix_secdata_eq(scm, skb);
 }
 
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index c9d345a91c41..2ca768d88a68 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -46,8 +46,6 @@ struct whitelist_entry {
 };
 
 static const struct whitelist_entry whitelist[] = {
-	/* unix_skb_parms via UNIXCB() buffer */
-	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
 	{ }
 };
 
-- 
2.32.0

