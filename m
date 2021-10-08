Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528F2C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Oct 2021 23:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E20360F94
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Oct 2021 23:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbhJHX5F (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbhJHX5F (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Oct 2021 19:57:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4950EC061765
        for <linux-hardening@vger.kernel.org>; Fri,  8 Oct 2021 16:55:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa4so8019428pjb.2
        for <linux-hardening@vger.kernel.org>; Fri, 08 Oct 2021 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTgT6QanWfRduDXfALgprcIXPoYmwJMRISipF8hOgn0=;
        b=UvrNsbuHOolQTlQBXEtvY7PhQ4e4HGX7cruVovKzRM26iiB57Q92NDOkOvdFsX9KBd
         9WQXT1UMFWJsbCYpXTLLlQQyIlz2otEFClCRNRWAE1mWhdllnhjYqjC+fcpXest6HeZ2
         wypm984zf7l3YgA/7h3zdE6+DYAIADuYfU6fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTgT6QanWfRduDXfALgprcIXPoYmwJMRISipF8hOgn0=;
        b=oReYrnyGycaEgVEDy9TzOaF7l3sqSD9lqT3X/2xOUus/7bH9AuyqcpdeWXu5jBuEND
         NL8kTeyLCJCzxyBvXek7A5vMYw+4T7mdR1ZnqbVfb3NdQtddrpjhyvI0kBVr2AhE2LPB
         OUZIMN4WZgjRE3vJcmj8OX96NODlzipgvwSQwYz4z/ZRH8DS8pl661Mww8XxW79iAZG5
         QE98VJ2Yx9WIHZJq45W6bIqT+xYEiSKowURJ9L5ehOM2/+sjBjEl0XzgpB2nYPA1mIIp
         U2gcLbTebZH4dGzMRi1Cb1EWCcb0XByatEanQ7U0yrdNfJEpfHUoprEK8Snns5+hrg5u
         pgcQ==
X-Gm-Message-State: AOAM531MSnoURdA0aTSLCvrspx2oXHu7kdcT9pxyJkJtTuRPwh0BhL5i
        bmgVVBlSUNwbSODO7Tz+klXeUQ==
X-Google-Smtp-Source: ABdhPJxVP3N4yhiAQdhQSX2YP8sb7Lm448c8O2UVd19pFUeo4nh/fLA29BP3BsuiH+I1rOT0b4n0kQ==
X-Received: by 2002:a17:90b:224e:: with SMTP id hk14mr14867208pjb.224.1633737308774;
        Fri, 08 Oct 2021 16:55:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13sm13196981pjl.15.2021.10.08.16.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 16:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, jannh@google.com,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian.brauner@ubuntu.com,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] selftests: proc: Make sure wchan works when it exists
Date:   Fri,  8 Oct 2021 16:55:04 -0700
Message-Id: <20211008235504.2957528-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; h=from:subject; bh=rB8jOOGIdiP/iyWBGWq3AhwcsSSZTX18wRYEg/FXYmE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhYNpXPkUEdGrIu4y1HLLDxNMb+n9ox77AOSdFvFSD bfhAXb+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWDaVwAKCRCJcvTf3G3AJn0CD/ 4qW+e9mYMV4ZcwM0iBRmJhmZQxAWr33QtMkLwAO/EaIltsDgim6Ni+pKchA7nIQjf3oFoqZjbhP1Cp C5Y7Qq4W1DR1cD046gu5TzATKoxsbcwcSzBS5mrAPaUKY+vIyciYsqgw2myydRz4vBdNOKy9UcpVLm paa85vPMPsppqd8cQv/Wf1V6J7sjIXORRYYMokEGmQO/aXSShOol1KMtbgLiVh5ws4/KbOjtT0Z3XU R/kBl05TmhX1U0qXJiDMTeHa3PfSHFgxLTbqNUQQzsosY7JSG4IWl4KLpVpC6WRSvnSlYdf1tw65M0 FnCVLSWYGZ1wLsSMcsPhhU+5Vviwlrr4QUtFNXsFxLXOXn/JrgN3XtJWWlfuepZyKeGWOqNX3DzKNw 1BepILhh0xVogfv0fIoee3O/i1+8FjgQUZSO2cCC1fjVW+P5CMAKJwOqhJzlJ3aphOFwcJYTs4SJ5v SRBo1aFbAxpB5Z8dkUeM2EtS5bbjiIj2oau4wVSmQ4wkLIhXT14qIEA70r6JONKZtfnIBmBLESvybZ /eMvMPyvwOaV6N3NiZ1pNMmC8mOJXV4CjQ70UB44ZvfWOg+aMru+++l1uCPrJumAAPedlRsnt08d1J w8+mDwVkblkD5MbHnVgz3Odw5e5YJoCoKR7LNNX10D3EKvOIl/PDTirCZQ0w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This makes sure that wchan contains a sensible symbol when a process is
blocked. Specifically this calls the sleep() syscall, and expects the
architecture to have called schedule() from a function that has "sleep"
somewhere in its name. For example, on the architectures I tested
(x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":

$ tools/testing/selftests/proc/proc-pid-wchan
ok: found 'sleep' in wchan 'hrtimer_nanosleep'

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Hi Peter,

Can you add this to the wchan series, please? This should help wchan from
regressing in the future, and allow us to notice if the depth accidentally
changes, like Mark saw.
---
 tools/testing/selftests/proc/Makefile         |  1 +
 tools/testing/selftests/proc/proc-pid-wchan.c | 69 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/proc/proc-pid-wchan.c

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 1054e40a499a..45cf35703ece 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -8,6 +8,7 @@ TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
 TEST_GEN_PROGS += proc-pid-vm
+TEST_GEN_PROGS += proc-pid-wchan
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
diff --git a/tools/testing/selftests/proc/proc-pid-wchan.c b/tools/testing/selftests/proc/proc-pid-wchan.c
new file mode 100644
index 000000000000..7d7870c31cef
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-pid-wchan.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Make sure that wchan returns a reasonable symbol when blocked.
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#define perror_exit(str) do { perror(str); _exit(1); } while (0)
+
+int main(void)
+{
+	char buf[64];
+	pid_t child;
+	int sync[2], fd;
+
+	if (pipe(sync) < 0)
+		perror_exit("pipe");
+
+	child = fork();
+	if (child < 0)
+		perror_exit("fork");
+	if (child == 0) {
+		/* Child */
+		if (close(sync[0]) < 0)
+			perror_exit("child close sync[0]");
+		if (close(sync[1]) < 0)
+			perror_exit("child close sync[1]");
+		sleep(10);
+		_exit(0);
+	}
+	/* Parent */
+	if (close(sync[1]) < 0)
+		perror_exit("parent close sync[1]");
+	if (read(sync[0], buf, 1) != 0)
+		perror_exit("parent read sync[0]");
+
+	snprintf(buf, sizeof(buf), "/proc/%d/wchan", child);
+	fd = open(buf, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			return 4;
+		perror_exit(buf);
+	}
+
+	memset(buf, 0, sizeof(buf));
+	if (read(fd, buf, sizeof(buf) - 1) < 1)
+		perror_exit(buf);
+	if (strstr(buf, "sleep") == NULL) {
+		fprintf(stderr, "FAIL: did not find 'sleep' in wchan '%s'\n", buf);
+		return 1;
+	}
+	printf("ok: found 'sleep' in wchan '%s'\n", buf);
+
+	if (kill(child, SIGKILL) < 0)
+		perror_exit("kill");
+	if (waitpid(child, NULL, 0) != child) {
+		fprintf(stderr, "waitpid: got the wrong child!?\n");
+		return 1;
+	}
+
+	return 0;
+}
-- 
2.30.2

