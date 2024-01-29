Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6524E1B5
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553257; cv=none; b=Viw5jSaRhCzyc1eKCrOOygjbUcv05Sj51oMbtRS/zhksZ8mgkUCP4X2ky5f8YVaURconjlwuiQMx7MdYSQBeZRi01RzMnQ35uAgaqWc00RjEJtb/ooPP/s52ULQUPdxBzt/fIDVuLDwe6gEdZw6NN0d5tE22wVYl2KKHmYxPVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553257; c=relaxed/simple;
	bh=8qBo+r1o5uX8xwwRI2+8kwqWeOJfk0QZ5WpwUuylvAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrysNOWopp5FABuKLixC/xqOBoLyTUJxNHSd4VoCNqnA2eGjdSoMOeMZ8jSNHoQTaOoXhgZhDVwpoD5AFePJJZ4jzP7MqnDuyKYmxrWprXodVV3Rdanu24anaMQP4TV5z22booQLRJVqpruuCTOEUHSLAUw/FF3QwCRT8IAQwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eub8a9ui; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eub8a9ui"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so1672800a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 10:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553255; x=1707158055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOi3qaLwpWcyO/WH2EIxnXUOlsjjGr/OsABWCZKoxrI=;
        b=Eub8a9ui/PD9+H2I/pc7bb4Nb3sbuiqED1cEn2I9VPVW35a6n4PLBQ2Hpvu+Ya8t9g
         JNyaYZ5kJNJd8CuX4NCvm5j3FwtJ1PGYx2qqLTRuNZo2Q97mIWYJ5ZhPXA81seL/pIgo
         PR2GRTOl5cIXxr+4gCyhc0muUbaANhoEyLwPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553255; x=1707158055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOi3qaLwpWcyO/WH2EIxnXUOlsjjGr/OsABWCZKoxrI=;
        b=VYfDA8oEIQR8GCl6Cm0YdaFeeF+6YY03cnEBUEd7DrweU3oFOkqcspCjwfR/XXlroY
         isTtH5nqrHyAcM+3YjDD43mgdJPrn9CVtdOSai4Zdj2Su2wxSS6IDrsDjz6dpsu7movL
         /afhPfF96vY4UZ7aVDLyN/s9J9p2k657R5YG0TUMpqry0rW874Trz8T33b+DCgCQEc01
         N0tCETfqcE/mUnOKlTNcSRA5MfR+GQ4372hZl78THovQ+WPrfais3IET61eWRT/onmRw
         E5qzMJSMV9gdoTLN/SK4b4cjWegRRcBILF8G5nDpFrB79T8X0lFLiEGulx6ZDZD8sgYd
         sg1w==
X-Gm-Message-State: AOJu0YxH5xZOSHyIyufy5icsK8Ctqbv6N3D23+40DjURwwpaatwBt4oG
	QQRhvTmxy0SbIc5b5wLOIxVVhfsIUCbZbFn/rfEFI+c7tF28tN2+qD+Tzthu7NMa/U0v2xQJfbM
	=
X-Google-Smtp-Source: AGHT+IFnFzWopA+FTNbLpeku3V9/v0WIlaYJvIgixHV3VvflgAsIYyXCbCLM6XVYfJn/avWkMTal3Q==
X-Received: by 2002:a05:6a20:4f1a:b0:19c:8fcf:97ca with SMTP id gi26-20020a056a204f1a00b0019c8fcf97camr2530546pzb.60.1706553255720;
        Mon, 29 Jan 2024 10:34:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902f74700b001d71669a30fsm5722452plw.109.2024.01.29.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:34:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5/5] overflow: Introduce inc_wrap() and dec_wrap()
Date: Mon, 29 Jan 2024 10:34:09 -0800
Message-Id: <20240129183411.3791340-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129182845.work.694-kees@kernel.org>
References: <20240129182845.work.694-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=keescook@chromium.org;
 h=from:subject; bh=8qBo+r1o5uX8xwwRI2+8kwqWeOJfk0QZ5WpwUuylvAw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt++hTMcckwazpkGwN3co7nO6qqaui6d7qOFGo
 HqcZdYYMsCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfvoQAKCRCJcvTf3G3A
 JjLYD/41af8TH5vPKBme99k9V45iwAafnhobwzSpJqZkoF4aHZaUg8mvXE/PdM99iATMf4nPr/O
 ycsKDiuC7/euYHLEyODmb5I9L6hzlvWnzy42LxuTs2qIAFSxP5t9wx/DrAEDO3LAmhOQdFJlJMm
 2Ya7/S7q9Qz68sLIZXcotFktkTo/X4bZvLP126YodD7eWqlUlcK2vrCtT8tuDe9Zkp6VAaHTVOm
 KsbmGdkOwxg+/TbsvkvFAsAwGF/fuL9/dZ5yM61GTA7QXOEPvth0Qn7dNxOZWI4eHPH1vQe7h5Z
 q3sB+SXjCesHuzwWrb5yTTJYOiOAwNKg49o/EbdiX2smvigUX7v1rxToz8wEsj8hk1DP4q3oFC6
 Qo8klArnkKEr+dgnT2Efc1viiGfzP9mNWSKecF2xMm/WYmp3DSvP2BA708K+PGI8LBok2W/2Gt+
 zz6DukdknEKikX0o6i1odluirCLQohzsIQ7nGemLeuxI23hqmTwS/axvt5RUexfKh9cLroTPRgf
 3knmXQSDxlUrZIwyrhLjczoe36Hb0WgjSwMOounvBs2H1dF+67uD4HOd5Y6OkyVzf4W3EbHrA7R
 fpbNA1NoQ9sdcKeZQprybnCISRKc+FxGIQUWR99xo9Yu7mB6oaTidtLxM3vHjKPL2BMSZ6xdL5B 9K5/jDKen/0fwXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This allows replacements of the idioms "var += offset" and "var -= offset"
with the inc_wrap() and dec_wrap() helpers respectively. They will avoid
wrap-around sanitizer instrumentation.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4f945e9e7881..080b18b84498 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -138,6 +138,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__sum;					\
 	})
 
+/**
+ * add_wrap() - Intentionally perform a wrapping increment
+ * @a: variable to be incremented
+ * @b: amount to add
+ *
+ * Increments @a by @b with wrap-around. Returns the resulting
+ * value of @a. Will not trip any wrap-around sanitizers.
+ */
+#define inc_wrap(var, offset)					\
+	({							\
+		if (check_add_overflow(var, offset, &var)) {	\
+			/* do nothing */			\
+		}						\
+		var;						\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -169,6 +185,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;					\
 	})
 
+/**
+ * dec_wrap() - Intentionally perform a wrapping decrement
+ * @a: variable to be decremented
+ * @b: amount to subtract
+ *
+ * Decrements @a by @b with wrap-around. Returns the resulting
+ * value of @a. Will not trip any wrap-around sanitizers.
+ */
+#define dec_wrap(var, offset)					\
+	({							\
+		if (check_sub_overflow(var, offset, &var)) {	\
+			/* do nothing */			\
+		}						\
+		var;						\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
-- 
2.34.1

