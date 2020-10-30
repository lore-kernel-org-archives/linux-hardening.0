Return-Path: <SRS0=mkbF=EF=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E2C00A89
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F4620729
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="Ib9/YJJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgJ3PhM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgJ3PhM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Oct 2020 11:37:12 -0400
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B54C0613D2;
        Fri, 30 Oct 2020 08:37:12 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CN5yq6qqnz110K;
        Fri, 30 Oct 2020 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1604072227;
        bh=a8NC42R6u3qlmdveQqeX3g+/yoA0KQ9pNupZi4YG580=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ib9/YJJGeRFgUpki+T+v+8nTyAJmWVrljn9eYxtlNNGSDm2OKgl7R0O/NaqLNIZjh
         BpFKmo8PYDPWWVGVp7bmfqcEPb/bZ74uOYFdczA5uBaQ+3hid6FpEZK3xo913m8c1p
         CleY+M1v960YfCepgpmgmgf/reE8bahA3r1kUP30=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CN5yq50gfz10yD;
        Fri, 30 Oct 2020 15:37:07 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v4 1/3] Fix unefficient call to memset before memcpu in nla_strlcpy.
Date:   Fri, 30 Oct 2020 16:36:45 +0100
Message-Id: <20201030153647.4408-2-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201030153647.4408-1-laniel_francis@privacyrequired.com>
References: <20201030153647.4408-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Before this commit, nla_strlcpy first memseted dst to 0 then wrote src into it.
This is inefficient because bytes whom number is less than src length are written
twice.

This patch solves this issue by first writing src into dst then fill dst with
0's.
Note that, in the case where src length is higher than dst, only 0 is written.
Otherwise there are as many 0's written to fill dst.

For example, if src is "foo\0" and dst is 5 bytes long, the result will be:
1. "fooGG" after memcpy (G means garbage).
2. "foo\0\0" after memset.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 lib/nlattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/nlattr.c b/lib/nlattr.c
index 74019c8ebf6b..07156e581997 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -731,8 +731,9 @@ size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
 	if (dstsize > 0) {
 		size_t len = (srclen >= dstsize) ? dstsize - 1 : srclen;
 
-		memset(dst, 0, dstsize);
 		memcpy(dst, src, len);
+		/* Zero pad end of dst. */
+		memset(dst + len, 0, dstsize - len);
 	}
 
 	return srclen;
-- 
2.20.1

