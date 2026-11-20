Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171542;
	b=iTBsbNdXkfnfOJDriFaiEqww1sD8NG9Rnnwp619iZCk4UH7zQ5wKHs9dhYPnRg6K9j5k
	 882mqGZKf4YR+6dhi7Z3RtQpF7fmWgvY02XLM33af/HH6MOwAeown5G/kEJ21t5N/O80z
	 Wd7Fpq8r7gq/fh0GT7Hq6Mn0aXFhjjBbKdSOGsdPdoDsP9JXDUvsV/lb7ksB3t7YwYB57
	 f5Z5vABXdFKT6Ws26ysynxt4DkUHzrUu3If4S2j11k9h42monWd/U4clz/MAwuN5BgX0c
	 juxcb8dHynZJF1g4qjOYLGtSbrTMhz4pMD3+spf1nTbIhRHhy4sOXDBJR/K45U/StJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171542;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6mt0x/WvoPZ8PYKNt3cXfDXfrvC+eykybhxZfVDy/z4=;
	b=qXfXvMqw1fB9BriB7uoz23kywZqwJ5vB1VwY/In8fZi0fdMlrf4y5bAG+K8LYxLl2zgS
	 Ax8wUJvap2HtPfAeVns/YMwki1Htz8octFLMR90SLmpaTIO83YJftw9HQBSAF7p49/ZtW
	 0dP2jbq3B2oRZzbR8NtegJ9P8oABGTf2vpkmiYBjHsHlGupbZZQmcYLlIRuujvFQnCft3
	 az48rEi0JYoo31Izn6dvY4T5eNJYfBssWsBK/8Fl8fWg7H4CRMXrAJ0POFVPSntECrgGm
	 NmuLTENa3mwpRT5/7NQP0VwZ6xrru6s48feq6LBxsRYjQCAG9GEPfQSOlwVDx3mB8lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=msMZFYqp;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676F606A332;
	Fri, 20 Nov 2026 10:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E676F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=msMZFYqp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6mt0x/WvoPZ8PYKNt3cXfDXfrvC+eykybhxZfVDy/z4=; b=msMZFYqp+cM8kchkrE5rwCIkHd
	IvHmeNysPbjbeEiylYZn81RUn/Ht3Hh7xl+3suU+MSipA9y4SARB5e4tkuPwBf/1/JeZ4agcOXwIn
	lLVkHPW5CbryDzgIS35bR8Nez3cMLlmVcgwa/KZTeHnk7Ej3lmvIdCRuNkCMNu4Z23EolakSlwMmX
	BcMPg8Ni2fCOT39I0Xyqu1sIPdM1lpWCci2AUBCiW1V9Tp0tft2bq2wJKdUc1Y7djHYxERGcNbVgy
	d92Un+WIF/OCHbxyBsy+hs5Memaf0dNBmuVzlxz746JgEAU24We4S+2fTtBVEXqnngVR3KT2RBqWm
	gDb7Rb6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUM7b-00000002tO5-1Mbd;
	Fri, 20 Nov 2026 10:45:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E1613008D6; Fri, 20 Nov 2026 11:45:34 +0100 (CET)
Date: Fri, 20 Nov 2026 11:45:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
	hpa@zytor.com, gustavoars@kernel.org, ardb@kernel.org,
	hca@linux.ibm.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, riel@surriel.com,
	shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com,
	atish.patra@linux.dev, dgreid@meta.com
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack fills
Message-ID: <20261120104534.GO2668564@noisy.programming.kicks-ass.net>
References: <20261119213147.1094488-1-usama.arif@linux.dev>
 <20261119213147.1094488-3-usama.arif@linux.dev>
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
In-Reply-To: <20261119213147.1094488-3-usama.arif@linux.dev>

On Thu, Nov 19, 2026 at 01:31:08PM -0800, Usama Arif wrote:
> +#ifdef CONFIG_X86_64
> +#define __stackleak_poison __stackleak_poison
> +static __always_inline void __stackleak_poison(unsigned long erase_low,
> +					       unsigned long erase_high,
> +					       unsigned long poison)
> +{
> +	unsigned long count;
> +
> +	/* Short spans do not amortize the startup cost of REP STOSQ. */
> +	if (erase_high <= erase_low + 512) {
> +		while (erase_low < erase_high) {
> +			*(unsigned long *)erase_low = poison;
> +			erase_low += sizeof(unsigned long);
> +		}
> +		return;
> +	}
> +
> +	count = (erase_high - erase_low) / sizeof(unsigned long);
> +	asm volatile("rep stosq"
> +		     : "+D" (erase_low), "+c" (count)
> +		     : "a" (poison)
> +		     : "memory");
> +}
> +#endif

Gemini seems to suggest 16-32 words would be sufficient to amortize the
REP STOS setup. It was also adamant I try and unroll that earlier loop.

How about something like so, does that make sense? Also, I suppose we
should make memset64() __always_inline if we use it here. I'm not at all
sold on the unroll here, the asm is pretty horrid for what it does.

---
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -28,6 +28,7 @@ struct vm86;
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
 #include <asm/shstk.h>
+#include <asm/string.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -580,6 +581,33 @@ static __always_inline bool on_thread_st
 			       current_stack_pointer) < THREAD_SIZE;
 }
 
+#ifdef CONFIG_X86_64
+#define __stackleak_poison __stackleak_poison
+static __always_inline void __stackleak_poison(unsigned long erase_low,
+					       unsigned long erase_high,
+					       unsigned long poison)
+{
+	unsigned long count = (erase_high - erase_low) / sizeof(unsigned long);
+
+	/* Amortize the startup cost of REP STOSQ. */
+	if (count < 32) {
+		unsigned long *ptr = (unsigned long *)erase_low;
+
+		while (count) {
+			switch ((count-1) % 4) {
+			case 3: ptr[--count] = poison; fallthrough;
+			case 2: ptr[--count] = poison; fallthrough;
+			case 1: ptr[--count] = poison; fallthrough;
+			case 0: ptr[--count] = poison; break;
+			}
+		}
+		return;
+	}
+
+	memset64((void *)erase_low, poison, count);
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
