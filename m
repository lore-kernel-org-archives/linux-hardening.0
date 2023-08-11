Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265EC001DE
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Aug 2023 21:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbjHKVTc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbjHKVTa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Aug 2023 17:19:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F91FED
        for <linux-hardening@vger.kernel.org>; Fri, 11 Aug 2023 14:19:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586b0ef17daso66479797b3.1
        for <linux-hardening@vger.kernel.org>; Fri, 11 Aug 2023 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691788769; x=1692393569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiHGiTVfdz5CucudaZHkceNNqnAp127R9oXTgpxLmS0=;
        b=69/W2KdBUbTfVSLt7H2R1qqS3DXKFqFlWpbGW7Cg3ECEi8vGGHJaho4vRdFup3fEeV
         zVcU2qUDoBdNFmSOCqTHHDQHKg2IrdYm39Vt5gS5rz94OnIR7DEtN2lsAVmSb0Tqz0Ht
         Z5l8peAOiEHZtJ2Gklp82OPAuiBTHojD7Pg5Q7iZZcREV+yEUuxSLNG0n8waPGLDRreo
         a+NcGUKV8kMK8j8cMqGepg+/OizzIBECrGyezlwSfbYn9niSi09jOGbJhiGnOPkuEtJ8
         YU/x8cXvc9erPDbri9oiyV6O0REpsuYGmemCP2W4ouJtR3u/tP7DEk/xn+Z9gKF0xqOQ
         LNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788769; x=1692393569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiHGiTVfdz5CucudaZHkceNNqnAp127R9oXTgpxLmS0=;
        b=fLuaYT9UM3G9Iznox5ZfK/tTTDtlSbqnVxh0tJZrGbJ1wWetyGRtQ1RGYifTWRl6Mg
         osxXGeQO2bwedcSx7cGJ/aX4pJJ5RkMm+uxymxh24SplcvXPCnRPE7qq/ph14bYvGIDN
         clVW1xH+dVH04szZK7B6Aq7e0Cp2XxminLL8o18CmrPPIMuuFt+p6b/hNoo6EP2iDUeX
         gFMeAiqeuL+VDr+05Nj8DrBjzoOzOEDjzQ3X4OP3MhLgqS/n0dtXATRYvCGwOy3v9z5C
         P2lAo7fi3iodnYKW5ZE09QpWuE4oJ9Hd0VPF4xYI0If+jJpdF+Cm9BeKQtFSjvvVKsnP
         Zbcw==
X-Gm-Message-State: AOJu0Yy1TxGzxD/h18R6Pv2eZ/EbYIWXd+k1TC9H14pgs8h/dUvDkI+8
        4UzDIPQlbVDa9Tt379uJALDpdbvqiBILQtk8zg==
X-Google-Smtp-Source: AGHT+IHbwU50kF0vOvJsfl6xiGMeCABLjZMuvF4jlcuA/i0PNQczwluQDWHlLkKRUAyDj0PAcSup4QVhVi2nvA+/Lg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:af49:0:b0:589:a610:aef with SMTP
 id x9-20020a81af49000000b00589a6100aefmr76862ywj.2.1691788769080; Fri, 11 Aug
 2023 14:19:29 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:19:21 +0000
In-Reply-To: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
Mime-Version: 1.0
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691788764; l=2360;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=un5KrhEbUeSG5MIia1JYWEm7kQ5KlO4dof2rfH0SxB0=; b=3nGjJYu+m7uWyObArsWKunAcpSZnHjKe9mn5gkmY/yM21roqfaVuczXVmSVp0u0rKkq9+vbWf
 LjstrWwCo1OAJQJrgXlXQxNm1g4I4F9O5JB8O/Ope1+HZNTSmJBVJ/g
X-Mailer: b4 0.12.3
Message-ID: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-3-301052a5663e@google.com>
Subject: [PATCH RFC 3/3] powerpc/ps3: refactor strncpy usage attempt 2.5
From:   Justin Stitt <justinstitt@google.com>
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Forward declare `make_field` for a cleaner diff

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/powerpc/platforms/ps3/repository.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 6b731a5d4adc..6a08bb7704da 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -20,6 +20,8 @@ enum ps3_lpar_id {
 	PS3_LPAR_ID_PME = 1,
 };
 
+static u64 make_field(const char *text, u64 index);
+
 #define dump_field(_a, _b) _dump_field(_a, _b, __func__, __LINE__)
 static void _dump_field(const char *hdr, u64 n, const char *func, int line)
 {
@@ -63,33 +65,33 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 }
 
 /**
- * make_field - Make subsequent fields of a repository node name.
- * @text: Text portion of the field.  Use "" for 'don't care'.
+ * make_first_field - Make the first field of a repository node name.
+ * @text: Text portion of the field.
  * @index: Numeric index portion of the field.  Use zero for 'don't care'.
  *
+ * This routine sets the vendor id to zero (non-vendor specific).
  * Returns field value.
  */
 
-static u64 make_field(const char *text, u64 index)
+static u64 make_first_field(const char *text, u64 index)
 {
-	u64 n = 0;
-
-	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
-	return n + index;
+	return PS3_VENDOR_ID_NONE + ((make_field(text, index) - index) >> 32) + index;
 }
 
 /**
- * make_first_field - Make the first field of a repository node name.
- * @text: Text portion of the field.
+ * make_field - Make subsequent fields of a repository node name.
+ * @text: Text portion of the field.  Use "" for 'don't care'.
  * @index: Numeric index portion of the field.  Use zero for 'don't care'.
  *
- * This routine sets the vendor id to zero (non-vendor specific).
  * Returns field value.
  */
 
-static u64 make_first_field(const char *text, u64 index)
+static u64 make_field(const char *text, u64 index)
 {
-	return PS3_VENDOR_ID_NONE + ((make_field(text, index) - index) >> 32) + index;
+	u64 n = 0;
+
+	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
+	return n + index;
 }
 
 /**

-- 
2.41.0.640.ga95def55d0-goog

