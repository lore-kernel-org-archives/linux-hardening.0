Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8715CD74
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141047; cv=none; b=HcyYWQp3MGiePyYkQUN1OSZFRGWy76pHiB49uCraKYLhZqDrsUErH7Aj94aFBXSbZ/CmszbhGWXQKqLopmBEdyiY4LgCbrmVfa0kUD2TljMo35EDcH0qg+RA9QWkeE7+zwh0eaGlWRz1dyBgu9+1n0vK6k4QVnLB9M0wMiErKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141047; c=relaxed/simple;
	bh=WkYih5t6WQKzC8SRX+eOO5zI9Mi24DV+jfAcAFV75MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1jNm/DZh/LPX4BC+MeyBtiWHjqFjsaAueCpdsj4Wlskn2dsg22UCcrCgYq/kzEmVEj/1W/MDNUIzgInx0Awkc7D84xh8FX6w2gQoS5Sde42gVU4VwsPbAWXEgWdIxGYgMWwZdSFDsFdt+KcKg7qICMKGgaj+Sl8XkrnEpDkeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AfJDiRoO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AfJDiRoO"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abc28af1ba4so128384966b.1
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141043; x=1741745843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jha9BeMcP/SA8VECG4X9DDtpBo8dKz3YZuDo79u+NoA=;
        b=AfJDiRoOsd3ep55dVYZoCJpcULd7b4yLl7/lmXiIdGZFezcWwYH+EuMQxMP1OJvloP
         SpzCZYx7DyKiBz2C1qZlTDfC6WWGwPRVQIjkuHJhVy+NaXYj9PxisenjXbpS1VXLCyMZ
         IDReA9pOqG5uYwXtwULDgrhb4hwTm6hMV0C+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141043; x=1741745843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jha9BeMcP/SA8VECG4X9DDtpBo8dKz3YZuDo79u+NoA=;
        b=WRhULXfgxkFpXkRpeQiSYmsdJrLxX+bhL9WUh2KwFdNoYYIEIQxxfyhzuqzp09tEGs
         5oMGS9ov3RtZjMi7ZNNQapx8tIDDHjqce5TPgGqwkQXq67wEnO6XmSLGOzMpgh7XDXMi
         w+cp37PRV5Pb3zvOPKDxRHekfvKKYlK0ZMVlVBgbXdZ53vwA0PgPxGSL+7ad8EcDO8CG
         d7nOjC79KVtlc3EKoDOZfPzjUxG15aGufePmLzW8xBd2Rc7fauujuCVAVG2m8+hKSUvL
         3e8sBUX0z1dCoz/nCKM3O+o3CqgohtGUHEjT4NOmj1AONfAHpGWtiNi7c0x7+tIFxJ3J
         ZkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFDTFs/X5Cix4O2Nq+xhggiQgXVn930a1cj41ZiYzo9ljNNTD3yVot3lzja0mqc/hVEqaZVYqLpwFiq9U4CZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJWW8+x9T1E/axuX7R1tIY8ZR7gO0KjHcdb05ihpFz3hwORCl
	Q/mUC/nRZSxo4I3Au5yjWWL9nj7dCBMyukVAPflts8b6+Qemx59y5DJ4OQdAYg==
X-Gm-Gg: ASbGncun9T67qxW1cE0Nfgh0ijRw26G710JGrc2uqyRHCBdDJ7zjUmpOaqRTEpejqhr
	ylMgqLFSVsPewLRXBT9aKxgLUCKvs7rDRyjgn4BIcq2PkNkGksPc2MmJKWyUFeGHDzsQNCDaWgm
	NGvdDXLUPQcQ1L4tTRFxwBJNtmAGdhSSlkKYg45Dtgexw8P9VPlO+fNYro6JfbZFj/oQjU4ruLI
	b7cw8UjlViVaI1UL2aB6HM9Rv42bl5xz5MbGdSozfhdB0oqglgRJzIUhBQd1IEFoLBZJcQPdggX
	8PMgGM3gpco48nlOTor1+rOuA3bA2ibg0qHc/uILjG/QJwsvemwe9dRBDQHgFjiA9+H5gPPb1md
	g
X-Google-Smtp-Source: AGHT+IHAY/NTcScvmVs2xXOeM1Ij1O2NDVu041npSdSjcuYalt0YFoSHHFOL4tb05WaRr9KzRw08ZQ==
X-Received: by 2002:a05:6402:35d2:b0:5e0:36fa:ac1e with SMTP id 4fb4d7f45d1cf-5e59f4717ebmr416274a12.6.1741141043123;
        Tue, 04 Mar 2025 18:17:23 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:21 -0800 (PST)
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
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v9 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Wed,  5 Mar 2025 02:17:06 +0000
Message-ID: <20250305021711.3867874-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
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
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

