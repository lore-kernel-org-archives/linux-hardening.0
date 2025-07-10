Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D86442C;
	Thu, 10 Jul 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183051; cv=none; b=R8Y4K2Nl0zjRru8tbW80WU9G7lLZfOpfXqk+j/62O1LJbngKaSKSxN+NWisGba2rlvfWQsJImBmBZqbwax+P4byzsw2lsIMeoaqM59uWUt3DGjRU3dLoDFSb4qOIJeaodrK3fQbETXrcLYbvnwmoB4XheR4mTudA7R89+Sgx9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183051; c=relaxed/simple;
	bh=uP1Rd77wxX/Fb6ettFx80wxbqPad+vTShdCzOI/MZqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sisrMRjx7kwPQtA9xEXy2LoMOYr9M1Jq+UuO9/RKnWC0TAlQbFsBOdC2YeUcfHr197dnjL+GPAmUBxMqDN0KgUoop6iIybm8W+w9eIVhJcONpL25ESPl+D1iTbNOu5ivc9bsq/MaMpuIbWnfSngRmuxGe4GOvLdoOnWXGZIf/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPANN/xW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPANN/xW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15833C4CEF6;
	Thu, 10 Jul 2025 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752183050;
	bh=uP1Rd77wxX/Fb6ettFx80wxbqPad+vTShdCzOI/MZqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPANN/xWTuc7WxMQpqAFV5aOwLOMsb9ly9HOJg/d++a2uWkTjZd8DFsnoNHyR7jaV
	 xc1CTlLvbE39tKkSHt4VCDF/zIoB9Lw06DiuwmvUccwxHy9Tz1cLQjWs2+V7vkk0f3
	 bq9oHpeCxXe4rvE0OLmXv9tKj0GP4FsyzX/x5Mo4N3Q+BAYBE2/4VuqWy8Zf4wVa07
	 P9+4ARBo7oLlkg+gQvgTmbv647YpBI27qIZK0pGWG5vi3LoTXAALvdHKvqGM+KVLPP
	 FStK2OkSj0oze/P+HEIoMR8fJJWXge9EMVNNrIdF4q6bKcGXyckJX/0oX3LJuu7vLE
	 /pi8htZLnV3jQ==
Date: Thu, 10 Jul 2025 23:30:44 +0200
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
Subject: [RFC v5 1/7] vsprintf: Add [v]sprintf_end()
Message-ID: <2c4f793de0b849259088c1f52db44ace5a4e6f66.1752182685.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752182685.git.alx@kernel.org>

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
 lib/vsprintf.c          | 59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 51cab2def9ec..a0dc35574521 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -13,6 +13,8 @@ __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) char *sprintf_end(char *p, const char end[0], const char *fmt, ...);
+__printf(3, 0) char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list args);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
 __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 01699852f30c..d32df53a713a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2923,6 +2923,40 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vscnprintf);
 
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
+	size_t size;
+
+	if (unlikely(p == NULL))
+		return NULL;
+
+	size = end - p;
+	if (WARN_ON_ONCE(size == 0 || size > INT_MAX))
+		return NULL;
+
+	len = vsnprintf(p, size, fmt, args);
+	if (unlikely(len >= size))
+		return NULL;
+
+	return p + len;
+}
+EXPORT_SYMBOL(vsprintf_end);
+
 /**
  * snprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2974,6 +3008,31 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(scnprintf);
 
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

