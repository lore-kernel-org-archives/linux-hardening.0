Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F330F81A
	for <linux-hardening@vger.kernel.org>; Sun,  6 Sep 2026 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729548; cv=pass; b=TBQOPtgwU0o24Al6awdVTNRbMPc1pVJ5sIrrooymzhOmhHbdeXkaGdXOeUa2RCqBXbqeXqB/bLF1whEwIXmvlegbFgHQN3jWnrNzmJ22lMNYTL0ZdIRY4eHwkl2CcT+n7ti1inJhJ0JhVSvQESLM03aMOpRQfOMGn9IIviPbLVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729548; c=relaxed/simple;
	bh=a3fvvbX7cM9VaBSTpUdpBerX/x90UKji9J7/G1wk5MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lukBlbuqwgC9wsV7Mi+fhDf5bxDL4Otx2b1LjgGdMwhmxza4jn/DK4XjI+I93+bPtVo30shofoo6ZV1EjPOFTwMsK/hyf8ODvDAjCWseUixyuskeWuTB6cZ2H6m86a4babhkzwSblhKyiohdDuJzYzwi8OJOn0kdemD90mJStCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjM3P9ed; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjM3P9ed"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso3851324a12.0
        for <linux-hardening@vger.kernel.org>; Sun, 06 Sep 2026 14:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788729545; cv=none;
        d=google.com; s=arc-20260327;
        b=ccpdIvoEKcsp696+W0B1XCjHAIgcHo2xoZWRc1Ddr9U+8X7vkpicGlr9LiBmtYME+G
         9UXkQd8ekrzxEjZ3DybP+Vg3pMPnA3RS+kFBM4f6JVbPAjh94nrmkGZvRQXdShMtzRcL
         jEU/wxIhSvKXknMLcX9qaR7h9jxG866vj2EWCIhZJc/CirCrEXSGaH3sNcompEly1u6s
         M82lfeyhTt2wY1uQLBq08JlY515v0xx9+SQoyp0AcJ1bNYGVU1Q7EpVv8yg2NQHfq9WF
         TA+Wp1VgWGQtA98edX1nfAWUjLTd252gcCc+KGqK+FrM4/WZ0D0jHxOlHjGywmaFGd7u
         FLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MP3HD/0QtNeP9ei7WQxKxV5sg8EMw7BImzoh0b7yENc=;
        fh=1L1AOVB9fr2o08rcjDL5T5P4bsAmOIVjDL6bHVQrHO8=;
        b=apAYcg1yhouoXtV0rK7M3xniwihWeDnsSelQ/0m8lIRhVlBS/CcRle3VXqXTdGfhkt
         8yx3QeCwNZhCvQi4G9OVp77Cf9i8SLLk0gXoetLTWG+26jXOyzA+z85mKFs4q1IOGaPr
         2Vrkc6jYAaAalryB9jY25+30zeA6CCiAOuLL81JJLC1t7AxtHISE5C59yJlvZ+aafqUh
         6+wf/lCvZBmdbQ5WK1dxvDrWhnuIIMgsL7t3e/dcRi//E4cT2q3ltNvpoRVxDcIVg6um
         lfFEHHGUSClUyQ6pnU8ejnBQd/3KlKvhtrcZWYx/o83eILa7GCHfehOATLX+vyO5TaGD
         aOgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788729545; x=1789334345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MP3HD/0QtNeP9ei7WQxKxV5sg8EMw7BImzoh0b7yENc=;
        b=ZjM3P9edJY2p9+sXfi6wpheuJLJyBAQrg626ADX+APOXUKniG7Il3hS/xaZz4B5yVN
         lHXfSuaMpmhrN1REqhyK/hH4YNacB5UprYhn52WBGFBK/dZnxH2e9X2VjXu1A4t0EIR6
         MM8bjrJoX0QOuhhET3Y2o5XuUHcr2MFRI8TGzv4UYIhdMVcBYlcp1xyOTu0V9cHX2zOk
         7RV6MTmS376CFS6/pHBLCfToSIfEj9zMuJcxwpNmsSWlPGR8WOVmhPByoIedB7pOGHAX
         OVDLaRSkgPTh82wwGaqTYzTJtisTpkCu3wxk8Zylqu/X8XQkEgxXif3LwSQWCtTxcYq4
         d2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788729545; x=1789334345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MP3HD/0QtNeP9ei7WQxKxV5sg8EMw7BImzoh0b7yENc=;
        b=oCQ3mluUxVRyGQ95pYxoN3CEyYen1ZeOZO8lpLaSn3SIlhU5Zry3rVkAyw5Me+N3yF
         zZSiC6752MMQ36oz7OqmWba/KR9OE+mNoJKaFaS/qRM8qjMuBdseOzj4zw4ZQAtug0VK
         Z+LTG6IaZMpxaHsNUzpAHYs5MTW0J6Cnsxm/QN4wxVGONZ6H2C6E/wqYaY0ikiPd1aXM
         vw/F15wij53aAulL+tE040D04Nn67YrNzMKglBKr5aBgyomwekRBTlTzFJ/t4X+/MY06
         YiW35vcDhPIORW7tgJCPb81mvFfe4onGm1I7CFrREAngnJrR2PTKtL2zb8wjnntaWUZA
         EpmQ==
X-Forwarded-Encrypted: i=1; AKwUvBywn+pfJPTheMQSS4vOpoAGHay3V814367DOzuFZJUuhJCLRY4hQ+naaEx3Yeg1Rd/4aHYxhUyTqNp6hW0Bh+E=@vger.kernel.org
X-Gm-Message-State: AFuF++mixswmZkdDdByEGXqrJFfqsJ+sE9N7yPyIY24vlcEEuS2TGlaw
	DxvESlaxdyLWsz3JGRlVi+fPOH2FamdwLJlzMrKqU1LGSfLr/qFtmNtK5a4uIQaOzMJzrh9Y/Qu
	IHv3tb9Xqv248sfxnwcV0WCR5DsYE22s=
X-Gm-Gg: AYBFou0S7mthejOGd3F8guWMQeCQq+6S45K23zCZpG2K4wNnCTeqFrX4kexNUrzJL7I
	18qD1gI/EsMzzycY7cMbx148tnseyjLZuIi5eoj50kyItCaZ8PMUzEjKXfm2rOaYlrzk22gZBxv
	mLSLvHwrh2X3Syrd6I5dlBN6lkzQ1wtwSvQkgMHhIpMDS9B8Ybr9Xz+tN/MHjcH5LtpG+hMD2PY
	kUbUy1nmltIe4hFfaytQvE+pJlXwtivaejpoXL7ip7eBxfAvocBuI+rkwjyoEqr05TK108StWoC
	cz/D510IAWTRlSbFcznP4gsXClDh+tDiCLW2F6orBWLkppqPEgeZaXFAijCykMJYzK/xDo+gnLD
	P++0=
X-Received: by 2002:a05:6402:a54b:10b0:6a7:ee56:6168 with SMTP id
 4fb4d7f45d1cf-6a7ee5662cbmr3862944a12.42.1788729544623; Sun, 06 Sep 2026
 14:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 6 Sep 2026 23:18:53 +0200
X-Gm-Features: AcwNN1VVD2MOFYnkwTPmM1Hkx57HiIJE0QsNlrlbsPgcqdYaCSfoGNghg8wPnT4
Message-ID: <CA+=Fv5Qa_DdKWxFT1RO64CyoVRe7NxdUxnabhpNYRbwafMZ7LA@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] alpha: catch up on architecture Kconfig options
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Kees Cook <kees@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sat, Sep 5, 2026 at 9:29=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> This is v2 of "alpha: catch up on architecture Kconfig options"
> (https://lore.kernel.org/linux-alpha/CAEdQ38FoUPzftf9vDcJK8L38j+cDzTyxdL+=
Fj-3oAQHmmOxaOA@mail.gmail.com/T/#t),
> addressing Magnus Lindholm's review and rebased onto v7.3-rc1 plus his
> GENERIC_ENTRY v5
> (https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmai=
l.com/T/#t),
> per his request.
>
> Changes since v1:
>
>  - Dropped "fix arch_irqs_disabled_flags() to treat any raised IPL as
>    disabled".  Magnus's objection was right: per the Architecture
>    Reference Manual an intermediate IPL only masks interrupts at or
>    below that level, and do_entInt() already drives PS.IPL to IPL_MAX
>    itself before reporting hardirq state to lockdep, so the original
>    arch_irqs_disabled_flags() was correct as it stood.
>
>  - Dropped "add TRACE_IRQFLAGS_SUPPORT".  It conflicted with
>    GENERIC_ENTRY exactly where Magnus expected: the entInt, entSys, and
>    restore_all instrumentation it added is now redundant with the
>    hardirq-state transitions GENERIC_ENTRY performs on those paths
>    itself.  I want to work out separately, and with real testing,
>    whether the remaining synchronous-exception entry points need
>    anything at all here, rather than resend a patch I can't fully
>    justify.
>
>  - Fixed "add ARCH_SUPPORTS_PAGE_TABLE_CHECK support", which no longer
>    built against v7.3-rc1: commit cf8771ca4cdb ("mm/page_table_check:
>    Pass mm_struct to pxx_user_accessible_page()") changed the callback
>    signature, and Alpha's copy is now updated to match.
>
>  - Added the Signed-off-by that was missing from "select SPARSE_IRQ".
>
>  - Folded the corresponding arch-support.txt updates into "select
>    ARCH_HAS_GCOV_PROFILE_ALL", "select HAVE_DEBUG_KMEMLEAK", "add
>    ARCH_HAS_PTE_SPECIAL support", and "select ARCH_HAS_DEBUG_VM_PGTABLE",
>    and added ALPHA to the memtest=3D parameter list in
>    kernel-parameters.txt.
>
>  - Did not touch "add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP
>    support" beyond rebasing it.  Magnus found real gaps there
>    (tools/perf has no Alpha register mask, and regs->usp isn't
>    snapshotted on the interrupt path), so I've left the corresponding
>    feature matrices alone rather than claim it's done.
>
>  - Picked up Tested-by/Reviewed-by from Magnus on the patches he gave
>    them for.
>
> Not yet addressed: whether do_entInt() should own hardirq context for
> both interrupt paths and drop the irq_enter()/irq_exit() pair from
> handle_irq(), which Magnus asked about on "enter hardirq context before
> looking up the irq descriptor". No code change there yet; I'll follow up
> on that thread separately.
>
> Tested by cross-building with alpha-unknown-linux-gnu-gcc against
> defconfig and, for the page-table-check fix, against a config with
> CONFIG_PAGE_TABLE_CHECK=3Dy. Boot tested on an AlphaServer ES47.
>
> Also available at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git arch-k=
config-options-v2
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Matt Turner (22):
>       alpha: enter hardirq context before looking up the irq descriptor
>       alpha: select ARCH_HAS_UBSAN
>       alpha: select ARCH_HAS_GCOV_PROFILE_ALL
>       alpha: select HAVE_DEBUG_KMEMLEAK
>       alpha: select EDAC_SUPPORT
>       alpha: select ARCH_SUPPORTS_ATOMIC_RMW
>       alpha: select ARCH_HAS_FAST_MULTIPLIER
>       alpha: select ARCH_SUPPORTS_INT128
>       alpha: select HAVE_ARCH_COMPILER_H
>       alpha: select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>       alpha: add HAVE_ARCH_THREAD_STRUCT_WHITELIST support
>       alpha: add ARCH_HAS_PTE_SPECIAL support
>       alpha: add ARCH_SUPPORTS_PAGE_TABLE_CHECK support
>       alpha: select ARCH_HAS_DEBUG_VM_PGTABLE
>       alpha: select HAVE_GUP_FAST
>       alpha: select ARCH_USE_MEMTEST
>       alpha: select SYSCTL_EXCEPTION_TRACE
>       alpha: discard .eh_frame and the relocation sections
>       alpha: select ARCH_WANT_LD_ORPHAN_WARN
>       alpha: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>       alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP support
>       alpha: select SPARSE_IRQ
>
>  Documentation/admin-guide/kernel-parameters.txt    |  2 +-
>  .../debug/debug-vm-pgtable/arch-support.txt        |  2 +-
>  .../debug/gcov-profile-all/arch-support.txt        |  2 +-
>  .../features/debug/kmemleak/arch-support.txt       |  2 +-
>  .../features/vm/pte_special/arch-support.txt       |  2 +-
>  arch/alpha/Kconfig                                 | 21 ++++++
>  arch/alpha/include/asm/perf_regs.h                 |  7 ++
>  arch/alpha/include/asm/pgtable.h                   | 24 +++++-
>  arch/alpha/include/asm/processor.h                 |  7 ++
>  arch/alpha/include/uapi/asm/perf_regs.h            | 34 +++++++++
>  arch/alpha/kernel/Makefile                         |  1 +
>  arch/alpha/kernel/irq.c                            |  9 ++-
>  arch/alpha/kernel/irq_alpha.c                      | 13 ++++
>  arch/alpha/kernel/perf_regs.c                      | 86 ++++++++++++++++=
++++++
>  arch/alpha/kernel/vmlinux.lds.S                    | 11 +++
>  arch/alpha/mm/fault.c                              | 29 ++++++++
>  arch/alpha/mm/init.c                               |  5 ++
>  17 files changed, 248 insertions(+), 9 deletions(-)
> ---
> base-commit: f321329c1b70835e6b0807fddac6d4117e5604fc
> change-id: 20260904-arch-kconfig-options-v2-8efa959ffcbd
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>

Overall, nice work with this series!

I noticed that patches 3, 4, 12, 13, 14, and 16 contain additional
prose between your Signed-off-by and the `---` separator. git mailinfo
includes this prose in the commit message, so it separates your
sign-off from the final trailer block.

These changes are already documented in the cover letter's
changes-since-v1 section, so I think the extra paragraphs can simply
be removed. If any are intended to remain in the permanent commit
message, they should be moved above the trailer block instead.

Regards,
Magnus
