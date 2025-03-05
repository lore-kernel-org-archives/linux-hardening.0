Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179E194137
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141057; cv=none; b=dlS6j/DEJnxczS/its3KHvmiRN8r4d4doPPFfxkIpo/IN8fh6HN4F0S2zhBXMcDMqDAPlOp4C1/LjNOSEsuE64+16Lmruweq0UZAcMkLNFFeBut4SJD5m5X2dnkL1ItRM+REZNAExrVQtzVZW9nzu8O3aTYDOjffDBmMR9DFBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141057; c=relaxed/simple;
	bh=UmY/ayF8HBN/ulyyItJ7lAYgnpBsHJWqhLt8h/dNxHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0fiFduYyi98gpFTfKzxiIYSRhpKynAsoooyzxOPT2Mr1AS81LDRIcr/EYbyO0hgnVw2y9RBFPYNYJDlXWCCBAeifsEJp24Gm705BEV+iafb2CDBvdJqufq0aQMfIdmEdVLZKuai9CL4VQYRxfsDRhwzjZk9KYT2lVZ9wwpZvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C1i+UPTV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C1i+UPTV"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac08167634bso46062666b.1
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 18:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141053; x=1741745853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcCXP5+9u/FLOTwAJWuE/Eiiwb6Tr4w/nKcMIQwNMtE=;
        b=C1i+UPTV6AA+ewFKbZqsLZmuLRob1bl+nC1SJXQK7vRnqeejuIhwDoai008RgyRYDy
         cyVHJ+PSmulhyXzM1CuE4YKfXf/9FDzTJObKeo3vISeb2B7VyD75HkHC0rmSzB3sOxh6
         ddFvlOydoxRRvD/aztyv/e/JEmRHMJkz/PCmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141053; x=1741745853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcCXP5+9u/FLOTwAJWuE/Eiiwb6Tr4w/nKcMIQwNMtE=;
        b=SsO8c8HzgpzLInxOvplOO4iYhEmJTuKkLnces631miJ81E+6/loXx8fUEDJBkYMa17
         h4e0LjIV8cfBBqbNEJMg47CuQjBeZ+kCIfvYVX0jRdTLGC8iwQA9vY+A829b2DS0Raab
         8A7QyJ9Ai8nTH9usVCcJ0rwlPJvCiGO0ITT9Rs2XuGDbJoZAdIKU0NA4mMJnU+QKtU4R
         zXoF1d1dd6s0emKZuhhSghSQ0wpJ7qBmvbpab1AFOUcCmew9MM4FaD5QONd46yGG1zv4
         JDnq7vrwp/5vkSKgvjBccrIYq9JwcGE+JGRTlPaVtCya7TYVkMCszXbhiDJLLn5KXY1z
         FGZA==
X-Forwarded-Encrypted: i=1; AJvYcCWtNiSUHFHdsWFw12xGpsykUT0uXMhCz00cQkaledS1wZTGIir6rvWu4/2RQT6yZ6yVjII2quyw9PsrDyirUS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSbiIC+Msbpt+YSY4GLb7ebCzIjfCmdMsSVogLsjLYHyDfLGr
	pQwiSB3kmYxuVCXVGDRebVpXAORk5ZoiPNxv7SDmCQqYda4WbXnOYa/8K6jQ9w==
X-Gm-Gg: ASbGncv0hu9idS8Ir5C8lpui4MypmciocjZXMdONhjbDYbLBrk0VegI3Jw9W6VejBW9
	ZHOe+Mcs5WtLFoez2ZLasu1Qtw+6SPzK8dWLhElmbtp17tdTo0rrB5unP/t/10u+ot+1KG4y8Fw
	SGCENQB4Ol0gB73WmN+pR6vg7VD/NjC26TiPKvLEftNpq8/lJE+HQ2IUHX2afsHFBZ649GwBH7j
	kEY72McZqsTf8skFwQcK5q0WHJ//3kz/XLUJDNi9DFMvyn21zKBYryE+GoZdlSddHfGnA3V6jKZ
	/+kZ5SyUmcOsMDAQroEvgsjKJeCT0NkpVXIzZ6S5Yz7v7nSfzxscBLNSCqOodLiJOkfqOeAMDxh
	F
X-Google-Smtp-Source: AGHT+IF66plIcsj14Sd9utRPSZXYkhyhx8Xszzbcm4MTAIg/x5pKqpJrtPh/c/C2SNaU4l/Ayi6xCg==
X-Received: by 2002:a05:6402:2693:b0:5e4:d499:5e1 with SMTP id 4fb4d7f45d1cf-5e59f3747a9mr478745a12.1.1741141053293;
        Tue, 04 Mar 2025 18:17:33 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:32 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v9 7/7] selftest: test system mappings are sealed.
Date: Wed,  5 Mar 2025 02:17:11 +0000
Message-ID: <20250305021711.3867874-8-jeffxu@google.com>
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

Add sysmap_is_sealed.c to test system mappings are sealed.

Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
config file.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../mseal_system_mappings/.gitignore          |   2 +
 .../selftests/mseal_system_mappings/Makefile  |   6 +
 .../selftests/mseal_system_mappings/config    |   1 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 119 ++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 create mode 100644 tools/testing/selftests/mseal_system_mappings/config
 create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8daac70c2f9d..be836be8f03f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -61,6 +61,7 @@ TARGETS += mount
 TARGETS += mount_setattr
 TARGETS += move_mount_set_group
 TARGETS += mqueue
+TARGETS += mseal_system_mappings
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
new file mode 100644
index 000000000000..319c497a595e
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sysmap_is_sealed
diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
new file mode 100644
index 000000000000..2b4504e2f52f
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := sysmap_is_sealed
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
new file mode 100644
index 000000000000..675cb9f37b86
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/config
@@ -0,0 +1 @@
+CONFIG_MSEAL_SYSTEM_MAPPINGS=y
diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
new file mode 100644
index 000000000000..0d2af30c3bf5
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * test system mappings are sealed when
+ * KCONFIG_MSEAL_SYSTEM_MAPPINGS=y
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+
+#define VMFLAGS "VmFlags:"
+#define MSEAL_FLAGS "sl"
+#define MAX_LINE_LEN 512
+
+bool has_mapping(char *name, FILE *maps)
+{
+	char line[MAX_LINE_LEN];
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (strstr(line, name))
+			return true;
+	}
+
+	return false;
+}
+
+bool mapping_is_sealed(char *name, FILE *maps)
+{
+	char line[MAX_LINE_LEN];
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
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
+FIXTURE(basic) {
+	FILE *maps;
+};
+
+FIXTURE_SETUP(basic)
+{
+	self->maps = fopen("/proc/self/smaps", "r");
+	if (!self->maps)
+		SKIP(return, "Could not open /proc/self/smap, errno=%d",
+			errno);
+};
+
+FIXTURE_TEARDOWN(basic)
+{
+	if (self->maps)
+		fclose(self->maps);
+};
+
+FIXTURE_VARIANT(basic)
+{
+	char *name;
+	bool sealed;
+};
+
+FIXTURE_VARIANT_ADD(basic, vdso) {
+	.name = "[vdso]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar) {
+	.name = "[vvar]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
+	.name = "[vvar_vclock]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, sigpage) {
+	.name = "[sigpage]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, vectors) {
+	.name = "[vectors]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, uprobes) {
+	.name = "[uprobes]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, stack) {
+	.name = "[stack]",
+	.sealed = false,
+};
+
+TEST_F(basic, check_sealed)
+{
+	if (!has_mapping(variant->name, self->maps)) {
+		SKIP(return, "could not find the mapping, %s",
+			variant->name);
+	}
+
+	EXPECT_EQ(variant->sealed,
+		mapping_is_sealed(variant->name, self->maps));
+};
+
+TEST_HARNESS_MAIN
-- 
2.48.1.711.g2feabab25a-goog

