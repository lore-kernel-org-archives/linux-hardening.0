Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C921BBBF7
	for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040966; cv=none; b=dAt+L7DOua+jxesJP+/T/R6bqvjeVjT7qvanv4Cr3+rm0lZqNlpY5S0d6Sw36Gx4OldowIaZBjvz+BZ5E+uOYXjb7IqoGrJijA4deU3kLoEm0KT8JYKOAm0KugsQx9jA0rjRtIGF5Y6EEbDTFaDFET4939fMM8OqTjRhbwkOrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040966; c=relaxed/simple;
	bh=43bJiScg9S0+2a59vw6ENrMPRMP4sp01lRmumuKJSQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZB6TDh01VcoTMZr3VFMtFgbzNbiOF9mZhGN8LwcpjQIvXQ1sFmjFewNksyQJjz0YC7UuBzZlsAmAln8hplZ9dR2R8yJs0d7US6At/YH3F7/w9XntRNPMU3v4So7DjOwy9UHxn1/FySotw5iSPrRefgG05kKce05s2PauRxHbj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TcvTW5Ns; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TcvTW5Ns"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c3e70fb6dfso70354a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725040964; x=1725645764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/lLriAP27R5nHPgsK9ypk/521J0I4x/lWwi5ADQ+zA=;
        b=TcvTW5NszHJoTNak4uL+xbjNopz2etxhfKDqVOftECGQhPV52SNaThSXfbAox+h0g4
         SP6luZW91W9BSkjDsf8f45OHZULi7pu8SNBkIbFaPVt2acOW4hVrQca0I4+uYZQ4e0dg
         UDZTMCHHD3LPQ/tuSmmSogz2OhCZ1O0e6+IKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040964; x=1725645764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/lLriAP27R5nHPgsK9ypk/521J0I4x/lWwi5ADQ+zA=;
        b=In0dIUYQ3w0v8Or+jNyqgVkJHNxElS1WJgx5iPyUIY07+EMlri2JMlSmKFtpW6WUyJ
         YnajQAkaZDCAurml7WSeiULtv13aNCCTcX3S/EHFBumiTf3ecotFFNtq/RtmLYvQOMbn
         e9ljif6XrkQriRYXz0F6oiLAKT95b1214WiyaVIdK21wCStCmMpYk2TAa6eZEV02xvNb
         b86mXDk6WOcwdukm2jwPonX/zkQbGD+PgwpQieV6G9oZGqagi2KyCI01caQBvXeg5kl1
         MNbqCW8feE2Wgj/f1FTpnO8MFmet0wxNAdZ1HC1cna6Y/l5sDAWpWtcATj8tzrG67981
         nC9A==
X-Forwarded-Encrypted: i=1; AJvYcCU/1HZsiLDbEEMLnUrOagBsOun75LPhVDyFm8snR2Ijz/kZ2jGE9Y5aHY3QmcHIaDRs6zTZpOVxODhf+zIxPJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmu9e2G8QQ3P12nBsnmXcMkRchbec8GGPOuVxiHQoskvlWQ+h1
	EyR48Zk/XEIV7iR41GnlmTakEjBX/91zl/IdC7KjR2XXE5Foq1ahhpQqs2gV9A==
X-Google-Smtp-Source: AGHT+IF7ss5vHuxDy95Wgb4WUGPyZvgp4tHfy8UO1MWvFABXKWvo/BydPzQQ6FPcavBSzZ5iLhUHAQ==
X-Received: by 2002:a05:6a00:3e0a:b0:710:5243:4161 with SMTP id d2e1a72fcca58-7173078b724mr1724291b3a.5.1725040963782;
        Fri, 30 Aug 2024 11:02:43 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e575d087sm3037827b3a.207.2024.08.30.11.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:02:42 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 2/5] selftests/mseal: add sealed madvise type
Date: Fri, 30 Aug 2024 18:02:34 +0000
Message-ID: <20240830180237.1220027-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830180237.1220027-1-jeffxu@chromium.org>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add a testcase to cover all sealed madvise type.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 7198f2314f9b..6d77dc9b5442 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2121,6 +2121,32 @@ static void test_seal_madvise_nodiscard(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_discard_madvise_advice(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int sealed_advice[] = {MADV_FREE, MADV_DONTNEED,
+		MADV_DONTNEED_LOCKED, MADV_REMOVE,
+		MADV_DONTFORK, MADV_WIPEONFORK};
+	int size_sealed_advice = sizeof(sealed_advice) / sizeof(int);
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = seal_single_address(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	for (int i = 0; i < size_sealed_advice; i++) {
+		ret = sys_madvise(ptr, size, sealed_advice[i]);
+		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+	}
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2142,7 +2168,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(88);
+	ksft_set_plan(89);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2251,5 +2277,7 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(false);
 	test_seal_discard_ro_anon_on_pkey(true);
 
+	test_seal_discard_madvise_advice();
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog

