Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03FC61DA4
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Feb 2023 05:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBBFp2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Feb 2023 00:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjBBFpZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Feb 2023 00:45:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BE3B0EC;
        Wed,  1 Feb 2023 21:45:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F5B6177C;
        Thu,  2 Feb 2023 05:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BF3C4339B;
        Thu,  2 Feb 2023 05:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675316723;
        bh=sg1KwdXv0FVnbAh1B0Mu7C1aCwLVKT+GZqGfNjJjHPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHVTcuz0ufejEqPH8YQ3xCQIHYRS8ASbecuMe0myj5RXS+rzSqlIoTs/UYV4pK+Yn
         c71VaOaHKrxWWrxre1Z/TG0pUXs/NYisdCzWRGu/GUAYDcnpVKczoucKRKC4cJHipw
         Z8gliPQzg7QyReemptGzXYOUDcKrA9ZJleqiB5reGStnwhNwdiuT9ENVL2I0lgvl6C
         iMDdRFAkEuiabudBE1dznZmPG2ids1RbQXWGjtsWEHK+0S0nTfKaK0z/6xRCmUdelj
         rQEI9YPYEPlO4wqKbf05saJIZpUarYJnGfpRPogA2jZskP95QU80v4V4TCs3I30TbG
         9n4mU9si+eo4g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        SeongJae Park <sj@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 4.14 06/16] hexagon: Fix function name in die()
Date:   Wed,  1 Feb 2023 21:43:56 -0800
Message-Id: <20230202054406.221721-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202054406.221721-1-ebiggers@kernel.org>
References: <20230202054406.221721-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

commit 4f0712ccec09c071e221242a2db9a6779a55a949 upstream.

When building ARCH=hexagon defconfig:

arch/hexagon/kernel/traps.c:217:2: error: implicit declaration of
function 'make_dead_task' [-Werror,-Wimplicit-function-declaration]
        make_dead_task(err);
        ^

The function's name is make_task_dead(), change it so there is no more
build error.

Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lkml.kernel.org/r/20211227184851.2297759-2-nathan@kernel.org
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 797608772f8a4..65330343bdc33 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -234,7 +234,7 @@ int die(const char *str, struct pt_regs *regs, long err)
 		panic("Fatal exception");
 
 	oops_exit();
-	make_dead_task(err);
+	make_task_dead(err);
 	return 0;
 }
 
-- 
2.39.1

