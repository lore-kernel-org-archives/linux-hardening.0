Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A226C63708
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Dec 2022 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLGPtw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLGPts (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:48 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEC7391D9
        for <linux-hardening@vger.kernel.org>; Wed,  7 Dec 2022 07:49:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d3so17390287plr.10
        for <linux-hardening@vger.kernel.org>; Wed, 07 Dec 2022 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbsvwgwPR3B757gRns7/stgcrkFvNaKcuShOuGKUmaw=;
        b=dWibBvBTiVA/84gDobjRgvxVixl764pEHsZqeOQjsQTYcSLe2AY2xlkKC1Imw+7IV2
         PoFF7j9IoX6GzTzxhWS5x5nv3blYhAWDvnhY/ykRnnBQF3Y3rS372HPWrCicpAQYKQ4/
         NY3okmtSv8f4TkrJddqps6OldgMeuk8K3hlFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbsvwgwPR3B757gRns7/stgcrkFvNaKcuShOuGKUmaw=;
        b=gm6XOIAJW0+08e4wIm144YIkM9UKFalk7kcbhHZygB54jLn4XVb4mXYGyZytkS6YUz
         TkmA2laDufU7B6qcxg5t4FjuryT8RMUJ7/SSuwkOu6EzOKCvFJ7FJaLei6v+ntYeVn2J
         qBPJ5Y4B8BWmmMMf6LV3GQXplxfjqHmEum7NY3i+eADZtqbz1hrImtaIcIdB2IUEwWR9
         XnMtS8nAOlHsqlDKUaNiYP/0Qcc5Jj8jBuwBIvBuaYTsO1qmiXTW0YeU53okRotLBmqp
         zp6SAiilaNR+/+EpHFO/zVIa2c5K6SaNTyCMgNppGoAMOZzc8cpUZgqNZMm72Y0mc0Bx
         ZEhg==
X-Gm-Message-State: ANoB5pmzN+m3frJ4yqLf+zAOrPZ5BgLHi+IaxgBMwUCsplBOTqzOaB3L
        MJb+xSJv9ErMtcgYaPFsyubk+A==
X-Google-Smtp-Source: AA0mqf65I6vPuxVOpHwNsHHWkaw68sLPWZIiaC5lE8zMMVwu8IMu2bTggeZG3xjdH6nSzo8NcdHflA==
X-Received: by 2002:a17:903:40cb:b0:189:b4d0:aee with SMTP id t11-20020a17090340cb00b00189b4d00aeemr756372pld.67.1670428186688;
        Wed, 07 Dec 2022 07:49:46 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017f7628cbddsm14920934plh.30.2022.12.07.07.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:49:46 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org
Subject: [PATCH v6 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Date:   Wed,  7 Dec 2022 15:49:35 +0000
Message-Id: <20221207154939.2532830-3-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221207154939.2532830-1-jeffxu@google.com>
References: <20221207154939.2532830-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Daniel Verkamp <dverkamp@chromium.org>

Basic tests to ensure that user/group/other execute bits cannot be
changed after applying F_SEAL_EXEC to a memfd.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 129 ++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..1d7e7b36bbdd 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -28,12 +28,44 @@
 #define MFD_DEF_SIZE 8192
 #define STACK_SIZE 65536
 
+#ifndef F_SEAL_EXEC
+#define F_SEAL_EXEC	0x0020
+#endif
+
+#ifndef MAX_PATH
+#define MAX_PATH 256
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
 
+static ssize_t fd2name(int fd, char *buf, size_t bufsize)
+{
+	char buf1[MAX_PATH];
+	int size;
+	ssize_t nbytes;
+
+	size = snprintf(buf1, MAX_PATH, "/proc/self/fd/%d", fd);
+	if (size < 0) {
+		printf("snprintf(%d) failed on %m\n", fd);
+		abort();
+	}
+
+	/*
+	 * reserver one byte for string termination.
+	 */
+	nbytes = readlink(buf1, buf, bufsize-1);
+	if (nbytes == -1) {
+		printf("readlink(%s) failed %m\n", buf1);
+		abort();
+	}
+	buf[nbytes] = '\0';
+	return nbytes;
+}
+
 static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 {
 	int r, fd;
@@ -98,11 +130,14 @@ static unsigned int mfd_assert_get_seals(int fd)
 
 static void mfd_assert_has_seals(int fd, unsigned int seals)
 {
+	char buf[MAX_PATH];
+	int nbytes;
 	unsigned int s;
+	fd2name(fd, buf, MAX_PATH);
 
 	s = mfd_assert_get_seals(fd);
 	if (s != seals) {
-		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
+		printf("%u != %u = GET_SEALS(%s)\n", seals, s, buf);
 		abort();
 	}
 }
@@ -594,6 +629,64 @@ static void mfd_fail_grow_write(int fd)
 	}
 }
 
+static void mfd_assert_mode(int fd, int mode)
+{
+	struct stat st;
+	char buf[MAX_PATH];
+	int nbytes;
+
+	fd2name(fd, buf, MAX_PATH);
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%s) failed: %m\n", buf);
+		abort();
+	}
+
+	if ((st.st_mode & 07777) != mode) {
+		printf("fstat(%s) wrong file mode 0%04o, but expected 0%04o\n",
+		       buf, (int)st.st_mode & 07777, mode);
+		abort();
+	}
+}
+
+static void mfd_assert_chmod(int fd, int mode)
+{
+	char buf[MAX_PATH];
+	int nbytes;
+
+	fd2name(fd, buf, MAX_PATH);
+
+	if (fchmod(fd, mode) < 0) {
+		printf("fchmod(%s, 0%04o) failed: %m\n", buf, mode);
+		abort();
+	}
+
+	mfd_assert_mode(fd, mode);
+}
+
+static void mfd_fail_chmod(int fd, int mode)
+{
+	struct stat st;
+	char buf[MAX_PATH];
+	int nbytes;
+
+	fd2name(fd, buf, MAX_PATH);
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%s) failed: %m\n", buf);
+		abort();
+	}
+
+	if (fchmod(fd, mode) == 0) {
+		printf("fchmod(%s, 0%04o) didn't fail as expected\n",
+		       buf, mode);
+		abort();
+	}
+
+	/* verify that file mode bits did not change */
+	mfd_assert_mode(fd, st.st_mode & 07777);
+}
+
 static int idle_thread_fn(void *arg)
 {
 	sigset_t set;
@@ -880,6 +973,39 @@ static void test_seal_resize(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_EXEC
+ * Test that chmod() cannot change x bits after sealing
+ */
+static void test_seal_exec(void)
+{
+	int fd;
+
+	printf("%s SEAL-EXEC\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0777);
+
+	mfd_assert_chmod(fd, 0644);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+
+	mfd_assert_chmod(fd, 0600);
+	mfd_fail_chmod(fd, 0777);
+	mfd_fail_chmod(fd, 0670);
+	mfd_fail_chmod(fd, 0605);
+	mfd_fail_chmod(fd, 0700);
+	mfd_fail_chmod(fd, 0100);
+	mfd_assert_chmod(fd, 0666);
+
+	close(fd);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1059,6 +1185,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_exec();
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

