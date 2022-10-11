Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78062C4321E
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKUBX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJKUBV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 16:01:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF79A9ED
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:01:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so12077pjs.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjvqTyZutnL7yMogIWHPivDIHBfuRj4Mu3exlJZLrDI=;
        b=ZMD/dUnH/4uKkR6xfid/HgrzkMTavww075W/m4W5y1ADAqwTsVI78M1hR9JWqvO5Wt
         B74srQ1At9WxjeJfaDJJv4m6e0K6uoAVGeqlYu0RnW+KhZF0Mwd4zCUICadYI66ZpXFR
         YiWMCDqlXoh+rAZb9e/JGXeAzrHGBAhs46mKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjvqTyZutnL7yMogIWHPivDIHBfuRj4Mu3exlJZLrDI=;
        b=K9Kl9buFW8/anikcsMcHDoxcu4yQdA0fETZyR2/SbLsYBuKTtWza0TTfNOmg6nj2pP
         +QOd7ElNeCI49P9nRGnmlJOIKOmIWq10cfWBTiuqu/53Way75mlVGBY7PJ+q9fsN0y+B
         bj9HQOGMJPk6oMzAbdOLWm+bH7sgowZ0dlgPPjk8jnI9zYto8StEtJpRCbz/YUKkKd0Q
         5J6isS3Bj2hjtPGrbIrSM7Do4QW5QICT7D9x1FJjP8wkr7wQyUZYyAe9Vmil9TQKybqf
         L6xDCO6RvvQ7zqWRyEGKGomAVE2Ec5sXg2SQjtcger7368AV8IKELD6i/r2Co81ujIVx
         z8SA==
X-Gm-Message-State: ACrzQf19RMZOqJkwWrJejt57BwDz6eSOumHOaMdcQy7FAQsPPYwWFfzG
        HoR5jnQW7StRxvqfZn4E75JK/w==
X-Google-Smtp-Source: AMsMyM5LOvi6jvt4bLvXEvDmmvjTbAhepkZCZD5DLm3PiFDo+zRPB+BkV0ktWjBiyIc3ri/87GcNyg==
X-Received: by 2002:a17:902:be18:b0:178:b9c9:97b8 with SMTP id r24-20020a170902be1800b00178b9c997b8mr25179917pls.38.1665518479904;
        Tue, 11 Oct 2022 13:01:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b0056268979639sm9355112pfb.123.2022.10.11.13.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:01:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Date:   Tue, 11 Oct 2022 13:01:12 -0700
Message-Id: <20221011200112.731334-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011200112.731334-1-keescook@chromium.org>
References: <20221011200112.731334-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; h=from:subject; bh=jb7waUPK/Knlq69ss6WwnLXDb9Y+1PWtCy1mjIPpCDU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRcuHvftNYJAD25knIqafGcekDRN9mybmr08F3Mw8 pmRudm2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0XLhwAKCRCJcvTf3G3AJgCQD/ 4iD65olwVNJs1LrfjfXaMurzeDGkwV36aBRIkBTvEMxiNZjaxwJnEisYuTf2g0hMHUSyws3ih2MMy6 fTlwbgpH/Dj8OT/H1r49u0rx1h2gSk9EXS8gFXm1edRMF+5w+xP3bQ1V5I5et6wWki4Cw4OcyyfVws 0NJBYaTvGT4oS4//nxpGOPQtF+9umSEGS9qTAx/cmi7O7iScOPbn5lB5xBKDYkhi3ucBlgRoMGmIM3 U8KuJP04fy6yxgcdzgDyDKnsuPfv7slDYDpGqOuWshF1REbmGfE3z0YIj1d9wGZ7D8vfBT+411+zx6 IwGEmXEEGEbugOJHYd+4k0FGCH+1vZ96SCYR6I13URKeQHE3RHOoFCDLZak4rix9i6v5PjeyDIRzNi aUwcfiASrZIXTgDfLv6uL1RjVU3NO5LYwQHUiPAkqQaLlEKUy4Ipz4U4/NLaVQsmQj8OZGP/vs9AZh Vdvfa0biqliOVqy1gBl2Ai0XczfWtPoPjS7VjwpAl2EoTvAh+7pA2yNVTZZy5hKNRyItnrEh5OMXu7 TEPW32gczyYy4gHW61+HCIjSl1uzImVQwRf5LtzDUTK8/1sgsNNX+e+KDJWj++bbzxBk7A4YJ7uLXO Kc5UPWf3HoqltNfHKZwUngsABuqJmYllqvUYYWVb4OtJFUixA+MIUvgz6idw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Update pstore to better reflect reality of active contributors:

- Remove Anton and Colin (thank you for your help through the years!)
- Move Tony to Reviewer
- Add Guilherme as Reviewer
- Add mailing list
- Upgrade to Supported

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..bb18a6c91c4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16458,10 +16458,10 @@ F:	net/psample
 
 PSTORE FILESYSTEM
 M:	Kees Cook <keescook@chromium.org>
-M:	Anton Vorontsov <anton@enomsg.org>
-M:	Colin Cross <ccross@android.com>
-M:	Tony Luck <tony.luck@intel.com>
-S:	Maintained
+R:	Tony Luck <tony.luck@intel.com>
+R:	Guilherme G. Piccoli <gpiccoli@igalia.com>
+L:	linux-hardening@vger.kernel.org
+S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
 F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/admin-guide/pstore-blk.rst
-- 
2.34.1

