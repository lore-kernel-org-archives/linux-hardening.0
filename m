Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738972D23B9
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488931; cv=none; b=W5hOGosvMK2fDIlUwbR8VNAauPilpZdypQevmJXwE3Txlt0AdfoIPZr94TfIPM6+1U+JLwhPWdBXl67m9GGRML652Z8iaDTudVgJL/a3g0l2PI3td3E0sngvnLz+p9rrRXeJaHtGWTapNGx7zzLzfltRlYed9F6RVxYgSZLKAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488931; c=relaxed/simple;
	bh=MP5zEF0mz0wb93X/rIDUcTYdHjOJaAF4mJGNz5/sX9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kaQdsbYcklCiDJJeOvodAi5Op4ga+guEqWe5iKDX97COidw4Ag06qTBj6CuIR9hyGljtgNs8xt5PtktvzYSdCIBUZUL9iJZKakX0tGgjNp/KN9A0V3tyR1o2xjRVZKfle08qd2YOnXCcsx5K+JkhUwGmhNXeNSqMA+7nm6FzFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrM6KNmg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrM6KNmg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34372216275so6370109a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763488928; x=1764093728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDSqI1R4vRI3ysYIo080sf0JavtMkZgMqlZ1yIgknuw=;
        b=LrM6KNmgGwgphcxgnn+OljAbEhAXf3m4MDkHLDIksSmTPHLx3MAn+GySHiiZyqOuHM
         5eE/7a83lvKrrzBlgAUdV9Av+O+OuB/w4CHd7ITwBE2IRDDZV7dAz5He4L4FFaLiUm/K
         GceFt2G0QSqgCQkS8xNdLWrbgwBdj9u1pTL6Ph+ENeBzwsYwAA9kK2Z6Ohl3M3PkPQSu
         lzouFLgBoNagWu1YiHQAn1Qmp9qkMtc2d276l88tI1rzvzJpWYgFkAr08KF+VPUq7ZUX
         KhkgEeY609WfizfRYOwo1TQuAxPMvPp3EjPLf8Q5gpk7MoLlyJcH8Q6yB72c/p+61KLL
         sFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763488928; x=1764093728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDSqI1R4vRI3ysYIo080sf0JavtMkZgMqlZ1yIgknuw=;
        b=bvym8nYofcWjIBK44FBWJqgdUuKxoEdwDqs+Z527CsNuXByXJ48R0qMya0yhPdzvI5
         YuFb72ygbWodomS3nC9mGb5te8lD2CoHsYFWuOzewkHSwHFc8eT8Xk2hsRKrVcF8sFR3
         LNLokmqbZC3HX9aw1xqZgVv7h2flYvnQQu2gWXS6y5TIXi2p1iNf8XylUvsxZ63V6A1U
         j+Ecqd6wcKf6SDiKKspgkTIvgZTZgaHK+VOeGLW2ewfTE0HRgFITBnwt/vvDZTSlgSfC
         jYT264VpEmusga4Pmii0BupNi+FUX1mJmv2k4xEWdtFFXuMYR/8LczvBxrEUqGg7/IYk
         lJ7w==
X-Gm-Message-State: AOJu0YygpMn6oiZa5QAWOIWPcKaz5FRG8D+kmevSoZ+gVm4LfgbdENoO
	tconNbkJjtKAOV9LezJfzI2h2lQpzEROmLCfvONzUZMo6KHVwmsE7dyiv8QoqQ==
X-Gm-Gg: ASbGnctKfOOWo6tVsRQcCIUMZYt+JQYaKvvI9CKGK6AEllfAX+USQB/r0XVZSpdg05y
	zQZTddT77v894UAGuKL6J6xkHkktQppiAzoiEIvd7QxpUY2wLclDOYH/ixwcCteOxMfj3GiDTvo
	zMJA+JLOqjpNIGHWEPme5lJ3g5C6ZflZYgjz3EWPdnEoPGGLStE674JDF5jwWjwHgKJw6NwBbR7
	1rSG1mskVcYavOlfxDuVhpDumWMUiCA7XdWeAcDzj7qMPqvFvom247uAFUpvIiulGajM0rCQgNz
	FBVh48FTxw3Wfp8M0lGdHIxDZ3pERw4e3342+WTIKfmgAUo6mFXleKeAqEx113PcVPVBPwJCBOX
	m+f1hpFUaRfuImlZT731j4ZevanjDknRif8tt/DTCfaJbgMle0vgvP+deNa8Y/CeJLW4Xrqy9d3
	LukzZB787janTsjQ/IYAWZo4hKloSPqywkkp9eTNL9KVjwWBCa
X-Google-Smtp-Source: AGHT+IETQQ/I8WB37aKOwJZ2GzuSvVlMT7g4UMuSCuKxzvCr4hGmo8cU/iNziuRs02ZXg1pvwnn/Pw==
X-Received: by 2002:a17:90b:2d05:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-343fa6326e0mr18986629a91.21.1763488928250;
        Tue, 18 Nov 2025 10:02:08 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b053038fsm1349412a91.14.2025.11.18.10.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:02:07 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: kees@kernel.org,
	andy@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] string: Fix missing kernel-doc descriptions in string.h
Date: Tue, 18 Nov 2025 18:00:08 +0000
Message-Id: <20251118180008.2620929-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running kernel-doc validation, several warnings were emitted for
functions in include/linux/string.h due to missing return value
documentation or missing parameter descriptions:

    Warning: include/linux/string.h:375 No description found for return value of 'kbasename'
    Warning: include/linux/string.h:560 No description found for return value of 'strstarts'
    WARNING: include/linux/string.h:573 function parameter 'str' not described in 'strends'
    WARNING: include/linux/string.h:573 function parameter 'suffix' not described in 'strends'

This patch adds the missing "Returns:" sections for kbasename() and
strstarts(), and provides parameter descriptions for strends().
These changes resolve all kernel-doc warnings in this header.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 include/linux/string.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 929d05d1247c..3597e2801463 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -371,6 +371,10 @@ static inline void memzero_explicit(void *s, size_t count)
  * kbasename - return the last part of a pathname.
  *
  * @path: path to extract the filename from.
+ *
+ * Returns:
+ * Pointer to the filename portion inside @path. If no '/' exists,
+ * returns @path unchanged.
  */
 static inline const char *kbasename(const char *path)
 {
@@ -556,6 +560,9 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
  * strstarts - does @str start with @prefix?
  * @str: string to examine
  * @prefix: prefix to look for.
+ *
+ * Returns:
+ * True if @str begins with @prefix. False in all other cases.
  */
 static inline bool strstarts(const char *str, const char *prefix)
 {
@@ -564,8 +571,8 @@ static inline bool strstarts(const char *str, const char *prefix)
 
 /**
  * strends - Check if a string ends with another string.
- * @str - NULL-terminated string to check against @suffix
- * @suffix - NULL-terminated string defining the suffix to look for in @str
+ * @str: NULL-terminated string to check against @suffix
+ * @suffix: NULL-terminated string defining the suffix to look for in @str
  *
  * Returns:
  * True if @str ends with @suffix. False in all other cases.
-- 
2.34.1

