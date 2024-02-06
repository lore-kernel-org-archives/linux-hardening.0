Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35813246A
	for <linux-hardening@vger.kernel.org>; Tue,  6 Feb 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229344; cv=none; b=AeaZ6QmdYOKFotuylmX7/Ddq+3js3+5Vbnxqt4tJ6sdzWo/1xR0Lav4gZUQ1IQovPsDfR99ISWsM3dOf53UZlr5OI0XM/PbrzDeQ3nsf1er0r1kWle47agx/EwL1yi9jccP84wOkzSjonXNMPEm9aSxz6Ob5bhHr0nk960ovp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229344; c=relaxed/simple;
	bh=ftA6fxUrXEunZTcxHNIjZ6BhF5aIrSt6eYUpeNFdlXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiAfgrJsSCsvryCaEKI0wCd6+4a+frZyO+SG8O7eKyAIvHdG8jkomadXx9elfLohZzVFsR6nSiy6Rb6+TrlFe9FCz/NQCn+VLr7mCaf6AI42J3W5gk9s0+yQWlHswPGVZbUxHGNN3ZYEJXxodwJiPkf3Kre7HEmrd/r6UITdy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B9hixiV4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B9hixiV4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d91397bd22so7190285ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 06 Feb 2024 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707229342; x=1707834142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUoezDG1AzB3IpHrnkZKY44PgV8//O1B2eigzb1QW3g=;
        b=B9hixiV4Z9whtH2ix+CvJpnuXh71Zn5vv5acai7Rnwb8fISejtgpTKiM5WlDgVl3SZ
         QQ+5NYOo9ZGGDZANEcqT5iXeVVqSM8OQOoi9a3kYTgTXpqF+69r85o78qkWpAf0rYKaz
         2wzcGSmogLkIb32M1f+4AZsA6JTi4OkWndxr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229342; x=1707834142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUoezDG1AzB3IpHrnkZKY44PgV8//O1B2eigzb1QW3g=;
        b=nCOZfm0D6Blzjf3SvO/zhR5rWHngDgMLVN43DGYvpQ1cDVxO33G8vaIPRwCqbRaQ2d
         YzF8QIKIpvk2uEwAphkDaW8gxa2oXDjunDluYpDqP28UXrbhUr5ZjK4/YA6TJuT/Chby
         XacXeiQrxjCYgfzRzXOQBOUL5IlqqozqvL70O4jXH/RtgCl6OR7RKXCDJerQRyqbb/pL
         olXgMlgwUc3Kh5IHKnD0Q7ohuLv6NBYSE/pvNNCfunNrMsMmDzreT0z2mKhfZ8cYsAca
         bXJEoXluvCFxQ4h2BR/4OTgV5xWQbjXsDftcDGHYqMTc+tBMcr4hpBeoOOnCQuSTlUTF
         pXTw==
X-Gm-Message-State: AOJu0YynfB12PpDSnP0MNRn2cDhtg6tWB61/NtKUddQXmqNOAevOXC6U
	k5y0U1Y3NKPBvXtpvW87FUnf5ig/KtUzeCAPwWuJRpmUHKa/0vKRSFvsGzeUw5UewlfM+LovVew
	=
X-Google-Smtp-Source: AGHT+IFkb4bRyzjqSX3JRHkMu7TwnCk2yN9ZD5QfS0//Gp0HH6jpcCurPbtH6+InCccczQYhxPidvg==
X-Received: by 2002:a17:902:6803:b0:1d9:bba8:16f1 with SMTP id h3-20020a170902680300b001d9bba816f1mr1493962plk.50.1707229342518;
        Tue, 06 Feb 2024 06:22:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVBiJl5sSNuX3epyJPI7cpDQ5h5nkdlby2inL3eARtoSG8hy/jWr62Sc6tuHMgQEUnKg5QOk5dogumFVublnktDm64c8CvUzJX91ZJN9I5Z7V2zBNg8A9hGhJn7g9RQlfV0HqxomZgvHPINaEI+wPsRwHkF+aVzAVjX8Wi0Q0nlIFjzvk5IFsq9u9l8qiGPp0Hu27H5w+rhlfegqgE3XCoj8uF/ByEtlxUT9aMqT51gYvu5zx17GcdE3DpUHnWP1/twrAvC/2ykP1NJfKxaKGPRnBn9UhSJ7aPgR49VwKEpZMOlzeN/M6clSEMPPGRJgGLRCirqj28WnFQslRrT+TKCKhShx1gNtLoOVmYZRaRBIhGqyyuN2VYnnfol62Hqt9mlg+pU2pWqVECXYCg0ooJ+uojdvg0TdjtlpxMu8ZxmBMAWS3PLHnxR7yv8nTGt9PH+p00+ndYJEY/y+gfbntWb
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001d8fb2591a6sm1927205plk.171.2024.02.06.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:22:21 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v3 1/4] string: Redefine strscpy_pad() as a macro
Date: Tue,  6 Feb 2024 06:22:16 -0800
Message-Id: <20240206142221.2208763-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142027.make.107-kees@kernel.org>
References: <20240206142027.make.107-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3826; i=keescook@chromium.org;
 h=from:subject; bh=ftA6fxUrXEunZTcxHNIjZ6BhF5aIrSt6eYUpeNFdlXA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwkCba+eO8AWAs1iqb8nBpmwYItGRsUp3cnZLt
 JSR4c+PTxCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJAmwAKCRCJcvTf3G3A
 Jga6D/4qoBSjrvyh0UrxSO0LWPNsVnXplNq13jIv34e0RmgqAE/fRVb2ugkoIOyvKz7fVKtClfr
 JCDXYz7V3OjO7Mi8eLKK7Fw/VNM5pOpTiToyEWZy7YHWupSmHlohhO/QWNvxSiXAqQm13wKDJAM
 2f1RTPD+zIAWGH2uhE5/rIPlW56QMYDXcwrUQ6fGi5ySfVQLLu7IVI6tvhXomWxwS2kmvgvXV3n
 CWt+FDQJORntS6V4zRHeHftm0p1PLqVBdvTiKxUMPhwq3r564GLgpAyQguR1HLmM4L+S5nvUfhh
 OLyCx37bhcvMm5IRct/WRY5bYMsSA9MTKILeh5KkBZAl/1esXhUOnuOYT3b5kT0khgZ+sakcKjT
 SeoczboKqmd5sw30klUx/7vvg26XrScYK4RwCrPHFTIihaeWsYUvNw3m7akbNtPv/CHKAQ95DYr
 EQoB/FCyrQrFq3qahBIpj5eJ/Kw2RF3y+mMLCDqCy5RapAGGz9zb7gUNiMcNIi9bJa2w8UE3UmL
 X1DWrnhxob8HVAVgx7g2GPY6E7xSNcS+xpWoOvWKr/OUWPzGAt4PTBqCncakdQlClecsvO3zMjS
 Ne7r55u11fFj92/hWpiJFPzcJXzoB+kNL8A2gFO0KdMCwEWuSjj1AImLORFnqEo9ej/vDMr8SUk Wk9mwenStuipW6Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making strscpy_pad()'s 3rd argument optional, redefine
it as a macro. This also has the benefit of allowing greater FORITFY
introspection, as it couldn't see into the strscpy() nor the memset()
within strscpy_pad().

Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 33 +++++++++++++++++++++++++++++++--
 lib/string_helpers.c   | 34 ----------------------------------
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index ab148d8dbfc1..03f59cf7fe72 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -70,8 +70,37 @@ extern char * strncpy(char *,const char *, __kernel_size_t);
 ssize_t strscpy(char *, const char *, size_t);
 #endif
 
-/* Wraps calls to strscpy()/memset(), no arch specific code required */
-ssize_t strscpy_pad(char *dest, const char *src, size_t count);
+/**
+ * strscpy_pad() - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer. The
+ * behavior is undefined if the string buffers overlap. The destination
+ * buffer is always %NUL terminated, unless it's zero-sized.
+ *
+ * If the source string is shorter than the destination buffer, zeros
+ * the tail of the destination buffer.
+ *
+ * For full explanation of why you may want to consider using the
+ * 'strscpy' functions please see the function docstring for strscpy().
+ *
+ * Returns:
+ * * The number of characters copied (not including the trailing %NULs)
+ * * -E2BIG if count is 0 or @src was truncated.
+ */
+#define strscpy_pad(dest, src, count)	({			\
+	char *__dst = (dest);						\
+	const char *__src = (src);					\
+	const size_t __count = (count);					\
+	ssize_t __wrote;						\
+									\
+	__wrote = strscpy(__dst, __src, __count);			\
+	if (__wrote >= 0 && __wrote < __count)				\
+		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
+	__wrote;							\
+})
 
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 7713f73e66b0..606c3099013f 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -825,40 +825,6 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 }
 EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
 
-/**
- * strscpy_pad() - Copy a C-string into a sized buffer
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- * @count: Size of destination buffer
- *
- * Copy the string, or as much of it as fits, into the dest buffer.  The
- * behavior is undefined if the string buffers overlap.  The destination
- * buffer is always %NUL terminated, unless it's zero-sized.
- *
- * If the source string is shorter than the destination buffer, zeros
- * the tail of the destination buffer.
- *
- * For full explanation of why you may want to consider using the
- * 'strscpy' functions please see the function docstring for strscpy().
- *
- * Returns:
- * * The number of characters copied (not including the trailing %NUL)
- * * -E2BIG if count is 0 or @src was truncated.
- */
-ssize_t strscpy_pad(char *dest, const char *src, size_t count)
-{
-	ssize_t written;
-
-	written = strscpy(dest, src, count);
-	if (written < 0 || written == count - 1)
-		return written;
-
-	memset(dest + written + 1, 0, count - written - 1);
-
-	return written;
-}
-EXPORT_SYMBOL(strscpy_pad);
-
 /**
  * skip_spaces - Removes leading whitespace from @str.
  * @str: The string to be stripped.
-- 
2.34.1

