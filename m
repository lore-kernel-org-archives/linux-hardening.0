Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6424DCD379F
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbjIOUQp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbjIOUQS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:16:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C32D58
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:14:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c336f5b1ffso22805835ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808898; x=1695413698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2adzcEiFT17X0tMOdRHOC+4xSYu7V9ABPtDWz0mCD/0=;
        b=J+2qPFbR6NPi/lK36YaaEC2g7PZyp9zwCLefboI4JRP0GTtDspwegZ299UymSfEEdx
         VTHlzOOOtOfXoj6QW6He9icCoRrS6Ln/09oAgHTFyIqNxUIWu+M4gIdgddj+iIzMdf5x
         Hm7ZAVdXwNz1FhWIfw2ZTfpDx/QYeunL3e1Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808898; x=1695413698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2adzcEiFT17X0tMOdRHOC+4xSYu7V9ABPtDWz0mCD/0=;
        b=EVdfnpNGu9Lx4nYVPzIIXGAeVL5OPTPwcwuD9lbOjYXR5AmHATFYFJuOxkRD0iJ4bM
         +63YHNNugv/+NKdnV+yheXjR4BMtNoMh1DQi3YV0B5/Rqpi87oaDt0HWWf7CjKTFfXvE
         ynwa+aAuDLg/qnYp5XK6pEDsz5ceKszCmkPImYExSuzuaSpiLoo2RAk3JG8LQjgywquW
         4lotUoM4ydpMbYwSh8oS0wynGR50eKYFgAzJ8PxTBULv247wIE1bHgq5oCtPg4wUhjZx
         gp/nkiZPVMzUYegSHhNDjPdor+mCWD5pcPvGXDmebRz3RKKIFRggFVM9h+ICq+Y+xIWv
         5rPg==
X-Gm-Message-State: AOJu0Ywl302FXt+X0CT933SoBqbr9b0RVwJm0n629lyHRnJlKkRYjRgE
        K96x28tNiBVGYNHcu+5dIW3L2Q==
X-Google-Smtp-Source: AGHT+IFl5ZOAgVGqBoYurT+RiGDKwf2m+mMLCPmLDws6lMZeLSgdeHZqG1yi5Xh/qs1zbtBogZWowg==
X-Received: by 2002:a17:902:e882:b0:1bf:11ce:c6ae with SMTP id w2-20020a170902e88200b001bf11cec6aemr3250482plg.18.1694808898073;
        Fri, 15 Sep 2023 13:14:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b001c43307f87asm1837631pln.91.2023.09.15.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:14:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] afs: Annotate struct afs_permits with __counted_by
Date:   Fri, 15 Sep 2023 13:14:56 -0700
Message-Id: <20230915201456.never.529-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=keescook@chromium.org;
 h=from:subject:message-id; bh=C30Tpce9LuvDnPhShi9VewRUfa54HHSLTSiinU7ab60=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLtASGYM643odAtTW+2uVzG0JxIaa//Ye+Bts
 GG3+SOU75WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7QAAKCRCJcvTf3G3A
 JmQ5D/939BFdVcrl8LsWHb25cdDVwqzcQu0ePiQa21qI3gkIx7d/C8DZ2qrX3QrHPyxnky+ufgQ
 9Zl9fn6bdqHc6imsnBAAkRegAyTuYMtUmp6zi8w2Bzf9dT8r/xuT8GtAkMlo336a7xveH3luRbO
 MTr9lMWq4ZJ3GCh0FTdJmckVsF1hybn6tpSNZL4Y/I+pDLjDduYV0/VAwzRB5SWlre0mug2WBNk
 XgGKTUWr6zml7tQhaxlp2r8rgMuLcQTuwTty++KM6qyaDw4HNfJ5wfSF9UDjeJHS489LFQbaKMf
 JD0csUlqzQK9Azl1Fqed6jTMZL4924e8MnjWmZD7SgMa2mzDlFzDMenajpdoBypMvFqQwQKAXwo
 X4BSZvbaAg22gLUsQHDBNNqKLkhjYfvhE7AvGLCXu+f1m7P0zrjNKuX2YoEnYrj1M+n3+AJCO3j
 ix5OuhOhpXAJNFqJsHsVoS62xM2i4ui5ZpF9HMLGUNANCkwQeTKYk69PXhuZIu0M4aEfDKphuBt
 KMJdwM3G8URutOHI00MxVT7g14ZllYBBq5BmjfNgn8YKUPI+iARkBV+anvIM3LIKGKsU48jFCH9
 2y3kY1IkkyCqw+M212bqRFmBVg18HbLa4Q0zv7sPzuZUf2DdSubfdtYc/RRjRx3oKgnwxo90i8o
 ZlTc3RO ZPK5Fl1w==
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

As found with Coccinelle[1], add __counted_by for struct afs_permits.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/afs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 07433a5349ca..469a717467a4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -705,7 +705,7 @@ struct afs_permits {
 	refcount_t		usage;
 	unsigned short		nr_permits;	/* Number of records */
 	bool			invalidated;	/* Invalidated due to key change */
-	struct afs_permit	permits[];	/* List of permits sorted by key pointer */
+	struct afs_permit	permits[] __counted_by(nr_permits);	/* List of permits sorted by key pointer */
 };
 
 /*
-- 
2.34.1

