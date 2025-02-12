Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B391DA60F
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330521; cv=none; b=h1nmjUKXXbqMJ30qjnc/F47w6T0/cLhpodWOToNVTInQ2uHZ3+5GiHjgUOeEwPccgRTMUoI46CtGLOLvX+qHpagLHdvgHe6D6HDCZNtR2Lbf1NYNUbXBNBpjq9yjQjIIPeFjPkdF7/A0viGqhjXP3jt3TGyrkzvNN4YLr1mFYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330521; c=relaxed/simple;
	bh=w05nUehMgqwD35vj2y2xYw7+UYzGcB8hX3kEdKcacUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s49qqmYEFmqj9yTp1FNiNdArlTS2ALKiuuxLigviA2m/MH3XwGfyebReRChmRQntHj7y455CvcCBk+A1VbgT7eXHk4TocYDkFN/rCKstEyykETdNo2+xUNjaJFuC1xKx3XFu7WOWqgarQqjLDBGUbNSrNQ3Muh40zNGsQZK541E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IawSfX5q; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IawSfX5q"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f45526dea0so1494565a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330519; x=1739935319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncxizXOAVrQ+BWFck4tB/XehU76xAVIOQApqyTjKcXY=;
        b=IawSfX5qB2NIA773BpHMcYG7zdu1MGJW2P8MV+XmDVUcVx/AytsNNwZnoIm1Pi4s99
         hkQFSyRGCnTD6eqrdjnatsKPmMP0K9OHmosSfvrViiZiLvVkPP67mVmDU8Y5hGNqfWP5
         spnLjP2rCy5bRZIlxyIzozQUjzYj5fgPhQR3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330519; x=1739935319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncxizXOAVrQ+BWFck4tB/XehU76xAVIOQApqyTjKcXY=;
        b=mn/AZuEh2pAYUSeSHqwQWQzfCLgkdp7mP9ZcaWE56fzzfcldNteIh3iWCf9BK+4Nf3
         QFqySVGZeBYIlNmom2OI0vxEx+lNyD0tlRmZD2Y/SUCAAw8Dg+/MybuDWTIxP6L4ayl7
         wnVOcwqGjvSrJSTHP4LEbLFAP9FYrj1Up7aG4wBDorX/zo9RncsW89cgHkVX1irpWeXq
         4AxPb7Rmf3pNf3G/LccnZx3T+Tyh78xp/Jhp1IxrNqqfajMRT6Hn0+dcqwEgzLeCBHFM
         nNYvnIK87lu9H5rqfcWHyW6PGSJZCzUeEkgyDGC2nUxZpphtvIziAHh2dM7njtWC+TAb
         p+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXK6Sj1rsFT8t3zmM4Mfc2RUDNmHsyaNVxFWKVhS216vr0pW0Z2zOxTeBzhyg+BYQ+rO4vr6rCXnt98hyB2WUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlpwAmuBG5LHnBAqWLPA0ZH2BLWosf8QKsybCf450vdoq5k/T
	Jxow8qafJ/Zv49FMCSpFfmoiEOzOi1us70XqYWVNXhpZThGeAeMhjBEqka3cVw==
X-Gm-Gg: ASbGncvrx61yuZc5OaINeL16/V/J9X6cI6eJPSVsAkIoJVWUYufQxda/8W95FnAKamO
	AsmlJjufejiHvOfN+wcTxFneI/9aZzxl/nDsYq4zQ0OY7USiNgB3AwiBG1CnruuAxh40JL92CEA
	fD8EL4X+ggSFz9o9nDmG73wt75Hq8InC9HFWXS4kV94W2aXUY5siBax6mzY6tvj4Zih0EFg9hHn
	Rf5WzB7Zx16uSpTyCTEPnB9ulTvFAdlaRVTIMe+TRe2tQt6YmOmUrZPwnJ8n53U5x/BWCN14UJL
	i+gIJ+mcgbwzkjvz93pFUyKQw4HYEES1Mc1N6H5dybcW1AuJow==
X-Google-Smtp-Source: AGHT+IE4/7BwbuwtwfhXwLsB0i3Q5aZn7rPFgpOtvzT4ULZm4VcW3dgNVOfd6aFz9L3M8GZfkNV1AQ==
X-Received: by 2002:a05:6a00:181a:b0:730:8cfb:d5f5 with SMTP id d2e1a72fcca58-7322c4031d2mr872747b3a.6.1739330518746;
        Tue, 11 Feb 2025 19:21:58 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73089c88552sm5087106b3a.93.2025.02.11.19.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:21:58 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v5 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Wed, 12 Feb 2025 03:21:50 +0000
Message-ID: <20250212032155.1276806-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
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
---
 .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index d53959e03593..c68077c56b22 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdbool.h>
 
 #include <sys/mman.h>
 #include <sys/auxv.h>
@@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
 
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
+		ksft_test_result_skip("Could not open /proc/self/smaps\n");
+		return 0;
+	}
+
+	if (vdso_sealed(maps)) {
+		ksft_test_result_skip("vdso is sealed\n");
+		return 0;
+	}
+
 	child = fork();
 	if (child == -1)
 		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
-- 
2.48.1.502.g6dc24dfdaf-goog

