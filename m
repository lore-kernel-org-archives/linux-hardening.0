Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BD3D3339
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876814; cv=none; b=o4YrQm3LahmIrjLcJKUspRE1sWpIz0nbxUJ7Tt4Iav/G5jujHUoQr+mT/9fFe7aUzw0w+BfR5ZgPPAYTqrHpLchRkojGQxJ3/QAM24hBVligFNlfFSRJIof0n4sxfeTNvlFr1rjOH1W7lj1KiE7b4+288ASnxeista8nZEA44Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876814; c=relaxed/simple;
	bh=Apu7QMg5t9X4XqrrbiaHMr1fwOGa5UsX6I+AkCFq82s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFfgtx73LWB1ArgaWgjKy9u14UhZzLCiQSvnqb0s7udRp37oL7sl1NlVCFUeKyj5jydatJgrfxk6V5ioyCzIpauqqxObWUNcGfykIcYBSMpfUKMzjZTm8qjCD2HOeOKjwfWdzibAy1NfWdxZcSvViWNfDqB/MvyahgHNkBU7QCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu08MTWV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu08MTWV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so44122085e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774876811; x=1775481611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAjBJkYCqeFogUSVOqhybn+Qkp+h53Wf7afwElb+C9U=;
        b=iu08MTWVyQBXil+stpw+Uc+GBUJA0R0ERNFTJaaTpCyKaQlmZMq092fYT58Jzp8e2p
         Q18/BSrMjxx2mfOlwc52tuJSJ5vp3MNJo5OwKfQCjKA6CTXkuOqQKxCn7chURrIKn1Qv
         1EjiDWlaG+WvYocIdUZio+Y+5+of/9NwSKrnUbdUD0ZNhlTfCqw+fkKSNW/NHw7p94Eb
         I8TzqP3g+Hox/iDuIE2EmnYGqn1ABpnp2uvuROc6mzh+9cQl36OW4mMkZlg7r9XA0wd2
         6qKUGzY0sbKIYFgpzjYJj2BvKki1qrdxcEAbxUFuh12jtKwkIsowrYemNY+m1CB9TqPu
         ZRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876811; x=1775481611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAjBJkYCqeFogUSVOqhybn+Qkp+h53Wf7afwElb+C9U=;
        b=GXc/TUpvBOX3A5/WZ4l1ndNXcNvXRgH93brBQD1LknWO4VAtWCwOMOuPH/odHON1cN
         Evm1K3tHwpA0k0jNGYO86KAun0oI9EJqVIfg7RDXV/E2CnUVSeW5yo27Rd9q/aqap/TS
         F2i/eKeO/sYNDYvvazC+TuglEmuiJ+8l7i6je3DQlAhTqw34vvZCM8FcR9SWa2fvWLdc
         BvX8QuLhjajgYjG2XnMuwuQgVofJgw0+6jqzpoLznuxdWqmwSOXMdAf40/1FCEVvtwB0
         g0UZ1IA3HuTgJRtKKjZ7Hs/5ipzHOGjbGC3hID4T131IgEF9yXxBkBWWfpJszleDk3e6
         mNcA==
X-Forwarded-Encrypted: i=1; AJvYcCUpDHQjhQL6Tkq//c3p9E+URsoVdzt6Sqtcd6LD40SUdLAsUaBJZizKvpW1yRK6dEJD8fb7KudmxqcPOCdlZxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0u/j3roC5prxnBvtea/SggpTQQV4Yptrd9PZZdxDmyugGYUO
	LTcVQgq8heOQemjpPLDlvQWBEkQP6HYEr4F0unzhG1Izt0/gk6A4q0sN
X-Gm-Gg: ATEYQzw0pEMuY2S1Kq9EkzSJ8mBV7yR3cZ5mLklxTre7JGprRDky6EggnFbVCdTlrWP
	BRYy9OQI3zostBQ24gvZ0wdMRKjIiKzE4bSI9iY4K707Ab3lmj8m7jdrf5+W594/yxq3j1G/Xu0
	XmWlMEzL4f6JqtyDaxwhpRcWZpqmD/rZkJ31S/6tc0ClF9tvfMFr5hBebSnVtDtvKY1OP+qw5zL
	WzgtlhXKZW0ZPgVHbMQS6arKpUwAtI88KT2Oy700dgdDY4xLkQXneyIy6RYhMaJdtLs9arkQf2p
	IXWKJB5jkVSMWnepo0Ianmuqx3tcuKP/41acpettZco4RRK1WRm5d7f2MJzYkm19sVx9YBK88cF
	MzGq8+TQDLDhQBUHOkVcAHr8X7nwNerX0OLKN0kwf8SQONRXtEhD+r5Oq8+UeQCGJlChVEQYbdb
	oYXQbD6AH2OivZVWRNAfCfce+8lMVb8TMtFwLtFx4OH5l+ruG3h5WG2tHphwBFBQLZtiGfPQ4V7
	oS7c4ab
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-487290a9254mr185295365e9.1.1774876810909;
        Mon, 30 Mar 2026 06:20:10 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb52e5sm81322315e9.7.2026.03.30.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:20:10 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 3/3] fortify: Simplify strlen() logic
Date: Mon, 30 Mar 2026 14:20:03 +0100
Message-Id: <20260330132003.3379-4-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260330132003.3379-1-david.laight.linux@gmail.com>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The __builtin_choose_expr() doesn't gain you anything, replace with
a simple ?: operator.
Then __is_constexpr() can then be replaced with __builtin_constant_p().
This still works for static initialisers - the expression can contain
a function call - provided it isn't actually called.

Calling the strnlen() wrapper just add a lot more logic to read through.
Replace with a call to __real_strnlen().

However the compiler can decide that __builtin_constant_p(__builtin_strlen(p))
is false, but split as ret = __builtin_strlen(p); __builtin_constant_p(ret)
and it suddenly becomes true.
So an additional check is needed before calling __real_strnlen().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/fortify-string.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 758afd7c5f8a..6cd670492270 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -230,9 +230,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 }
 
 /*
- * Defined after fortified strnlen to reuse it. However, it must still be
- * possible for strlen() to be used on compile-time strings for use in
- * static initializers (i.e. as a constant expression).
+ * strlen() of a compile-time string needs to be a constant expression
+ * so it can be used, for example, as a static initializer.
  */
 /**
  * strlen - Return count of characters in a NUL-terminated string
@@ -247,9 +246,9 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
  * Returns number of characters in @p (NOT including the final NUL).
  *
  */
-#define strlen(p)							\
-	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
-		__builtin_strlen(p), __fortify_strlen(p))
+#define strlen(p)					\
+	(__builtin_constant_p(__builtin_strlen(p)) ?	\
+		__builtin_strlen(p) : __fortify_strlen(p))
 __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
 __kernel_size_t __fortify_strlen(const char * const POS p)
 {
@@ -259,7 +258,14 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 	/* Give up if we don't know how large p is. */
 	if (p_size == SIZE_MAX)
 		return __underlying_strlen(p);
-	ret = strnlen(p, p_size);
+	/*
+	 * 'ret' can be constant here even though the __builtin_constant_p(__builtin_strlen(p))
+	 * in the #define wrapper is false.
+	 */
+	ret = __builtin_strlen(p);
+	if (__builtin_constant_p(ret))
+		return ret;
+	ret = __real_strnlen(p, p_size);
 	if (p_size <= ret)
 		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
-- 
2.39.5

