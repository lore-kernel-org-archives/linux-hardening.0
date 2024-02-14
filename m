Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8C13B7B5
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939970; cv=none; b=dPCplY7YtwK50hASRK/sHeJCMeMAfoZe1W1m4Qzvdfs7d4Y0DqXBVSKZJT/wMskrLBjRewWZq7d/vZGoGb/ZQwaS/7CunyVmAw3Jtwg3uOKQX4cSWy6Tl+cEdWhE9mF9UcBJpCZyaXHvsjk0V79jen8igKtETxbotMm7aZ0lWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939970; c=relaxed/simple;
	bh=XRea/mEhcbAGWa9Y4NibhO2kDjISXokmQWKcnCxCkCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8ur5N13VL1BcD4JepkdbftplWYOB7PbMN84uAQdNWj+KiHgOuDc4VtdmZWI10b2BYDZDEQT/fm+0iXxXD+1wnW1AQj6tJiuLvmpflYexXdla9ApM/bU19bhLrvVl8iE8ZHJ80SESsMLGYSNxvkEFc9HpgdD/dCZAmXMz1h8tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hRBhV1LJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hRBhV1LJ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so140548a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939967; x=1708544767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM19jkSsuav/2hSBnxgTz0qK403f31xS1I7deDtmjCo=;
        b=hRBhV1LJaKbD/SctkW9TsVEfJ9jJVSR7lo4biBe5oylfH7l8vAiQjA6YAY9AWqbc5W
         8AIo8ThPDuVI3X1Fhbj7KKRBtCYWfPsIVg95UE6XVb2mRyeRrNfHV+f8/cKnSYImzObR
         RfGJPe8q9OhsoJf25JPuhkJKwY3Ra/BRj0nEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939967; x=1708544767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM19jkSsuav/2hSBnxgTz0qK403f31xS1I7deDtmjCo=;
        b=vREKo+xUd9U1w39nLA9EAQuAlSi2qqFA8VAz4rRueN/qbJlAn0Ww8hB6QwbHxpeebb
         F3qdYtytzTuRr14kXi4be/9NIrp8q1vfZk+M4HOT8A6vHbzsCgfQCxxvyFJThfzC89mt
         uW1yXfzJrbcAIuA7qOaSSbAuU+0zh5aMzEjWKjJcYIUNrbzFOCuRTVe5IZAByBX5KkIs
         28/LGPlI9tZ2l1oc1nrz+fMQOFSEAry7/sUKuShQuDYCbYjEdQOXAi+hx3rmZQIPt2Py
         yFGhcWNWD6poAApy3N6cUNoHd3Tp6xTodZMhVeyHyhB6+Qnqar7Gsd078KDHb2KXG6hv
         HAvA==
X-Forwarded-Encrypted: i=1; AJvYcCWhpsHY4Fn3y7fjor5qSUQF9PX38LHi52f9U6IDOozxodDrFWY9J2Z/L7tdfQpaZNuBW+VjM/aPamsRoSnumiXjEtEvXeLHu811+IKfsCHh
X-Gm-Message-State: AOJu0Yxu4zs1gKw7ud/YZA5meeMasVNO6+/bhyC2ByyGQosS9/je0mc5
	RuRo0zcyKdJgM5V7xtFQ6vcUyJ8+vWoaN86DcQHtd2/D5P6QvSTl+GjNYkjJwA==
X-Google-Smtp-Source: AGHT+IG1BEnCT0dNA4a8fVl3B4GlNEFYN3BUqCrJsR1LiFYg1x0FRbzeVM1jPRNPwcIOIv8T1wUjjw==
X-Received: by 2002:a17:90a:ad09:b0:298:ca21:45e8 with SMTP id r9-20020a17090aad0900b00298ca2145e8mr3554808pjq.7.1707939966688;
        Wed, 14 Feb 2024 11:46:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a08c900b002966a13f2e9sm1794443pjn.37.2024.02.14.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Wed, 14 Feb 2024 11:46:01 -0800
Message-Id: <20240214194605.602505-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214194432.makes.837-kees@kernel.org>
References: <20240214194432.makes.837-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2828; i=keescook@chromium.org;
 h=from:subject; bh=XRea/mEhcbAGWa9Y4NibhO2kDjISXokmQWKcnCxCkCA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzRh7r+ya4r7uEt9x8g08cu6WVWLE7l1GWFkDZ
 9tMyyEzBZiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc0YewAKCRCJcvTf3G3A
 JokeD/4syUq1+l4y9hFWnYnriJZrkny078pHVb3PIOY5XYIudZ7ZTv5wuMAwVzHjGujXsmINAAO
 pvn3kJa2F6Fu75yGUOsdFeG+YwFY6VARtUIQDEgUtoGl9ulfw/jzOViuCCPRtZ8VE+6yAsrz34V
 cI4G7wA8IuprJ7z7dYaOGt6npq+U390i9v9w19QuSX6Q61KrNl2Oj4Sd8WAuCWs6xnUj2fGa9fy
 No3EaO924o3xaALxo8oKz8difZ+2TlvzxarU3j+wXtuwKLtE8xtUYcJRQoRYcWtZPH189hLRZZ/
 OSs3HhcGiJyzihAAVr7oRL9Q323ECK+cbgVhHgVUNE1qrQbI8kEbKqWmqqdaEeLO1CjQVfeCbwN
 tlSPBwgtAkSvDTFssmMwHj+PI2dg8R6nNULk/ZYzsgBjABA/VYd6gNSmGE71Clc7t6OoJ1716iR
 ccUkN/TTWttr2MhLMa9f5sEsqFKd49BxDylTAqgO6NvD7qAbqb8V69oJ22k9+67QhFLnxAKNNxp
 kAsCJkher0VmBPGWFR7dK9KbrTYa5hPVrdKrjzTOphv+FKiWzPs5+dS4UfNQF0Ani7da/rQsisj
 LgY3RieGWc9W3kAP7vFeEf9JkLj7p2aAp9dVUDMObMj5wbTzD6+sK3QbS5kqou0OuVJTG3LO+6T H3GIukbfitb4mnA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/overflow.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 7b5cf4a5cd19..ad64d810c8aa 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -57,11 +57,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second addend
  * @d: pointer to store sum
  *
- * Returns 0 on success.
+ * Returns true on wrap-around, false otherwise.
  *
- * *@d holds the results of the attempted addition, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * sum has overflowed or been truncated.
+ * *@d holds the results of the attempted addition, regardless of whether
+ * wrap-around occurred.
  */
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
@@ -72,11 +71,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: subtrahend; value to subtract from @a
  * @d: pointer to store difference
  *
- * Returns 0 on success.
+ * Returns true on wrap-around, false otherwise.
  *
- * *@d holds the results of the attempted subtraction, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * difference has underflowed or been truncated.
+ * *@d holds the results of the attempted subtraction, regardless of whether
+ * wrap-around occurred.
  */
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
@@ -87,11 +85,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second factor
  * @d: pointer to store product
  *
- * Returns 0 on success.
+ * Returns true on wrap-around, false otherwise.
  *
- * *@d holds the results of the attempted multiplication, but is not
- * considered "safe for use" on a non-zero return value, which indicates
- * that the product has overflowed or been truncated.
+ * *@d holds the results of the attempted multiplication, regardless of whether
+ * wrap-around occurred.
  */
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
-- 
2.34.1

