Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11491C4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E186120D
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 14:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhHVOaL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 10:30:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:54793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhHVOaK (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 10:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629642564;
        bh=qgl7lJStS+005yGjkk6fF/fD8RNwVNKYgDY82cD7XbE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gKM0u4b4J4tYlXkKApojb6DdGx7lbVtT7Qudx2DZ3EPtdVPIBWocxAKHwRxv+8GF0
         WEPxn620OFDy4T5dhHxucFhK/GtY7PtNL69E2Fxh25lBednuWafYh6+dDYLJX1Sv98
         K+tunMFjXej5DfqCnvnGUuIJXTAiE0p7Xk1RkQKk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MyKDU-1nGLeh3JJE-00ygsc; Sun, 22 Aug 2021 16:29:23 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] staging/rtl8192u: Prefer kcalloc over open coded arithmetic
Date:   Sun, 22 Aug 2021 16:28:20 +0200
Message-Id: <20210822142820.5109-3-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822142820.5109-1-len.baker@gmx.com>
References: <20210822142820.5109-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/B/R2NoiAsjs4dDhAM7hbX+batYy1t+8T2cJ3GwZQXsvTVWTZF+
 aJ/lDy/4CtESgwUMVOE0yAIA4Gzc7ulUcZM9C5n0KuTB/xcazAzyhmvwJLBk2847+gNNOUY
 0p5uL6CCM31yZSoutql2vMcjmTBy53SLsGQ+fAn3cNH3FpLtQWOwPT9wBajzNa17gjAbCIo
 FqHm5k5d5SSKflH8wZ4Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cvpceODj6WE=:0/9rcMhe8pn2pueFu8w1kw
 QJXlLj2v9m86sPRLFNHFiKir4teShLcEMbFgdkvCLcAN6tiicA+mfjdE4EOqrEuOF31j3mzKn
 7m68zoT6CgP12Y9ntaD2Woy3dbqfEBQdzcdIKauzaMWyjM2G7S2up5svQks0+E7S/xwYyg3K3
 AugoH6dH9gWULBVCps03xjc1bwLl4Ga86pbORND9JWF2FYkJ7tXFItpWYQrXcfJqYiWl+Bpuw
 Inx9NGxAkQP5WMrctMTP8mvSkxioN9fwZGbW2z/NNTRU794KWHcZJp15sNnzpjcJJkbPwSaF8
 aVv8px/0c1mPbYZEtRhJGzf6vFc+NEKYZciJUenCIVlCqGYFPK+1/43oPDP30MbpSyG21XQ/n
 EocENCSXZmINnBi7fgxm47RWfAQ3tYjsrF2QIiM7txRx7HjGjiN01CVi8f4sPU1nvQIK50zI+
 sHznu2f/j7JGxWSgu/KvZkUcO5Y3kIY8BzQFhTZVK4VX+hU0gD46WxEz2s1/Y+wKhvITTVUxo
 BguCiEys1nf6i/2ZD1qS+qp/S2PQXkjJPSDD0rvZSwjAFI5cmXdgmy4rFAc5St7cbigBolSna
 acUr7Fhb3gCd4kIcuni+kj8TfA2AQwGx65hmUQEc5Blgm5u43SQdNXBKhdUOiv3TgIsZ+J77S
 ykLaqJ+fKXOt0tK7O+1CLwpLwmg29jlulYA0hEp2udsvKRgbEkCjd1JuQTwTmvwxUn7nkFVsG
 iyzhoHawPoPyWQuIV/E8NxX/btVlKwuv2zZc5EqfmTLYq4uJHtNyBaI41EHcVm1+77jWwKy2v
 h3TQC7U+RrWF9uhcS9BZQy2MO+jERVT+BuscOTO3xsMeV+EHrsWBZHHIKQEEdjDf6vJQSma6R
 BDfWOxdrm4hbhVP0BofideYXE61MUYq96cBNDaiaNFm+ItU7uClVAn85YB2gPJRunDpMezjyl
 0B8b/foDN8ns7HiktVj02ZbNU+pAt+HAxnTmXztKuFsaSY6qJntTep6d7H6iVZy3rLvlLX4Da
 d/TffKC33wrIN2Vf8qLBzD7Nh58PYT0GrD9eZuivf5Y5MHlrll9FTzFw3BygPVOlZ7jvFOMSk
 vh0wnwW2LjbyxH26L8H3uRT31J/TQvhgmlL4mkG2H0/JvipefTj2lU52w==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Dynamic size calculations (especially multiplication) should not be
performed in memory allocator (or similar) function arguments due to the
risk of them overflowing. This could lead to values wrapping around and
a smaller allocation being made than the caller was expecting. Using
those allocations could lead to linear overflows of heap memory and
other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl81=
92u/r819xU_phy.c
index ff6fe2ee3349..97f4d89500ae 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1195,17 +1195,17 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 	u8 e_rfpath;
 	bool ret;

-	pre_cmd =3D kzalloc(sizeof(*pre_cmd) * MAX_PRECMD_CNT, GFP_KERNEL);
+	pre_cmd =3D kcalloc(MAX_PRECMD_CNT, sizeof(*pre_cmd), GFP_KERNEL);
 	if (!pre_cmd)
 		return false;

-	post_cmd =3D kzalloc(sizeof(*post_cmd) * MAX_POSTCMD_CNT, GFP_KERNEL);
+	post_cmd =3D kcalloc(MAX_POSTCMD_CNT, sizeof(*post_cmd), GFP_KERNEL);
 	if (!post_cmd) {
 		kfree(pre_cmd);
 		return false;
 	}

-	rf_cmd =3D kzalloc(sizeof(*rf_cmd) * MAX_RFDEPENDCMD_CNT, GFP_KERNEL);
+	rf_cmd =3D kcalloc(MAX_RFDEPENDCMD_CNT, sizeof(*rf_cmd), GFP_KERNEL);
 	if (!rf_cmd) {
 		kfree(pre_cmd);
 		kfree(post_cmd);
=2D-
2.25.1

