Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F8839FD
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419826; cv=none; b=gJJKYgzy8g1TaisiUtLnE0bLw/3n86IKOWPraE1y53OvUmq4alf+JmZ0rlasdzdM9RzuNxPJXXEJwP+L0OLn3V8GzAIgmW+ohBDcFV3Vq97AfsOcBFTqYkIGlp5Mftr+tvkntzP0x4J1EL+ao+GMe74HSkR7g3RwRzgRVTYKmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419826; c=relaxed/simple;
	bh=GzYQquZtF8F0UCCwehYpS7+bOLrS47ikty216klT3dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8D/TN2luUnf3S5c2QjtnK6WjMjopCXsDpWau1+IXz782jqJdTxxhuNDX0SyzKvcQ78JLTrIhfomxkAtEbqVgAOLI+srABymy3MYLfG/ttBrPz7L+WO2nkflqNHJr6dmxMBzLt/E+YLjiYbAiYyfoSqmEUHR1ADna8hynsoPGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TiUMKNt8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TiUMKNt8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e65b29f703so43184585ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 12:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714419824; x=1715024624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otPR4dXeRXWcAXnWruvS43ZNV3eS/x5LH+123jbXlqc=;
        b=TiUMKNt8dFJ4Xv4UvBCCGcGu+YglpkPZX748+BQ0r7bO5Z8Vs/cwTYQ4ivQTIWlw6E
         kPPPs2+QoPqZ87yPVNRhf2XrVej6xss1ZSwTFiYuneDoqQkV8Gs6mOVJwheLjMSyRuWx
         DzkOb7VV9bLttTkTA8+RcN7U1YFmkbt750TqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419824; x=1715024624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otPR4dXeRXWcAXnWruvS43ZNV3eS/x5LH+123jbXlqc=;
        b=ZrQ2CYbDP+LTHICsjqlHlsCdigyT7VR787OQm9oxdtR2by42vriExmjRFw8HqbxkG+
         XYyXfA//hFXoj/OAYaYzuXHChjlsM8m4xLr6DbuS8CWL6RsM1QiIrHDZVDuwLWf+cUng
         7i2K02/VubqxdEd9JaOasrp4aWMWzkiE8eKXe0yU+fRdDBHtWTSDZPLE12r7s1a8128u
         8sWXODPPZr5m7CkLYc0/AknpKBuUMPwGLb03vWzj4E2VpM/iG59NRTWRR+Auvtdt6PkX
         sDAhkEEmy/vex6SlkhMyLh8/imWc4BBibfvEM0Xc3UmyZGCgNsf40NvGkbRf3+X09hwm
         GPGQ==
X-Gm-Message-State: AOJu0YyFvn9VbqIswDL96kOqm4aojGnD9D1N0PU8zT7kmITkUv7M9lRi
	1T5P98mjVbhqR7oHQQCpghJRD6euGKND7ZJW/uyo73n85gh3fKhjOc5r0SXokVr8YhdgTG4IKWA
	=
X-Google-Smtp-Source: AGHT+IHAKpP40EtJrVx6f8RKp3tg35tYjrloyE4mT5cO5VfP5jL4BJiIUxyQB6ipUGsXnskqYUja8w==
X-Received: by 2002:a17:90a:eb02:b0:2a2:9b37:367a with SMTP id j2-20020a17090aeb0200b002a29b37367amr10075252pjz.39.1714419824483;
        Mon, 29 Apr 2024 12:43:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id em6-20020a17090b014600b002b16d9ab430sm3008510pjb.3.2024.04.29.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:43:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kunit/fortify: Do not spam logs with fortify WARNs
Date: Mon, 29 Apr 2024 12:43:40 -0700
Message-Id: <20240429194342.2421639-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429194019.work.664-kees@kernel.org>
References: <20240429194019.work.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=keescook@chromium.org;
 h=from:subject; bh=GzYQquZtF8F0UCCwehYpS7+bOLrS47ikty216klT3dg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmL/ht/xDIv4y4i+JPHwtNCbLZWfqsyLg6nbhjx
 IJsn9pE/y+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZi/4bQAKCRCJcvTf3G3A
 JoFoD/9172DQtDzDQxs4bjGGOYab+1EegLgpEK2YmJvABHtD2I8nNIVuRlrIdDfQGOWCqoICExJ
 zVVTUQqTc9wveXXJtHFuF9AiCt0PoNm8xefFoz/Xlh1UGHjTAJqJIyncN0NR4Xs7lpt5bgDP5d5
 Y30loWV+NGZ3X41eq9hSDpF1Q11S+FGd1HzhT74oPpSJa8W6+RxgUrosZI2JDxbKTe2ZBbkVtUb
 BvFDzEb4N1Ru+eWvHMt0aEa+07hRVy6om0J+bstBwJ+ov3lVYv99DMGFYw9qbEUfuLTZK5I6sTd
 sL+RxJhFNShnqf+Si6WumZVN/Jgvf7fSb9LRD2LE+4V4oZCR6+pVZTrw2WPpwKk2AEfmT3xavWA
 ypJJ/07cOJOz/9t8pPb0Cy/o0/rJLzU1F3au4uXWhAZruoF1LsZD81fy1G3e/XkbAy1H3H2PA99
 mglmy4of+9BT3ChwVrSXKx9ucEuww0Tw2ZaqktzHQycE2apxJVAgjWdGmeACJt5/1KLg7vIzk1b
 cNPtrKP+srnKaxWS55g8Q7o3YqYPtS2fgZYOaButrY8yiSQBpoEJyNSxuyWye46d0zTZrcc+X5u
 SRQet0ZZxCp8BZRmtQPXAhaAkiHVJ2kuKJC6EnwFnDci8OV9DalVWyJcegkApv6QWocFpWyPQnO 7vWupGNdSmBn8qQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When running KUnit fortify tests, we're already doing precise tracking
of which warnings are getting hit. Don't fill the logs with WARNs unless
we've been explicitly built with DEBUG enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 lib/fortify_kunit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 6f9a86c94538..bbbfc2238aa9 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,10 +15,17 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+/* We don't need to fill dmesg with the fortify WARNs during testing. */
+#ifdef DEBUG
+# define FORTIFY_REPORT_KUNIT(x...) __fortify_report(x)
+#else
+# define FORTIFY_REPORT_KUNIT(x...) do { } while (0)
+#endif
+
 /* Redefine fortify_panic() to track failures. */
 void fortify_add_kunit_error(int write);
 #define fortify_panic(func, write, avail, size, retfail) do {		\
-	__fortify_report(FORTIFY_REASON(func, write), avail, size);	\
+	FORTIFY_REPORT_KUNIT(FORTIFY_REASON(func, write), avail, size);	\
 	fortify_add_kunit_error(write);					\
 	return (retfail);						\
 } while (0)
-- 
2.34.1

