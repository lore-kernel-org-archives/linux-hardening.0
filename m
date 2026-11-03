Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719099;
	b=njJSndFy6cbo6KmTCE2dTO/XTPPjdh8C869RPPW6DwP4HZg7uX/76Bf+i3Pjx02Y3MjW
	 u7e7Ej3Y3rX8ui6JjR1IOgnqte2GahXnnGrkmzHYZNDOCFCRox5douggiykPQxA4SCdXI
	 WgJlpdUylXVjWkziMBuHiLxgwf/gti1Z6CrRpv1DTv/GtO5fikOCFMV9D5upDb8/mtssV
	 +2R8hA++fXHOxYqblSi+e2es47dPWerzZKIzZw6AmN98LeTWCr7EnZvRQpxFzTegAEcwk
	 b72H+H5+ZREKltaFc87Ois0LMr2nM4V2/PxlRKVSrcTXcemAeBj6x74AXDIsy4TMIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=sR930nY0OLfAMXoZyFzjwPE74WxrEfgyHo+tDAm4b7A=;
	b=Ahu8yZYHjAJEaE1pCrreeEqrB7+iYd6nWRTRY3NI8ZJ6mHr9EH49+dnHuT+/ovWWbe7f
	 GdDo1fa2QvkEJ1y/niAHWrooaT1cZWje90BSPMssIpUYpEssH479iNyDp9HaT17rDUuWR
	 qRUqjXQdfJxjMVq6RluEVk7FSkaS0cCfirKeEBz/mIpZuwJyGPY4PmyQKLFvYxD9sxDAA
	 oQueIutqc5wPcb/1bF2XyeV5zEcOGjJoIcqVlWLb1yYuI4MmZZBF4zZRHioFIlgzlf8Kg
	 MvC5YS9Bc+5AOQonJbDj8KDSePjP8JNg0kwUqHOpjS2jouZFF3QtzorA063SLzz3TYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="tCY4G/fN";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BA606B265
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 15:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 667BA606B265
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tCY4G/fN
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1438d9363fbso790845c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 07:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719099; x=1794323899; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sR930nY0OLfAMXoZyFzjwPE74WxrEfgyHo+tDAm4b7A=;
        b=tCY4G/fNKBPrNKIJMDAH4z60NE/6pvSHmz4YmXDN0B+/w6hLIH+uOPL6uZQwDSAFSi
         ji5fqoupBeQyhW7F/5/GHEGCbg4c/RCf1hH9/0dzPW58fBu3Nk4SPtkya9OT2xuJFrpb
         37JHo51VgUcAiAINY6PXRFxnWqavoDo63iMKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719099; x=1794323899;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sR930nY0OLfAMXoZyFzjwPE74WxrEfgyHo+tDAm4b7A=;
        b=PrYnyoJUoLAUerR89e1Kp1gi2M+ewM4bNkIILZXw8nQ67It/llwtdo0VZwjzdEV/Fi
         apOajJVTyhXQzX02MzweF1RqJtRNUTiVexl3vw9y5SXbzcyCdeb/OQyrP/C9czQoGcRt
         Y9hCa5LbBYDPKKTX2NSmuSArkaZVEf7hpX9a1hKh5EZ980l6gjK48gftiFgqoWoSatC8
         6VgcXnAuuMsNMOpYnjcQBAFskZ+h80N0x2EaglE7S+YQgpPQHCkzuci3tWwOJzTmYixl
         u1HnThMs7FnmRwutfiaVXzasCF83QYrhbHNAMYkcTX4pvu884geyoiaySX4CzmfJuRSa
         Qmuw==
X-Forwarded-Encrypted: i=1; AKwUvBwQiQopgugi//vGnWt9DuBHsDucoWjx2KVN/vkbxKnxhG8WuY+d9E5u5QWyFHTz1DvV52t/Bl12Ebg8BTIaWeM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uoTspVNyQ7VeMfi8n3jegXBV4noKRqN3o+vkthOG9gnY14Vmn
	F5QhPEx/avbIBlqSmMejnQvXw4+oKk21RSxjYiOdaYS4n6Yu64Sk2thV/NGtwunm0jQ=
X-Gm-Gg: AYBFou1aqzfkxJiwBJ1k5x0Eii6C9VJ42Z+ptNBylk1/PxZh/DkjF9+Dscu63D7HYz2
	CA2qCohAwoIfc56/tILIpa3V/l0/JO6Fm439mKKsGxgePYBonB7QHDVu59vF7B6A7Ubg/qtjogR
	on9hHGqsGvzdnrJh3O1v0/3vi1xh8c7rZRhjEKO0pVn7TixJoa5nQu+4SUeIvezUpOmAq0YF4zA
	5I8Qh/+r3IZzvKDG9XN5yEn29Z7oyrB1nxlMeQ8wwQ80GXfpeAZYtAwFrrMrAZWTc353Moxg7Hu
	IiiNUf7asoEaGCf5X5kv6mrxxtAjTd2xX4soiuX8xB+c0zrv7JwaBQc7ULKdnhlWNCw3ZMXYbjf
	EgeAAcgb/XnyxM/VoTkINimf5RgkdwLtL+uevpPDjJhtsZYjAIOuCaMR6SOARayqXHHIUn8mmOi
	mvgsOyTeYoA/2ovz7Jeb3FG9Yyl2a7iz1KnS6U+z8obBcA580SUpTsmT4LsV0BdyBfgD+3Ym2UT
	wD8wFGYQxFC234F32g6hK6wZPfUtMEFlH7rfdXlXhCbH6aJ/VqV1dPJKeXDcb2uJHc8rnJXPOWL
	VC3fTYXIdHKTnY2NX8TllQ/VzHlbI6pN0bd7lq+PHqA+P+orcIMWpY8zX2RJDUffyjS1qh9FD0p
	mefF59lc/awBUKcWt6VwivVfbw5wEXaI3+rdGm96BEDYJSYLpDuCTcMwNG/Gkj53tioXm7iRXtV
	4AOLB9KhTMWVDW98G+zQ==
X-Received: by 2002:a05:7022:b903:b0:17a:a3d4:8b17 with SMTP id a92af1059eb24-1ac5ac4f0aemr16822717c88.12.1793719098430;
        Tue, 03 Nov 2026 07:18:18 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm42657488c88.14.2026.11.03.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:17 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:15 +0800
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
Subject: [PATCH v2 3/8] selftests/mm: Test that the seal on system mappings
 is enforced
Message-ID: <cff8df45bfedfe7dbd3aca9416923c27be2a4a3e.1793718940.git.chris@chrisdown.name>
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

sysmap_is_sealed checks that system mappings are marked as sealed in
smaps, but not that the seal is actually enforced. The rest of this
series changes how system mappings get sealed, so let's make sure that
is covered first.

Add tests that munmap(), mremap() and mprotect() of [vdso] fail with
EPERM when it's sealed, and succeed when it isn't.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/mm/sysmap_is_sealed.c | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/mm/sysmap_is_sealed.c b/tools/testing/selftests/mm/sysmap_is_sealed.c
index d5ab2b0d8ca7..bfa140e01d8a 100644
--- a/tools/testing/selftests/mm/sysmap_is_sealed.c
+++ b/tools/testing/selftests/mm/sysmap_is_sealed.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <sys/auxv.h>
+#include <sys/mman.h>
 
 #include "kselftest.h"
 #include "kselftest_harness.h"
@@ -138,4 +139,104 @@ TEST_F(basic, check_sealed)
 		mapping_is_sealed(variant->name, self->maps));
 };
 
+static void *find_vdso(struct procmap_fd *procmap, size_t *size)
+{
+	void *vdso = (void *)getauxval(AT_SYSINFO_EHDR);
+
+	if (!vdso || !find_vma_procmap(procmap, vdso))
+		return NULL;
+	*size = procmap->query.vma_end - procmap->query.vma_start;
+	return (void *)(uintptr_t)procmap->query.vma_start;
+}
+
+/*
+ * When [vdso] isn't sealed, these leave libc with a vDSO which it can't use,
+ * which is fine since each test runs in its own child. Skip if AT_SYSINFO
+ * is set, since libc may also use the vDSO for syscalls.
+ */
+TEST(vdso_munmap)
+{
+	struct procmap_fd procmap;
+	bool sealed;
+	size_t size;
+	void *vdso;
+	int ret;
+
+	ASSERT_EQ(0, open_self_procmap(&procmap));
+	vdso = find_vdso(&procmap, &size);
+	if (!vdso)
+		SKIP(return, "could not find the mapping, [vdso]");
+	sealed = check_vmflag_sealed(vdso);
+	if (!sealed && getauxval(AT_SYSINFO))
+		SKIP(return, "libc makes syscalls through the vDSO");
+
+	ret = munmap(vdso, size);
+	if (sealed) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EPERM, errno);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+	EXPECT_EQ(sealed, find_vma_procmap(&procmap, vdso));
+	close_procmap(&procmap);
+}
+
+TEST(vdso_mremap)
+{
+	struct procmap_fd procmap;
+	void *vdso, *dst, *ret;
+	bool sealed;
+	size_t size;
+
+	ASSERT_EQ(0, open_self_procmap(&procmap));
+	vdso = find_vdso(&procmap, &size);
+	if (!vdso)
+		SKIP(return, "could not find the mapping, [vdso]");
+	sealed = check_vmflag_sealed(vdso);
+	if (!sealed && getauxval(AT_SYSINFO))
+		SKIP(return, "libc makes syscalls through the vDSO");
+
+	dst = mmap(NULL, size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, dst);
+
+	ret = mremap(vdso, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, dst);
+	if (sealed) {
+		EXPECT_EQ(MAP_FAILED, ret);
+		EXPECT_EQ(EPERM, errno);
+	} else {
+		EXPECT_EQ(dst, ret);
+	}
+	EXPECT_EQ(sealed, find_vma_procmap(&procmap, vdso));
+	close_procmap(&procmap);
+}
+
+TEST(vdso_mprotect)
+{
+	struct procmap_fd procmap;
+	bool sealed;
+	size_t size;
+	void *vdso;
+	int ret;
+
+	ASSERT_EQ(0, open_self_procmap(&procmap));
+	vdso = find_vdso(&procmap, &size);
+	if (!vdso)
+		SKIP(return, "could not find the mapping, [vdso]");
+	sealed = check_vmflag_sealed(vdso);
+	if (!sealed && getauxval(AT_SYSINFO))
+		SKIP(return, "libc makes syscalls through the vDSO");
+
+	ret = mprotect(vdso, size, PROT_READ | PROT_WRITE);
+	if (sealed) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EPERM, errno);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+	ASSERT_TRUE(find_vma_procmap(&procmap, vdso));
+	EXPECT_EQ(sealed,
+		  !(procmap.query.vma_flags & PROCMAP_QUERY_VMA_WRITABLE));
+	close_procmap(&procmap);
+}
+
 TEST_HARNESS_MAIN
-- 
2.54.0

