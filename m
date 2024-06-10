Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D6142E91
	for <linux-hardening@vger.kernel.org>; Mon, 10 Jun 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033211; cv=none; b=nq7P4cogd9uSRIR1l4LwL0CHbp9PtfYxj0B+LrRY6a7zNRNUJbtJDefOe4SjRaDsDbX6u+Ww0JnuzqxNHyfrAF3IsCAdI3RNKq3oiInwmzzcFRBtLsj6t4bcISCrckpPCNoaHG9uue4HltZo5yVv58giEBkjYup92EklrQCHWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033211; c=relaxed/simple;
	bh=djm11PbPLUTyQQJ9l3sDzgoLBWIugExYLbEBTnWiegA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SKFkBefeDy8c5uk956ceniWe/v+poFJaVEs9wRab4jtdXylc99mnpBnZkcAts4ix06qoffrjO7lmmOVzZhn2HJXebS4rioq4RBf+Od8Y+JkVsRUGiXKZ0IgAAiFZYNO55VMALeY4HJj0RaeWoZL1tzDDH9rB/MwYlTbG6hPgDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgkp0Ga7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgkp0Ga7"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42153125d3eso33439345e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jun 2024 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718033208; x=1718638008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DMRJJSTKqYUGD8dus+yMRcwA/79j6mVNZpg6fqpBuM4=;
        b=pgkp0Ga7h4ZccLbSE/rOnb0ucU2zJnjBZkR+d4jPHlMY/9QxCUql8K8GjldEpGnZL6
         +jMgCGioDpvs7wXTO26y9gzXwUxgHszbDN4vR8hhkSq83hfggwcxlJ/Aa3A8RkitXimv
         vt+XcdytZ+RfSnkJjT1GMYIEJc5AJjanLJ7Qd/STohiswdbaV9uhYMOfTG4MO2+S8Gw7
         xKdG5WdR7YkiP82ebb7h+6nijYJObCTdVn09ANsIi62N8MVXZdmZ9C4S0MyByHiLJc6U
         ZzCJc3fGJKd8bHfRXtgvKQcOujkLc7W+ALDPt7EmLMHDJbARrTvrrAWnlHogE0CmNLgh
         uV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718033208; x=1718638008;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMRJJSTKqYUGD8dus+yMRcwA/79j6mVNZpg6fqpBuM4=;
        b=wIQQFo18CtW+sXA9EDVER8enwOL2EPuHsvr2whw39DZIHWQ3eOwyEonN4SoHNX1eYj
         4VyqTV0Ri/diXNe04jvT1juseQtcNRhGtYs6sehXimRL+TmC+6ZbvCUHQH3xda4oe9JB
         pCe//1Kz6fzb0TNXCnEqQ9wpBqEKMAG/wYD0FmCZYcfDPVzIV+IkVY6fWKhSAStLLslh
         TDc2X37dK7WKdKnaDqx8gpB2gT58fw/jEJL3hX7FSHwacNZBDJyXpZ/r8C7KQCJS4Ili
         x93PXFGtDJ04JJm5qgTosiCDRJQVQLyhZrS1kqfodPgyG+NTkzOLUUut/Hj8TjgJUVCn
         DIHg==
X-Gm-Message-State: AOJu0YxPX6Rb/Z8ViIYIYJ1b5i/aks1XdWJ2kPQfciOwcNoZrcHWXbBh
	dz8CsUarNSZgocRc5wp7QG6hdZf/GNJOmKMtUA6QoLjvHXUCrZupT3f1Zw0wyMhNiw2LCw==
X-Google-Smtp-Source: AGHT+IEgVKYDJAU1PB7jiqGHNCiuMfVzxelJUEkF9CTltoEJ0PqEdL6NNITTyaGvrim+bR2T+XtvJETE
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5487:b0:41f:e5af:181e with SMTP id
 5b1f17b1804b1-42164a4e229mr408355e9.7.1718033208283; Mon, 10 Jun 2024
 08:26:48 -0700 (PDT)
Date: Mon, 10 Jun 2024 17:26:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=ardb@kernel.org;
 h=from:subject; bh=eJNPUyXrEg+4UdWAVwkHUS/E+tlxeHkytZaImtWFzIg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS1dWn/dQ06xa7aMn3l3LbaR6hWs1Np5teBSz7+sug23P
 oflSz3uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPJnc7wT69IwtFPpvN/y/+7
 Wxg77slM8LghKBZ9uEr/3+zyi9InlBj+Sk+1KnEoyzgmLs4Xu2au+k6pq8ECnGs2vXyuJTLnwF1 NXgA=
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610152638.2755370-2-ardb+git@google.com>
Subject: [PATCH] crypto: arm/crc32 - add kCFI annotations to asm routines
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-crypto@vger.kernel.org
Cc: linux-hardening@vger.kernel.org, herbert@gondor.apana.org.au, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The crc32/crc32c implementations using the scalar CRC32 instructions are
accessed via indirect calls, and so they must be annotated with type ids
in order to execute correctly when kCFI is enabled.

Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/crypto/crc32-ce-core.S | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/crypto/crc32-ce-core.S b/arch/arm/crypto/crc32-ce-core.S
index 3f13a76b9066..88f9edf94e95 100644
--- a/arch/arm/crypto/crc32-ce-core.S
+++ b/arch/arm/crypto/crc32-ce-core.S
@@ -48,6 +48,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	.text
@@ -123,11 +124,12 @@
 	 * uint crc32_pmull_le(unsigned char const *buffer,
 	 *                     size_t len, uint crc32)
 	 */
-ENTRY(crc32_pmull_le)
+SYM_FUNC_START(crc32_pmull_le)
 	adr		r3, .Lcrc32_constants
 	b		0f
+SYM_FUNC_END(crc32_pmull_le)
 
-ENTRY(crc32c_pmull_le)
+SYM_FUNC_START(crc32c_pmull_le)
 	adr		r3, .Lcrc32c_constants
 
 0:	bic		LEN, LEN, #15
@@ -236,8 +238,7 @@ fold_64:
 	vmov		r0, s5
 
 	bx		lr
-ENDPROC(crc32_pmull_le)
-ENDPROC(crc32c_pmull_le)
+SYM_FUNC_END(crc32c_pmull_le)
 
 	.macro		__crc32, c
 	subs		ip, r2, #8
@@ -296,11 +297,11 @@ ARM_BE8(rev16		r3, r3		)
 	.endm
 
 	.align		5
-ENTRY(crc32_armv8_le)
+SYM_TYPED_FUNC_START(crc32_armv8_le)
 	__crc32
-ENDPROC(crc32_armv8_le)
+SYM_FUNC_END(crc32_armv8_le)
 
 	.align		5
-ENTRY(crc32c_armv8_le)
+SYM_TYPED_FUNC_START(crc32c_armv8_le)
 	__crc32		c
-ENDPROC(crc32c_armv8_le)
+SYM_FUNC_END(crc32c_armv8_le)
-- 
2.45.2.505.gda0bf45e8d-goog

