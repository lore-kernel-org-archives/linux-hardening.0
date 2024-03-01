Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13B52F81
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 04:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268284; cv=none; b=ljg3/2K/J4jyLKtLd0amWq/2KJgGOLuSG7Bve4st6iAeetQLF3HwbGYCaVS4vwEbXEhg5JORV4YQfQLdJz19E41Z4A91wVUDumpYAhw8GUJ/DQcapTH4czU1LBxBYe5Mx8063IONk1EHJJatSerg7i/WRETj7ulJ0b+WjTPUkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268284; c=relaxed/simple;
	bh=mZCSNoaZZKbSakFDmMwKoymVUugJ1bVB7eASshxhkHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GODu8cVgNNbReDZ++TQ7TZap1FhT/hXkKucYgYASyU2LpZ629wFoUYNP2ANwc7SBYWe8X9k+04dg8RAEiaQWLrAe0o2tw5jUItBy9Wn3ToJ/3ms3B+Xl530bLujYWQDOTJ4ai30wwlXeYerMHJVOAiTUxft+1Jow5+ZX9ovX1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SsL/ZEBw; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsL/ZEBw"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bba50cd318so1174395b6e.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 20:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709268281; x=1709873081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUicd2n6ht+rA5byppQHy+nx4IzWcP+LTMq589jP68Y=;
        b=SsL/ZEBwo4yOajF83l3tWeE3zUcqp7+MGFhG1sukjrLqR79CRZRqIeh5V84tuW/a72
         s3HVZoy3P2td1BHQR1YxsPK/2MOlCSm4QbWKiLbVFq/vWo5o1kJOnEluOV6zp6sxwt6O
         TXFIiZwxoMgHcfhzz6uQnnC5aBpEpaw9nK2fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268281; x=1709873081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUicd2n6ht+rA5byppQHy+nx4IzWcP+LTMq589jP68Y=;
        b=YZl7PGfx6+7HPIHf4N/Sci/pGe+gwyWCDEOzOIFSH0FnxsxBgUF87HR2DKdDPWKNQv
         LTzX6dYVXXid8ys+MZtCEVG1iFv7nSRkJayRLA2YEBxhCt8wpE7dZRV06vgTuPeIT8rk
         /05pm+1wYl3pY21bSfETxuwZ31Ix6qiie5a6ljO5cy2Hswgp5lrdClipyv1Qbz/a1Gat
         SPVCc1ntdM2BxJXw1VQbq9hDvvDQNnWKwxuPw6SEEjQtPwrcOl23ALL5TR9FKd09Lrfh
         XeRCue93+so19oOszz4Uwq7tIfuV5+kf6Xp9EIJGSMr89Ei3Kba276gJp/L3saa54OHz
         k4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUZIG0v7AZW2L1fo6SdhP5qX0hPaS1zw214UPn9li6g+PdtveH2WPX+8FTS0ajRsAVfZ9J6GX+B2GXUVGNtwwb7Uti3SCOmUI+uU/rFf2N
X-Gm-Message-State: AOJu0Yw2ElTSBKUyyRIi93QeQXJL0RvKTUOOEuQVD/tQ/+ALbZv0rlFP
	MsWMn6pMNqO2xOvTqfgvn+aa7T7fcDTeHtupwszsQxwGxdbog0gxggXA6WKR0g==
X-Google-Smtp-Source: AGHT+IHxhneCZvSya6MvyvgL3RGHKA11Kn0g5FZc6lrd0p58P+2hnWFkDMdO/hK42mOZSjstfdFApg==
X-Received: by 2002:a05:6808:bc8:b0:3c1:663e:ceb2 with SMTP id o8-20020a0568080bc800b003c1663eceb2mr831324oik.24.1709268281588;
        Thu, 29 Feb 2024 20:44:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id se3-20020a17090b518300b00296fd5e0de1sm4444309pjb.34.2024.02.29.20.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 20:44:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] compiler.h: Explain how __is_constexpr() works
Date: Thu, 29 Feb 2024 20:44:37 -0800
Message-Id: <20240301044428.work.411-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3830; i=keescook@chromium.org;
 h=from:subject:message-id; bh=mZCSNoaZZKbSakFDmMwKoymVUugJ1bVB7eASshxhkHw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4V01DNueOMxKBHs1UNYi4cYy1NODxLhYG/ufE
 zM5XYdHsWuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeFdNQAKCRCJcvTf3G3A
 JvsWD/41meKbJvTmmS63eBbTW06592QnHpGowqbBjGfTc/aFd2X9Y5fyc1502V1dr2w1pFO9mhD
 k4zOwkMno3DeB8ls+aLkQ+IG0qv2mBAT+sKkYUlTd2d04/e6PgwF/wKaEGGefhxhhFbbIyme616
 3fZ1By98Hs9K3QbuMNAD8/1ns7gRqsm8whwJACqeEVPJcmVUG7CYqw0xv+OyvLSLb9b2gVe/vav
 +aNTSrCHBaEG6X/SUZYK9Ms45l8R8MRdo4lVnyWWmFXFKtkiftdogKeDMbDcb4IMtbNo6khAW06
 1cboFMV7ZcvZF49NhMkxN/du3mjyhWZfN2CpcHo2PiU2CM3dHX2itJl/AKT/nrlSl1TnUaduxSM
 aRU48jYdYspLBfe5MDHPoIfvE2e7vip5KxyVLzuTDDTsI+s45N4jHSEukiiKNljLkV2t8J4mC7S
 DPkoAEdEYaleWvakf94egJdxCPE8F723bHoBvSgvcr1P8u8hVPhXHRyraYXcuaZipZewdT5JQ9B
 rev2s5GZJLLvnJrfYMN9sR9SO3DvmS6GODRBzjD+u00isEXqM8EQUs0MlitaXcob6r9/5XIcpKp
 3bCK0SFvjhdlPxiSKaOZSEjVzOiQ5xybHyVsdY27A/qvPJfRdjsEu/hf/cHqR3dEfc5WDAxmM2+
 Rb1bEsY JaZm7f4Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The __is_constexpr() macro is dark magic. Shed some light on it with
a comment to explain how and why it works.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
v2: *thread necromancy* rewrite based on feedback to v1
v1: https://lore.kernel.org/all/20220131204357.1133674-1-keescook@chromium.org/
---
 include/linux/compiler.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index bb1339c7057b..38cd9f3c8f6a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -231,6 +231,45 @@ static inline void *offset_to_ptr(const int *off)
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
  * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ *
+ * Details:
+ * - sizeof() return an integer constant expression, and does not evaluate
+ *   the value of its operand; it only examines the type of its operand.
+ * - The results of comparing two integer constant expressions is also
+ *   an integer constant expression.
+ * - The first literal "8" isn't important. It could be any literal value.
+ * - The second literal "8" is to avoid warnings about unaligned pointers;
+ *   this could otherwise just be "1".
+ * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
+ *   architectures.
+ * - The C Standard defines "null pointer constant", "(void *)0", as
+ *   distinct from other void pointers.
+ * - If (x) is an integer constant expression, then the "* 0l" resolves
+ *   it into an integer constant expression of value 0. Since it is cast to
+ *   "void *", this makes the second operand a null pointer constant.
+ * - If (x) is not an integer constant expression, then the second operand
+ *   resolves to a void pointer (but not a null pointer constant: the value
+ *   is not an integer constant 0).
+ * - The conditional operator's third operand, "(int *)8", is an object
+ *   pointer (to type "int").
+ * - The behavior (including the return type) of the conditional operator
+ *   ("operand1 ? operand2 : operand3") depends on the kind of expressions
+ *   given for the second and third operands. This is the central mechanism
+ *   of the macro:
+ *   - When one operand is a null pointer constant (i.e. when x is an integer
+ *     constant expression) and the other is an object pointer (i.e. our
+ *     third operand), the conditional operator returns the type of the
+ *     object pointer operand (i.e. "int *). Here, within the sizeof(), we
+ *     would then get:
+ *       sizeof(*((int *)(...))  == sizeof(int)  == 4
+ *   - When one operand is a void pointer (i.e. when x is not an integer
+ *     constant expression) and the other is an object pointer (i.e. our
+ *     third operand), the conditional operator returns a "void *" type.
+ *     Here, within the sizeof(), we would then get:
+ *       sizeof(*((void *)(...)) == sizeof(void) == 1
+ * - The equality comparison to "sizeof(int)" therefore depends on (x):
+ *     sizeof(int) == sizeof(int)     (x) was a constant expression
+ *     sizeof(int) != sizeof(void)    (x) was not a constant expression
  */
 #define __is_constexpr(x) \
 	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-- 
2.34.1

