Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5BC4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 01:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiLBBgD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiLBBf7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 20:35:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD3D20AB
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 17:35:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x66so3571270pfx.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 17:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP31bsPSm9f+hAa3TK6LgXNEEfW0wwdldtJ51E5YYMM=;
        b=h54Ivo7q4Zdaa4YfuGYp4JEDINKQlEWi8Y7JROzg8A6deqnzT+HJ3ASFvDkyQDhVPt
         6bmrFOZPo7Ftex4TwpNnkPOGsFVX7JF7cuu99nPIRYwkovEhOOIAQSNjazxInWQoXHzy
         /tl+ViyHQ9zvXgJhzRK5IHKjw/NbaqwCPfWn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP31bsPSm9f+hAa3TK6LgXNEEfW0wwdldtJ51E5YYMM=;
        b=E9mGyBOY9aLEyIiuc1MfFWOOKg8F1io0QlRQDwWHErmIdnFlqIuc0CEH23WLsgfb0+
         rOka6c1mUyuGKZdWWugWUgDIGzOYsxvZa6NHiQnkV9gxwUajlPribUyu69Gqg/LJa6zU
         QkBwWS6JcMgekG0zA/gNSZdJifjEIjaaof6XSKoa5tKUjtyVXw2ZeknBE9M5ItF/ABuB
         JkDIys9hS0J6oOnEdnaLAmh8kv8CcNJQKbXffpsQeiTWrzN43Y6hNleafyalkFo840iJ
         YkOef5ZEoE7xY/RoFsdKae65/cYI+aAtV0GuZCIp2kdqXEimhfA5A4YvIGHPbcu2PPtJ
         aeWQ==
X-Gm-Message-State: ANoB5pkXelt1ssMi66+6CDBLHfKdp9oO7DgmlAYLzzLB456rXP+ou7yp
        Wqdt2WBBF8beLYwQqt6kj8FSVveM7Cqqp20d
X-Google-Smtp-Source: AA0mqf6s5/DD/qEipDy95aXwC2Z3tWXhD0ZZ1Ih93gpvBAsrbgYstV1S9ORwEXoi15r0GE04k1z42A==
X-Received: by 2002:a63:185a:0:b0:476:e84c:ab63 with SMTP id 26-20020a63185a000000b00476e84cab63mr47437406pgy.496.1669944957535;
        Thu, 01 Dec 2022 17:35:57 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id s13-20020a65690d000000b00477fb27eaddsm3074241pgq.63.2022.12.01.17.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:35:57 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Fri,  2 Dec 2022 01:34:04 +0000
Message-Id: <20221202013404.163143-7-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
References: <20221202013404.163143-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

When apply F_SEAL_EXEC to an executable memfd, add write seals also to
prevent modification of memfd.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/memfd.c                                 |  3 +++
 tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 96dcfbfed09e..3a04c0698957 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_ALL_SEALS;
+
 	*file_seals |= seals;
 	error = 0;
 
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 775c9e6c061e..0731e5b3cdce 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -32,6 +32,13 @@
 #define F_SEAL_EXEC	0x0020
 #endif
 
+#define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_SHRINK | \
+		     F_SEAL_GROW | \
+		     F_SEAL_WRITE | \
+		     F_SEAL_FUTURE_WRITE | \
+		     F_SEAL_EXEC)
+
 #ifndef MAX_PATH
 #define MAX_PATH 256
 #endif
@@ -1006,6 +1013,7 @@ static void test_exec_seal(void)
 
 	printf("%s SEAL-EXEC\n", memfd_str);
 
+	printf("%s	Apply SEAL_EXEC\n", memfd_str);
 	fd = mfd_assert_new("kern_memfd_seal_exec",
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
@@ -1024,7 +1032,24 @@ static void test_exec_seal(void)
 	mfd_fail_chmod(fd, 0700);
 	mfd_fail_chmod(fd, 0100);
 	mfd_assert_chmod(fd, 0666);
+	mfd_assert_write(fd);
+	close(fd);
+
+	printf("%s	Apply ALL_SEALS\n", memfd_str);
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
 
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_chmod(fd, 0700);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_ALL_SEALS);
+
+	mfd_fail_chmod(fd, 0711);
+	mfd_fail_chmod(fd, 0600);
+	mfd_fail_write(fd);
 	close(fd);
 }
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

