Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719119;
	b=0ll+s/iwTFswB+czOOYTjgkknY4f1+8FVz3A6Uv8STkQNGjQQ8DoPsFROzJAu4xAWSBr
	 P2txN/u/z1I7pTayP2xUsFQqq7/WGQxjI3kHXY26CTNNG216VbqxrvFP1j6I3wVdHM3fe
	 JIGdphsJSGSegKlK3L0Ph7jBcuK7Dh9zHermmAmISIQPe2fBTlGy76IfP+pd6SP+4z5bB
	 PapZjgbfAb0lQQQCU+5+TaG0ENjfkjzV8FV1bxFAAj0lEY8U7yi7z2poIjwig8reKZg9C
	 REO8Fpids6isr5kegj1d+0sZ7er0aaiXOvWq4XjSS6e+xuDX/bXOSqeCrpd/3Bx5+pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
	b=I/ttIudDMSYTvNA4kScjAIyrIbOu5uyIsNPI5l2tt2D9KM4o0qDYDA9y0hQKCaNmPqT7
	 swmGyO61SfLhJ7Te+drmLcMluMV96jiQDAKQqkq4kEahauyXu7GRIb3yre4s5gw4vV3bF
	 IJAdgtP5tLBole94H+1ZxY72G6W15bac8+KnAX+rioknZinBzVsbK9ir4J2VVkZBRFzci
	 owVNsAH2yxrmjaAxjh74xyqQilVRUI2zdZs5YsW8vLwohimLsttDBNjBagb7a8Z9xKkV4
	 NgGM1o6+Ri677AxqqcvhOt0vaMIYry+b+rA46zpsRLktMFOgU7Uo+xreRQyiE6OmuqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29191606FCE0
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 15:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29191606FCE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso1544414b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719118; x=1794323918; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=NzH9v5uEH+MPtdumNErHcLU8TI7esovID+0FCTg4cq4Ny7OB6Jbv2iuLnSDCRB39Vh
         z1jm9WbnlKgC0FM/ImPLdCDbfHy1wPtGKCnh7nLr66I2ZWRMh6r61Gw1Myi8kqqxygS/
         MP+GB+led6l0lrR+WCQZnEEeUcd7JizQOJMcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719118; x=1794323918;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=k5ad1NFb7q1dMBNsJAmjMVS0ljEjKY8/wQm15mgE+UBxIbsdSlcCLKoACCIipS4oHk
         6ZFcwa9uRtdSGoWKQfb80sZ+LzlfOGLSJnjqOJ5TVZ7sJq69rJhhVoGnB7nYZK1EQJ6K
         1jxbRGjbU8sIPRuY0A1R9GFRSxMEXLFIBLcjf26D8aoQrm8uMyrOuNFFIW7Au7FQsCHw
         //ytT0OfPE31YLmlyo3aXS8G15b0xn/P4jiySQ8blfxmahRCH9LJtOaXWSE3UsxBkETo
         MmtYKyioJr2urkvz9sFedEigdt0Xc5/swu61QtyA7tpzQlkf5katzUrV7swtPtQGmKuf
         z1sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZFaN1J8QLPZvXHtg3AtPDJWzMBXQ1P/UoBk8tIyXgMz0PGQYcYaIojuEv1k9REqHg3L4DOtHoE0hX9uDEpjA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r+PLx205tGLmCebvkInhZmD17pByU/oas+CdvAY2Ru+BBisK1
	pDpub02marHpYnLXvu+Xbal3K1ADOF5olJlaDOylN8/SB4urO4kuBfhqe6NV/SkRnZQ=
X-Gm-Gg: AYBFou1iqYPp7qh0ZAE5dQzEYp+KhsWpsKnovLTOta1RHPL5mffoZa7KOVru+k5PJ3r
	0t+f1fwUqUnpz4XMk457WDCnT60+d3B1UeEH6CKtGxDqcO2CnmjitvIdN17T/ErlMA3ToDAd9KY
	pbgD1DZG9G1u2loiQ0+nQs4lJLVvStVb1BcLtnD8xC+KYDlDVLr53ypGgqKeOI/Ly1UVmfcDaF9
	OWVQlYN1orcHucwnoURPxggc6qrTMTZmSkF/0XKk2OhZ537m+ftyheW3/70dN0VYzaNN+C5qrRI
	BxLwhK3e1RSQXu8wvVETOnX26+9g3SBEXcoioLu/+oKyauikEi2Hc4NgiDS8T+lCAlVNsW47zVZ
	6hsCncWDKvK4mgHdQALgmwBYltKwktnH6EN/bW06Ajw+g9ujVbIyYlqcYqoVqbGyTY250P6InJR
	lQEc5MiqbiKfLw7GM/EVroyMoDWK6yX2lofnQ4N1Ps/nbb9+NGBd2eCrhpLOqp/FfupWs0x9WIC
	vG0dnijMzwsdMqpe+Dd4nMxGLeR/7+pV289m99hDTOGDV5FDYnSYtXD8Tc38QPfxNlDpqRahiR0
	aJCWVesPxPgQ59vrFtCAvF2M6cMVHaQREyYd5QWpo5rtTDJizBg+Yg95IOdxW20AigYhiq0DsZM
	GaxRj/XfCxNrTqlNqgR/9Rvw/ej8iw6+07vJRs7BG/3F84BQ1FUD4g73pWRxAmUDGdrbDv1Vajx
	Qqfug+Q8JiLefUgGK5Lw==
X-Received: by 2002:a05:6a20:914a:b0:3dd:a009:3182 with SMTP id adf61e73a8af0-3e928e2909amr12529216637.42.1793719118513;
        Tue, 03 Nov 2026 07:18:38 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb362ab313sm1592131a12.0.2026.11.03.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:35 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:33 +0800
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
Subject: [PATCH v2 5/8] uprobes/x86: Leave sealed trampolines in place on
 optimisation failure
Message-ID: <eafd3da2cd2c3e2c4d137a46f50351dc6290c5ea.1793718940.git.chris@chrisdown.name>
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

If swbp_optimize() fails, __arch_uprobe_optimize() unmaps the
trampoline it has just created. The next patch seals all special
mappings when CONFIG_MSEAL_SYSTEM_MAPPINGS is enabled, which includes
uprobe trampolines, and then this do_munmap() would fail with -EPERM
and warn a second time.

Nothing is really leaked if we leave the trampoline mapped in that
case, since get_uprobe_trampoline() reuses any existing trampoline
which is in reach of the probe. So let's just leave it in place when
it's sealed.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..fb895bfc09e0 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1183,7 +1183,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
 	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
-	if (WARN_ON_ONCE(ret) && new_mapping)
+	if (WARN_ON_ONCE(ret) && new_mapping && !vma_test(tramp, VMA_SEALED_BIT))
 		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
 	return ret;
 }
-- 
2.54.0

