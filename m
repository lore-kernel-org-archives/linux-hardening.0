Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827F19C54F;
	Sun,  6 Jul 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823458; cv=none; b=M+mcRpJQzxYIaIc1Q2KjK8zC5boUm1KRdAHTxaWLrTytrLjdwG1djXGYDeBHhpKD4k6AFyuCebYA2gp2nj4cY5/odg8OrioIh9dDDr3DOOscdIzCEGb/te5l4kfre6haVDAqQlh9R0CnKN5F1+jz0nX0CrVwljOcvj/hdfNaz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823458; c=relaxed/simple;
	bh=Yezh1PpcDSnMIsQt/1ue+JNou0BqpTIh4TMeGHqSd4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnKanAp/yN51hxDN+a9wlxaDhtpnG5v15f+b4+N0Z6/oPd6PXxF9cqEtnIhJ7IKQugicuX1+25KgGUyBa2guBrliUKCLzqythfdPyC9tQk9F8aEF9B2WNWCotOqtukK+4R3SgaFvZeIvh+oDsYakVSVp5EEsSY/r1pyHR8WP7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJgCPADR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJgCPADR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D591BC4CEEE;
	Sun,  6 Jul 2025 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751823456;
	bh=Yezh1PpcDSnMIsQt/1ue+JNou0BqpTIh4TMeGHqSd4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJgCPADR2ekdfgwOWk/dsELsGQzgTRkDGth8uwcI8eKSU21X/oqBbIscR+qFLH96s
	 4yU6AhXki8Dkv+qdFY5rUeO4XqXvtCqqlKQoEKWnUm1FC7IqeLP0xQQ7AHDBuPLXvi
	 R1ryKK55/ujdlp9C9mqF993dg7PFuyyQPhAVhIsGErECvqXMeb9+3M0NiRldjOezLh
	 zB646vD1yem0Vo0WlT/eVudEaML7JKwZtstdg4KWBZVXUZlYGeWcRXFsFbv/j2YKU/
	 3VZJ2zHBf9CyM0t1si6JbNFmduZesKiE58rabaI8+eJFVe+uySZI8dPlQcgCJ4D1So
	 4vLdGj4K0bzag==
Date: Sun, 6 Jul 2025 19:37:33 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v2 1/5] vsprintf: Add [v]seprintf(), [v]stprintf()
Message-ID: <64334f0b94d6b853e6104ec4f89bcf910978db76.1751823326.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751823326.git.alx@kernel.org>

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
 include/linux/sprintf.h |   4 ++
 lib/vsprintf.c          | 109 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 51cab2def9ec..c3dbfd2efd2b 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -11,8 +11,12 @@ __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
 __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
 __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) int stprintf(char *buf, size_t size, const char *fmt, ...);
+__printf(3, 0) int vstprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) char *seprintf(char *p, const char end[0], const char *fmt, ...);
+__printf(3, 0) char *vseprintf(char *p, const char end[0], const char *fmt, va_list args);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
 __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
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

