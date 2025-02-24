Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F039263F3A
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419119; cv=none; b=Ix00giX0mqn29FPHlQkD6MUCwOFcC7lHLYcWPM3YsKpGUdWdEmxLWPBFyJNuPqwKXMNDRpwkt0qFFpTH4/GZ6FF5DcaP8Pc8YO2GEsOFp4UniJNgUKCx6+o3nuxPbzhnSqBc448eukK+l954fdwd6KrGJBDexfcES9odRIWbn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419119; c=relaxed/simple;
	bh=OBBKl96vxFBmA1av2T8KVacZIA2ShhvhvpxM/xuQFAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALxRMke69j5gf2LN1TEV4yELushYOvHGp4hvX0NdVNWNUus7WQaZYbUKAPECWuqGXsLGLtMa0TQNENFkXk4SyJhOuS7wOIMcrPaWztelzMWN5kzE67jlNyyVfTMGCDmyQq4IRslc8LSU8E0vmQb31bX4A5GHHqITGyIa5d5KZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oX45CEQi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oX45CEQi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d27fcdaaso9793265ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 09:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419117; x=1741023917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOuDnv83CpzU9+Is9rRk+mGWBAWQzFMYMR0kufccTA4=;
        b=oX45CEQiaBFt2c3ke/zIZRDDmgl/Gj6ptwCMxYGCLSi197WwLvGN5fy2oVTYvCI5Fr
         dazXMgrlaCwHfVgQv43jtSJpMO8Ra+sKfpCo0VpxZl5EZqSeEe4fT6yiLytsL2R8S8Lv
         7WBYKy7l+iykCRvn4gHJUa4vWJCav0WYNCwks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419117; x=1741023917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOuDnv83CpzU9+Is9rRk+mGWBAWQzFMYMR0kufccTA4=;
        b=RW4lRLZvLiurZNBiPjQNK/NnFRjbwVZ8wq923hEbiZR1t/Z9/sjBvd92EYIPJggT6r
         8uJcO2JQen0dn5jkBQMXqZcBlb5hIxlmDZbqkFipoZYQrwqk8MP+O1Qi3q6AiZLkVp/D
         O4jT7vK66zdfW/nkpgFb7mBCrszm7JUkg5boFj8ZEnZCIYmkIVmDxt+v2dJaTT2ebA/8
         UjiKh61EmpVmQthhW2O97EVlcKHwRUM8xwKjJSe4CnZV1ADZ7s4qI1pFee+++kzQ0uFb
         Nx8gsGG7TTRgsGEbBksgr+0euM+/8mqOE6YLwDNpKR9wYRpvSY5nfTJJZ4xX3WhjuEQo
         NXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbM4Qo4eY4+0AmeqZyZIdNjyNuXoEn7xZwBo/wyFlftwno52NRR3Iv33shR9fL9qc4UqukCWcUPF84uxdCy6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbh3CJP/5tojuxJRCQ/gm2ncMpV5efB/68+xO9oP0etFD8X00u
	PqhoEu88USqbAMtUo4jRPI8CP8i3PNavMffMr7t/PXCgHrQwlx0P3nk79uxCDQ==
X-Gm-Gg: ASbGncuyLthsNcu03AibfK0fT/iF9RfECtWsTCI6CC3wcnkm+Ux+1mGaPhTWogM7Wbv
	9wq6PS+y1V5esON73x9T+GbMhgJgsZmb+mjdLuDXxQun8iZSEG/1MSZiOYCMyhOtc+XPr9We44f
	sWHt4fKKREtUhtOfaJu2pvdu/lIB5k+H4xV4YiAKOjk/n9q0rpDTju6BeTfvh3JF3ZkO8l7WmL9
	bw+u/Z2YQdgpbVaDBk3s7eDrBlmcRf2poWmvh2GthBGg35y/TVGiaQ3p4Vd0RGrDXnhTpcMWLXQ
	u19UvLDjd1GdVnXKi3fnSCY34QOwvtypi/QE05I3ndfjGiMFHWl9EXfNFnAa
X-Google-Smtp-Source: AGHT+IEeYZ54rRUbGdZQIOlhhcGLgC+WoktvweDeP2f3Op4uks5fDxTwn3C0YXbJAivdUXc4ZCp44A==
X-Received: by 2002:a17:902:d4cb:b0:216:1d5a:f348 with SMTP id d9443c01a7336-2219ffc3d7amr90719385ad.11.1740419117182;
        Mon, 24 Feb 2025 09:45:17 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349634sm180515125ad.31.2025.02.24.09.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:16 -0800 (PST)
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
Subject: [PATCH v6 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Mon, 24 Feb 2025 17:45:08 +0000
Message-ID: <20250224174513.3600914-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
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
2.48.1.601.g30ceb7b040-goog

