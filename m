Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A618DC77B76
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Apr 2023 02:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjDNC2Q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Apr 2023 22:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDNC2P (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Apr 2023 22:28:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAED4EF2
        for <linux-hardening@vger.kernel.org>; Thu, 13 Apr 2023 19:28:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kh6so15455770plb.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Apr 2023 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681439285; x=1684031285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wV0ORfeXv57jdNTZ94hzyydSs04V0lY4z8KcxEzlrGU=;
        b=LNh11wT4EHIzhimZwEgXV9BDMf7nHy+oBl6lf8qtqMoNiEz6OoQG9N1T2bGlwiCoe7
         izBspUiGU1sLSEskgQCVo7NLelLl2Ec5Fsqg+nqpkAkfvZRlAPfALKIxZsDh5hB5bByW
         Jd+YhfV2XTBYasK3IDCGRuYOotcdq44GCS8nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681439285; x=1684031285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wV0ORfeXv57jdNTZ94hzyydSs04V0lY4z8KcxEzlrGU=;
        b=IYPedwyvb9OXWedPK03v5GFPxX9BC0Pbo37j3Ak/+0C9P+7xAlPZFzKG3dHHuXl9uA
         flbP0h1tQ+16aO8m56m+oyOHkkYm2qiVCqGlsl8yrYQLuuwp8jIKEdKQ7uiir/NJ0XhJ
         Cb6MuKuzQU5an0d9iKpDKbSBhpNsnzBtIke7ubPt9EIKP/r+bHmN4G7mpr/ZXtnUucBx
         WQV2R5Qd2BbeBKfg1vmWUkrBF/Ci7um5IMbl65iI7F1YCsd8VnMkPwKBzNhy0vHYcoeU
         0E1yXPJrgd88KrCaBlc7jOwxKkkNwWtf5/COx0k8w0eDXPJNMbMrY1cwhJZTcT9feOW3
         cYdw==
X-Gm-Message-State: AAQBX9dW+6iA786kBAyjo479ZBTkB+AY2aVHpx3i/HEokgor3Lr8q08I
        emoHyUpQRSUDUF3sDttYYsw02g==
X-Google-Smtp-Source: AKy350YAYoawfrxXQq9o1RU60KWyzyS6aXgZpnvHFLuSmoSnnEGsr+nci58MA60iAQlgbFwQQ9A5RA==
X-Received: by 2002:a17:90a:7c0f:b0:23f:83de:7e4a with SMTP id v15-20020a17090a7c0f00b0023f83de7e4amr4082251pjf.7.1681439284753;
        Thu, 13 Apr 2023 19:28:04 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id m2-20020a17090aab0200b0024677263e36sm1972982pjq.43.2023.04.13.19.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 19:28:04 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] selftests/memfd: fix test_sysctl
Date:   Fri, 14 Apr 2023 02:28:01 +0000
Message-ID: <20230414022801.2545257-1-jeffxu@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

sysctl memfd_noexec is pid-namespaced, non-reservable,
and inherent to the child process.
Moving the inherence test from init ns to child ns, so
init ns can keep the default value.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303312259.441e35db-yujie.liu@intel.com
---
 tools/testing/selftests/memfd/memfd_test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index ae71f15f790d..dba0e8ba002f 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -43,6 +43,9 @@
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
+static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *));
+static int newpid_thread_fn2(void *arg);
+static void join_newpid_thread(pid_t pid);
 
 static ssize_t fd2name(int fd, char *buf, size_t bufsize)
 {
@@ -1111,6 +1114,7 @@ static void test_noexec_seal(void)
 static void test_sysctl_child(void)
 {
 	int fd;
+	int pid;
 
 	printf("%s sysctl 0\n", memfd_str);
 	sysctl_assert_write("0");
@@ -1129,6 +1133,10 @@ static void test_sysctl_child(void)
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
 
+	printf("%s child ns\n", memfd_str);
+	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
+	join_newpid_thread(pid);
+
 	mfd_assert_mode(fd, 0666);
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
@@ -1206,12 +1214,6 @@ static void test_sysctl(void)
 	int pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn);
 
 	join_newpid_thread(pid);
-
-	printf("%s child ns\n", memfd_str);
-	sysctl_assert_write("1");
-
-	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
-	join_newpid_thread(pid);
 }
 
 /*
-- 
2.40.0.577.gac1e443424-goog

