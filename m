Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898412D777
	for <linux-hardening@vger.kernel.org>; Fri, 19 Apr 2024 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535319; cv=none; b=ZE9nZIrch8UZlUpA9o+xjFPxFJEKWLWiwctZXsL1HBy9mPOy2bXMj1lG18wIw1bhEciahlOMtaU/w3B41GAz4Z7lNnC9o+ekP3WBYARBR9wajpyR6+GXGBirt4LFihsFGsP0flznE9FVZP4q73F/E/USI1E0San52Vx21UjOQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535319; c=relaxed/simple;
	bh=7JWSpM2kQDgdhS7MxWu6/jWKr0reol9OW0kZrZqvHmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLoq2SoMRpW+UEJZwOhC/rT1lM9LIGBNI7+IkoUp1P24W0p03iP3JEqf4rNhRlq5VZbNGBemTNaN9RE80K+MyqCUwE33xeqPQq+0gJP8wdni1i6h7+PuaiyIZcz672tydkCBHQrvTfPYNuF85i8kIAho6MO3iozJ+ZE8fPUlS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kWrgIwMK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWrgIwMK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso16078445ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 19 Apr 2024 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713535317; x=1714140117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00aXZIfu/CU/JwgnMvI61xs02qBwyI9BWekjvfS0UmQ=;
        b=kWrgIwMKje7yjCUWIZfHnPzBgn/QUgBVYe8SFjunoTBXV1/4dh8/aKd2ss9HeUf30/
         9jmwKwQlWKWkz7yErUabwHf59X3dOzQ8Poshj1+ljDjokcnfd/IypqFjsE/ZSZnJHUMc
         UpdHBLcYHNMvKtnmaScDhtg8bj97xnvnMzJj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535317; x=1714140117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00aXZIfu/CU/JwgnMvI61xs02qBwyI9BWekjvfS0UmQ=;
        b=L/3oj2uaNmuE4sj5A1WRPjNu1qW9aix5+0Pp1IkduofkyZZuu1w1KMSYUMsW15cNwm
         Ves9gwwQgHxKhUTxXubojdTQpmBrkv02hOXhgMmaztDY6lJGcHQGPWfbndGjkp1MSh67
         8cP34+nIl6wwXP6O97NLwSScTecf9EKCJK+UaAk6Fb7weluyVYYKQRzeGgKrDTf7+acm
         iPWKh9OhtXL7dNcVLX1NeCz4wMgU+JXyYLOkqiXY1NH/GBsl4gyk7OTrkF5Rcvvb7At+
         Hv42WZmCOpvXqxdSK6KA8yLz4fjKmMOvAtchNBDTlmUb5iYQpvgL+cZ1AGw0ERRuyt0l
         R5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWOb4ibj1ZbGM7BQhb95RDJ5FzS1h4Ixgb+QFzS6DLPm8eV3wNRSKqPSx615aLeluJNvxn16AHwb+JvHlSrTqhqVOF1guJG6N1R6iFs0KZ1
X-Gm-Message-State: AOJu0YxDuiP1pxRcpiqDdPuVdMhz3sh0PXJfHhgpa/SjucXk27buo792
	G/vRVpFYN/We9bhXWFTgC16amxN+7Y8go7EMppo1lDht6Fn3AA/o0pooRyOQoA==
X-Google-Smtp-Source: AGHT+IGvdv7Ek1b2qNPsmr7nP0vVFk5q/EGKILYsFtmIuo8fk61V81FXepCspPTdmQToMFg+aFb9sg==
X-Received: by 2002:a17:903:584:b0:1e5:d083:c5b3 with SMTP id jv4-20020a170903058400b001e5d083c5b3mr2336853plb.5.1713535316698;
        Fri, 19 Apr 2024 07:01:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b001e41f1dda43sm3359800plt.75.2024.04.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:01:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] string: Prepare to merge strscpy_kunit.c into string_kunit.c
Date: Fri, 19 Apr 2024 07:01:50 -0700
Message-Id: <20240419140155.3028912-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
References: <20240419140017.work.012-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4340; i=keescook@chromium.org;
 h=from:subject; bh=7JWSpM2kQDgdhS7MxWu6/jWKr0reol9OW0kZrZqvHmI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmInlS0xZ5WAVRqziUhxIayUxzSjLXA0S2q+FIw
 8q9kGU04d+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiJ5UgAKCRCJcvTf3G3A
 JiD1EACJ4AJp4sgr+G8l3STUzbHYsu0kjlsq3HbtlUxSS++Rq+xUirYLNa3RKvOV5b0Qf0f1IvR
 034uSQBHzII7wWhd9WmOtam3gRIK4HF6L2s16HrwHZMMzdvd63HkGKlQe4tOgBb2gjrzf5qxK8E
 6BJyZ8fGKYmdIrCWo0kAQrmTitz1wUWRq+bCnWcVwkjKT3DwPp/QbT0h/kmczmgdmRnJIwLNmpe
 sUMJ1PuUbsJdFtBLs16RWSc52ORqQeD3GHQq2lGKv20VCFnIllxVMQgQ3jgtapntZ/YOVDCzy3t
 HqU4lCcqB/2/vSqEuNULhOScZmJiVFJiCZdA+8Gq/TfiCA2VrIuzn+ZDvpqugITLH1kQhAyLhef
 zJuZHvstTTwkByWE1k5Wh+mXZKjFwUgQRT0qZekBx8RPSqbpIvtOOul43gMIBt/Q4RIOQWCbzoc
 0QVpEUmUiYG3Q+ejblONq/Sx+p++p5rBMzgJZk1Rf66vKixDqwmipEkAoWxjR8ipNjzLpDANF3p
 Q2S5mmDUl+eW34uaSQOQSE01Z/eSLyuZEHa5xvbblHWss5Mku4Gu0v15Rg67RA7p4rf4teSPAa9
 E5yTExUB0n0J5PYNriSH76gvd3/12Uh27X11UFRM8htx56oMuPq6NjwWl5TeAWNm+273DBirImS BrwTUdZ7dRDFhfA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for moving the strscpy_kunit.c tests into string_kunit.c,
rename "tc" to "strscpy_check" for better readability.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 lib/strscpy_kunit.c | 51 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/lib/strscpy_kunit.c b/lib/strscpy_kunit.c
index a6b6344354ed..b6d1d93a8883 100644
--- a/lib/strscpy_kunit.c
+++ b/lib/strscpy_kunit.c
@@ -8,22 +8,23 @@
 #include <kunit/test.h>
 #include <linux/string.h>
 
-/*
- * tc() - Run a specific test case.
+/**
+ * strscpy_check() - Run a specific test case.
+ * @test: KUnit test context pointer
  * @src: Source string, argument to strscpy_pad()
  * @count: Size of destination buffer, argument to strscpy_pad()
  * @expected: Expected return value from call to strscpy_pad()
- * @terminator: 1 if there should be a terminating null byte 0 otherwise.
  * @chars: Number of characters from the src string expected to be
  *         written to the dst buffer.
+ * @terminator: 1 if there should be a terminating null byte 0 otherwise.
  * @pad: Number of pad characters expected (in the tail of dst buffer).
  *       (@pad does not include the null terminator byte.)
  *
  * Calls strscpy_pad() and verifies the return value and state of the
  * destination buffer after the call returns.
  */
-static void tc(struct kunit *test, char *src, int count, int expected,
-	       int chars, int terminator, int pad)
+static void strscpy_check(struct kunit *test, char *src, int count,
+			  int expected, int chars, int terminator, int pad)
 {
 	int nr_bytes_poison;
 	int max_expected;
@@ -79,12 +80,12 @@ static void tc(struct kunit *test, char *src, int count, int expected,
 	}
 }
 
-static void strscpy_test(struct kunit *test)
+static void test_strscpy(struct kunit *test)
 {
 	char dest[8];
 
 	/*
-	 * tc() uses a destination buffer of size 6 and needs at
+	 * strscpy_check() uses a destination buffer of size 6 and needs at
 	 * least 2 characters spare (one for null and one to check for
 	 * overflow).  This means we should only call tc() with
 	 * strings up to a maximum of 4 characters long and 'count'
@@ -92,27 +93,27 @@ static void strscpy_test(struct kunit *test)
 	 * the buffer size in tc().
 	 */
 
-	/* tc(test, src, count, expected, chars, terminator, pad) */
-	tc(test, "a", 0, -E2BIG, 0, 0, 0);
-	tc(test, "",  0, -E2BIG, 0, 0, 0);
+	/* strscpy_check(test, src, count, expected, chars, terminator, pad) */
+	strscpy_check(test, "a", 0, -E2BIG, 0, 0, 0);
+	strscpy_check(test, "",  0, -E2BIG, 0, 0, 0);
 
-	tc(test, "a", 1, -E2BIG, 0, 1, 0);
-	tc(test, "",  1, 0,	 0, 1, 0);
+	strscpy_check(test, "a", 1, -E2BIG, 0, 1, 0);
+	strscpy_check(test, "",  1, 0,	 0, 1, 0);
 
-	tc(test, "ab", 2, -E2BIG, 1, 1, 0);
-	tc(test, "a",  2, 1,	  1, 1, 0);
-	tc(test, "",   2, 0,	  0, 1, 1);
+	strscpy_check(test, "ab", 2, -E2BIG, 1, 1, 0);
+	strscpy_check(test, "a",  2, 1,	  1, 1, 0);
+	strscpy_check(test, "",   2, 0,	  0, 1, 1);
 
-	tc(test, "abc", 3, -E2BIG, 2, 1, 0);
-	tc(test, "ab",  3, 2,	   2, 1, 0);
-	tc(test, "a",   3, 1,	   1, 1, 1);
-	tc(test, "",    3, 0,	   0, 1, 2);
+	strscpy_check(test, "abc", 3, -E2BIG, 2, 1, 0);
+	strscpy_check(test, "ab",  3, 2,	   2, 1, 0);
+	strscpy_check(test, "a",   3, 1,	   1, 1, 1);
+	strscpy_check(test, "",    3, 0,	   0, 1, 2);
 
-	tc(test, "abcd", 4, -E2BIG, 3, 1, 0);
-	tc(test, "abc",  4, 3,	    3, 1, 0);
-	tc(test, "ab",   4, 2,	    2, 1, 1);
-	tc(test, "a",    4, 1,	    1, 1, 2);
-	tc(test, "",     4, 0,	    0, 1, 3);
+	strscpy_check(test, "abcd", 4, -E2BIG, 3, 1, 0);
+	strscpy_check(test, "abc",  4, 3,	    3, 1, 0);
+	strscpy_check(test, "ab",   4, 2,	    2, 1, 1);
+	strscpy_check(test, "a",    4, 1,	    1, 1, 2);
+	strscpy_check(test, "",     4, 0,	    0, 1, 3);
 
 	/* Compile-time-known source strings. */
 	KUNIT_EXPECT_EQ(test, strscpy(dest, "", ARRAY_SIZE(dest)), 0);
@@ -127,7 +128,7 @@ static void strscpy_test(struct kunit *test)
 }
 
 static struct kunit_case strscpy_test_cases[] = {
-	KUNIT_CASE(strscpy_test),
+	KUNIT_CASE(test_strscpy),
 	{}
 };
 
-- 
2.34.1

