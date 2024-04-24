Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5A16190A
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976187; cv=none; b=owZ/a3n1HW2NYX5N6kDFolmDiVY71n2F3ojEpPHqtfFeKMYdmUh0qHAFz4ZpaiS0h0PUwgCTZ9/QfJ55g4v3jHLZMF/5rm+blx8GMoqmyOledVVWt1b/7PiwETxao4PwbBB40S/9utu/ZPYHHp4MVpEz+r+ee+c7HBs7RlboUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976187; c=relaxed/simple;
	bh=8+7ximJNE3huew93u7w7rKw7nI9gr+b5vuxXFU9vyvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FOGbj3c6UfSQCArCY9Yz+9aWFMsvRav5CledoET5DyPzhb0eWVwsbWTqJgaNkDQuA126f/9p7G32o0fzkwdjT3eOuKNeKkclR7ZcrL/4yuI8pN2t86hUbVq1SIN6yPJurLOwb8B6YfF0xGyDy0hISLPy8ZqF2klPNyJ4jcUZ3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A+dLW/1n; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+dLW/1n"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ad8919ba0cso103375a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713976185; x=1714580985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+9qworkCYA/dEd2E6NqOCyfCT0RGwXnd8JnfZdAXT8=;
        b=A+dLW/1nuw3sXHG7tlRFKZsrOJJQTLeroSS5BwbJTNp2IIxFlFuTIdUc5C+MkKV7Tq
         VVUKXa/s9bFwwgIOZsy6ZwsyqwkkctPuEN7S3T05Q0xTfwy8si0YvPPSRX9Sx0K5J8Vd
         2zUeHYKPpCxeAL8/5+zuixDKVfO4+L2Sl1a4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976185; x=1714580985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+9qworkCYA/dEd2E6NqOCyfCT0RGwXnd8JnfZdAXT8=;
        b=tZBZyWcCunhSrqlEPc7w+1xY99wVqOkAyPWKDejZvB9WacSHeEEyh1/CcnOPJhEj/1
         iusEYKmhQwWnUc2Ji//wwgeuyS+d66T3TL/M9J1pqP3keer2FouEIbLKZEk5Y8cXNwTS
         +pWIvjVtjRYCnvVnw4AkJ3EqINYqQxGGwpf6EqtjHCtbb2qVzlA9XlBm2yE2j1Qsp1JP
         rRu51MdLsg+zQ0X3s7HofhWmWO0mfhVMmxH78nAoG448cO2kcwfykzzDIOvXEWg9JtH1
         3iIJgq8SQr2YEOp8R3G4776v5XfdeU79FTvYQyoA7xAiUieTq8P2G+7renC7OZCkJqX6
         BLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSE1uONBszdWIKMZ6dLxSKKzYEJsdBoHidMqQQV6t1w1busgA0Z2beORw0QGoO7wkiZinsTg0WGtmrJX9AuSDTnVvOwWb02eNpSsc9OXst
X-Gm-Message-State: AOJu0YxB/tl8Ux6/f73XPyEGbMACqC5n9lB1/Or92pXIoEEJ/2CLncP2
	Q66Cz4EahDdoK7wxURRDJvMAZgzPKzY/EYrecXykwOW0pOuIYXilA0V6nzSSiA==
X-Google-Smtp-Source: AGHT+IF8x9JyIeAJSw7VIxu8xH6DCylTL+H9JeDriwvvZQ1jU7WO3B56bHHqDAeGQFwXjN+8dL18Hw==
X-Received: by 2002:a17:90b:1b51:b0:2a5:12dc:1609 with SMTP id nv17-20020a17090b1b5100b002a512dc1609mr2715263pjb.39.1713976185447;
        Wed, 24 Apr 2024 09:29:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b002a269828bb8sm11388846pjh.40.2024.04.24.09.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:29:44 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: Avoid i386 UBSAN handler crashes with Clang
Date: Wed, 24 Apr 2024 09:29:43 -0700
Message-Id: <20240424162942.work.341-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3634; i=keescook@chromium.org;
 h=from:subject:message-id; bh=8+7ximJNE3huew93u7w7rKw7nI9gr+b5vuxXFU9vyvI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKTN3dyNIMp+O7q+bYM3wOmd9O8k5WMCGmgktL
 WF4UQsY51yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZikzdwAKCRCJcvTf3G3A
 JosuD/4l0IQyly+v15MjXYIsDPKX4IUkiRHY6oGlP49ZY8fFeuSdWJ3yArBs2w2o0pI0Xz7TeNc
 xcw5Xe5jnSvWWVDiu6qp0yW4tCOvqM6yNZrf7rn7xlvHjmJ30bKKPw5RC0sNlkxt5V/nPLVUoER
 /k68qektDitJ9fBrTUwESO45p5eEMf02JAGnZEWFiKRx1VLYS9p4eLuHsegE2iV6NBeoQoWbjwp
 ogvJwyBtZbApgP1wO3TnY6fU2f7t91bS2KKqv7oaFXxiR1VIoHLnSjMD7E3juz/7XvDWRkdH9aV
 MKVZIOoiX6ab+ck7wlBvhVEUqJwGboQ9DeZ75AY2+SueBm/5ZfdIL9JRYMoCtSbMxPi+QLCfc9Z
 gSNMRitoL7+KpQFNircO1i/MsOr1So2bnjiGk+JJv/I9QbAI22XZRCVwFebXoc98lAhooaByiYV
 m+BDlmdQC9F8Bo5Qu7GUHHYcBQvrhI61ZNlcRSC2RpmDi2/grWEZCJws+Mn558xoHd9PLeX0sQK
 l7hQO4NRBwXVkglPNiVSiT6b/ZKBR7+ys46WMhRmOtxhm0JQhJGo5LSfrCa3HRahV8uw335O4P4
 uyRt7a8PDmyCLIOM97cCwO8uPgqPud0XMPyhHaEpnusRbh5Icubm3EELeU/K+gvYCId554loEZ6
 /UXvy36 I133L96A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When generating Runtime Calls, Clang doesn't respect the -mregparm=3
option used on i386. Hopefully this will be fixed correctly in Clang 19:
https://github.com/llvm/llvm-project/pull/89707
but we need to fix this for earlier Clang versions today. Force the
calling convention to use non-register arguments.

Reported-by: ernsteiswuerfel
Closes: https://github.com/KSPP/linux/issues/350
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: llvm@lists.linux.dev
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 lib/ubsan.h | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/lib/ubsan.h b/lib/ubsan.h
index 50ef50811b7c..978828f6099d 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -124,19 +124,32 @@ typedef s64 s_max;
 typedef u64 u_max;
 #endif
 
-void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
-void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
-void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
-void __ubsan_handle_negate_overflow(void *_data, void *old_val);
-void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
-void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
-void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
-void __ubsan_handle_out_of_bounds(void *_data, void *index);
-void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
-void __ubsan_handle_builtin_unreachable(void *_data);
-void __ubsan_handle_load_invalid_value(void *_data, void *val);
-void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
-					 unsigned long align,
-					 unsigned long offset);
+/*
+ * When generating Runtime Calls, Clang doesn't respect the -mregparm=3
+ * option used on i386. Hopefully this will be fixed correctly in Clang 19:
+ * https://github.com/llvm/llvm-project/pull/89707
+ * but we need to fix this for earlier Clang versions today. Force the
+ * calling convention to use non-register arguments.
+ */
+#if defined(__clang__) && defined(CONFIG_X86_32)
+# define ubsan_linkage asmlinkage
+#else
+# define ubsan_linkage /**/
+#endif
+
+void ubsan_linkage __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_negate_overflow(void *_data, void *old_val);
+void ubsan_linkage __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
+void ubsan_linkage __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
+void ubsan_linkage __ubsan_handle_out_of_bounds(void *_data, void *index);
+void ubsan_linkage __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
+void ubsan_linkage __ubsan_handle_builtin_unreachable(void *_data);
+void ubsan_linkage __ubsan_handle_load_invalid_value(void *_data, void *val);
+void ubsan_linkage __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
+						       unsigned long align,
+						       unsigned long offset);
 
 #endif
-- 
2.34.1

