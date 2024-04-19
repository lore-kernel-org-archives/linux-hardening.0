Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47E12DD90
	for <linux-hardening@vger.kernel.org>; Fri, 19 Apr 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535320; cv=none; b=u0WVgTCgOhgqornH+nEHGyML0TW2gHIHx4m3EIHV785YQXFX1VrDDQzGBOeR4ucJoNIB72cVTE0HXXVrLemBq8Q4EECJanKPPbHtxAnoPhUTWhU7+N14VtZMbRcHXWd0Fi2kR8gq2tIyuAbGtSSl+2HOZKOOQoe/LALethW/H0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535320; c=relaxed/simple;
	bh=SOokn6hAfXRfXzM8wtwZF973hyHYm8001yb/KucN+yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGTpg2GoCqsLQ6/nvyizevgnFVCHhPjkg7CVXPCQdcKz6ZTdQaFwS1/sYx/FvOyFwXcRaxoOiDWxO3J/Z9Uc2h+m9DeTxRnP9IHCfG+k2h9DOdNJwaoQlulY1AtwxMu21fDn1acizLmRtWAgskSEM8/8EWj1D6d8FuPfEOPUpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bgeDXqXf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bgeDXqXf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0bec01232so17249945ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Apr 2024 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713535317; x=1714140117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60bj08fNOYkyzGjFmyldnZhisQMFjo0YMqTtaPxORRQ=;
        b=bgeDXqXfN1uesqpIYgPTOCg9HwUKDMNUPjTcuVeYbshVLThDQb3rqo5EdeT4zH2has
         0YQuvYzjuObhlAvYUCYq58pXYzoNJ9taFs7X4NuMtuziljM3KEHmMzA6yz0Lcq86seLO
         VuX21HEcTE0FrBsx8osyoCksQEs7rySRpznzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535317; x=1714140117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60bj08fNOYkyzGjFmyldnZhisQMFjo0YMqTtaPxORRQ=;
        b=R0Ida+E3njmXQjwlSZEyb/ecluJWuE6eYz73G3w5hBisR70z2Vk2wkNJSxalVB6ODA
         wMV9ulMXV1qNIqrfGCLwZA3nNA6onK/d6bhiAyZ794BVP5N1F6OZGw59WiEbxbX7cTa0
         FenHAQ6GFCmYc98uVLjR5g7DlqcA2NgIPTG54Ht0miBiaknBg13QVqg3ztDKDliyp9Op
         nhbYsliQEgMEpNIyvh4jJwnA0YMD0hoV9JLhGqSYCYfgSJqI1wFFeLhJpi1MDMxW3VyX
         mSS3XTIuQ7GI5lXgNDbfS2M0aMKBZS3UoES9zhPdcJt4t1G8JdEsU7cje6Pma5151YpJ
         Uu2g==
X-Forwarded-Encrypted: i=1; AJvYcCWgJS3uSlYSCYHA/J5C92SpTRRjxlPztGthiHXitQl8/zs334Rua3YGNjLIaekYPxZmqTIkd5dsZ8+rvpmdAsPgTA22EB8wTtpB0/nClLHM
X-Gm-Message-State: AOJu0YwGcGZS6YGzZ5OJ3HpumDGKucWa9+H6jAqIfUCTvirY25R2PEwj
	gI8KVQ14eVoRYGV2DJrHvmm45jigy0h9Tz+OUBxdTKL22Y6BEKmbtdNrF/mvbtQuud5yya06dfk
	=
X-Google-Smtp-Source: AGHT+IFxKIaiTQQnHHvaeNar935ymXBnwNgd3CdnYSm3XwjOGr+DFuZ5d0WL0a9FfnSo5+zx+j7sMg==
X-Received: by 2002:a17:902:b486:b0:1e2:718d:f290 with SMTP id y6-20020a170902b48600b001e2718df290mr2175867plr.67.1713535317611;
        Fri, 19 Apr 2024 07:01:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001e284b9b28asm3410545pln.129.2024.04.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:01:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] string: Prepare to merge strcat KUnit tests into string_kunit.c
Date: Fri, 19 Apr 2024 07:01:52 -0700
Message-Id: <20240419140155.3028912-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
References: <20240419140017.work.012-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=keescook@chromium.org;
 h=from:subject; bh=SOokn6hAfXRfXzM8wtwZF973hyHYm8001yb/KucN+yA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmInlS+imGbP3YLDk5RSzjCVBlFhXpXtJzQQJGm
 h0NyeIBVWGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiJ5UgAKCRCJcvTf3G3A
 JkPcD/9hwNQiymaqHA9VWj14VNEZE4Km6N9feNZHjDYp+2MAxj8NUXO81sPxxv/w2XR7erfCHMP
 4SbtoE+nGHXRDbSioIkyVAsSJDQlZbqngPnPLgUQ1a3NQh4BjcA05Tf8Z/nqFE+3VLydiEA3u+3
 nEnON5PZEO7MJa4g2DXBGhonjgRXeQDl5WNdcUfQpUFJw92KDfV485RnQfHHGwV9iDSmmdBo6GY
 QOzU2WbovxDaNTXHQ21Ssj7sQBDH9uHCfSU2p+50nPtyRV86sXi0DxVRAWxOZ1FhGFWRk57h0Js
 tPxMRojOAdzBhiP9uYcZY+C6dFXwOCyx9yfq1UQZx0h7gMAnVX31bzRq79eoEiUQ1aU3V7Wl5Ta
 a1bn/Wu28FsrUuNecO7kgJKb5C3aVkN0J7ibAd7outSSPcJmZoTLFPVh+pvOSJXxYlZK5gqZyjB
 Df5EzAsWhnqD8FTXVSGc4/8b+1MvTzFvDfRiBZz9T+eiM7esjtiTqDxTzUOxTRdZ1bAgkanAo0k
 4jr5uy8WnrwVw+tDV0V7LvNr+VA8C8DopWurfl2UvPZg/qA8PpB1cssFyFAX0OyCI8engzk69mZ
 kzm1SjnJC/DDEs6jvqMk2HhyuSJQF1BUCfsWaJvZABj8yHZgozyTzOyyemz9lg5ZVMus2r+apiR Wrz7TD5G/7dJ8qA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The test naming convention differs between string_kunit.c and
strcat_kunit.c. Move "test" to the beginning of the function name.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 lib/strcat_kunit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/strcat_kunit.c b/lib/strcat_kunit.c
index e21be95514af..ca09f7f0e6a2 100644
--- a/lib/strcat_kunit.c
+++ b/lib/strcat_kunit.c
@@ -10,7 +10,7 @@
 
 static volatile int unconst;
 
-static void strcat_test(struct kunit *test)
+static void test_strcat(struct kunit *test)
 {
 	char dest[8];
 
@@ -29,7 +29,7 @@ static void strcat_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void strncat_test(struct kunit *test)
+static void test_strncat(struct kunit *test)
 {
 	char dest[8];
 
@@ -56,7 +56,7 @@ static void strncat_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void strlcat_test(struct kunit *test)
+static void test_strlcat(struct kunit *test)
 {
 	char dest[8] = "";
 	int len = sizeof(dest) + unconst;
@@ -88,9 +88,9 @@ static void strlcat_test(struct kunit *test)
 }
 
 static struct kunit_case strcat_test_cases[] = {
-	KUNIT_CASE(strcat_test),
-	KUNIT_CASE(strncat_test),
-	KUNIT_CASE(strlcat_test),
+	KUNIT_CASE(test_strcat),
+	KUNIT_CASE(test_strncat),
+	KUNIT_CASE(test_strlcat),
 	{}
 };
 
-- 
2.34.1

