Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B35576B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074020; cv=none; b=T80uTpFMnhrIZReJhFIk7mcDn06s5BpfSR47M/2F4lfvyAvmxo7afx75iMMToYN2xOA5tCqWrcE8Kv6MtFu4OUiL/PZrLLjaUOyw68NEl7jW3LHW1udsni8vAFNntkW8cDQ/bwMgbx9Kn3nAZR24O5KR7ijEDQgylDomUAck3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074020; c=relaxed/simple;
	bh=9Fi67i95/kAeREHqLFvk3tyaog6fahIgnSjOjLdnjT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ynm6pYE58g7aaLWI4+jCt6UhtZcZD1Wims2Yc+Vyydmj8yE5EYS4sYOMI6GvXy+kXJitU/eXrKdBeGxoGRkR2TercJxLmh+UP0e1sZWua0SjW/tkLZ/E6kMaxk4dn264iRRihuyAT/LySQYPgqjd3Uygy39F7VSY+DJb9domqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fHCiwZyr; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fHCiwZyr"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3561308b6e.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709074018; x=1709678818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLVwRTSD9ZA8wnLZflOwUZvL7Dh0SCpTGUEycKGf948=;
        b=fHCiwZyrjoe1pAMv04eVduZbZwUkAR2iLSHd0nvXsQbZTvo9ivE/h2UX/r5Qas2ruA
         3EtggsaA3LAYxJdbFnLZWDYPftdwFOUgfNIwmDomzMmzxAGqcUbSINZ/p4DU0r+rNyg2
         RM19tmMshoCd0dNAQIZ4/svtafzfio7sGRV8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074018; x=1709678818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLVwRTSD9ZA8wnLZflOwUZvL7Dh0SCpTGUEycKGf948=;
        b=C2pZfbmOrTq2geCKSxIz1tjJ2XohJYRLSOhyb3PMZ76yqgCSHRkXaatAQbe4H1wwPu
         FjXKJUITcAj6uiihS+CjLOAeEle/ypKiNzDHbUVqt4GuVk7KRmy6SclzOJFkI74SUF08
         H8eNLLuw8U7dmX0+5D70sKeIHf7P69smrGSPXjQxJOBsyKhnCn6vJe8XJyiTMp+r8jm6
         XDTtc2ZPp0msNc0x3NwCD3+dOP1n8PXq/BMO6csuauJjOLStYNZ6hHMYrp9kZx4yN20s
         S2vWon5RX400ODjIl4ioF4kvSEJ3yitguLfcxpTDdfr6J9La9aAcWDw1iPiH0uL0t0cM
         9l0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0VB7q8eZvkLHys9EGY4mPBQAqUOQKGoCyTH9TBW/mCI7JVHQk5RX+Hbk5jESQuKAqAS/SJ7KBokUG++WtlZh0zO9IeCUlFV/+tL73vXOW
X-Gm-Message-State: AOJu0YwGeD84RFy1JUMAW1/KVkNAG0sU/IY3Yoaho0X0sl8MdD1sKHeV
	3zHwfM194btc1TUS8QdvGn8pQQsKtu5HDd6o1HHZQ3B0/jZijrTLSAFqB70TGeAsd2gl+RfXvKs
	=
X-Google-Smtp-Source: AGHT+IFL7/hUbHtEX+C8ENjORP0ILArfVaCkvARMjulurnSQ6MhJue6ixDwTvfM+Se+ZdgDRLrC+uw==
X-Received: by 2002:a05:6808:114b:b0:3c1:aace:475e with SMTP id u11-20020a056808114b00b003c1aace475emr4314155oiu.1.1709074018445;
        Tue, 27 Feb 2024 14:46:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b006e4ce93dc28sm6462431pfn.104.2024.02.27.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:46:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] lib: stackinit: Adjust target string to 8 bytes for m68k
Date: Tue, 27 Feb 2024 14:46:56 -0800
Message-Id: <20240227224653.work.603-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886; i=keescook@chromium.org;
 h=from:subject:message-id; bh=9Fi67i95/kAeREHqLFvk3tyaog6fahIgnSjOjLdnjT8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl3mZgX4RYYkhnet9g+fNYxlAk16036/x70gZOB
 gwF8N+55sWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZd5mYAAKCRCJcvTf3G3A
 JpHzD/4/WTvgh1uRidbb9W95fV24HgJlTmIR5Dxy7PCQrI4dYNV+OG8l4P7CbVXbAfW5xHELhEW
 SmPi0XdYHDlXEWGKOMeqzD8H399fuUfIenhcw/ahukDnvSc+4tt5x/5QCB4q+01me6BIETQOxnm
 jGT4eFF4rEYOmRjx5g1PoQx13kdH5MqWHRxI6uyYBi0yoomwckog4OoDIxAK+euzD/KTnYYqsN8
 5uQ71dcFzRdTsZJkYmZJzFB/r0RR9Plk0WkVrDiJ+XgJcDuwbtjQDHiDk3V9VRI8BV5vLfeIWx8
 BNCpEdJ5KKHCcEso+n69DN7I2O1uQLP4vvWg0k3dQgB/h0bhW+61xwoz7DLmren7abhpZXToMTw
 FtY0DLy9PUzRBFCSwVm3BSIjW7yHT0/GGRdgU1ZrLWpxGd2WY6U3bR+G4uHu/tg4ljRGV8hb8JV
 vqFqp6ywVMeSEZnKipNmYs37+/Dj6y9NKelGdcFO7XoW8uenDUyJMlmVkNSMF2tGzIh3CPVVJpK
 Jc9MsguYXiTk4UKN4kqqOV2VRaKDYFm5DIEIDeH55i9V9MX2+n1vTg/uABHwNqXsJpIAKfQ1d8t
 u0h+9GCBQO5SAdMVIco8IVfK9M8IMiPZWNM5zG/UaYa914WHH4LO3OuBInpAWMM5gxGdwGYPqOy
 Pednaz4 9+/FuD2Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For reasons I cannot understand, m68k moves the start of the stack frame
for consecutive calls to the same function if the function's test
variable is larger than 8 bytes. This was only happening for the char
array test (obviously), so adjust the length of the string for m68k
only. I want the array size to be longer than "unsigned long" for every
given architecture, so the other remain unchanged.

Additionally adjust the error message to be a bit more clear about
what's happened, and move the KUNIT check outside of the consecutive
calls to minimize what happens between them.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/stackinit_kunit.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index 05947a2feb93..dc3c68f46f0a 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -63,7 +63,16 @@ static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
 #define FETCH_ARG_STRING(var)		var
 #define FETCH_ARG_STRUCT(var)		&var
 
+/*
+ * On m68k, if the leaf function test variable is longer than 8 bytes,
+ * the start of the stack frame moves. 8 is sufficiently large to
+ * test m68k char arrays, but leave it at 16 for other architectures.
+ */
+#ifdef CONFIG_M68K
+#define FILL_SIZE_STRING		8
+#else
 #define FILL_SIZE_STRING		16
+#endif
 
 #define INIT_CLONE_SCALAR		/**/
 #define INIT_CLONE_STRING		[FILL_SIZE_STRING]
@@ -165,19 +174,23 @@ static noinline void test_ ## name (struct kunit *test)		\
 	/* Verify all bytes overwritten with 0xFF. */		\
 	for (sum = 0, i = 0; i < target_size; i++)		\
 		sum += (check_buf[i] != 0xFF);			\
-	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
-			    "leaf fill was not 0xFF!?\n");	\
 	/* Clear entire check buffer for later bit tests. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Extract stack-defined variable contents. */		\
 	ignored = leaf_ ##name((unsigned long)&ignored, 0,	\
 				FETCH_ARG_ ## which(zero));	\
+	/*							\
+	 * Delay the sum test to here to do as little as	\
+	 * possible between the two leaf function calls.	\
+	 */							\
+	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
+			    "leaf fill was not 0xFF!?\n");	\
 								\
 	/* Validate that compiler lined up fill and target. */	\
 	KUNIT_ASSERT_TRUE_MSG(test,				\
 		stackinit_range_contains(fill_start, fill_size,	\
 			    target_start, target_size),		\
-		"stack fill missed target!? "			\
+		"stackframe was not the same between calls!? "	\
 		"(fill %zu wide, target offset by %d)\n",	\
 		fill_size,					\
 		(int)((ssize_t)(uintptr_t)fill_start -		\
-- 
2.34.1

