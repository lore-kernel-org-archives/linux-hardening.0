Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7ED3CF699;
	Fri, 14 Aug 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718948; cv=none; b=RkFYR2BTsX2seYd+kp7eNbyT5gxkIvNfDBHGUEgC4HKQCvptqpZorcMyewjxIMHMZwpun7MrydPEmzl9v2DU1LEURiIe8wLVvAYxQhv3D9YAKeBXDu1FhNuhFLgLAfT+z+M9d+juHPu6DE/642y6YGf+rCBN/Oq51/UuRO6Di6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718948; c=relaxed/simple;
	bh=7+bN1TZKacyRXechISZSOSGjlg9FX4uJDoaorVRA2fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIHEzCKokThw6TB3gntnRt1va7lOOqRvvCdr394gQ4iH+zcH1ifc3lXXzY1qFnIIoZoQGfUNlzSqnJ7GMbzSBtDtI6OH16CPCXfTMynLJuD/UGwB1s1x6edVgBSLdd8R+HgEWP9WuO+t6+xJNrQletSFalsHz1bK8f3Lzdzx1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oc0XcM0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2OuR/0r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oc0XcM0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2OuR/0r"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786718943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK6erdxfE4Myh29DN+Y5TS6R4dais4jnxoRvV8jJ/zw=;
	b=oc0XcM0XE6lczZIpqt2JXeEPvFfzXnx3pKKWXE02fSWOLPPozKeatKQ3fMxusZL4ONnwXN
	VC/kcfg3ddA4E4qc+O9oW/fmAWiJ4IxAPDzUuYdM6QdwOjOEx+KF1djhqkb+FIXx7uiEZz
	japESG6GwK+6vCrQD49dWzEwrgjLdXzAhNYdjW79tLiKkjQxg1AQgNdGQ/rSGewYlhRmbD
	TPQptQYLYb3aNGhbt4p94YEwJdtFH4G1LcVTdW5mN7AO0s1leIUvl/1q84kxTOdnJqdEIQ
	qLG7LwWX4txROqh1++0PBMOXTSYYsfKUJ11U+EOMcaxN5VXr0zduhsNWnrUoSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786718943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK6erdxfE4Myh29DN+Y5TS6R4dais4jnxoRvV8jJ/zw=;
	b=j2OuR/0rWy4/6Ik2fZmGbUNBz68uPfEKuyWGKlvkmUiA1Wo1VOGmoAfy3+Ce4WbMU8eOY2
	IdUKeesaTrvkhhCg==
To: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] vsprintf: Don't leak pointers for %ps without KALLSYMS enabled
Date: Fri, 14 Aug 2026 16:48:53 +0200
Message-ID: <20260814144854.746840-2-bigeasy@linutronix.de>
In-Reply-To: <20260814144854.746840-1-bigeasy@linutronix.de>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The "%ps" format modifier prints the name of the symbol which is more
valuable in terms of debugging and does not leak the actual pointer.

Without KALLSYMS it will leak the pointer which is not intended. The
default policy for pointers is to print a hashed value and not to leak
the actual pointer.

Print "(unknown)" for any symbol resolution witout KALLSYMS enabled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2bc6ef483576c..ac954cc7bfb31 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1008,7 +1008,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
=20
 	return string_nocheck(buf, end, sym, spec);
 #else
-	return special_hex_number(buf, end, value, sizeof(void *));
+	return string_nocheck(buf, end, "(unknown)", spec);
 #endif
 }
=20
--=20
2.55.0

