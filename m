Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C621C27C44
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 21:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjHPVkB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbjHPVj2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 17:39:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD411FD0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 14:39:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d799aa369so7132537b3.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692221967; x=1692826767;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgfv9XpiXMzsq2kLywbyVX/AZp8i35sYGiNA5Uju+Tg=;
        b=B3mPwfTrF1Ige4phc1lVSf7W1iqdnDLezfu/Ms6Scp4jsTZmzB8Vfhv4DjxvTlOZcs
         tk9VlKRIXH/RwiRpno3xlRg+kYX83WMe3fSZqxLsQk8WKCjS3QrUPun6+6rZd3biMiEj
         ZG5kCeCarobtr+BZHlkQj9h7xwP4ChxqgVGCxRNAks9MBaH2PoN9TO+DMTtcDE8Js0xd
         33v65vYmTZ13eJmIkbsGN9AMOKxl5rl/FHmo+ofyFjDDjj5uScL02oYID9O494OUmQQa
         ZMvGjuUfwo8WSY4vIfUiJkdlTULm7UYdPh65MmP5xyig/2Fz+behqtWgnayNAE3uRygV
         KUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221967; x=1692826767;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgfv9XpiXMzsq2kLywbyVX/AZp8i35sYGiNA5Uju+Tg=;
        b=DnSeZCMNjESAv/k9JyItUG9WS9Z/50rYgD5DhGKGuFv933S/ecDEUVIq+wa+tcIMya
         qap7GSiZPCf1V08wXKEvNT4ohMyXi9y81psdTmqECzS4A6njyYp8cJK7sojE6F8eIVuX
         JwRYO6rX86/gmEhO5shK4D+4xf7KWKyMAdmyA05B8vvYMAHtuHV2fC+DsX8kbdRzqgfC
         kCHwcR76nuaO8KYxWXm/JbVRNNatbukoJNXRS9bXg6ap/o4uxOSEV25+0oyiFUvw0nfE
         QiJ5TZM/SP7ScmIa6mONMBDJKlUp6ecpEflwjfx+eZnfnTh2XSVf8xX9nC/vjaeD1y5W
         PwSw==
X-Gm-Message-State: AOJu0Yzozbd2PIkmTWZlVgl379fYpBmgHnB32fUl01yLLWIdGgsXVPmI
        rNWWOVXcspqAwpZU6njadJSpqj8nskxqvVfehg==
X-Google-Smtp-Source: AGHT+IEVHWg7faDJGpLl8t8qRgynXOF8x/oPuFyxnuV6asqFbVWol9ZvrF92XF57cIBZH1l24F8+JcpNC2abmYHuJg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ae66:0:b0:589:9ebc:4bfc with SMTP
 id g38-20020a81ae66000000b005899ebc4bfcmr41356ywk.9.1692221967232; Wed, 16
 Aug 2023 14:39:27 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:39:24 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAtC3WQC/x3NwQrCMAyA4VcZORtYW5zFVxEPpctcQNuQFHWMv
 bvF43f5/x2MlMngOuyg9GbjWjrcaYC8pvIg5Lkb/OjDGN2E1rRk2TBpXlHqh1QyyjO1perLUCy gklTjVnXDeE4ux+lCsw/Qm6K08Pf/u92P4wcoxlPwfwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692221966; l=1607;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=30eCBoYcInKFNOcnuhFfYjRixFwqc2selXbnOKgw6dI=; b=xDzKLH1yz1jxJwierFXeVLUgiJfBIeQIt+nXl5gaKMxMfmxMDGzOJZDP9cseijM4Ywj0ktUp1
 Q2cOTSB+/0pDQWF0iqwsPv7ZIS9SsHY6BJ5okfK8iTSE6218SV8h728
X-Mailer: b4 0.12.3
Message-ID: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
Subject: [PATCH] powerpc/ps3: refactor strncpy usage
From:   Justin Stitt <justinstitt@google.com>
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

`make_first_field()` should use similar implementation to `make_field()`
due to memcpy having more obvious behavior here. The end result yields
the same behavior as the previous `strncpy`-based implementation
including the NUL-padding.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note:
This follows up on a previous RFC which can be found here:
https://lore.kernel.org/all/20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com/
---
 arch/powerpc/platforms/ps3/repository.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 205763061a2d..1abe33fbe529 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -73,9 +73,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 
 static u64 make_first_field(const char *text, u64 index)
 {
-	u64 n;
+	u64 n = 0;
 
-	strncpy((char *)&n, text, 8);
+	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
 	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
 }
 

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230816-strncpy-arch-powerpc-platforms-ps3-repository-85a1c867ed23

Best regards,
--
Justin Stitt <justinstitt@google.com>

