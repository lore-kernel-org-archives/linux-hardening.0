Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6980FC64E8A
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DF722470
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqvjv1bM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgKTSdO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:33:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbgKTSdO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:33:14 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 174B022D0A;
        Fri, 20 Nov 2020 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897193;
        bh=my70itP3lr3qWoW2WmWc2na58+HpUeKWgsniYzdn5aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqvjv1bMlCXrnxp6ksTqc0AqTH2mmCTuSjPW0cEOzHR9bLw9i/3GWLICO8Jkf4Z+/
         qYtAp8Vk2UtkSsyh7HK0M2g0kqALaMlwL7hoG55uXlS4TXIUxYO40MJu0gM6QzAgFU
         CPi3hngFgv3f6Oak5h2p/HSDP7vFA/QhG2JNeihE=
Date:   Fri, 20 Nov 2020 12:33:19 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 061/141] tee: Fix fall-through warnings for Clang
Message-ID: <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/tee/tee_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 6ade4a5c4840..5fdf26688230 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -452,6 +452,7 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (put_user((u64)p->u.memref.size, &up->b))
 				return -EFAULT;
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

