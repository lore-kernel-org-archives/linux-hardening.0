Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFDC433E9
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Jan 2021 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5535B23A62
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Jan 2021 20:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbhAUTsg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Jan 2021 14:48:36 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:56712 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbhAUSro (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Jan 2021 13:47:44 -0500
Date:   Thu, 21 Jan 2021 18:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1611254762; bh=1Awk2X9LSHOQQZek4o1ELWbmO0BY+pTltTaN3f2WBw4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=CrQodZ1xZM2FLIl9dUu8OGQbAxk8pFD5PDH+MeGcVSm7yNrjJgMYceYpJ4DtZ6Sz9
         G/sT2qYGM4zcgSHo9UI6KRunrCt2lTG0vIvGYhsz9kz4rNQgA4Ezy7jbPUVTNIcVJL
         f6IRqw8gtdbvMnVWdzcFu1tb0zBq5sC+tjaJTl8RpxB5H9BAOGuxyp8vDr83yRf18S
         HymS15rUgb8k/enkIRmNlOLFHj/PGIhv7Xf2pJrkpU55bodYBCL52/62XlNDcz9v/P
         fg25BXyyT2dj95PJUi7CWskvbskXafSVA27y9dZV8ER7go6NBgPOxEdr4deCWYFAdG
         Tb+Pk1nLNANug==
To:     Kees Cook <keescook@chromium.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Alexander Lobakin <alobakin@pm.me>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH kspp-next] kbuild: prevent CC_FLAGS_LTO self-bloating on recursive rebuilds
Message-ID: <20210121184544.659998-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

CC_FLAGS_LTO gets initialized only via +=3D, never with :=3D or =3D.
When building with CONFIG_TRIM_UNUSED_KSYMS, Kbuild may perform
several kernel rebuilds to satisfy symbol dependencies. In this
case, value of CC_FLAGS_LTO is concatenated each time, which
triggers a full rebuild.
Initialize it with :=3D to fix this.

Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 668909e7a460..2233951666f7 100644
--- a/Makefile
+++ b/Makefile
@@ -895,10 +895,10 @@ endif
=20
 ifdef CONFIG_LTO_CLANG
 ifdef CONFIG_LTO_CLANG_THIN
-CC_FLAGS_LTO=09+=3D -flto=3Dthin -fsplit-lto-unit
+CC_FLAGS_LTO=09:=3D -flto=3Dthin -fsplit-lto-unit
 KBUILD_LDFLAGS=09+=3D --thinlto-cache-dir=3D$(extmod-prefix).thinlto-cache
 else
-CC_FLAGS_LTO=09+=3D -flto
+CC_FLAGS_LTO=09:=3D -flto
 endif
 CC_FLAGS_LTO=09+=3D -fvisibility=3Dhidden
=20
--=20
2.30.0


