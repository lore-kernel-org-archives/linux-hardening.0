Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F26C636D6
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 10:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjBCKd3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 05:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBCKdA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 05:33:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95338A07D0;
        Fri,  3 Feb 2023 02:31:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C57E61ECF;
        Fri,  3 Feb 2023 10:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0405BC433EF;
        Fri,  3 Feb 2023 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675420283;
        bh=A3tC2FbFK0ui4EdTlSAS2z7JqfxGBW7AJ2cXa2P2ug8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/UWUXvQBEeFPq3wCtF1p6dWuFix8Ay9/nFySh/jLRcKcJQw3fdBdtPXh2M0fadx4
         MOtU/xCoLx2UhhtM5p+TBUiQzC6/+QqU0Bxol+AOyuzuGk/KuN7cUhR3BGimG+rreG
         g98DI5BoPfchJoSzfwyD3/+AdoVMD3JdDLktzggY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 129/134] docs: Fix path paste-o for /sys/kernel/warn_count
Date:   Fri,  3 Feb 2023 11:13:54 +0100
Message-Id: <20230203101029.620154017@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203101023.832083974@linuxfoundation.org>
References: <20230203101023.832083974@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-warn_count | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-warn_count b/Documentation/ABI/testing/sysfs-kernel-warn_count
index 08f083d2fd51..90a029813717 100644
--- a/Documentation/ABI/testing/sysfs-kernel-warn_count
+++ b/Documentation/ABI/testing/sysfs-kernel-warn_count
@@ -1,4 +1,4 @@
-What:		/sys/kernel/oops_count
+What:		/sys/kernel/warn_count
 Date:		November 2022
 KernelVersion:	6.2.0
 Contact:	Linux Kernel Hardening List <linux-hardening@vger.kernel.org>
-- 
2.39.0



