Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6023B63A;
	Sat,  5 Jul 2025 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751747632; cv=none; b=oqtEOLNpCkbhpAvo1cXbnZpkOcgNV9oLKRnNvNjMMIi3sIuk8Q9ZHrzmgKUU1PqHAXJvfDSpqJrpD9OQNuoY4j0mD8c9Rpa4AH0tBA713hsZ/mADK1Kb6OE9BKW2nYfm8m+eK7X3rLKTyUwBhivGp1hq33LrZwRJ7ZSIHoMiDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751747632; c=relaxed/simple;
	bh=c7Bo2eDkD0F/AkM6BOw7KB8MLG0DrouzGLLc8l13biQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r09/dtt7L1LDIE+zPtGpFw9WkhWaZEj3epUYlDnH6LuLmjtrl+SbzRE6u1XY6VTYzww0b6iYqEBjksK1ekASovl8HlMxbCU/57DRcrF0inN4IDFOIl+wcAoBBxSQV0oQZTe9q40/m4Z4ZpTG4hpe1ZA+jzQj1p2gEGFDHeIYnfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5hbx9w9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5hbx9w9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91627C4CEED;
	Sat,  5 Jul 2025 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751747631;
	bh=c7Bo2eDkD0F/AkM6BOw7KB8MLG0DrouzGLLc8l13biQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5hbx9w97+zyL6YBKFfr9nF1GPnuY/5ukMqCyyRIsPrABCtwHhVPAN/DnV2u6c+32
	 xW0bHiikiwyJy6yvZefvbyxFRSAlii1ZZ5DcZ7TvOFWMiNYWFs3YWfFTs9ctbxrLQ4
	 i2zJ6myUejCOyNYQokLo05iwY3fC4MG64DZVHzQfhDMNIzHds+LfSkTvWbZocOTwfZ
	 Cwlfe3KkuQbIYiKAqFHQBk6H8OzM+HYxCfBugJn6+Cu534Kh+7NumcgA4GDuom7cHt
	 UV3jYy5PerDxlbSeUx35OvGQM9tVypdyOEQlp76wRC4BI3oLy4nxOIxrdp5ct+ybWG
	 Rk9LjLniHg0rA==
Date: Sat, 5 Jul 2025 22:33:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC v1 1/3] vsprintf: Add [v]seprintf(), [v]stprintf()
Message-ID: <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751747518.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751747518.git.alx@kernel.org>

seprintf()
==========

seprintf() is a function similar to stpcpy(3) in the sense that it
returns a pointer that is suitable for chaining to other copy
operations.

It takes a pointer to the end of the buffer as a sentinel for when to
truncate, which unlike a size, doesn't need to be updated after every
call.  This makes it much more ergonomic, avoiding manually calculating
the size after each copy, which is error prone.

It also makes error handling much easier, by reporting truncation with
a null pointer, which is accepted and transparently passed down by
subsequent seprintf() calls.  This results in only needing to report
errors once after a chain of seprintf() calls, unlike snprintf(3), which
requires checking after every call.

	p = buf;
	e = buf + countof(buf);
	p = seprintf(p, e, foo);
	p = seprintf(p, e, bar);
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
	if (len >= size)
		goto trunc;

It seems aparent that it's a more elegant approach to string catenation.

stprintf()
==========

stprintf() is a helper that is needed for implementing seprintf()
--although it could be open-coded within vseprintf(), of course--, but
it's also useful by itself.  It has the same interface properties as
strscpy(): that is, it copies with truncation, and reports truncation
with -E2BIG.  It would be useful to replace some calls to snprintf(3)
and scnprintf() which don't need chaining, and where it's simpler to
pass a size.

It is better than plain snprintf(3), because it results in simpler error
detection (it doesn't need a check >=countof(buf), but rather <0).

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 lib/vsprintf.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 01699852f30c..a3efacadb5e5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2892,6 +2892,37 @@ int vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
 }
 EXPORT_SYMBOL(vsnprintf);
 
+/**
+ * vstprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is the length of the new string.
+ * If the string is truncated, the function returns -E2BIG.
+ *
+ * If you're not already dealing with a va_list consider using stprintf().
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+int vstprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int len;
+
+	len = vsnprintf(buf, size, fmt, args);
+
+	// It seems the kernel's vsnprintf() doesn't fail?
+	//if (unlikely(len < 0))
+	//	return -E2BIG;
+
+	if (unlikely(len >= size))
+		return -E2BIG;
+
+	return len;
+}
+EXPORT_SYMBOL(vstprintf);
+
 /**
  * vscnprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2923,6 +2954,36 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vscnprintf);
 
+/**
+ * vseprintf - Format a string and place it in a buffer
+ * @p: The buffer to place the result into
+ * @end: A pointer to one past the last character in the buffer
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is a pointer to the trailing '\0'.
+ * If @p is NULL, the function returns NULL.
+ * If the string is truncated, the function returns NULL.
+ *
+ * If you're not already dealing with a va_list consider using seprintf().
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+char *vseprintf(char *p, const char end[0], const char *fmt, va_list args)
+{
+	int len;
+
+	if (unlikely(p == NULL))
+		return NULL;
+
+	len = vstprintf(p, end - p, fmt, args);
+	if (unlikely(len < 0))
+		return NULL;
+
+	return p + len;
+}
+EXPORT_SYMBOL(vseprintf);
+
 /**
  * snprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2950,6 +3011,30 @@ int snprintf(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(snprintf);
 
+/**
+ * stprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ *
+ * The return value is the length of the new string.
+ * If the string is truncated, the function returns -E2BIG.
+ */
+
+int stprintf(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len = vstprintf(buf, size, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL(stprintf);
+
 /**
  * scnprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2974,6 +3059,30 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(scnprintf);
 
+/**
+ * seprintf - Format a string and place it in a buffer
+ * @p: The buffer to place the result into
+ * @end: A pointer to one past the last character in the buffer
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ *
+ * The return value is a pointer to the trailing '\0'.
+ * If @buf is NULL, the function returns NULL.
+ * If the string is truncated, the function returns NULL.
+ */
+
+char *seprintf(char *p, const char end[0], const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	p = vseprintf(p, end, fmt, args);
+	va_end(args);
+
+	return p;
+}
+EXPORT_SYMBOL(seprintf);
+
 /**
  * vsprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
-- 
2.50.0

