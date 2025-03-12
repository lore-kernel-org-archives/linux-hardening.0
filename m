Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F3A921
	for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738888; cv=none; b=OHxVFwKla5gt1Di+Vy4FIERpLP3CRTMzabfjMak4s4Pn6QE5Xof5TKyDOkGvpCnpN47e61Dt0+6P0HSkTzDh3BsZHSE/YgprdOa2Flje3s41c3Go9K5+n43Xrp+H6e2UxgmlJ5s4OEuHp+MC2D9xutFrkhD+e+G4IFp4ov/egBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738888; c=relaxed/simple;
	bh=E0hajOFy+vpCtuf88R9Ti+b+60Xg+fLnjQmi+V0i0oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOi1VHhbXZQUSgvOknRmbVIt1Y4EwpJvsUnNcpwy4VntVoiHBy+lS4H1xrIEl+HHL2D3p81kXjqj/bThWBnYR5yp3Q2q2G0vPH+hTW790jbtNIVhf6wBd5gmL5ROWwt8bCUpRnU7zyEfNlK1HSy1zK0e10DZUHT82Z9AvLIFjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nBVZokNJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBVZokNJ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so996942a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741738885; x=1742343685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miJIXyGYG3FDRWUe/NKY/2IA/SM1dTsr2zjDOOHuDTo=;
        b=nBVZokNJULTTLGlDeH+QhdefPlbGtadJTYisrscWeZKoqbMbt8ZdBdD+JAPkFjdXF9
         oqym5qLf9wyw87OIhlqnNOokF1AZLQZtrujJ3j7KT2q3XXxuUkSooXD0u+vSLh3UhddZ
         oZAw+q88AZE6Z+CbKZbiWHICyvioBpJjbEwt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738885; x=1742343685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miJIXyGYG3FDRWUe/NKY/2IA/SM1dTsr2zjDOOHuDTo=;
        b=UZHS1rLCGvHe4FAp2A/h+ujFinz0FTyss38+0oJgbLIIhIEe22Dz72ejjVd0F9kB47
         RLaGB5eNETpMQ15zbFzbmj9ETiBzdJRvL4ROvZCQcWKHXI2g21ldkVaOdNdAtVdA3F77
         JbHH7HZdpFsStfmX0IHyIDPG7NyBv5pyNcripLl2iCCKlnriyS5rciyMm9qPDpiglWXU
         +DefMR+svPu7cOFdXsi0FZmHMJnMVs8nYhJf9VpgbIu7l4bzTpDVH2GbqgtY978kqS3Q
         eeShNk2YfIXdB03Ri8f2ODqiVN80Ri0DqOXjaMgxXPJX2TOM529YbkiUtQqQQmoaiweR
         lJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx7DuTaIf4//9q85R2Rof7pb2PlqtdHLJTsACxLMtiVj8zLRdZXjtDL+eGSaFpox5zKnAh4wwC1TZriyGSnf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvG26A+oEiEdDttNJL9Yaw3WuzD6ByKhjrxjEM9MTA0EZRqxb6
	aMWAnHx9ifcGQ9M0sTDTvwZua0m/z70a6JW4FzmMxviMZRB6R8xoSmC/MDrq8g==
X-Gm-Gg: ASbGnctGNmHy5F7XyBGz6Dy2Xh+CyvyVk+DLnX+Iqvl3KkYDorl4nLGmQ+g5qTzTpQ0
	KFK8xjIhe3JSWL5J4CwtNq3knxgJBy9VlxDlMJH22nKQ3TgfR/H6s69hPsEbbQhSaDYH9ZDiTY7
	jmqOpKLrYMl+dS4ZBdxUmJ8m1EVrrD3M4eJqys35AF3sYYWZmxwmvJD1cQuKjy1IkHqp602OLjX
	CQ2H8Hh213ZQdaMp1x7W6uJgXggbpOfQApaHA27gzcOYOEs9IUdupG5KZRtOAXjQy4nzWPd/9NW
	G+pNm2Hgo9rfQIXyPdvF+sdAQxaYJ2ovtBqgBdzl72NVvcUd12P+4zBOUlRRnpxhsgQnV+fTheN
	P
X-Google-Smtp-Source: AGHT+IG2RY8KyPk79cZ65JQw4p98XAf1wvRrztHIEplkXwrKzzh8fZlWbd9JzkmEqA3hVmaYTTf1Tg==
X-Received: by 2002:a05:6402:35c6:b0:5e5:e17f:22fc with SMTP id 4fb4d7f45d1cf-5e617f919d5mr7379042a12.2.1741738884777;
        Tue, 11 Mar 2025 17:21:24 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm8846503a12.51.2025.03.11.17.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:21:23 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 1/2] selftests/mm: mseal_test: avoid using no-op mprotect
Date: Wed, 12 Mar 2025 00:21:16 +0000
Message-ID: <20250312002117.2556240-2-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312002117.2556240-1-jeffxu@google.com>
References: <20250312002117.2556240-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Modify mseal_tests to avoid using no-op mprotect.
The no-op mprotect shall be allowed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
---
 tools/testing/selftests/mm/mseal_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ad17005521a8..0d4e5d8aeefb 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -677,7 +677,7 @@ static void test_seal_mprotect_two_vma(bool seal)
 		FAIL_TEST_IF_FALSE(!ret);
 	}
 
-	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ);
 	if (seal)
 		FAIL_TEST_IF_FALSE(ret < 0);
 	else
@@ -718,7 +718,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 	FAIL_TEST_IF_FALSE(!ret);
 
 	/* the second page is sealed. */
-	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
+	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ);
 	if (seal)
 		FAIL_TEST_IF_FALSE(ret < 0);
 	else
@@ -873,7 +873,7 @@ static void test_seal_mprotect_split(bool seal)
 		FAIL_TEST_IF_FALSE(!ret);
 
 
-	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
+	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_WRITE);
 	if (seal)
 		FAIL_TEST_IF_FALSE(ret < 0);
 	else
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

