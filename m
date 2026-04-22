Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880F30DD30
	for <linux-hardening@vger.kernel.org>; Wed, 22 Apr 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871603; cv=none; b=XlA1Dz1iX8yAfsRnlAxjr4b08HkQC33eQzJwJZCBmDYaOrouq/SZ/CzOSLAW+hiPG2NdRDTyzN2Lq+sMm7VKajoTzrte0yg/yMJukVChdYYhIndzdfOIpal6UybDadnaxdM3DCf0n4kp6k28J+ClxSvBxgqz0TXOpDeyr7n/7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871603; c=relaxed/simple;
	bh=rdCUpxrjSHkQ3T98egy1ZBC2mo3Rw+rJgkqg+TeHKq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd0+fwAA7ZFgfWXdclBKrbyKNefsFsoupjK0d/O4ytWqRQxWAUsQWOP83XySBjVmoJDrM8K5tVRmNV4INsoWvPWfwR3CRwUBHccL4UF1aunUSHeQv+coNbDAsGBe7DVv4XBpWLMdIAf0lnFjoaj2JjGLT6c9NVmbiX9WRsZTpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kebRykF/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kebRykF/"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a1307438ddso5155347e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 22 Apr 2026 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776871600; x=1777476400; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mguVNYCKn1UqNE6wCiBdJA3G/L2uqCAslGSj7SsF/bg=;
        b=kebRykF/iKN0MOF0TikW5UpSBJzoL0z4MwT8LOiuCL5ocTdPMBaRMSz6hxQ76ZVVev
         iom2xB46niCqzvdGg5KpN4QsUB0pOpjQ1nxH0HAUqq1hVNXBOd5MuSh8UEEwhS755vHm
         roxos3HRQzmUi5jJxCDkhR0MTNEbNnPddA45VssaI5zlb+jnR2gAzsjz83T7X2vDUg5l
         Rd0mALwyPOenYoRbuUhoesKGCrolOYMmEvgYwN/xP7sRIh2CcDiH6ol2Uk2zZsiGeHD3
         p+F5j+O8Ew2wNYJGTuvrzob8ad7U4bGSr6TU40DYBntY1tD9aBUu0vQf3Il94prydNgp
         Tqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871600; x=1777476400;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mguVNYCKn1UqNE6wCiBdJA3G/L2uqCAslGSj7SsF/bg=;
        b=Xgh776OtblysmXskStUqPNNIaGmBqHM36VtBP9fq2uYeLAmPNebBYsjfC5DovSfGJq
         3Nj9j2QBljJZv2H2xCtNOZL6p1arjIP6p3cybVl25iOT/s5bWCMRQ+9/raYjybrPj/hL
         vqP9xMnuDSNPM9PGQTEXQO54lh12SVqR23KzN1fK11bub4I2hRAKNDAh+Azo799Oo+CO
         Y29bgGWj/GF7bQ4yefJINOwwnuGF9SGzw2QvE81q40u6+2YymfTZxYQ0GDOxkyXS8/09
         TZJxuygq+fajrpEm+HSce5d4WGAnH3AScfUjBQtxe2F0lJFMWJp+J24XUc8zmX0v5+RV
         pIqw==
X-Forwarded-Encrypted: i=1; AFNElJ+j6mAzbsl7zrgfFHmfSiWJ4Uys67IO3ZcARhW9wZSFLSGjen+h9nc/Z2KlS/jmAv1hZpdQvPT7HZ0bJjMPkg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1R1EamPoLwus8KmNpRkpCMn3Ab6G/PYDyhnBvoEO6FvJHuVh
	h/8pPq0W4wE+3GiTPx+YoB0I7wr3MgbSG+aAy28FRS6sI76KPKlf4ZXiArNmt3DKPw==
X-Gm-Gg: AeBDiet0CAhJ5g5nCmtKAYo9+IkucOLVgiNwc8NijtjPkOc7Ea2RymicsSroK3DHEfx
	BPeTgTX09xRkNwDiNUill6TdLrGdw3gBG39YSfuNtduVWsuaP8EhlqtZgREL0DCdHOxgxgYgFGy
	r+FQvKYrlXSRCFZrjfjunUwm6ijQpjoj/i7XeLbntEPaOYuOUyrWziuDTUf7QBesJRiHVRBKEr9
	WZuFSCdsarS0hZem8Jgi85f4NyG5AEQanTLFUR0Vwx0zLGCMdjI4RseU6hHtiwlufUOLnjZ49Im
	WhBKALubPap1nd7MvSULkA0QBqEPRFYikIDONZI3RcL9P7rPKlrvvfsdRKrb1d/3gtOsWuDV7bH
	AkAmt2hnbp42nCcm9H4Wzulf9gqy+vWZM+V/FndWxY/9jllHE2mmrejIEHs7/nBlZT8gPmt87M+
	UnQQkSGXTnWb9dDvZmpf5izRFXo1rG5Uaq/zcvvxp9LhepCHBysOXJ29ost8Q8jesk9jDcZ+hXi
	sHHbZOqAVaPpj319RBb
X-Received: by 2002:a05:6512:3d20:b0:5a3:ff44:f019 with SMTP id 2adb3069b0e04-5a4172ca21dmr9302999e87.11.1776871599679;
        Wed, 22 Apr 2026 08:26:39 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:ec7d:19d1:709a:2171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad30asm4558169e87.16.2026.04.22.08.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:26:38 -0700 (PDT)
Date: Wed, 22 Apr 2026 17:26:30 +0200
From: Marco Elver <elver@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com,
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>,
	Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Matteo Rizzo <matteorizzo@google.com>,
	GONG Ruiqi <gongruiqi1@huawei.com>
Subject: Re: [PATCH v2] slab: support for compiler-assisted type-based slab
 cache partitioning
Message-ID: <aejopk23CsntyFOB@elver.google.com>
References: <20260415143735.2974230-1-elver@google.com>
 <202604210954.84C57E5E0@keescook>
 <CANpmjNO8CcR56LXAQf4GQhGcbU4MQkRCa7gVvwuAfvVrzEUhQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO8CcR56LXAQf4GQhGcbU4MQkRCa7gVvwuAfvVrzEUhQg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Apr 21, 2026 at 09:13PM +0200, Marco Elver wrote:
[...]
> > And actually, perhaps a global rename of the options so the selection
> > naming is at the end of the CONFIG phrase, and bundle the on/off into
> > the choice:
> >
> >
> > choice
> >         prompt "Partitioned slab cache mode"
> >         depends on PARTITION_KMALLOC_CACHES
> >         default KMALLOC_PARTITION_TYPED if !SLUB_TINY && CC_HAS_ALLOC_TOKEN
> >         default KMALLOC_PARTITION_RANDOM if !SLUB_TINY
> >         default KMALLOC_PARTITION_NONE
> >
> > config KMALLOC_PARTITION_NONE
> > ...
> > config KMALLOC_PARTITION_RANDOM
> >         depends on !SLUB_TINY
> > ...
> > config KMALLOC_PARTITION_TYPED
> >         depends on !SLUB_TINY && CC_HAS_ALLOC_TOKEN
> 
> There was a comment somewhere else that even introducing
> PARTITION_KMALLOC_CACHES might confuse users of RANDOM_KMALLOC_CACHES.
> I think completely getting rid of and renaming RANDOM_KMALLOC_CACHES
> has marginal benefit, and will cause friction for existing users (even
> moreso than already). I see little benefit here, and would prefer not
> to break user configs more than needed: configs that already set
> RANDOM_KMALLOC_CACHES, upon rebuild will be prompted to enable
> PARTITION_KMALLOC_CACHES; if user says Y, then their previous
> selection (RANDOM) would already be picked and they don't have to
> rediscover that it exists under a new name.
> 
> I can make this change, but only if you're sure the benefit outweighs
> the downsides here.

Upon further reflection, since the transition isn't smooth anyway, I'm
probably going to rename, but have them all use the PARTITION_KMALLOC_*
prefix so it's easy to just search for "CONFIG_PARTITION_KMALLOC_". I
don't see the need for a "NONE" variant - I've seen this pattern
elsewhere, and then you end up with users reading the .config and
concluding "CONFIG_PARTITION_KMALLOC_CACHES is enabled ... but oh never
mind actually it isn't" which I find confusing. This could be useful if
we had a dynamic on/off toggle and the default is NONE, but that's not
the case here.

diff --git a/Makefile b/Makefile
index f70170ed1522..d1f63ffb85f0 100644
--- a/Makefile
+++ b/Makefile
@@ -989,7 +989,7 @@ KBUILD_CFLAGS	+= $(CC_AUTO_VAR_INIT_ZERO_ENABLER)
 endif
 endif
 
-ifdef CONFIG_TYPED_KMALLOC_CACHES
+ifdef CONFIG_PARTITION_KMALLOC_TYPED
 # PARTITION_KMALLOC_CACHES_NR + 1
 KBUILD_CFLAGS	+= -falloc-token-max=16
 endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0537c3596163..b46300037ca5 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -501,10 +501,10 @@ int kmem_cache_shrink(struct kmem_cache *s);
 
 #ifdef CONFIG_PARTITION_KMALLOC_CACHES
 typedef struct { unsigned long v; } kmalloc_token_t;
-#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#ifdef CONFIG_PARTITION_KMALLOC_RANDOM
 extern unsigned long random_kmalloc_seed;
 #define __kmalloc_token(...) ((kmalloc_token_t){ .v = _RET_IP_ })
-#elif defined(CONFIG_TYPED_KMALLOC_CACHES)
+#elif defined(CONFIG_PARTITION_KMALLOC_TYPED)
 #define __kmalloc_token(...) ((kmalloc_token_t){ .v = __builtin_infer_alloc_token(__VA_ARGS__) })
 #endif
 #define DECL_TOKEN_PARAM(_token)	, kmalloc_token_t (_token)
@@ -732,11 +732,11 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, kmalloc
 	 * with a single branch for all the relevant flags.
 	 */
 	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
-#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#ifdef CONFIG_PARTITION_KMALLOC_RANDOM
 		/* PARTITION_KMALLOC_CACHES_NR (=15) copies + the KMALLOC_NORMAL */
 		return KMALLOC_PARTITION_START + hash_64(token.v ^ random_kmalloc_seed,
 							 ilog2(PARTITION_KMALLOC_CACHES_NR + 1));
-#elif defined(CONFIG_TYPED_KMALLOC_CACHES)
+#elif defined(CONFIG_PARTITION_KMALLOC_TYPED)
 		return KMALLOC_PARTITION_START + token.v;
 #else
 		return KMALLOC_NORMAL;
diff --git a/mm/Kconfig b/mm/Kconfig
index 6d44bd2633bb..d8510913fbeb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -265,12 +265,12 @@ config PARTITION_KMALLOC_CACHES
 choice
 	prompt "Partitioned slab cache mode"
 	depends on PARTITION_KMALLOC_CACHES
-	default TYPED_KMALLOC_CACHES if CC_HAS_ALLOC_TOKEN
-	default RANDOM_KMALLOC_CACHES
+	default PARTITION_KMALLOC_TYPED if CC_HAS_ALLOC_TOKEN
+	default PARTITION_KMALLOC_RANDOM
 	help
 	  Selects the slab cache partitioning mode.
 
-config RANDOM_KMALLOC_CACHES
+config PARTITION_KMALLOC_RANDOM
 	bool "Randomize slab caches for normal kmalloc"
 	help
 	  Randomly pick a slab cache based on code address and a per-boot
@@ -282,17 +282,17 @@ config RANDOM_KMALLOC_CACHES
 	  the randomization by retrying attacks across multiple machines until
 	  the target objects are co-located.
 
-config TYPED_KMALLOC_CACHES
+config PARTITION_KMALLOC_TYPED
 	bool "Type based slab cache selection for normal kmalloc"
 	depends on CC_HAS_ALLOC_TOKEN
 	help
 	  Rely on Clang's allocation tokens to choose a slab cache, where token
 	  IDs are derived from the allocated type.
 
-	  Unlike RANDOM_KMALLOC_CACHES, cache assignment is deterministic based
+	  Unlike PARTITION_KMALLOC_RANDOM, cache assignment is deterministic based
 	  on type, which guarantees that objects of certain types are not
 	  placed in the same cache. This effectively mitigates certain classes
-	  of exploits that probabilistic defenses like RANDOM_KMALLOC_CACHES
+	  of exploits that probabilistic defenses like PARTITION_KMALLOC_RANDOM
 	  only make harder but not impossible. However, this also means the
 	  cache assignment is predictable.
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 21ab7dd79b5e..ca5e2a6d4e46 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -742,7 +742,7 @@ kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES] __ro_after_init =
 { /* initialization for https://llvm.org/pr42570 */ };
 EXPORT_SYMBOL(kmalloc_caches);
 
-#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#ifdef CONFIG_PARTITION_KMALLOC_RANDOM
 unsigned long random_kmalloc_seed __ro_after_init;
 EXPORT_SYMBOL(random_kmalloc_seed);
 #endif
@@ -1010,7 +1010,7 @@ void __init create_kmalloc_caches(void)
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++)
 			new_kmalloc_cache(i, type);
 	}
-#ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#ifdef CONFIG_PARTITION_KMALLOC_RANDOM
 	random_kmalloc_seed = get_random_u64();
 #endif
 
