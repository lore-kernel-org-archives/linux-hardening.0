Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719156;
	b=z3dwPNcWMsPUWcXXdNGvz629WOq6wZbp9xshDryhCxMHEqEhm1DeKA4f+wNpksoskuhr
	 bC6cBi9/JRHgM3K09BJAGy2xbrC4ijaBHDs0YrviW/worVZc7E2In2EdnuCas4egsAj9+
	 OjK49E5avUVgn+oBsuRnCnG43q2SuH2zZ6iYrEGnNSO/i7omFgZiC/bF0/W/JngJ2lkti
	 hQuCZNt4D6WVVdW7nKSfz2kLe0qwzFUgVNjXrMPAVfh4CR3EmTCY7tMtn1teDAnHmRK+U
	 ZxO3qBfEYWNvdb3oDWQfQVHPgX89TaqqQX8OdlvoWEsNjJVPB1iXmOV6Qv9wGSR4uCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=nFMfg3/nt4kJ6ByBxDP0S88zpskLBtu8XVaP0ySPO4M=;
	b=JI+Yj2tWwGRn4UnBjOrdYALyDfLV3LAufghTIobfgqAvbOqXt8BGzXPV90mvD9b7fDl/
	 q7hYeYbEKhxwAq/GB/P3DRgIjAIg0BTzfrSikWUyuqpth3SFoyd1tDDderCGtHtGLVvC0
	 Wrj90XKy8mhIsRB9Sv1V4Nos/RFZmtAZS43XHYaRdYJ2kHptTVYkvb3Hz4LZJbMGzPqIK
	 o/ymxDlhc1dB0i685uzRqFSVbKLua7VrygNSFRT9p2Gqpy/U32zEilCi0CRcPUldW/8+I
	 hXCuuAojWD/75BGBw8frp8fXk+8RHI7raimfrVu2SA9DY7ZkU8Jp18NF23YBgZNGvZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=HiZKqjod;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219560A5BE6
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 15:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3219560A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=HiZKqjod
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e812e2b31bso25718035ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719155; x=1794323955; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nFMfg3/nt4kJ6ByBxDP0S88zpskLBtu8XVaP0ySPO4M=;
        b=HiZKqjodmC+QQmLAeaRDa6IAzpCvNu0e/O+ZxnDhxZcqbtzhfsFirRaImXsTbNtcHc
         kZnISC5LjTgyAMGkaIBpkPEgBVilEidh2y0Jo0Uw2J2JKg+dkQ20GsYD/n1Qq+ZJyvAP
         S9mhCv9d2fjHoV5vo3CMXEefki+aKbj9UEvwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719155; x=1794323955;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFMfg3/nt4kJ6ByBxDP0S88zpskLBtu8XVaP0ySPO4M=;
        b=FfN6xCdzHLoLl1BUxRDa3FMxa7B8q/jQiTXi9zQT3anUZoAt3LxZGdBSIZ1BdSPp6s
         xhSOZOVUGC51iG0wWufN2fdmVxEYK5MuGM9LXxa5hku4NN3OGH1Rmfv9SqPzV3FEp6Jg
         tJmvWyO82aI6/oHfJXfiDfEXJmvcAaijSMVxCxPbuAIEk9DbLTJNv6pRkDejOEt1YpIv
         jn5iv9hxWdtSmKjZcKzl4tDoAeK5Tcp2WjBRSejdyDqejvA6jwD6DIeY0RCnzpRRo10z
         8VStjhVp7IJzNZVDVa5ShXhW651Q9vj81FXktSlAMH+MTHYtQyL8KhohW/2G3R63GIoK
         tGDg==
X-Forwarded-Encrypted: i=1; AKwUvBzL7TiNKC58vEH/a8YjwJNFJYy7rDjsfgi7hUBj5G3Y/J1JJ2DRcqqyTebFBW+RIKmDZ42ECmxWI4p6f2I7v/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Xbl7iKZAxwfACndbDQ/SkoNq2bWBG/k0Aw4Lz2gI0JtFhhjxR
	Km7GGbB1NyUYmhKem71UWZoqtUVRwr4gcCl/cdyXN4ZqvBRQVrlqlRed19j5AElhQXM=
X-Gm-Gg: AYBFou2Lu0dcLmjI5sM28Pw39b1s6dzujQWOkCr9CjBwGklbGjPiOVIfyrUoOqwRUOl
	DKfkSu7qFLgJqYNRcChs2jCCFzJi/FnNruqB7wQIfnwBpG4tOCgY1G/VzMhkm/Nuw6xmva4fRDU
	8Jq6MrbJxFnTICwUgLlgmesCKJT3Ir/CM8Mal9vU20ePIvHGzeJYsotyJy6DAepvSfXfdMY8SyY
	kkqkKfRCWQmIhsfTit6i2PTD0JdVUjZBSMzCot6pbx6mbFzwd90nB6/dRWP1Kri1E6MjIFGQytR
	a2p+Yf00VWciL6uDa/wH+Onx+pYnXQFswuBEbSnSKmbAfDMgg5LzEdbx22v6PQtmSpj+B+YXibB
	mku/Dj6pEZPNw2KRjsl9XpgoXnHiKriaf7oAUYbcZCDUQO/htJgeINnws1oKE7Ey3PDewIXn5kG
	L6XdJDtA0nSavxohoUC2nlwHsgFgrynHjuMcjF/l0a8b3XRJX5fzn3pp1F1wn4sJ5gfJQ9Olac/
	SXryVYRgYZH1PCf7Co5OVXaHvm47MakJ2unZNjj6fIAuOiQqtquYZQ9ikPCqJwQ67KLzxkoXTXU
	jTF9NJ4Ql1heeLiYot6iwzZP//5RR84Ey5kditm6T+F9+mic9DPGL21XQy6+XIyhfPBRnUxuoqg
	IymGz++V9pHwhQJUYoBtdGgzAo/7NANc6q3SfTVOTw1JqVJ9xsKPa/OTJG7yHelscLQd5rDb1
X-Received: by 2002:a17:903:1b2d:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2eb36414d03mr125058495ad.7.1793719154563;
        Tue, 03 Nov 2026 07:19:14 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392492fbsm42885535ad.32.2026.11.03.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:19:13 -0800 (PST)
Date: Tue, 3 Nov 2026 23:19:10 +0800
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
Subject: [PATCH v2 8/8] selftests/mm: Check that no_mseal_sys_mappings
 unseals system mappings
Message-ID: <053ef1ff0a6a7e5b37109d59a064a7665e087cb0.1793718940.git.chris@chrisdown.name>
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

Booting with no_mseal_sys_mappings currently makes check_sealed skip and
expect_sealed fail, so nothing checks that the parameter actually turns
sealing off.

So let's check /proc/cmdline for it, and when it's there, expect [vdso]
and the other system mappings to be unsealed rather than skipping or
failing. The vdso tests already expect munmap(), mremap() and mprotect()
to succeed when [vdso] isn't sealed, so that covers what the parameter
allows as well.

Suggested-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/mm/sysmap_is_sealed.c | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/sysmap_is_sealed.c b/tools/testing/selftests/mm/sysmap_is_sealed.c
index bfa140e01d8a..158e116ca3b4 100644
--- a/tools/testing/selftests/mm/sysmap_is_sealed.c
+++ b/tools/testing/selftests/mm/sysmap_is_sealed.c
@@ -56,6 +56,21 @@ static bool sysmaps_sealed(void)
 	return vdso && check_vmflag_sealed(vdso);
 }
 
+static bool sysmaps_disabled(void)
+{
+	char cmdline[4096];
+	bool disabled = false;
+	FILE *f;
+
+	f = fopen("/proc/cmdline", "r");
+	if (!f)
+		return false;
+	if (fgets(cmdline, sizeof(cmdline), f))
+		disabled = strstr(cmdline, "no_mseal_sys_mappings");
+	fclose(f);
+	return disabled;
+}
+
 /*
  * Kernels built without CONFIG_MSEAL_SYSTEM_MAPPINGS don't seal system
  * mappings either, so check_sealed skips if they aren't sealed. This fails
@@ -63,7 +78,7 @@ static bool sysmaps_sealed(void)
  */
 TEST(expect_sealed)
 {
-	EXPECT_TRUE(sysmaps_sealed());
+	EXPECT_EQ(!sysmaps_disabled(), sysmaps_sealed());
 }
 
 FIXTURE(basic) {
@@ -127,7 +142,9 @@ FIXTURE_VARIANT_ADD(basic, stack) {
 
 TEST_F(basic, check_sealed)
 {
-	if (!sysmaps_sealed())
+	bool disabled = sysmaps_disabled();
+
+	if (!disabled && !sysmaps_sealed())
 		SKIP(return, "system mappings are not sealed");
 
 	if (!has_mapping(variant->name, self->maps)) {
@@ -135,8 +152,8 @@ TEST_F(basic, check_sealed)
 			variant->name);
 	}
 
-	EXPECT_EQ(variant->sealed,
-		mapping_is_sealed(variant->name, self->maps));
+	EXPECT_EQ(variant->sealed && !disabled,
+		  mapping_is_sealed(variant->name, self->maps));
 };
 
 static void *find_vdso(struct procmap_fd *procmap, size_t *size)
-- 
2.54.0

