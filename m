Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FFFC47087
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 19:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C072613B5
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 19:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhE1UAS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 16:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhE1UAR (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 16:00:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D11B6139A;
        Fri, 28 May 2021 19:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622231922;
        bh=pezj5ZNGgRcbAxU5OA6hJzg2hYt/RIs+WrdZ9Me9mlU=;
        h=Date:From:To:Cc:Subject:From;
        b=Apzwi3wlJnl382Sz48qIYvSs4HfB2PFSMH3USMpgp1MhzVFyivU4+OhvjknqY/jJw
         PbJXeI45xoQPIm3WqZpxxGbZynNL/LcMR5F1qCZs3Z6HHya7gH1+r6y+8h58u2x3ZU
         H8X+f/Fye0kRWdAtsNEJOjxiFcx19qm1zZMIsEY7t7Bff1eOC+oehMiXmc57i2eDoG
         hFF9KMDP4phVJhpD86T36IEvejH2L6poIgDnLGoq+/RqnLypz5Y1EAja4gYf+3xvIz
         nqVNgjlQnHVlvEFvU08No6W4QoSdos4FTEPMF4fNt8LHrsjOYht/ugdvf8WZdZOuC5
         is+8wB7pac2Qg==
Date:   Fri, 28 May 2021 14:59:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ring-buffer: Fix fall-through warning for Clang
Message-ID: <20210528195942.GA39174@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix
a fall-through warning by replacing a /* fall through */ comment
with the new pseudo-keyword macro fallthrough;

Notice that Clang doesn't recognize /* fall through */ comments as
implicit fall-through markings, so in order to globally enable
-Wimplicit-fallthrough for Clang, these comments need to be
replaced with fallthrough; in the whole codebase.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 25 in linux-next. This is one of those last remaining
      warnings.

 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2c0ee6484990..d1463eac11a3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3391,7 +3391,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		case RINGBUF_TYPE_PADDING:
 			if (event->time_delta == 1)
 				break;
-			/* fall through */
+			fallthrough;
 		case RINGBUF_TYPE_DATA:
 			ts += event->time_delta;
 			break;
-- 
2.27.0

