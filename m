Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788E132472
	for <linux-hardening@vger.kernel.org>; Tue,  6 Feb 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229346; cv=none; b=aoL6B0oJ1xQavhqIfVppPR5VVVsySUgehxwqRegzrzuqe6wlTYuh84mu/Hu0WvNRnd06UKFs572mvZQjQ97IDeGA5ZEIVHExPBFJz8jaaDaMZQp3gB1w/W3SGAcOkmyXrJc//XaWifWi6aKu6lDduNXfOHX3CMSJu7yjD8z+X5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229346; c=relaxed/simple;
	bh=cgm+i5e0DImLno4Cl42VWs3gXJ/FYegxHzATOxk7JqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bw2aT7Bh4tFISHzQXSVopqMGNK/JUJGTRrTEMmij2zGM6Y5R5ljdXegXI1eWn+FlBkk1NpRAdf2CUGyOhHNwhPo17hdWchuigZ7TWvAJh+TCTHCNpdQcPEO1e6ZGntX5FG2mnFh899nlnT6xw1wxCcZpeF7173SRDE3pLpbLAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P7pYpUAD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7pYpUAD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7858a469aso41745745ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 06 Feb 2024 06:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707229344; x=1707834144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqYtmG8hHVF+DID/XSnE8UT4bODHlUYWehuF8bFwVfo=;
        b=P7pYpUAD8YtqTPEYS2BeoDxXtkiCsdsv2Wu8t1gtfFzN0H0qB7jPwWySKy9lAY6f3r
         J4Wi4p48orEdaqGu5CVymCLgQ3JurIQkuzxpYKstUpr1b98Dq+5wGvK8fHWnbye/t5pW
         1BzBn5c8UxajKXaDZebDzrxRrg037v2wfFcNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229344; x=1707834144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqYtmG8hHVF+DID/XSnE8UT4bODHlUYWehuF8bFwVfo=;
        b=Rva23GJDnfmhx2h1PfSvgu1Skbj8qWv5yXAn00cF8pRR5i4CkTYEWO/EMQv/NmTCfz
         xprKADYOxjlhTiPonYgBC6LfP6o03BQCt+T0edm6lInD5TdGftewD5ggByej0ni5lE5G
         YsF3GpWjYe+RI1rwF1M6WNg+9CAn4gPfjxuCvn0ld0dVsKUMpc7SHHFQOU1wqCNaWr/i
         dtNjGm2H93Il1R9Tp45D6mgIE1j1cXtlDbqYeToE0SmwkG+b61W+PzmluS8LtnG98Z7N
         tEg6XS08jO8EL/Cwg9lbNLv23ZXM6fcXkiiPR3bx6Pf5smeNMOC7fLS7LgWvtawi5LdX
         DYaw==
X-Gm-Message-State: AOJu0YyJVYET1OAbbb3++KvIepAV/GeG1OgT3Eqv+8qRBj7eOIq2Trd/
	dk83Nv0E1lVxDrQ5qiyIQ2ny6d6hbqHXlBTnNHUzV/ZgGhPaM8cGv9gTJdK2tg==
X-Google-Smtp-Source: AGHT+IFZNKy2roe4isaW/3P7Ltqj+cyb3XivcBXp+wZ7FiRzJuOGyNpoMvLJySjBT/IT1nSjBZPBaQ==
X-Received: by 2002:a17:903:2447:b0:1d9:b21f:539e with SMTP id l7-20020a170903244700b001d9b21f539emr1916374pls.59.1707229343723;
        Tue, 06 Feb 2024 06:22:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlZZIrmY09eOI8iB8rBxq4yDPfOGMeSugdKEHsAUwl/TYliRCPITQB6UflzwNa6JD6+m0/iALSjO2W9mEH61tDhl7gbbYxKKAomD9F7Si3m3QgmKtXXbZXLHRB1BOYxi6qyOavwlb+cfLHPIZw51mYjzUYQHm6H0kxvRIUN0LNCqrYvAQ/uaGiNH/i0YXTHQjVwTFBHZOCKywdw7IQWRQli9+RCdSyS9CXB0nRrz+vA9m7N1Un3b4R6eG//KJLsi8XWKBHn/a3+iIIDmQ4FebYBAko+Yf+svJrEF3jdW02hVDst8SZkxQA50mUciRYf1REuV5/D1ryjePFmAlHLTVtCP8TJryISBJpBIYqBt9jWh2+1YKE4uxabtST3KdTOROMnDeFl21LsvgkDMdD60vm9DD0OK0CNQ53GzeBtHqyEVDeZ+kwmQW8+MPAV5N6hZiz+2moLjM8Htxm0qr/xPPL
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d68300b001d72f6ba383sm1900996ply.224.2024.02.06.06.22.21
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
Subject: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Date: Tue,  6 Feb 2024 06:22:18 -0800
Message-Id: <20240206142221.2208763-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142027.make.107-kees@kernel.org>
References: <20240206142027.make.107-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=keescook@chromium.org;
 h=from:subject; bh=cgm+i5e0DImLno4Cl42VWs3gXJ/FYegxHzATOxk7JqU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwkCbbZsr3bu0aaa7OMhvDrcFMrisXsQMmFbyZ
 gKEKT/ac8WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJAmwAKCRCJcvTf3G3A
 JqcqD/0U2D4y2McJjWOrTxf/kgRo8AYOPREygm/mXLqHiRTstAJBgEwSxsRtRU/aJALSJv/JqbR
 qzu+ONINnH1o5SoyLsRLvXzP0vuziQLKciy6hHtOhjWJ7GTi15TWaBDgtHXayK9OFff+gCFEyiW
 zPZcsQ7phH8aiLYRagH93X2309qmXfCvrA4WsnUnc3cQfDVmFj2/Sl1sJKy9LwNnrVoqwYTQhl6
 rOV22gcSHQ6+Tlaz3QIcQhiN7uQSl+mb0mBjQG41W0NEBQHB7UKaQ1+fHbyjzf0idQGBpW613kY
 oyb/21y/eto/hljZm2iTgblRDBtKIDFbxazryj6TNJ7BdQkBYwVX5gLN5p//oDz9cryic14FLpQ
 /oaHbLL52MvoTRZa4w6jHoQZhU6ByXQOE9DAVn6XjBUelg1JnuqgqHHBP3vsC4XOep7luf9W17x
 sWFkgFQlnBjI4XUfEx0jxUlk5bEqixkFIr8zMR8H2EKIrLqmcHZhYQkNmMxwUvcbvL6A4L2zXwN
 FRb5pIsF1exRKTSPoCLOum0ZKtMtS/5gynHgSJMlbw7WOWVywd81ptTlb1TUux1ekCTgyZHs4eF
 Av+HQi968qemEjvAnon7yaIet+VBuKRN3ZteDrNsf7JomVPfSv+n6sm+rn37SNm2qRT+TWK02i3 f17sfSHEF5ioSew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
optional when the destination is a compile-time known size array.

Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 79b875de615e..9bd421ad92a4 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -79,6 +79,10 @@ ssize_t sized_strscpy(char *, const char *, size_t);
 	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
 #define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
 
+#define __strscpy_pad0(dst, src, ...)	\
+	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
+#define __strscpy_pad1(dst, src, size)	sized_strscpy_pad(dst, src, size)
+
 /**
  * strscpy - Copy a C-string into a sized buffer
  * @dst: Where to copy the string to
@@ -104,6 +108,18 @@ ssize_t sized_strscpy(char *, const char *, size_t);
 #define strscpy(dst, src, ...)	\
 	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
 
+#define sized_strscpy_pad(dest, src, count)	({			\
+	char *__dst = (dest);						\
+	const char *__src = (src);					\
+	const size_t __count = (count);					\
+	ssize_t __wrote;						\
+									\
+	__wrote = sized_strscpy(__dst, __src, __count);			\
+	if (__wrote >= 0 && __wrote < __count)				\
+		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
+	__wrote;							\
+})
+
 /**
  * strscpy_pad() - Copy a C-string into a sized buffer
  * @dest: Where to copy the string to
@@ -124,17 +140,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * * The number of characters copied (not including the trailing %NULs)
  * * -E2BIG if count is 0 or @src was truncated.
  */
-#define strscpy_pad(dest, src, count)	({			\
-	char *__dst = (dest);						\
-	const char *__src = (src);					\
-	const size_t __count = (count);					\
-	ssize_t __wrote;						\
-									\
-	__wrote = strscpy(__dst, __src, __count);			\
-	if (__wrote >= 0 && __wrote < __count)				\
-		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
-	__wrote;							\
-})
+#define strscpy_pad(dst, src, ...)	\
+	CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
 
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
-- 
2.34.1

