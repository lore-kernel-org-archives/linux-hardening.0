Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB57F7EC
	for <linux-hardening@vger.kernel.org>; Wed,  7 Feb 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319467; cv=none; b=B1/9t+9u/s2XdUe5Ua0XyzMTz/fvuHUuvyx0MgzuYsxoFjN80An8bMUnn3vttCIKiN/gUmpIzc0cTg58P9lxPtHUMxqxeODPQtdx9iLGB3SYYJCoMp7ebiiH90Riq60Q4nxYQFgIA5sschOvasEYZl3MVEDDuLdDsmdkA63eOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319467; c=relaxed/simple;
	bh=ixNr6X1gB7VeIiW3pk9Za3U1z37zW3zrQNIbl69tCT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBjSUFxfRMdXs9W3dg5nSqLyjE/e32xQzTXkr4cuqBnKUEyixahDIFaepwWQ/JykiEGEZ3Cpof34xCPYPY1cyb8SH1K5nS/Uzvb0XFSAHziBIrluXCF6bIMYIpfDhInsCuZJdCr0HTYVP9IZgs3sZ66s7+axdEiGitxDRwGo1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XWnYOmVx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWnYOmVx"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dc11fdddd6so628633a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Feb 2024 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707319466; x=1707924266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RerG7d2KkWMxwjKi3Bk1dJMaOiX+RZ04/h8EQNw22Ro=;
        b=XWnYOmVxSytj9wsDLNNyNKglcn1Qk9EaUcOsivQti0aOQHUDFgXUTFfq3fxd4bXRrK
         gvZKWFXAlKllDbOkdE6+qPGA2mLTE+G0semPUEEfYb/F2xm54wHoeLuWzaYxr7gktKyv
         qZ1wRuAyWg0A3iiJc0Azxof7W5czSL27fspGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319466; x=1707924266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RerG7d2KkWMxwjKi3Bk1dJMaOiX+RZ04/h8EQNw22Ro=;
        b=p9P8jvLDtlXbgwYu/IAkiIKhFrJL6Mqsrf8zhqGaD6fnpEHzhJP4Psu+Wz3kKrEsha
         jpYLbQYVRMxN8GCNysQtA0Ok/4vURftzAQ2mMzTvatMkhNVLAPZOS9vysnvmmK6eRNVx
         v8XyX0Upc2u5yArM2PTKYaahxITqUCTo/Vx07j6wkOjxs9y/fSngHAA7Wq3tGmNs8Enx
         ctmUluiuBS8hwjBrhJ63cwCL4Q3Dl5fwNQKwRdfjxxhET5U9K9i4YJx2+op0cKcUoR75
         ISwELRF/cX0OBaXhYv30MojOB4/wxGmprXmt0xuics+db5uZS4GtD4e1QiKgfj6Y5zi0
         dJVA==
X-Gm-Message-State: AOJu0YyKSd5HhsYXz74WqXCxlvrKMvYi/0rMioRRCQUxYh2fI1r19nCL
	W8uBHT1TyaNYfPYjtEXaq9WIkaHF6C9QzCMYIxERcmYRgjdTcHV0TCXZurZ2Sg==
X-Google-Smtp-Source: AGHT+IEh9zhhOLjajS/dZOXJL8FztQnyk2ZMJ2b6fVgBm83/EIAhrXQQBOSk9VqyAAy0JZFm5Jzd/Q==
X-Received: by 2002:a05:6a21:3418:b0:19e:abbf:a47e with SMTP id yn24-20020a056a21341800b0019eabbfa47emr311728pzb.27.1707319465882;
        Wed, 07 Feb 2024 07:24:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIN68fbzFNvUo+nMQeBWXzeHDrwMJ1PoHDu3NkMZuzw5PqnVe9v4dYwJC8bFBr5MTSOXyzrZd3c/2XQ31kUNulOf0IXiCl5wj8HrZt7pgdhVZOtuDMj9T0SzzrRQe2w/jr/81Gh6PwcbaUl3xLm3GA0i9V+OoA3LQyvvn9ePzkX2OYgrcISp3ji/pIfakipoGJiRr5ce2COrOWZpF13G17/XkZHKUy0c2KLW73Ez5j4QHQqxkQOIZPOcrOUQr5YPGI2RzSvS8X5NlMaS+909Pk+Yt87DpfZszS7Kb/r/9cnvfrSA8wKGk1HyegC+tG1FiwUJrKDM+FRg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa27-20020a056a002d1b00b006dbdb5946d7sm1715455pfb.6.2024.02.07.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:24:24 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Wed,  7 Feb 2024 07:24:18 -0800
Message-Id: <20240207152422.3855315-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207152317.do.560-kees@kernel.org>
References: <20240207152317.do.560-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=keescook@chromium.org;
 h=from:subject; bh=ixNr6X1gB7VeIiW3pk9Za3U1z37zW3zrQNIbl69tCT0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlw6Cj2+8A/TrJjsBiIAx2op9/6wn1k5bn1wnZL
 w9hYjTQS5WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcOgowAKCRCJcvTf3G3A
 JrVrEACqhj3zhpOpirlHTgyqw2dv77Afdp4NYgHxwiKF2RhojJQXRmWssRiy/b+PrmQwg8y4Oo+
 VVOBsTYIav/X9fxfiqyn7YYrDEibUC0l/4veXMRu0fxl1urJ2J2teom17HOCbGYk17Jnw2lp5VQ
 8MYH0cLCa2s4jLHyuxr/hjmpdj2HFIxa5pJZA1aEhK1T2n6kHC4FieG5j/dO26APViY1DRpi5UD
 /YCsSn++Ad84Z/hCdqVT2mwggO+veFL06gp0NWOH8akV63+sK0OpG027YsZCM31avb6vY+xkOab
 l6a0Oowld4rRVYya4KKZE0zlL6RcvUwqlc++CEnV7bvUGcU+pUEWUUtnh/i+kml3n+II7Mrjiy8
 N9aPF+VMMHp6Ush0kqVm114qsRP/f5ZbrQewIpmkjS5H/YR0PxOjXA1643SF5NQQ/Ngf9UydMth
 gq/MJhPXhugN/iR4my4tjhJeiL+5CPw0t3jucp+Ur6Tv4dLH08hA7Q3+unglr0v7hF6QdViKD61
 cc62FrhC1LGh/lDH+/JMoCWl5KLlGyRBNCLdR+KifoBrc6Rh04AAMBz4HjtUH83D47X5GobBCyu
 62sTrx6BawTTwuONlAPvuSU2nA5UyfOGXc0S1IRAuSl0iGiF1OhPqplky0t0VO4D3QMBxeGb45l HKXRtpdvtCn5Yvw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 7b5cf4a5cd19..4e741ebb8005 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second addend
  * @d: pointer to store sum
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted addition, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * sum has overflowed or been truncated.
+ * *@d holds the results of the attempted addition, which may wrap-around.
  */
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
@@ -72,11 +70,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: subtrahend; value to subtract from @a
  * @d: pointer to store difference
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted subtraction, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * difference has underflowed or been truncated.
+ * *@d holds the results of the attempted subtraction, which may wrap-around.
  */
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
@@ -87,11 +83,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second factor
  * @d: pointer to store product
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted multiplication, but is not
- * considered "safe for use" on a non-zero return value, which indicates
- * that the product has overflowed or been truncated.
+ * *@d holds the results of the attempted multiplication, which may wrap-around.
  */
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
-- 
2.34.1

