Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1D28980F
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798829; cv=pass; b=mYjOgqtgqAkj5x8W28ykNzcVkD+hKTHELu4kiJiAh8kAuGDTNWzCuyNTb7u+1o2+Oew9Mc4aZDjqYaGXNfUgjxkbFNc/UPjJnOdG/ceOcaJfT8HMEcOyvMUbMItIwKqSUGAnbVWA3ynXdOndris4XJjkfge3GGverBLKhU02tlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798829; c=relaxed/simple;
	bh=X4Wq2yf0iLQmaCYexwPzuD8C38X8+peC49jk0V+3V8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoYIRxnlDmrqTGIG3uWGVXcr+P2/u4QP9UxLDUHnpRZ1WbeTLUvbMc/QhhD7dobxZg1uB733f9zW32J1BirqHOnesCJA+drs0LTxIUm18pMtINwE7kGjSZuKrnhqSmyysc9R6J21QX1G203AZcv+9Lzx0pDIOMgNVBfiH1YIEcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJb8Yplz; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJb8Yplz"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1279eced0b9so6680165c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 12:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776798828; cv=none;
        d=google.com; s=arc-20240605;
        b=iXlBOSidXiYLdYCQuT/gaAX6smYWblXd7QQ/xpVNBCQW3xjeAVxAt9zvI2rL2WO+ks
         TvW14fxxrSPitve5j+cwOwdevGUcZjcEfU29i9fFzyMfUkJjJAtljTaEmMRNI+tOMDpE
         BlTdB0EBN91mG/NldQrBeA6PTGlC4t0ZQY6485U3LWbHT5Pp5jPy6qUnKUoSC/iD/cc1
         MPfZRtqLDsBsUlj2Vp7QJ2TpWjfgPmCgicykwYpjrCPi1Apw2hIDTaBAOfKBrPaXsALz
         2YQZqTHBWzRdlwNRtoG3tpTmN43SKdTZmbhwZ7vojf/u8RR1LW0GibDItCL0GLhTxinL
         IazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J+nBi8NMCSPfGIscPWxKFWQOBdlvlCfORQNm2QzRooQ=;
        fh=T7hFocESjL/15hxZnqsE/WZauuXcWoxkDm/kBA0RH9M=;
        b=gHDi2Aw+mIAbJoLdgez6swe8dHCsYtovsj7quQOtLJ1i5k33Buy/cjzBkw4teytQ6C
         cBcuIZjigo8LedV/Px9JUmpyj1o++Ry+XjtQ5RXuYVETvFUbF09OnI9ULCa0zvy8VWp/
         QguzU0O3ka24RwnWP2ixaG5CTztywyMbpPaU9ae/hAkLZ4VynQI36//zSnImCKkk9WFl
         W4R1/BhcvUOrmbS9QaGwFTQEKtaUiro8Kt036T8SVtsDqM8g9KnOJzywj6gws3hOl955
         pb7XDah9vAntebpN8ouRyaB6DCU7yvksW4nqUC7xU8ercHMd78fBU6KtbRWDalxmVBST
         acHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776798828; x=1777403628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+nBi8NMCSPfGIscPWxKFWQOBdlvlCfORQNm2QzRooQ=;
        b=gJb8Yplz3OHDlZrxo8835UYgB7N/2/Sumn/MImSDNYEubTQrst5w8OUomPU4ZLfXyP
         NZrXeEyKz6f+/62Olb0PBZ7rDxPVFLSSu9coBUZxMgnSkwmCQE79vmCcLBKON2h1G2gJ
         xsO8GK9cHSR/9nBxjBpsvarVIzlFxXpNfvk/XvSXiuGYBTXw1Nl9/k9KtWEXf3EsEx2P
         nQin5HyalvdcYpIFGClypw1dx5vKzSOJ/3NrPmtaoamM7rI1oMPB7iDGPGRR/lK+rZE/
         KoXKyZNRVc6qGo8WCxRjDqnVPVlt9ZmjkQ54+lMpxNmxwgED0wmpXrQ8RTjA/4UaXt3/
         8qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798828; x=1777403628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+nBi8NMCSPfGIscPWxKFWQOBdlvlCfORQNm2QzRooQ=;
        b=bvUsc8Hyd/PK5EcZPGttvsbK6odo/V2mLjDG2cF6x8aLJeE7uMggEpq1IJYFMXPiLK
         /CAxJr4Yck76xvYIrHCQ4XZIxY007yyblPw9ArQPet7sVedRKsi6T/e+IIuFRp8xysAG
         PPUspbiFy5S8J8Wm8AoS4I9t5LsPnpEEcQoMoGAiAdm5eoDHNzoRBBhDJTwzRIhoDwg2
         Pq8hZMbTsApFKoPyEu3aMc1GY+3GpHJ4eSfy8gAIG+8VKlm2TG72ntWT5j+XHvLgjw0y
         JuWS9OS9ZhzE4vVRxDrhDzhG/iDMqi+Tht7aAeoTHcQ3z6LO4gnyY3XQ67SUstfNFWvN
         wc9w==
X-Forwarded-Encrypted: i=1; AFNElJ/4W5r5+c5uj+sgwrnLtKppmV4a7aw7SwOkzSM4ha4h2YocKvAoEaW5w/Z72iU495bvzRDo8NKE1g8KBjiBvuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo09Z94NmONdnKTrh/u6jgL54o0L+qlPxUF6Iwgeu1dG4DEcYc
	VEWYB9+7U/gVfwYUoSw538+l9JLZKUJm999ZatZ5gmWsrV33WP1s1LKqQohcRQr6vStHrNUIBYB
	9tLWPd8FbzBeSDT6ArRA6dNJEQ9Slh5i7ogGXvLEd
X-Gm-Gg: AeBDievUTmnSvJTKIXl8JwXBGmAZK5BZ00DZgDhmY5kH3k7D7BfSSrTeOtpJ8tgNjN4
	VYNjHCP7gJLWhvklaCPjOVbz3gOqeHXGaNA9KF7s1RE2yNapz5dSepPV1rXan314eAxl42KLksS
	65EJqdvhQsWt6UIvdJwKUJxqninsMJ3tAkyluHDmk1kHmjrVMTTllG94bHF1OrC3HtzlRLmQIZk
	6iyBeaNyBEKi1uEoQ/PwdQBw6klgZQFxfxn4sQai9/nYuNI51cZ//hupULacF6527Fk2tVCv4QB
	IKq+sdxUfIv9gX2By25g4d8QMv4YVlDVJ9SIVWH00GFawraqmTndz6Tb5a0sfv/h1ZHoGZM=
X-Received: by 2002:a05:7022:4199:b0:12c:2cf8:2f30 with SMTP id
 a92af1059eb24-12c73f83616mr10488523c88.15.1776798827054; Tue, 21 Apr 2026
 12:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415143735.2974230-1-elver@google.com> <202604210954.84C57E5E0@keescook>
In-Reply-To: <202604210954.84C57E5E0@keescook>
From: Marco Elver <elver@google.com>
Date: Tue, 21 Apr 2026 21:13:10 +0200
X-Gm-Features: AQROBzBMsDbE7_dyhVt5xWTROldThQNRDRm_VJxxVveH1z3BL1b5nLG0UUHDDRE
Message-ID: <CANpmjNO8CcR56LXAQf4GQhGcbU4MQkRCa7gVvwuAfvVrzEUhQg@mail.gmail.com>
Subject: Re: [PATCH v2] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, 
	Hao Li <hao.li@linux.dev>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>, 
	Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>, 
	Matteo Rizzo <matteorizzo@google.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 19:22, 'Kees Cook' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Wed, Apr 15, 2026 at 04:37:05PM +0200, Marco Elver wrote:
> > The builtin __builtin_infer_alloc_token(<malloc-args>, ...) instructs
> > the compiler to infer an allocation type from arguments commonly passed
> > to memory-allocating functions and returns a type-derived token ID. The
> > implementation passes kmalloc-args to the builtin: the compiler performs
> > best-effort type inference, and then recognizes common patterns such as
> > `kmalloc(sizeof(T), ...)`, `kmalloc(sizeof(T) * n, ...)`, but also
> > `(T *)kmalloc(...)`. Where the compiler fails to infer a type the
> > fallback token (default: 0) is chosen.
> >
> > Note: kmalloc_obj(..) APIs fix the pattern how size and result type are
> > expressed, and therefore ensures there's not much drift in which
> > patterns the compiler needs to recognize. Specifically, kmalloc_obj()
> > and friends expand to `(TYPE *)KMALLOC(__obj_size, GFP)`, which the
> > compiler recognizes via the cast to TYPE*.
>
> Great! I'm glad this gets deterministically handled for the kmalloc_obj*
> cases.
>
> > Additionally, when I compile my kernel with -Rpass=alloc-token, which
> > provides diagnostics where (after dead-code elimination) type inference
> > failed, I see 186 allocation sites where the compiler failed to identify
> > a type (down from 966 when I sent the RFC [4]). Some initial review
> > confirms these are mostly variable sized buffers, but also include
> > structs with trailing flexible length arrays.
>
> For the call-site-partitioning series[1] I sent before, I had
> per-site caches for fixed-sized allocations and size bucket caches for
> variably-sized allocations. I'd like to see something similar for this
> series. Specifically, I replaced "kmalloc_slab" with "choose_slab" that
> did O(1) to find the dedicated cache/bucket for the allocation[2].
>
> In this case, we now have a build-time-constant value that it should be
> possible to use to look up a _single_ dedicated cache/bucket for the
> given unique type: there is no need to do hashing.

That should be a separate series; I know what you're getting at, but
it's a significant rework and a different design with different
properties. This simpler patch is likely ready for the next merge
window (once I send v3), and in light of recent developments, I'd like
this to land sooner than later.

> > [...]
> > -config RANDOM_KMALLOC_CACHES
> > -     default n
> > +config PARTITION_KMALLOC_CACHES
> >       depends on !SLUB_TINY
> > -     bool "Randomize slab caches for normal kmalloc"
> > +     bool "Partitioned slab caches for normal kmalloc"
> >       help
> > -       A hardening feature that creates multiple copies of slab caches for
> > -       normal kmalloc allocation and makes kmalloc randomly pick one based
> > -       on code address, which makes the attackers more difficult to spray
> > -       vulnerable memory objects on the heap for the purpose of exploiting
> > -       memory vulnerabilities.
> > +       A hardening feature that creates multiple isolated copies of slab
> > +       caches for normal kmalloc allocations. This makes it more difficult
> > +       to exploit memory-safety vulnerabilities by attacking vulnerable
> > +       co-located memory objects. Several modes are provided.
> >
> >         Currently the number of copies is set to 16, a reasonably large value
>
> The "16" buckets seems to hold for TYPED_KMALLOC_CACHES too? My goal
> with the earlier type-partitioning was to get _total_ isolation, not
> simply bucketed: 1 cache (or sizes-bucket) for each type. The "16"
> limitation from RANDOM_KMALLOC_CACHES was kind of arbitrary due to the
> hashing.

The token ID is also a hash, although it can be configured to be
unbounded to effectively give unique hash per type. As-is, limiting to
16 keeps it comparable to the RANDOM mode, albeit IMHO with better
isolation properties with the same overheads. As-is, performance
properties of RANDOM and TYPED are comparable, and the friction to
switch between them is minimal.

Unlike a completely new design, which will have comletely different
performance and memory usage properties - and wouldn't be comparable.

> >         that effectively diverges the memory objects allocated for different
> >         subsystems or modules into different caches, at the expense of a
> > -       limited degree of memory and CPU overhead that relates to hardware and
> > -       system workload.
> > +       limited degree of memory and CPU overhead that relates to hardware
> > +       and system workload.
> > +
> > +choice
> > +     prompt "Partitioned slab cache mode"
> > +     depends on PARTITION_KMALLOC_CACHES
> > +     default RANDOM_KMALLOC_CACHES
>
> I think this should be adjusted a bit:
>
> config CC_HAS_ALLOC_TOKEN
>         def_bool $(cc-option,-falloc-token-max=123)
>
> ...
> choice
>         prompt "Partitioned slab cache mode"
>         depends on PARTITION_KMALLOC_CACHES
>         default TYPED_KMALLOC_CACHES if CC_HAS_ALLOC_TOKEN
>         default RANDOM_KMALLOC_CACHES

Sure.

> And actually, perhaps a global rename of the options so the selection
> naming is at the end of the CONFIG phrase, and bundle the on/off into
> the choice:
>
>
> choice
>         prompt "Partitioned slab cache mode"
>         depends on PARTITION_KMALLOC_CACHES
>         default KMALLOC_PARTITION_TYPED if !SLUB_TINY && CC_HAS_ALLOC_TOKEN
>         default KMALLOC_PARTITION_RANDOM if !SLUB_TINY
>         default KMALLOC_PARTITION_NONE
>
> config KMALLOC_PARTITION_NONE
> ...
> config KMALLOC_PARTITION_RANDOM
>         depends on !SLUB_TINY
> ...
> config KMALLOC_PARTITION_TYPED
>         depends on !SLUB_TINY && CC_HAS_ALLOC_TOKEN

There was a comment somewhere else that even introducing
PARTITION_KMALLOC_CACHES might confuse users of RANDOM_KMALLOC_CACHES.
I think completely getting rid of and renaming RANDOM_KMALLOC_CACHES
has marginal benefit, and will cause friction for existing users (even
moreso than already). I see little benefit here, and would prefer not
to break user configs more than needed: configs that already set
RANDOM_KMALLOC_CACHES, upon rebuild will be prompted to enable
PARTITION_KMALLOC_CACHES; if user says Y, then their previous
selection (RANDOM) would already be picked and they don't have to
rediscover that it exists under a new name.

I can make this change, but only if you're sure the benefit outweighs
the downsides here.

Thanks,
-- Marco
