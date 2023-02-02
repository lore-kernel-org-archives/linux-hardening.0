Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206BC61DA4
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Feb 2023 04:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBBEpl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 1 Feb 2023 23:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjBBEof (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 1 Feb 2023 23:44:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B67DBF0;
        Wed,  1 Feb 2023 20:44:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96CD2B82429;
        Thu,  2 Feb 2023 04:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B04C433D2;
        Thu,  2 Feb 2023 04:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675313036;
        bh=jO10o07RAKyXXgWsy3XBxX0WTtST48LzT0RY2uOU2ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAvPdyTF1CQ/3SMGkgxIcGQ8mnvreRb6Y9/2ukXmDh1WFemGwMyBC0c7AqBi1xqPH
         JO2Uqg5rOhITiA5MiaREBArn7aI2aoKKKdUKADMfpRtU7LU1SlhAqcsvbqcPTht8wb
         lgaLkk83LDYAvizdVvzcoSPiWz71PbzCYFr1iXl5WvMezDDoDhE+kstRJA/9Byd3h7
         aYlB7koEzmGZnSsBzoXQTsSxPin2ATSvQvjAl9bWyWlxwW9CT6oScrGrklt/23JCE4
         TrK4XQIZn6y8WIjSL9ew+o63Wk3i7jimCXRu0iwkooyfUC5dDjsoSiwElziaOtAg/2
         5yLSWMvkSowVQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        SeongJae Park <sj@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 5.4 16/17] docs: Fix path paste-o for /sys/kernel/warn_count
Date:   Wed,  1 Feb 2023 20:42:54 -0800
Message-Id: <20230202044255.128815-17-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202044255.128815-1-ebiggers@kernel.org>
References: <20230202044255.128815-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 00dd027f721e0458418f7750d8a5a664ed3e5994 upstream.

Running "make htmldocs" shows that "/sys/kernel/oops_count" was
duplicated. This should have been "warn_count":

  Warning: /sys/kernel/oops_count is defined 2 times:
  ./Documentation/ABI/testing/sysfs-kernel-warn_count:0
  ./Documentation/ABI/testing/sysfs-kernel-oops_count:0

Fix the typo.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-doc/202212110529.A3Qav8aR-lkp@intel.com
Fixes: 8b05aa263361 ("panic: Expose "warn_count" to sysfs")
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/testing/sysfs-kernel-warn_count | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-warn_count b/Documentation/ABI/testing/sysfs-kernel-warn_count
index 08f083d2fd51b..90a029813717d 100644
--- a/Documentation/ABI/testing/sysfs-kernel-warn_count
+++ b/Documentation/ABI/testing/sysfs-kernel-warn_count
@@ -1,4 +1,4 @@
-What:		/sys/kernel/oops_count
+What:		/sys/kernel/warn_count
 Date:		November 2022
 KernelVersion:	6.2.0
 Contact:	Linux Kernel Hardening List <linux-hardening@vger.kernel.org>
-- 
2.39.1

