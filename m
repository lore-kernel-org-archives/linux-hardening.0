Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D4C432BE
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CDB61242
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhHVH5h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhHVH5g (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F38C061757
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bo18so10085885pjb.0
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkbCUqYXpxKrv+E9RWgklPDu42LROG49HfEVFdt9oJ8=;
        b=Lis4BwQuqQ5AiwLz0OPNa6NcDbii0sWFsfkJxxc/gLG4M5F6KFpFw0OwJAU4LLha1Y
         1VHPMCZBH6hQE8HwtdR6ByL1XQdmTyML/R1CZcj+jmjFz6FmyH8fCprGSTibSI3S7ckw
         dd651MGZpPUZCJD0eAyGjZ0erQ4aAMTYI08V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkbCUqYXpxKrv+E9RWgklPDu42LROG49HfEVFdt9oJ8=;
        b=U8dpVj4PioM9WsHaDt06INsXdGAG912MnLWwqej9QvqmcjEU0cbdDJlGLBL3kaYTn+
         jwlqMUvzFkpP+29xHq/U6yxQmkDl2TXpsC5MgO324QGnnSyUUtQv6Q+TJWar8B/tlOWP
         X9A6eogNuiGLThYYOvbDewx8DT5iTjeDVYc5jgwMBwF4Sd4ZMobIFegkg3218S31jYzw
         yJGqIq+bZ8jivAO9fkdLm81opXxjB9nl7J016DilUlXP+KX/I4mcNO+kQQDWTDMUvWo2
         A/jLLx1cj31fIgvhZOC7GIg70t3UQOlevntCQlcx/mtZvnGZYtbpHBkqejJskqGp+lY0
         Ql4g==
X-Gm-Message-State: AOAM531J9fqvph2Qx43RiUYyK9/MhoHDmhz8kJq0TGe/0o091qKMZkaL
        mt3fgBFDDYnPD/p7wOfuFf1xnQ==
X-Google-Smtp-Source: ABdhPJxMh0tsIpdLIetjZVeqwrL9nLQwgUFzp8AC30tGZZ5VwIWzP27ar8snqC6juFu+yovM8qX/ZA==
X-Received: by 2002:a17:902:8606:b029:12c:2625:76cf with SMTP id f6-20020a1709028606b029012c262576cfmr23579503plo.17.1629619015880;
        Sun, 22 Aug 2021 00:56:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm10588697pjq.5.2021.08.22.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 25/25] btrfs: Use memset_startat() to clear end of struct
Date:   Sun, 22 Aug 2021 00:51:22 -0700
Message-Id: <20210822075122.864511-26-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; h=from:subject; bh=XHjqu1RreJZUS0lhfMO2nlVUCup75rB1cNpejDSomCQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH6ZxQKCftHw+bbIsZDc7/cNC2VaaPC/Bzvi8PJ jBI2gduJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+gAKCRCJcvTf3G3AJlX6D/ 0ccDotcFu1yUXFehzHwNXSmCdP2dRq6MGepK0y703lxGRgYRXH8mgO0Xcee95Lf1qk9czxzNowS6Go sS7b4Pkw/E9zlTldMaPdOl2QcI5czJx7DD1K4TcjXVJIFmS6pKUwT+eyjq0GxpYr7UP56JMbPUEqe5 /FFM82ogo5GKXC7ZpnDH0SAN0vm6d6FA+qTuz09iEWwG/fISmVDLNgt5/5XHX+FBNT9x7tglj+UGJo J1LFFMUYLrtM2xP6W7KZ2dSwVZJXgKwar1gnOJNrESpF5p0R3pv662l39w1R5CaPsMt7yCRg/dKY83 xPpJ6QS6fappboPIqlmH5DsKrwK5tkqUZOo965oL22gXqQLlJrDFBpS+HcA90K77tmUDHw0cA1oZCj xEMwTwSaEaYhTUAETc8W+rxxhHOoWltHARk5AyjoMLUAB9R97PZJqtlzmw3T+LCpHan7/53N3wtmDo twQpqQVoR6GDsE+DDBy0ofV2si8wOgHKYzXDMIJhJ35Axs/8MT4SZe+NZy84FF+nL8DpWAWNa/4QPj +lqLt0IFYNIrpylbCHV7Fr8Rw7AwdoPxNmNyLThTwo3dPw1G+ZNgvqLhqFDYZIQiBRh8ruca3dYIvv JSKCxSme2hIV5U+VcQHoQKeTVwGooGQAZsYFH1gkRt9Apq6nbH2JORDnJ6kQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/btrfs/root-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 702dc5441f03..12ceb14a1141 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -39,10 +39,8 @@ static void btrfs_read_root_item(struct extent_buffer *eb, int slot,
 		need_reset = 1;
 	}
 	if (need_reset) {
-		memset(&item->generation_v2, 0,
-			sizeof(*item) - offsetof(struct btrfs_root_item,
-					generation_v2));
-
+		/* Clear all members from generation_v2 onwards. */
+		memset_startat(item, 0, generation_v2);
 		generate_random_guid(item->uuid);
 	}
 }
-- 
2.30.2

