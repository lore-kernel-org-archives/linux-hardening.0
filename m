Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF437CD3F;
	Tue, 24 Mar 2026 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318052; cv=none; b=HuR5T7aEIej8gLS/62yqZHoaYKK0f3csHqfsppM3Kxa9O2cY3Y6F/Bmx6ShUNSnVlito/vEiE4Voonu6Iipy+Bk8TXfoY2T0S7u45mTG0MZhs7/vULSZqC/XpjQb6rqJsLdDHU4lM/5YIUC1vqRd+C5mR+I+AAXFNjRRwke8Aiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318052; c=relaxed/simple;
	bh=pAx/PvSEGw7/5bbf1hocL2t4NIuGnAq/O9b0E3vE+9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7CnXVeqUV++tbLpgoLaQifRjhnGBcxHpc9uvs/Phjb05m+RdE/df2efpoElp4bWJ4zjtsDMLmXht6CFyq7W1EGUw40LFRSR11eFwrMojlotMBQzVc+mhpteLjFf8SH6XskU1RGvU41I6cZbWFIDLChuchcfJQjWkGn6r0qJTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8EMvOw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8EMvOw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0F8C4CEF7;
	Tue, 24 Mar 2026 02:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774318052;
	bh=pAx/PvSEGw7/5bbf1hocL2t4NIuGnAq/O9b0E3vE+9g=;
	h=From:To:Cc:Subject:Date:From;
	b=U8EMvOw6j0vFksVy3n6XcVQvweaSg341Sc1ESNsLoj+CprZ0nZRTbMrMExqa5EiN7
	 SJXAE3bgdUD5Ju7mXoHELM6K1d1t2qtGMgaW7HU+dMYh6fSSxNE+IRal15RHIo3dll
	 XcRyXiv51uocg2408dNPhgBeRJMZTtr3N9e7hTMXog52C8NQs2I84vbHdNaw37kb//
	 je8Ckddjhiw+LHhQv37aq360Q9r/tL5Ml89MWQqML9dELRx871Y2iC4Q7GVVbbW25g
	 G8xW1YVmwzwJz7TNItLryYekGTkI2Tw2GSFVkfWeZcjeWymQRagW0zuawdAkf/rTnL
	 HeoKe8m5xaDJg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/fortify: Drop unneeded FORTIFY_STR_OBJECT test
Date: Mon, 23 Mar 2026 19:07:30 -0700
Message-Id: <20260324020726.work.624-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3590; i=kees@kernel.org; h=from:subject:message-id; bh=pAx/PvSEGw7/5bbf1hocL2t4NIuGnAq/O9b0E3vE+9g=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkHPz7aqj25XPJxy7LLy45c4n3y793NjznxVzf6qh+48 mpHoWCDVEcpC4MYF4OsmCJLkJ17nIvH2/Zw97mKMHNYmUCGMHBxCsBEZOUZ/mdPS/+3fbXVVdts m/UHZfP7f7HWpKn9ydskp5P6RMnGYhcjw78PAo5pHU4fVB4em7ktuM93csaJ/p15x9keV/eu4RE 2ZgQA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The str* family of fortified functions all use member-sized limits
for a while now, so the FORTIFY_STR_OBJECT test is redundant to
FORTIFY_STR_MEMBER. While here, replace the strncpy() use with strscpy(),
as strncpy() is being removed.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/lkdtm/fortify.c            | 36 +++++--------------------
 tools/testing/selftests/lkdtm/tests.txt |  1 -
 2 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 00ed2147113e..7615a02dfc47 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -10,30 +10,6 @@
 
 static volatile int fortify_scratch_space;
 
-static void lkdtm_FORTIFY_STR_OBJECT(void)
-{
-	struct target {
-		char a[10];
-		int foo;
-	} target[3] = {};
-	/*
-	 * Using volatile prevents the compiler from determining the value of
-	 * 'size' at compile time. Without that, we would get a compile error
-	 * rather than a runtime error.
-	 */
-	volatile int size = 20;
-
-	pr_info("trying to strcmp() past the end of a struct\n");
-
-	strncpy(target[0].a, target[1].a, size);
-
-	/* Store result to global to prevent the code from being eliminated */
-	fortify_scratch_space = target[0].a[3];
-
-	pr_err("FAIL: fortify did not block a strncpy() object write overflow!\n");
-	pr_expected_config(CONFIG_FORTIFY_SOURCE);
-}
-
 static void lkdtm_FORTIFY_STR_MEMBER(void)
 {
 	struct target {
@@ -47,22 +23,23 @@ static void lkdtm_FORTIFY_STR_MEMBER(void)
 	if (!src)
 		return;
 
+	/* 15 bytes: past end of a[] but not target. */
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
-	pr_info("trying to strncpy() past the end of a struct member...\n");
+	pr_info("trying to strscpy() past the end of a struct member...\n");
 
 	/*
-	 * strncpy(target.a, src, 20); will hit a compile error because the
-	 * compiler knows at build time that target.a < 20 bytes. Use a
+	 * strscpy(target.a, src, 15); will hit a compile error because the
+	 * compiler knows at build time that target.a < 15 bytes. Use a
 	 * volatile to force a runtime error.
 	 */
-	strncpy(target.a, src, size);
+	strscpy(target.a, src, size);
 
 	/* Store result to global to prevent the code from being eliminated */
 	fortify_scratch_space = target.a[3];
 
-	pr_err("FAIL: fortify did not block a strncpy() struct member write overflow!\n");
+	pr_err("FAIL: fortify did not block a strscpy() struct member write overflow!\n");
 	pr_expected_config(CONFIG_FORTIFY_SOURCE);
 
 	kfree(src);
@@ -210,7 +187,6 @@ static void lkdtm_FORTIFY_STRSCPY(void)
 }
 
 static struct crashtype crashtypes[] = {
-	CRASHTYPE(FORTIFY_STR_OBJECT),
 	CRASHTYPE(FORTIFY_STR_MEMBER),
 	CRASHTYPE(FORTIFY_MEM_OBJECT),
 	CRASHTYPE(FORTIFY_MEM_MEMBER),
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index e62b85b591be..3245032db34d 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -82,7 +82,6 @@ STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
 CFI_BACKWARD call trace:|ok: control flow unchanged
 FORTIFY_STRSCPY detected buffer overflow
-FORTIFY_STR_OBJECT detected buffer overflow
 FORTIFY_STR_MEMBER detected buffer overflow
 FORTIFY_MEM_OBJECT detected buffer overflow
 FORTIFY_MEM_MEMBER detected field-spanning write
-- 
2.34.1

