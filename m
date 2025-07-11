Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52472288CC;
	Fri, 11 Jul 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199011; cv=none; b=j3ema35u2k6cmJ6FUqOzDEFyx6kXczHJHJ1l0Nfx62JFcw9TBdmriSUEKmohdctmiwmcuJWkNs9CD+GowyPFO5QEyv34deO9G8/gtxtuCfEWjF5psFw1Ydqpaqn/0OZ4AEUwHRiawf52IYdB7gJClDGkMt9sQ0+z9f070IBKoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199011; c=relaxed/simple;
	bh=SDtvVojw1lKkC1ixgqUR/M7GavSPKQ3ZRDqLgxzNGuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaOwgvyOdi9cpmb4JEl7g11g6pUcOOaAsA/M9+pNF0iphDUHuLHaLC9hG5sqePbS8iRuZflx32kbppD7azC8wl7NWjZTiX9M2gqzYFxDalmd/p5wvf2BJDR2z1XpLNur7qwPi697qpUQCV4htb6d3PUVEHj6afXy+R0q3F5las4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYvIpIqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYvIpIqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A27C4CEF5;
	Fri, 11 Jul 2025 01:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752199010;
	bh=SDtvVojw1lKkC1ixgqUR/M7GavSPKQ3ZRDqLgxzNGuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYvIpIqeRtL/++EgjV6eCZYSY5E07NzGsJ+Z4rbB41rkdxvNUGIwYD6aE58aadV0z
	 fs7AQROuNsZRt+2ezIahVjGCHSH8YoCqBUpSfUcW0eiY6VxyWIG11P65G4YhxMrF/K
	 aYeaJgZia5Zo2qh+2dmOCRWHRvB3kL1XloZSuGsSyfLbpYBFRlkHBJeH8HmizIy1IZ
	 R2FzvZoQtSEV+kKsjGVuLrNbFfukR9rsdSlFpaDwp+4JOjySSEe0d10SVNlOfkoz0U
	 l0WIXQaRyA0B7Pcj5+Pvw1xuv3Nem2HJA0oZt10hNpTNgSxQjPa7cdWchV5X8b/EBz
	 J0sTuQkEgIUWg==
Date: Fri, 11 Jul 2025 03:56:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: [RFC v6 2/8] vsprintf: Add [v]sprintf_end()
Message-ID: <c801c9a1a90dd27789c1eb778ad3a02bbb1e6616.1752193588.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752193588.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752193588.git.alx@kernel.org>

sprintf_end() is a function similar to stpcpy(3) in the sense that it
returns a pointer that is suitable for chaining to other copy
operations.

It takes a pointer to the end of the buffer as a sentinel for when to
truncate, which unlike a size, doesn't need to be updated after every
call.  This makes it much more ergonomic, avoiding manually calculating
the size after each copy, which is error prone.

It also makes error handling much easier, by reporting truncation with
a null pointer, which is accepted and transparently passed down by
subsequent sprintf_end() calls.  This results in only needing to report
errors once after a chain of sprintf_end() calls, unlike snprintf(3),
which requires checking after every call.

	p = buf;
	e = buf + countof(buf);
	p = sprintf_end(p, e, foo);
	p = sprintf_end(p, e, bar);
	if (p == NULL)
		goto trunc;

vs

	len = 0;
	size = countof(buf);
	len += snprintf(buf + len, size - len, foo);
	if (len >= size)
		goto trunc;

	len += snprintf(buf + len, size - len, bar);
	if (len >= size)
		goto trunc;

And also better than scnprintf() calls:

	len = 0;
	size = countof(buf);
	len += scnprintf(buf + len, size - len, foo);
	len += scnprintf(buf + len, size - len, bar);
	// No ability to check.

It seems aparent that it's a more elegant approach to string catenation.

These functions will soon be proposed for standardization as
[v]seprintf() into C2y, and they exist in Plan9 as seprint(2) --but the
Plan9 implementation has important bugs--.

Link: <https://www.alejandro-colomar.es/src/alx/alx/wg14/alx-0049.git/tree/alx-0049.txt>
Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marco Elver <elver@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/sprintf.h |  2 ++
 lib/vsprintf.c          | 54 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 5ea6ec9c2e59..8dfc37713747 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -15,6 +15,8 @@ __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int sprintf_trunc(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) char *sprintf_end(char *p, const char end[0], const char *fmt, ...);
+__printf(3, 0) char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list args);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
 __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 15e780942c56..5d0c5a0d60fd 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2951,6 +2951,35 @@ int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vsprintf_trunc);
 
+/**
+ * vsprintf_end - va_list string end-delimited print formatted
+ * @p: The buffer to place the result into
+ * @end: A pointer to one past the last character in the buffer
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is a pointer to the trailing '\0'.
+ * If @p is NULL, the function returns NULL.
+ * If the string is truncated, the function returns NULL.
+ * If @end <= @p, the function returns NULL.
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list args)
+{
+	int len;
+
+	if (unlikely(p == NULL))
+		return NULL;
+
+	len = vsprintf_trunc(p, end - p, fmt, args);
+	if (unlikely(len < 0))
+		return NULL;
+
+	return p + len;
+}
+EXPORT_SYMBOL(vsprintf_end);
+
 /**
  * snprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -3027,6 +3056,31 @@ int sprintf_trunc(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(sprintf_trunc);
 
+/**
+ * sprintf_end - string end-delimited print formatted
+ * @p: The buffer to place the result into
+ * @end: A pointer to one past the last character in the buffer
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ *
+ * The return value is a pointer to the trailing '\0'.
+ * If @buf is NULL, the function returns NULL.
+ * If the string is truncated, the function returns NULL.
+ * If @end <= @p, the function returns NULL.
+ */
+
+char *sprintf_end(char *p, const char end[0], const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	p = vsprintf_end(p, end, fmt, args);
+	va_end(args);
+
+	return p;
+}
+EXPORT_SYMBOL(sprintf_end);
+
 /**
  * vsprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
-- 
2.50.0

