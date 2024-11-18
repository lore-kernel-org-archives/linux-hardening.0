Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B9149C54
	for <linux-hardening@vger.kernel.org>; Mon, 18 Nov 2024 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910175; cv=none; b=e3+KMILrXZgoFaDpnCDkShrFZfGykYmx9cXdo+7ele0HQo9foGfTNkNPKk4RuZ8psJ5X4uIZWPtGqfOUMwf+zLKOCbmGRatsQVww1mlRV0L7S1070Dmg4UK3MfUPvBfIO7crVBtEjWbkcLobfAoE43s0XpgUrAAerP/CCLnBLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910175; c=relaxed/simple;
	bh=MYcA1SYZL5eECQEt5Blz/24x/o2zDNEKaLVbv9fsM/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LbUovXjRyZ47hevdmjZ/zKMfcPoyA0oWsVTaBV2t0hJ76qbq+h2QVTwKiZpHPK5ASHbmedNKkyinobiSgheGBvjq5LtyChQRYhKN9DkNZ6wUlQoOQrI4DhkzVabM+6cmXp6XV5RWT2WC3mhJ3RZR8cIX1soZ0ZRabB69ihnkgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0H5eX/q; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0H5eX/q"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da2140769so1424117e87.3
        for <linux-hardening@vger.kernel.org>; Sun, 17 Nov 2024 22:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731910172; x=1732514972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGNA6sx5LHgcCMlgC1W32r3d4tE2U1BHHSY/+BLBKZw=;
        b=G0H5eX/qXMlKMCaDoGTIR93N14HgXeaFvTpHGw1o8jSXfvI3zY0JaKqmGtXn7Jonth
         owkqo6EkDktekZNhHzSJukROtx+SGfaD7Zr17GHFeYW82CX8h4w+7eAZuBNIsLpFpbxd
         IisbNv188QbdxFcAF8ahHY9RNc78wSZLoCzjG5ywWLoo+fSSbufEna6r6Lp7IXjXbXHk
         Muy81sSa4gM7hYQEHm6s+5yXfnByij3cRMfUf7Xd0hSzUup9CEnIEPH7MypJFP/HIakN
         a9x3Dzin46aZyTH1vA3K2dzHVQ1syrGjNBxIlNZMGBmjbLl70j9R8K2UfAfqFu+kmLWR
         r4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731910172; x=1732514972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGNA6sx5LHgcCMlgC1W32r3d4tE2U1BHHSY/+BLBKZw=;
        b=YuBjPC4nh5EYJ2/xAi6c3OmzeBUIXlJsKV84befm0YW30EnkJ6AJZk/vjcuBGPPdyP
         mDFMVfYtTge/AyRBfzHT7uS9awp6WnN5YYYC3fjOjhRIaeqyuAFoFFblhcVuctMGGB4J
         dR/8TM6jy/7HZzLmVuFruYZKQZErU8GYCwIV/CIlQAgdSaXQ4DLim082Wnh/tf2q+GTF
         Q7jOmoXiS4uIK6GM79sTYdfZlM3Z5AMTf5HF5l7ZugYEKk5IEf2ZVarj3YTBXohmf8GQ
         wEdfkHjQx28AUpi+t0VfG5Vo68+JUr4U1y1EAl5+kiYBcsapFpuF5Fho/eOAxTymY99v
         zg3g==
X-Forwarded-Encrypted: i=1; AJvYcCXf6ICmCabmLQQgfT7mSyNJKtuRywWRQdD3OdKQxA8c6UaiHTcpQw1Er0mO+DhzfBtTTV7XsUExqJy2hbPiViY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywim2vr6h8K7emGmnGjuYOWVQQYag2zFZH1KpS9NlaNPf84h/fc
	+ZskjKAUYf37oBGuAzKakzPbm9NY8JC713HS8vCv3tTqqA82DHfiVKsaXeyXxek=
X-Google-Smtp-Source: AGHT+IG8+xEQp0aLf6lrQpiL2Ytg5PnQnbX2T1yiNEt0PqVgi/U6NwJqxM86obfWK6ZPpQ4c/Z5APA==
X-Received: by 2002:a05:6512:3a84:b0:53d:a927:8206 with SMTP id 2adb3069b0e04-53dab29ad8dmr3537156e87.20.1731910171992;
        Sun, 17 Nov 2024 22:09:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432daafc6b3sm144771705e9.0.2024.11.17.22.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 22:09:31 -0800 (PST)
Date: Mon, 18 Nov 2024 09:09:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: improve size_add/mul for 32bit systems
Message-ID: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

On 32bit systems, if you pass a long long to size_add()/mul() the top
32 bits are truncated away so the function doesn't work as expected.
Add a test to prevent this.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/linux/overflow.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0c7e3dcfe867..e90cd5245497 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -263,7 +263,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * with any overflow causing the return value to be SIZE_MAX. The
  * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
+static inline size_t __must_check __size_mul(size_t factor1, size_t factor2)
 {
 	size_t bytes;
 
@@ -273,6 +273,18 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 	return bytes;
 }
 
+#define size_mul(a, b) ({						\
+	typeof(a) __a = (a);						\
+	typeof(b) __b = (b);						\
+	unsigned long __res;						\
+	if (UINT_MAX == SIZE_MAX &&					\
+	    (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))		\
+		__res = ULONG_MAX;					\
+	else								\
+		__res = __size_mul(__a, __b);				\
+	__res;								\
+})
+
 /**
  * size_add() - Calculate size_t addition with saturation at SIZE_MAX
  * @addend1: first addend
@@ -282,7 +294,7 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
  * with any overflow causing the return value to be SIZE_MAX. The
  * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline size_t __must_check size_add(size_t addend1, size_t addend2)
+static inline size_t __must_check __size_add(size_t addend1, size_t addend2)
 {
 	size_t bytes;
 
@@ -292,6 +304,18 @@ static inline size_t __must_check size_add(size_t addend1, size_t addend2)
 	return bytes;
 }
 
+#define size_add(a, b) ({						\
+	typeof(a) __a = (a);						\
+	typeof(b) __b = (b);						\
+	unsigned long __res;						\
+	if (UINT_MAX == SIZE_MAX &&					\
+	    (__a >= (u64)SIZE_MAX || __b >= (u64)SIZE_MAX))		\
+		__res = ULONG_MAX;					\
+	else								\
+		__res = __size_add(__a, __b);				\
+	__res;								\
+})
+
 /**
  * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
  * @minuend: value to subtract from
-- 
2.45.2

