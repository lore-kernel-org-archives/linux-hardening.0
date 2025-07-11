Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8D288CC;
	Fri, 11 Jul 2025 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199004; cv=none; b=eTQr9VVBznFmnlqQ2Gmz8NAfLmbZmMQvH2Y9jFOPZa8nu991rVJpz2dJAdMgRN8QlmgGnvuSWis/zUGVDm7Khg/Jt2D4QR5V3plEZK7v96c47lCRS+mNbddx0DnMbq04+zpg0xi7RJiauDQlWieURusYVNOiLpsvwGvSNnyYqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199004; c=relaxed/simple;
	bh=id+QRz7CKCBHQtj9/ZPFhaypU90NRPk861KL3FVr7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL6jXbbP2xxNqSdSE1kXZ3mmzf7nyWUEG9y4IssR4Nb0p1LPmkzGVKNi2hqmM/XJKJS9Aod+www6HJZdAgqbaNfB6/EwOkvwTZMe+gWnKjDgZGFtwn4v3MuokCBohRmgztQJuaUUsy6K0R0R7sCRhca4f2H0gzst/nrM4NgkQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCgw+aiM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCgw+aiM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B075FC4CEE3;
	Fri, 11 Jul 2025 01:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752199004;
	bh=id+QRz7CKCBHQtj9/ZPFhaypU90NRPk861KL3FVr7UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCgw+aiMYtjB84bt6EC3wc5P2d1CBZM27lAcVpwvVnIdPKXIUDmxpwkpOpPvJgMjU
	 z8YyEkxjP+KgWynJZrfmHnkLGkM3HRGozNvNmIGiRL2w9eajrrc/xU9XSXQTOuMxKl
	 uk7EbWg2bpAdOVWAwso8DalSOrjHPpOs5sZy5he2AcWFVrtKYIlp008it8h85tzeiK
	 g/uirUmElownoNiKUXepy0UugdCJ0vXBTA72x5M003exeqp1LtjT7qdO37l+S2n1nE
	 RjMbTdxnxVVOG18yOEDnnb4bdpNV1wQFfxMJVVB4cKVQ/AHoDWKelVdfziOB21k1CE
	 15LVNNWguugVg==
Date: Fri, 11 Jul 2025 03:56:38 +0200
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
Subject: [RFC v6 1/8] vsprintf: Add [v]sprintf_trunc()
Message-ID: <dab6068bef5c9db7b89c7f959aea723c40b35dda.1752193588.git.alx@kernel.org>
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

sprintf_trunc() is a function similar to strscpy().  It truncates the
string, and returns an error code on truncation or error.  On success,
it returns the length of the new string.

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
 lib/vsprintf.c          | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 51cab2def9ec..5ea6ec9c2e59 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -13,6 +13,8 @@ __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) int sprintf_trunc(char *buf, size_t size, const char *fmt, ...);
+__printf(3, 0) int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
 __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 01699852f30c..15e780942c56 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2923,6 +2923,34 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vscnprintf);
 
+/**
+ * vsprintf_trunc - va_list string truncate print formatted
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is the length of the string.
+ * If the string is truncated, the function returns -E2BIG.
+ * If @size is invalid, the function returns -EOVERFLOW.
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int len;
+
+	if (WARN_ON_ONCE(size == 0 || size > INT_MAX))
+		return -EOVERFLOW;
+
+	len = vsnprintf(buf, size, fmt, args);
+	if (unlikely(len >= size))
+		return -E2BIG;
+
+	return len;
+}
+EXPORT_SYMBOL(vsprintf_trunc);
+
 /**
  * snprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2974,6 +3002,31 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(scnprintf);
 
+/**
+ * sprintf_trunc - string truncate print formatted
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ *
+ * The return value is the length of the string.
+ * If the string is truncated, the function returns -E2BIG.
+ * If @size is invalid, the function returns -EOVERFLOW.
+ */
+
+int sprintf_trunc(char *buf, size_t size, const char *fmt, ...)
+{
+	int len;
+	va_list args;
+
+	va_start(args, fmt);
+	len = vsprintf_trunc(buf, size, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL(sprintf_trunc);
+
 /**
  * vsprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
-- 
2.50.0

