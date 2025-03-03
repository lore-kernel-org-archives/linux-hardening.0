Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B391EB190
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978586; cv=none; b=TteFbvPndfd9tt3BCyZWFobL8GycIJtKtZfkD/CSzlNmGnZfncz7VANQVTP4JN8Oepq5YdDkq5Qkb4lNoGzP7N3gTjWnCX/831bMwfjpojuMbFcMJOzmCD6iO886FfeKSn18ULLzGDXvH1hAYezrmdMZ0r6lnRGfWll3/JQjzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978586; c=relaxed/simple;
	bh=INS9DlGcwtOWdHzzaCwgHMRJeqld1ZamApqFE5VhtYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX0dxo1DOafL2KHgIFSTNBNz9DOCnLFL5olSjpxJ1yyI9eXQCWwSFMEJ9ok7AQZYH1hUxIHi9WlsVM8hytolncVS3YTNF8mkq9+xOz5eeeNPaDG1A8Rf/gsIVoxlaM6nFhMT5kgUferfBW6ubZWFSphvwZFoTJMnaaC9MQ72iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BAEYc5OC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BAEYc5OC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4cbbb37ccso386194a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 02 Mar 2025 21:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978583; x=1741583383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5fgysdw0hYp2QViiRgS1DaKy3XnISgvx98xYEVPXVE=;
        b=BAEYc5OCYLDtJLwGdNBFLuD0adXaXVGRgNodKEV/3Mf3YRnu3RgVWELUIcrwygBKb+
         LIyLTgiP5h2hNh3FEw6LTKGyC/hvmrYNtumoxLpma2Lbna4ygle3HGkZZxYKBkT0odkt
         /+xwC4LyiHmpvzysJ+/40RjfDR2Gv5BUDa+Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978583; x=1741583383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5fgysdw0hYp2QViiRgS1DaKy3XnISgvx98xYEVPXVE=;
        b=Oz+1cNUzgkPPoA/hRyDNzcDzBPkbX3mas7pOAr6Ul32iSeXl4VFvvvnauXvjkGD7Pv
         aVE0/V8+yfU7MpDO82xgoWfnomj8tKG5fG9YWFZNK8r8LMmVkONAXpe8+OFbi+yjgOFS
         pr2Yqe4+LKbm0+dT+ij1eqyxtf4ArUahDYVB1hWb5Fzd06DTCyvjGVdv/K3LD1zT353B
         41tnVLkK46LD/J5a3As1bNB/XgyScGKvPlMGuRf18iJ2oMIBXqjs4RqBJD6mnXWzGoXf
         I9AcyN5/9Jy+9Cu7yN7NxPP/q1kapBUonJqrCfxR++QmT49zUG6vExlG+twf5dRmDWwK
         Yrpw==
X-Forwarded-Encrypted: i=1; AJvYcCU6rM8IuHsgtrd+UGuoTIJya/A28dFjN6Iu8WIV1Qvm8I7oyKBF2giqy+exZNhKqJVWhidDI6ewJCs9oamdvkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NyCWukPlXsP3EkMaA/MOB+bc8IUdvpHGFjocf1F4pzMlZ6ft
	iliefAJ/cedACg+hE/fs8KLBoJbsC6KDFWSY89zVxbKFsd+YnMA8YsbA6cEY4w==
X-Gm-Gg: ASbGnct6aVgjJyyg4wx/b0fCgiEqe9T5tqPX7CVZP8HxKe8Dkxrm7uJxvNLOsqthFB5
	G5zeI1H8QswfHTBnnZj9vFVgiZX43NsdG1bVg+z11JQ2y/rEweAg4xKY1z/LvbU7PkM1Lssq8Pw
	8Ac0xZL6DstiYX2/GyKoVhTCevQG1V1JIHnu/BFhSFIxD6HekDrZmZI0+eGK/FQ/68FTzowGkDV
	PFX5oDP4+zj8JEqRS/iryIXFIR8boE0lzB2lNQ0cYi8xddmcB9mmgImLcPY4QhBlP9kUOkRRY3m
	6bP99OWZGx1go0QFg5XcAyiCJpcRhlJXouaQyRxOebw99/X2/6Zlquk5dMCjC3xOti+kgTP4pQ3
	7
X-Google-Smtp-Source: AGHT+IHTdlg4uwUS2DR1NxqiIsQtmp7SzqfKi1TOhCGqRUS9eLAof+QK26Tfrj2rVc6wBqo4vEC8Zg==
X-Received: by 2002:a05:6402:35cb:b0:5de:d6c3:1119 with SMTP id 4fb4d7f45d1cf-5e4d6ac3cccmr4772163a12.1.1740978583010;
        Sun, 02 Mar 2025 21:09:43 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:41 -0800 (PST)
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
Subject: [PATCH v8 7/7] selftest: test system mappings are sealed.
Date: Mon,  3 Mar 2025 05:09:21 +0000
Message-ID: <20250303050921.3033083-8-jeffxu@google.com>
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

Add sysmap_is_sealed.c to test system mappings are sealed.

Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
config file.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../mseal_system_mappings/.gitignore          |   2 +
 .../selftests/mseal_system_mappings/Makefile  |   6 +
 .../selftests/mseal_system_mappings/config    |   1 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 create mode 100644 tools/testing/selftests/mseal_system_mappings/config
 create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

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
index 000000000000..c1e93794a58b
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
@@ -0,0 +1,113 @@
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
+#define VDSO_NAME "[vdso]"
+#define VVAR_NAME "[vvar]"
+#define VVAR_VCLOCK_NAME "[vvar_vclock]"
+#define UPROBES_NAME "[uprobes]"
+#define SIGPAGE_NAME "[sigpage]"
+#define VECTORS_NAME "[vectors]"
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
+};
+
+FIXTURE_VARIANT_ADD(basic, vdso) {
+	.name = VDSO_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar) {
+	.name = VVAR_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
+	.name = VVAR_VCLOCK_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, sigpage) {
+	.name = SIGPAGE_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, vectors) {
+	.name = VECTORS_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, uprobes) {
+	.name = UPROBES_NAME,
+};
+
+TEST_F(basic, is_sealed)
+{
+	if (!has_mapping(variant->name, self->maps)) {
+		SKIP(return, "could not found the mapping, %s",
+			variant->name);
+	}
+
+	EXPECT_TRUE(mapping_is_sealed(variant->name, self->maps));
+};
+
+TEST_HARNESS_MAIN
-- 
2.48.1.711.g2feabab25a-goog

