Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719090;
	b=SVVEsFJs/I7rWx7INjXZIHwFQVjeAeAWl3oxToadBYzmSScBJvdUthYtZ+fU32zPkTll
	 jEEqwPgHfZ+bvYal0jKhkY69CJxhBy9OaiAb381HKoMHv+XNZp02no7qodQmXkx5ObeqU
	 ZXd6CRLMpzEhhKsQWT+77/RSjMWl/BY4uXO235Mb/9btZVElbP1sHOtaSqzZI7julkX3n
	 yIWjfXH+RA2ZdUI0CotRrclGqacQgzy3iOVU9XVfS7Dersp1mKqs6uVI/FqRJDT7fA0jQ
	 Y8wM48jyofRjcePb+VQyZxwNqPtKLgcX/wHxSvWDWB7pcRcu4RMAkPIV+vJAdIECJJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=qMbUoE7myG/GAn/bAOasbXOTltQ3YhdGAnoaT+YPoYA=;
	b=SL1YbqRHwEodFj79FuoRSCNMEoHHHywnaV0LXk0Yb82+zb52uSUGJ1JZpRiqiIMJIVWB
	 7NEn+v1szywJ5/JuOFxRIe+8znhywsJXBqLJqx4miXJzqndTaKEq3d0bnZG+1ckGXmj0L
	 j4EKw/Fv2s9rQatR4P5jTUEB4RuQvnCZHZwdJnGJeTu8XNzDGZIyoQbz5Lqju0t0u276U
	 gfQfIkr82SIIOlT/ccN7eBtb7AYMcbT2eFAB1BZwmsWohqMhaSDkrg4PxyfbkDQzdRlSh
	 gdBqFuva+bpq0CYFmxZ4TapwHhSAH2XTAecI1SKXiD5RkmY9qBFgkteJQCWam8n13qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="p/kCuN20";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4A606B267
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 15:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C4A606B267
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=p/kCuN20
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so488663a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 07:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719090; x=1794323890; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qMbUoE7myG/GAn/bAOasbXOTltQ3YhdGAnoaT+YPoYA=;
        b=p/kCuN20gyAkrSvljj3hdsphluitU8f5J8am+KboA8ZLs9tHk1gPwvR8KdkfAMjdm7
         10OwgpsxuZ5weZnwdFdepjEmZYfJ3mDeoPWjZWPSTjQ9u2KNp5OTXv+A8t6bfArOeZRp
         fp+8CF4kYPuQhEUcrVqcHLikxSKgicQY+GkUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719090; x=1794323890;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMbUoE7myG/GAn/bAOasbXOTltQ3YhdGAnoaT+YPoYA=;
        b=11+OPeLMYvNviZUEbPJ37ymPJHC0GRJ6iBIZd7SQvsAELKQ0jftw+Bh+PcyYoID96L
         wyH8c3JqBwIbRnBPRCSJt+4Fwwfljq9sDjHs0Ze6qasVZbq5yRAZoX9EsKPhOo5btqE2
         U8duvx+eZq3cXNfyhMPJ6y3DZJD5UMCwO+lLzn9btQIDWoyNl0e/Hc6cANAdqDX4tkpP
         cn245DfgGLcI7XyB3WeD1+tKCVMHmxu2Vza68gAGRcN+4rOzhOLM825hLFYWoLBehA2V
         9j5R1ZaccJsOOqd9HluL6ndEDidX8XB+i+bKmtdHQxI2BdfGafeG0yBfIFBYn7SoxxE7
         8nAA==
X-Forwarded-Encrypted: i=1; AKwUvBxtuwBBnMe+kELAwtj1rghazxTsjxLq3KV/XWA+0h+1J+6ksGSF0DmkfEo+MqIagLnl3auzIk5Y1z0Iyx8rmog=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SpbkHwoXwV+unKN2TNrVGSyQMKd/e8tpB/dAToxvgeKdI63FB
	KQr1TaI3wp2TcKVEiKEGQlQaKTiUiXTP6UCeQfzEJ8uZgFn2WpdXZ/x5kFTZVQ3TDLA=
X-Gm-Gg: AYBFou36moozZem/9tDBdDGVjj+C/gHxIwQ4+MRe4+7ckC7wjwh0t5F+KZRNcbxwvG/
	y49e8Wv5Sk2zYMmPQskNEEBjecQC+/9gmQkXRVE3+6zs6Xwv3a9kBmvFZOuJLGAOd/5gD9T5aha
	SMzVBnYxKIAxdLffI1pRr5GG/xLDh/2Vd14lh9lOl+h1ShQVMgivbSdGHbwU7Bu+/BAHLiTzpxQ
	TooeyRHNnJ3RJhS/OWPbrl/d07e2ADB1JgxMKfER3h22eWcqz/q4dUzIQJpxvIRXs4/hyjobVyT
	Uxdy2Hw6cnEjCZVoZ4Py8Lx5z+/9U1qn1oUv0qTqMkMmQNMQF+mBTQd+nzE99GfCTxygScousWQ
	mAw/JE3UZ4elhO20N9GFTJCYdmSwxT8IoB+Tms3yCwpo41OIxSfHsAeEC4H/EjU4NXI8gEMLjkx
	szUnLr/hV/DQ2gLmbLK0qUlqFTXKcaeNMAcznruQq2EwmutEKP27oFJEPLFYYOp6nB2cqk8Z76y
	XusBpj9GoTo2xY/OErUBNT9BvgS8x1NGnzgfTGRYhwSDxpupNyHbNbzOw/PfMFYXRmQ3BbjzPOG
	BSu0IAPvg1PruU1WzfNT0YEB49nXOnrijo72MitFeJXPnqt33eBnANW46E8wOAMnVzmH4qCcrYt
	RKMi6PF//z9DOa2KKJu1Xe4iejzIiwXy0qx5ZPUhRqCtiibcb4SIlNPOGjfGdF0g7cwnF04uo
X-Received: by 2002:a17:90b:3ec7:b0:3ac:7406:b49 with SMTP id 98e67ed59e1d1-3ae896d7a1cmr6969572a91.15.1793719089722;
        Tue, 03 Nov 2026 07:18:09 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c903d0dsm4842349a91.12.2026.11.03.07.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:07 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:04 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 2/8] selftests/mm: Skip sysmap_is_sealed when system
 mappings aren't sealed
Message-ID: <6b11e9f77d8ede7ef2f16fef173970a7fa1978e5.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Now that sysmap_is_sealed runs with the other mm tests, it also runs on
kernels built without CONFIG_MSEAL_SYSTEM_MAPPINGS, where it fails.
Userspace can't tell whether the option is enabled, but a sealed [vdso]
in a new process means that it is.

So let's use [vdso] as the reference: skip if it isn't sealed, and
otherwise expect the other system mappings to be sealed too, and [stack]
not to be.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/mm/run_vmtests.sh     |  7 +++++-
 tools/testing/selftests/mm/sysmap_is_sealed.c | 22 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c          |  5 +++++
 tools/testing/selftests/mm/vm_util.h          |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 573da5006268..1134a2e82610 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -307,7 +307,12 @@ fi
 
 CATEGORY="mmap" run_test ./map_populate
 CATEGORY="mmap" run_test ./droppable
-CATEGORY="mmap" run_test ./sysmap_is_sealed
+if gzip -dcfq /proc/config.gz "/boot/config-$(uname -r)" 2>/dev/null |
+		grep -q "^CONFIG_MSEAL_SYSTEM_MAPPINGS=y"; then
+	CATEGORY="mmap" run_test ./sysmap_is_sealed
+else
+	CATEGORY="mmap" run_test ./sysmap_is_sealed -T expect_sealed
+fi
 
 CATEGORY="mlock" run_test ./mlock-random-test
 
diff --git a/tools/testing/selftests/mm/sysmap_is_sealed.c b/tools/testing/selftests/mm/sysmap_is_sealed.c
index cb0ca6ed7ebe..d5ab2b0d8ca7 100644
--- a/tools/testing/selftests/mm/sysmap_is_sealed.c
+++ b/tools/testing/selftests/mm/sysmap_is_sealed.c
@@ -10,9 +10,11 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdbool.h>
+#include <sys/auxv.h>
 
 #include "kselftest.h"
 #include "kselftest_harness.h"
+#include "vm_util.h"
 
 #define VMFLAGS "VmFlags:"
 #define MSEAL_FLAGS "sl"
@@ -46,6 +48,23 @@ bool mapping_is_sealed(char *name, FILE *maps)
 	return false;
 }
 
+static bool sysmaps_sealed(void)
+{
+	void *vdso = (void *)getauxval(AT_SYSINFO_EHDR);
+
+	return vdso && check_vmflag_sealed(vdso);
+}
+
+/*
+ * Kernels built without CONFIG_MSEAL_SYSTEM_MAPPINGS don't seal system
+ * mappings either, so check_sealed skips if they aren't sealed. This fails
+ * instead, so run_vmtests.sh only runs it when that's set.
+ */
+TEST(expect_sealed)
+{
+	EXPECT_TRUE(sysmaps_sealed());
+}
+
 FIXTURE(basic) {
 	FILE *maps;
 };
@@ -107,6 +126,9 @@ FIXTURE_VARIANT_ADD(basic, stack) {
 
 TEST_F(basic, check_sealed)
 {
+	if (!sysmaps_sealed())
+		SKIP(return, "system mappings are not sealed");
+
 	if (!has_mapping(variant->name, self->maps)) {
 		SKIP(return, "could not find the mapping, %s",
 			variant->name);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 8ef226107d78..6732f76b7e61 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -785,6 +785,11 @@ bool check_vmflag_guard(void *addr)
 	return check_vmflag(addr, "gu");
 }
 
+bool check_vmflag_sealed(void *addr)
+{
+	return check_vmflag(addr, "sl");
+}
+
 bool softdirty_supported(void)
 {
 	char *addr;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index d32cb79d9905..0e94793b0d21 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -117,6 +117,7 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 bool check_vmflag_io(void *addr);
 bool check_vmflag_pfnmap(void *addr);
 bool check_vmflag_guard(void *addr);
+bool check_vmflag_sealed(void *addr);
 int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
 int query_procmap(struct procmap_fd *procmap);
 bool find_vma_procmap(struct procmap_fd *procmap, void *address);
-- 
2.54.0

