Return-Path: <SRS0=j6/H=DX=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D1C433E7
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D06207DE
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 13:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="UfaV3mms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407873AbgJPNCC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406442AbgJPNCC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Oct 2020 09:02:02 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Oct 2020 06:02:01 PDT
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827DFC061755
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 06:02:01 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CCQzq2R9rz15VJ;
        Fri, 16 Oct 2020 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602852775;
        bh=R55XLjl9iB1jYM3CJqe3Xf6ZBnQfjHrUJlUTFDrKFk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfaV3mmsWomWbipRXq5xBWLO9M3siLTjBf1ExsfH5lOf2CtL0azxKfZmiw5SXs/kU
         pOVFUH6n2xfSIDJMCL9wN/jAO8BIRiUNPw3hUz45vYFc0mxkdpWwV2dz6o6H9LEBaO
         pI137ELvE5dlMDcEnysPTGYc/Hrk5KK34a3ogrk8=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCQzq1HWpz15VB;
        Fri, 16 Oct 2020 12:52:55 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v1 1/3] Fix unefficient call to memset before memcpu in nla_strlcpy.
Date:   Fri, 16 Oct 2020 14:52:14 +0200
Message-Id: <20201016125216.10922-2-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

This patch solves part 1 of issue: https://github.com/KSPP/linux/issues/110

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 lib/nlattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/nlattr.c b/lib/nlattr.c
index 74019c8ebf6b..ab96a5f4b9b8 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -731,8 +731,8 @@ size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
 	if (dstsize > 0) {
 		size_t len = (srclen >= dstsize) ? dstsize - 1 : srclen;
 
-		memset(dst, 0, dstsize);
 		memcpy(dst, src, len);
+		dst[len] = '\0';
 	}
 
 	return srclen;
-- 
2.20.1

