Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CD20A5D1
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437571; cv=none; b=pUi5EzSkamOzFg8gOogLj4CKEFX1qgFkEs0rB/4Sii/SiWpFtWJErjOik+9Tb6OHiw/6h9ox6w74FV2PJE9GxIT9wUR4up6Fe3Ku3lg+A7DAtA1rpXANd/LkXveOxzgIKzcHWHYANnrn7jXHwm0iTkc23//x0cna1qUjl+sH0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437571; c=relaxed/simple;
	bh=vx6vB9UgcnLZOWNDu7hZerIV11aErIGRCAi4dguYZw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUQLWfDC79PiknzwraM0d0zCcJcUJk1OUlCiv1beLIxY1YIJ3XpnKM+OtiVU2F+1dnbTNRX/bJUlZcIOKAcj74icw3yIeYRk+jzsOmLFcAQDtGm6owMFplihgBOR//EQg5Wx7qYXnNXexLVU09EF76m/neIIgL4rZ30rG7CQwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iJlAgvdg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJlAgvdg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22134a64d8cso12091025ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437569; x=1741042369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLPC0aGcYNb1lvLik1r4PuSirlrOiN9ljuV/brKB6K4=;
        b=iJlAgvdgtTCfaG6hOyucqOw1zthzJhXyoPf3t6Hjzd8UNgQKw1ZL4OxgbmboUsgn8S
         RjI8F9+PArJQgNj45YkaZZN7U+yP9Mum/+ccQQNLJZfDhPx8YQhhwhlTMvHlY14ywlYX
         62oT0Hf2zlrA7P78A8JBXzWhWqLDbVEnQXiY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437569; x=1741042369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLPC0aGcYNb1lvLik1r4PuSirlrOiN9ljuV/brKB6K4=;
        b=rBv2Cae1OwE2WlxCE2iYDc6VzYTJJ96QkN3k1TX6ST4rUyRZKr18Skjk67AvrNU5IN
         r6C6X06o846axxpZ6d+Twz3oaWJBP9x94Lif7/pglv3aT7iEs70OFrVQWgnAKW2dF+Eu
         X2gvgEL8Gv6+Mgk2LHLLgJUw5KmWocZVeJIz0FFw22aY9KVgDH8ffeFHq+s60PKGjulR
         02R8wHabGlyRP7I7Qu76eHH9x8QNsKX+5qX9fIEDOwmXjP+P2ACAanu3IVhEwjWISLbq
         sq6x8G1e6FRRJFcl+381Uk/LZmG8axUbBQN6+ciwwKTyu8Lbf0uAh4T30yB6eepnxMFU
         WGtA==
X-Forwarded-Encrypted: i=1; AJvYcCUUvhVuSiHVXPhxtH1XN2gOM44B9SG79im6FrmpohGMYmTeHVyqrD18VW/CqAKgitKqDQxinm5YcNGCVqHGb+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRrjbtBvUmlpMhQLeClZ4lHE103sFwmlyS3Qq0gcQtrVF6si1
	q+G4yv7OaBZNie8hlxofqtl9NQa9vc1xY2BVqTkKjCIADGrnGWu2SGvVUQbjiQ==
X-Gm-Gg: ASbGncvjMnRA1ExPUMJxzUXEtnzIn+MyKCsJXzXOWkF1r3OYOtJCSDiqbFK/D39bKc6
	gF4S4h5O/p6XbkR2RgaM3j2WL3RVyhJjmcyv0y1fEVfvW+x9YGF3PA6TEAMh6c/HMvO/y5Kedei
	m9GK8G8MR9sl8FuWT9PUoNRGC9e+q2I15zmS3tz0Aj+vGcbOaIzFZ6T1aB+46Z/0jsI0BJyzubw
	HKSIc/Vt31XRDkQwg8pFppj+O2mvsIfhKghH7sgjJmcL1/tyIluTpYL3HoPzROZS9BadKjbApP1
	BwQFbwLB75Rb0s/f+oglnLiLXL5hhrO8xb3SyVSIlmjgSoWHo0gFsc62Qa3y
X-Google-Smtp-Source: AGHT+IHCp48/6UHF/fa/HDiAGSPZBXV+VJjrvt3aHCsldayQ5uHsZNAe0/b2WwYSN5ozi8oGHlQeSA==
X-Received: by 2002:a17:902:fc8d:b0:220:f708:b7a2 with SMTP id d9443c01a7336-2219ffdfe62mr95535885ad.11.1740437569437;
        Mon, 24 Feb 2025 14:52:49 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a092fe4sm1292045ad.147.2025.02.24.14.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:48 -0800 (PST)
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
Subject: [PATCH v7 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Mon, 24 Feb 2025 22:52:41 +0000
Message-ID: <20250224225246.3712295-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
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
2.48.1.658.g4767266eb4-goog

