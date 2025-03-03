Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AF1DE4E5
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978575; cv=none; b=ThD0izGCrmKGBYh27kCXDmnnupiqMksHfmH42qK2XNyEPSYNMbCpZVLNujwVWql/ZLO0vrdDbLhdBZzWhWI/FIk5Bicp+0rq7CubeXWz0NRl1DBI8lYLKF0Ji8hFA1WVvKAA1cKGbM7AsqYhBI3ImVdtyMBG+Hf6AlqhIUeDHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978575; c=relaxed/simple;
	bh=mHyZGW3XXV2IETBinOXCmJuoOv/UZZoQ+5BGbFRYUkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr4ZNMpmHr/PndcV+fssjQdDQDv7sRCv1lZtHWsdEO6UUavK0+iZ0F8HFqBbAY9aN0Ql9kd/2UhYZXa2h6z7/5spsAjJMRByHObDi8QEKzpbDXue+KdfE2ryNPMmFXsjnH0vZd6EZ/oXtA/iOOKnSwJwsUi/3UmnXvBHzCJ8ESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VWkCs3pE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWkCs3pE"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4d18a2c51so386992a12.0
        for <linux-hardening@vger.kernel.org>; Sun, 02 Mar 2025 21:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978572; x=1741583372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPZJ0CcsH5TjJPWWmbSBZjzCQW+f7CPLi5bx9zgqPMQ=;
        b=VWkCs3pEY0L5JRr0BFQHWMsyRLEqm1LalT27OCxHAHgduk3t8qoxoz8Sk7Fp5NMFxJ
         8xOadFdwpIoDHsv0fY/Uu364N3s909dfFW5h00lf+YLHl/Yu7wXNuRLPUzPbO0vWzGgL
         djjrdJbG0Wfni9yIKWnGwSqjmFIpHQQanA1Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978572; x=1741583372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPZJ0CcsH5TjJPWWmbSBZjzCQW+f7CPLi5bx9zgqPMQ=;
        b=kg1gnrkaJQQKEmVtM+cngF1S0EdY5GP9UIyN0agSwrh3cvNlS6FaWb9F4QEDUx8/X1
         vzNf60U6YCy55fTa4qHFElrH3am2d/yHRaX7DZDIZS2elRZpNYTqIEDqEVcS8rCYW+KR
         85YRiDbpa4lnwrozAGOVBCm9cEDplzuo20Y/w0idYPDl6X4uVxBgJGSbuROIgpEXawh0
         EniVaZ+scOyJEkf2cG1Jb7EErIhYzdHTyMA0u8rQ/xY3THoFXB29CZOPfUPQZPEzlUX5
         P9JXwPXzEy6PYIIVNOwJ3g5rIdeepHsWBp5gfr0Fd97aiYyN+enjJ3VvwcXMJT/zW2TD
         Op8A==
X-Forwarded-Encrypted: i=1; AJvYcCUODg6B8yehI12LPqsEa8CvEAt9GWmgkfQmSPya7UxzLfd66p8Sk0asm4p8EJn1Rs2CzG+fnn8Ce+mZIjR0wYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACB8RfBLGtSG24E6Xn7BPZROsFhAhpPOxfSpr+itYEXfqEuzK
	smcR22TcyKNxDQz9NgJEnvhy7KAq0sceuzoKfQ9g13wJMyAtFtk9pX1ALBWBDQ==
X-Gm-Gg: ASbGncvGsg9Rl93HKWEbzq8sDS7qMuuMfaomjLLgD7/Hzls7on4xDTSHnNqolVCtsGq
	bEhKsErjMmwOARvulELJg6nFnrP9tfcDRyy0IYUAdQe9Ckf0BGEqOfifQM7p8sBAI5knaN9zG7i
	84EmIfrzJWFeQ8snjuqF8XECfJQujjEVbTNT78FJSO+Z/EM/zUM52Fd1+KeizgD+i6iQxpeXul/
	rFzfJF7Saxz5QW6cX6XOfzB6CdJJMYDHxSD3I9uhz4jWmUxcb/DPml3+A9dvSfCuYFlgCRTZeiW
	Kkiri8TDOw3N4WXwNeksUJVUtLmPW55NhRVdkgp5+v0nH4zCAvLb1rB2blRNB5l06wRJDoBBqYB
	l
X-Google-Smtp-Source: AGHT+IGAeqZ+McRryeGgqFOzw3HwO3Fs4NU8ex0NeuYH4wiS7VhFyW50n3jYgD9tGP1fasJPyc6AuQ==
X-Received: by 2002:a05:6402:2113:b0:5e0:803c:243d with SMTP id 4fb4d7f45d1cf-5e4d6b70387mr3929949a12.7.1740978572389;
        Sun, 02 Mar 2025 21:09:32 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:31 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v8 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Mon,  3 Mar 2025 05:09:16 +0000
Message-ID: <20250303050921.3033083-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add code to detect if the vdso is memory sealed, skip the test
if it is.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index d53959e03593..94bee6e0c813 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdbool.h>
 
 #include <sys/mman.h>
 #include <sys/auxv.h>
@@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
 
 }
 
+#define VDSO_NAME "[vdso]"
+#define VMFLAGS "VmFlags:"
+#define MSEAL_FLAGS "sl"
+#define MAX_LINE_LEN 512
+
+bool vdso_sealed(FILE *maps)
+{
+	char line[MAX_LINE_LEN];
+	bool has_vdso = false;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (strstr(line, VDSO_NAME))
+			has_vdso = true;
+
+		if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
+			if (strstr(line, MSEAL_FLAGS))
+				return true;
+
+			return false;
+		}
+	}
+
+	return false;
+}
+
 int main(int argc, char **argv, char **envp)
 {
 	pid_t child;
+	FILE *maps;
 
 	ksft_print_header();
 	ksft_set_plan(1);
 
+	maps = fopen("/proc/self/smaps", "r");
+	if (!maps) {
+		ksft_test_result_skip(
+			"Could not open /proc/self/smaps, errno=%d\n",
+			 errno);
+
+		return 0;
+	}
+
+	if (vdso_sealed(maps)) {
+		ksft_test_result_skip("vdso is sealed\n");
+		return 0;
+	}
+
+	fclose(maps);
+
 	child = fork();
 	if (child == -1)
 		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
-- 
2.48.1.711.g2feabab25a-goog

