Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF59DC433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 12 Sep 2021 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961F361050
	for <linux-hardening@archiver.kernel.org>; Sun, 12 Sep 2021 15:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhILPxT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 12 Sep 2021 11:53:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:36599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhILPxT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 12 Sep 2021 11:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631461914;
        bh=acR4bOYsVFW3jWp5YfwQ2ux3deK09WbrFwToGIM5Wr8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=betXKHWy88VQXJn/oCsS/DwSPiMD2g+7M5yrfDJEOq+jhucC93vV/XtyDal2sGlka
         xmLZAd1qc95FgGQo/fD6Hexyc1U0eU4F3MOswwlnsRtaIPKVoWwsU/TU3kZU34Ixy1
         o6q6OUlCeDsHz+PFAxZURE+H4JLobEx+KCy+QK/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N9MpS-1n28f01Ru0-015L0K; Sun, 12 Sep 2021 17:51:54 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Len Baker <len.baker@gmx.com>, Nicolas Pitre <npitre@baylibre.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        linux-i3c@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i3c/master/mipi-i3c-hci: Prefer kcalloc over open coded arithmetic
Date:   Sun, 12 Sep 2021 17:51:35 +0200
Message-Id: <20210912155135.7541-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:12Wxb35A9HfIn30GEUc5xzIzDRpJ5lPs/PpFMm+D3nx+SYskX9X
 5yUBASZXWNG9x2DIsftzvtH+mycCDGn0lBzzRKz56ZNK8N83gYraXbaelZVYvj1qHGY4PRp
 Bw5Z+ZJYd7WwV06KAuwduDbMYi+PUGmfCriF+/o+ZuERBS9ByFgl0T0wpNjoAKjQtVQRLsX
 NQGzDGcZrJZxytOJU6ONA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oa08IYzxaO8=:LdljQr4FvbYrpeql8L/94t
 zY6HFuPCFEUy2ku3dg6IYlfkM0GscR+L/nMs/9++kjR4mt7x5j60SP+LYaND79n/H/z65T1nJ
 Z8ryXDxs+dUVEXmY2dg0h3oWplA9p5t5TjlsaVefcbZmBz0zJgFff6L8mzPgDzOSAUufA5MiI
 ywrRDHL8wx4RF0xfm1MF6vpGoV0QUlQH4qakL/tvd511L3E1hovSS4+rJFAKy/KSP/IVIgSM/
 VHSWz+Nn7/BbBXFvHpReklkCtOw7R/BAYHdruVZ2/npUuVUgugu67nX6gogVqEF76Oq8pIIH9
 M4XLPoZFaY3Lbxu6KmtP9SMuMpJpbnDo7AOmytJW0X3NspfAgWPAY92IccplqemHE6tXOwGAo
 IofD6tMF5fTyIr7nqeRSmn+dmRqwth0ZLQtoH3bccwk1J+Q5A6nNz/p7J8HdYK+wz7IQ+ek91
 i9ExzqqQh2/IKqogfAcnh95n6iA5s3PYNjWXMNuju/Gv9Ku0Ip4Y7+qNSoakbPCnQVb2wo7fe
 4dKO5wLEBXZ1gnUwlaO9sisOQ206/MsEavQnzfT7GnTy9sZh7dlpsckaHoVvGdnNOOllOHy4y
 P7SPrfA+3Z0SG8DBnoG0bIa/kO9JGWyPpW8QmVb1EbqrDBnxC7SmH5ubF3cmbf0NriN11mMY3
 IHb5Bx5e2Z6iUvKRcFMxKYSdiIM3rRuzioBhueDDDh2OE1fBQ/EciKt4vDD76YhO4KNmFDIPf
 7qlnIZ4OVp6nK++R40P/mDcz2IsvaWih/ANNL8/qU2GO76j6UFRW719Gjzk7pbFSGTlgKP6lY
 HuRGsngGLpUxzKI8cna/stS1NvGKb6Ko0vrHgtalguhIKayqqMlcAF60EtFtLe1Sd4cXAic0p
 zDzxV4XnAyTqU4ShuSG0NYXgnJP3A/qy4VWWYro1qTvy7/Cygm/a/w2qLH11OljwIkyovBgK7
 9RY5/MP0sW2bfJNlT/nNzNlM/UYWZexuXq1aCxL4iljcsCNQYf0DEWbZ5q5evnUw+Jj8KjIPJ
 HHLn4sDWhIAVH7HVb1tacK0NgwL+2vcujrfjzh/tIaCYlErsWrBp/JxZAYakjJONdxWYM0psl
 j9QFX9ZDLnT36w=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/i3c/master/mipi-i3c-hci/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mi=
pi-i3c-hci/hci.h
index 80beb1d5be8f..f109923f6c3f 100644
=2D-- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -98,7 +98,7 @@ struct hci_xfer {

 static inline struct hci_xfer *hci_alloc_xfer(unsigned int n)
 {
-	return kzalloc(sizeof(struct hci_xfer) * n, GFP_KERNEL);
+	return kcalloc(n, sizeof(struct hci_xfer), GFP_KERNEL);
 }

 static inline void hci_free_xfer(struct hci_xfer *xfer, unsigned int n)
=2D-
2.25.1

