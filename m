Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2AF348C55
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292573; cv=none; b=fj8S8TF8UyvsW8SQkiNlV8qN+kUHylZGPYPnadmPPC18AT9U1v2alAXMCHY2a5CEyqkJwe9bKKNk81Rxt2wsuoXryNr8joiz4DIpEIAC9NJusgKekoHTfVJH0t6qb+SL8m6YMIRWD3FGinau7pCd7apGShB3e4PSpIkLoahhW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292573; c=relaxed/simple;
	bh=52pIhwO1sx/8MqjYI640DB/wIvQ/icsM6v73JsrwAmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7tGRIyVUwKDeJ6yesBflyhBrnc2gv9m27PfiU/tnNDzWVe4g9a9v4J8cL0owdvXQddOEhc0TgRKj4HfxxJshnshcQGe/DE9OJlAWijP0acVrbBdrESp+N1USOXecWQVwZsOCB4qjf4WtZ51fB28oZJ6PYkD4sm6nXBzy6xl1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n62vpcue; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n62vpcue"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so59904855e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292570; x=1779897370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T2Qb9RrZsz7qcSCkhnlZDPbWojGSBsbannTJKJ4R7U=;
        b=n62vpcueUnZXvic5IH+FPs2AYL0o4gqVtOYJdpv81YI40bWQ/nKOy3pht2AWFV3sfH
         R9TUniAydlqEI03aEOF9RrBTJX4qqAQmaYy+iesbYmnYRX+fJaepPPPXepBtK8B5cyVE
         oPMfLMn5OLt9ZqcborixaJEkPof8Q3sh68VQYyQrr9YRYowh5cH+r3Tv1BEOSzk5Uf+t
         K4kZYXEYtV6TfodqsE19OBDxq3y4aQ+OYjn7wLAiZuRrkqn8GzQWfQuL4o9JEd3T6mhg
         M6dofZaaXxfwze6foLho/oYHOi3QLPNj+wog3tBvCdvH4CQu3dopvD7eB5ecwf3174gy
         2MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292570; x=1779897370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1T2Qb9RrZsz7qcSCkhnlZDPbWojGSBsbannTJKJ4R7U=;
        b=TQX4GzXe2ZdSMHJwAIbT0feaHe/wrUtSetAqcclhg3yljXVTeKI51h+m0AodxJG0Ko
         tmvj9OY2iaKgDMFHA8QuArhZ46asLvJoHZwFslePoUI1rnk6j/avwECr7mPVyQcou0fl
         lQMYAJq2mHEyNznjjls7TwrzLRWtUcrl31R7zMLMidMUnySLeMP+Yngc6tfE0fqGStJn
         duAijVSAbgbv+6lpP1oIIxh341XmdKC0AjFj85kbgYSLFbEX2ZUDzVFyRiCNz24ETlUB
         Wv1vuYdkuLRRo9z3vq7QpqTFOawGiU0QcNh0ev1oGNOSPOO0FFsgmJQ9TMIOWqjLfOsE
         Hv5A==
X-Forwarded-Encrypted: i=1; AFNElJ/tKcbG2Bi8nSjmiNnOj3+h+jJr/z3BMW1hk1Nm8YItiNNeqvkZeOtoEu3d9QpQ2okMvbz0oHlHnvPobo9rGSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZfVaYCbikZZ5/yIRHDUsulVEQLCa6ftg95U24pZlc5LIKf7H
	e4oxdXOd7ZdscRQ8U5BtnF12up/WLU3dT7BYzhDP+lKlQn+qUejlmLhE
X-Gm-Gg: Acq92OHelFhh/+Ch/SLrFiKvnSVKiMRE8rMWylRnUqxXLS92r9PNtVZv8f1Qs7tCGEg
	Tpm+O/RwZVne0UZ89xvkQ378QZ00DxXQWoAUb7RJDOFb8YZnxOMyDxg0vEYPV4kQaZwuNli70YG
	PuHWTszX7GWd//Zleq/yychSHU6fCmj9eUIhogz1bzEXgN79qCI9CnQ1PpWnjqrGtz/r/efTE6+
	/KjF3Ws/TfrwIXcty9vN+uXGVSqE1e1rhiHUUP8OI4494XBOOhgCCWtPthAKTaMS+/3Nykuowqr
	4AbCRgunRHQeWYGtiRxob1kO5cllDpmFXsmmH9nbEj8v2IZWj6ttJvmaD68ASqCkJM8Q0OOrxDF
	Z2cH4Rk6GyBqMhqmvrs2z/QgoO/71MxaNy5wIx+lzjJcnITMFxU+UZHDy0rYegt0uobEOKE2G1R
	L5yh4j6qHcyWd6soe6oIuHutZUVggEIxetaunFjrKHLg==
X-Received: by 2002:a05:600c:470e:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48fe60f195amr364284635e9.15.1779292570096;
        Wed, 20 May 2026 08:56:10 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([89.216.37.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab290e1sm215565025e9.2.2026.05.20.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:56:09 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kees Cook <kees@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Andy Shevchenko <andy@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH 2/2] lib/string_kunit: extend benchmarks and unit test to memchr()
Date: Wed, 20 May 2026 17:55:31 +0200
Message-ID: <20260520155532.1139471-3-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520155532.1139471-1-milant2002@gmail.com>
References: <20260520155532.1139471-1-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

Extend the string benchmarking suite to include memchr().
Extend the string unit test to include memchr()

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
---
 lib/tests/string_kunit.c | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b027..3a7d96e292da 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -881,6 +881,57 @@ static void string_bench_strrchr(struct kunit *test)
 	STRING_BENCH_BUF(test, buf, len, strrchr, buf, '\0');
 }
 
+static void string_test_memchr(struct kunit *test)
+{
+	char *buf;
+	size_t max_len = 128;
+	size_t off, len, match_pos;
+	char *res;
+	char target = 0x88;
+
+	buf = kunit_kzalloc(test, max_len + 64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	memset(buf, 'A', max_len + 64);
+
+	for (off = 0; off < 16; off++) {
+		for (len = 1; len < max_len; len++) {
+			match_pos = len / 2;
+			buf[off + match_pos] = target;
+
+			res = memchr(buf + off, target, len);
+			KUNIT_EXPECT_PTR_EQ_MSG(test, res, buf + off + match_pos,
+						"Failed at:%zu len:%zu pos:%zu", off, len,
+						 match_pos);
+
+			buf[off + match_pos] = 'A';
+		}
+	}
+
+	memset(buf, 'A', max_len);
+	buf[10] = 'B';
+	buf[20] = 'B';
+	res = memchr(buf, 'B', max_len);
+	KUNIT_EXPECT_PTR_EQ(test, res, &buf[10]);
+
+	buf[50] = (char)0xFF;
+	res = memchr(buf, 0xFF, max_len);
+	KUNIT_EXPECT_PTR_EQ(test, res, &buf[50]);
+
+	buf[60] = '\0';
+	res = memchr(buf, '\0', max_len);
+	KUNIT_EXPECT_PTR_EQ(test, res, &buf[60]);
+
+	buf[max_len - 1] = 'Z';
+	res = memchr(buf, 'Z', max_len);
+	KUNIT_EXPECT_PTR_EQ(test, res, &buf[max_len - 1]);
+}
+
+static void string_bench_memchr(struct kunit *test)
+{
+	STRING_BENCH_BUF(test, buf, len, memchr, buf, '\0', len);
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset16),
 	KUNIT_CASE(string_test_memset32),
@@ -910,6 +961,8 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_bench_strnlen),
 	KUNIT_CASE(string_bench_strchr),
 	KUNIT_CASE(string_bench_strrchr),
+	KUNIT_CASE(string_test_memchr),
+	KUNIT_CASE(string_bench_memchr),
 	{}
 };
 
-- 
2.43.0

