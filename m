Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792449078;
	b=IsjS3nYvWD8/mqTOJZrWOjPsRRcS0Mf2BSLs+7YUPqh2Hwqvd2N5GdzQjC034DRi3M7h
	 Jxw9iIvSLbiM8ZYMeZd6OicoI1SgVy9RzuB5PK5tmBMfeWs8j0kSre7Wme1Em4BPChOee
	 LVUZE0OuD3VWthK55dA42cEJEyPCYTlXObotXikbasmR/efnGmfrszNw3L2+KVMujyNjV
	 GkkB3wz2RtsF/Jc8Xjqhcawfy2OhzCA/8d7OaGsgMEgS1p890Y4k7JtOuuD3Lar6cCIvF
	 8/8GNKJMQqKR8vmRzU9uZBhd+2KMvecZ7HKGkVtRjGjwhK0ACwIwVQofHX/bi6tmTcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
	b=afbngb3k9MtFS6E7Lunb6h0aTVwxDJ1JUZKUBicw+mbsjcaxqYlUUMahF54RFBDZXcGi
	 gJuYMRR4JfCKkuP4fUArm2rleHjCEPX1UqPulatRM+kmENhfpJpL01hZ9j/kGqhx/AJkH
	 BUWCX5ja4/0Ao8Sx0pqQFNIjNY8Eeg+kgensiIY5uITI1zn2xe7iw4vKMHdSapv1U+Q0y
	 4kw+wHjLwuZEtuD72LtWojp85ZA8DsCWm98Dy+6Ci7usqY4w80FYEnPJibZ0YhYZEmw5c
	 udgxPyLVNce1+s78kcLuxxIXzIg9XhiAcepWABdWLF3sBcbTfLzWIPXy2L7EWFDY1eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YCMkdDrm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95F606A322
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 22:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A95F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YCMkdDrm
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1517bda04a0so2159685c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 15:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792449077; cv=none;
        d=google.com; s=arc-20260327;
        b=B1lqH4f7lcFNMkXBf4aHPHkvnKBOyLyMhqqlHSBBaNlECdigzE149Qobdcbtx42SP3
         eELiPDyEOZwdD1ALqW/5viMcepwp/ozGRjUqhXt6gbJCq2mvaKS5kS9bFoXwoc8lsP2w
         pDDElsswhLZjFyIQ9kUsEs/ZnVjmQ/EKI44+N4wzlU2nzPBR67OgxM3noOdPmy89CFLC
         m3Kei8oyX+l5PvVUPX0R/pR+5zHDo+o+GbjxUPc2tErpk7nd7mf+rUljV91xZmd9g0lu
         pEC4+UzQHKjtzxo0R1A1XOm2lyFFuh0BoCMkbNxm/ynmpV3g9CjHlRsGNSt1px5wn60c
         0aTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        fh=Hcrg20sZHZ17hKPtg5JjRMrVNnmZiZI3cN0ADI52v4g=;
        b=TzI7ErjNns1k/E0yBZPIXEV6u5ri6yCJOnxGojToU2/zt/cGGJT19oKDaViUc1LxBb
         VzMIQuOds5UOoLplzZU4/pEWxAy+/Kfdx24uSHH+wE8/TPsEkkg3pORYZpCV1wdp5OnT
         yNWW4Z55+cCoZe5Thz5p2IQZnnkK0lSFN5+8GI9K0Ir+1CrDGGMycq9zCo4gALYhfK5u
         G0B4UodE6RzqppTXPJgrhz/NaspjihQZ6b08l3QPLdK4UtZHgkTW6JkF2Py85Q7JRlnx
         gWAvMfOIoVepoP4Ai0HJb1nOGpo/6VU6BN10Dt8o3hcV0eDYteP4muW/ldTTULzf6E+l
         yfDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792449077; x=1793053877; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        b=YCMkdDrmYL2MKkWIqbhOVvjnl+qDEwaOSu7dqFgO6Szu0Mwu4OimKlBzNR4pu/oYh6
         tXlOFcmLQ7TSI/oLKno3AKKnYq8tu0/255Gu7wzyfpMBipGGQcbpSV3J9yoJubEbtKY7
         i7bp2sYOc03Vdf8oJ1QJnVjCvzDMXtnubSVmYEdo+twnZrdZLF23PfQ3UHSjulP23hQp
         GOm9l0hqzOq+4uFI1pqFlAz5sJjBsrggzugacq2RPDYxwfW/4Iin33JyuDwy2tpzykk9
         MFUuecfiKdei8PIKB1rKfwCQktBEtYJ+0yQYDbhFK3qViCuYXGB9S+VXCn2DfA6JFUMo
         +xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792449077; x=1793053877;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        b=N+quGkl5dVezRqIqwX0k026XSk1v5OSyE1N/mZo3kc47Uf/sazWA30U/P7todG54Ot
         94gItgyNsDOUrvH/XShpmK5jdOBvqI1LpPCUPNNu8x65G7+tpzCIw+SWBTibDeH4HHwM
         qc2XGtLdmL6UsSrj0WBPXzJwqzsxSk4Pq9b2j0iafj6DNnW1wOJA22dG2BT7UixUJeAA
         m3WX8iOGYQPUbMSkKaaSmjndFKegL9a+/XeNmFPYnk2wk5VHKKmFXoOJiJ11t5nhaLpj
         jCaT75hhkznfud6FbnaLWHP93nCX5eUBaIoKjWpUrbAdxzIYc1V8FTgqgzz4Xn0UzX+Y
         aeGA==
X-Forwarded-Encrypted: i=1; AKwUvBwB9AhKSVgN2RtLyVCFa4Jf0pZvAB/V/y0UWZoO/EamOnLrG0Xsp9kGKaXeXxrb5fKdXeRdcAM4qZJkvJ7kJ2c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmu1ASvnhe93vVSRRQ+ACxp3J1LPp2WHYlIdVygivetzJeDt36
	Ea5S4+4cvFwsBKYxnme5F8dUqJTjmbltGU83S4R3qPZ91/5Bq+hhB/y0r7HhLMJHz3C59R3Z772
	+O53VWf/b5oJhb0e8LHkqBU3DjQ737kKNBCGi4D6h
X-Gm-Gg: AYBFou2MBBUS52gpuWeMfdrq/VcIysjhqY+rqkpmixAVfpVx+9lWuXbMaPOELmh7A4K
	VNi9apd3dFElHNa67zkKB9CokCddpnoDhhgTFz55sgenFY5CRPs6ZbiEi0D3AsFfcoWXAuFqk0U
	wz0aigAl55Oo3jsYnO3cBW7BdfzsdrTQCindBkfD3K6wXo90dZlWacsLLMqTotTh9GdaP4m6kHN
	iLDTGn/Iw4+8G6SHmHrxPlOfkLj7p9Gu8oxDbPpwTWkDS4ZJ/BIPZK7PYbY6wdU7p5jy+OZ0CHw
	5MClO+yn4WKSMFzs73wzovzx2OwHMeqEmra0WTrOWX1vya8DTYbGe4rGM/8D17K+DTeBnjHIqft
	7o+jw6n10ZskQD8C246x0t47ietRHJ6qbnnoI8QHepaKtGFzUhv8WuC2AbhTK6jKDhzau
X-Received: by 2002:a05:701b:42cb:10b0:169:b1b1:1445 with SMTP id
 a92af1059eb24-18512e2515fmr12984330c88.31.1792449074316; Mon, 19 Oct 2026
 15:31:14 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Oct 2026 00:30:37 +0200
X-Gm-Features: AclHuK-9KfyXQ0m8f9CHsU2jTa1lgiXB2sNpwhyCmDMarQWZL2s0qBm4al6Ih6c
Message-ID: <CANpmjNPPncfo41Hu=TKB8cd1aFm0Lm-9+AT6pXVsYyUgFVx8TQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 03:58, Qiliang Yuan <odys.yuan@gmail.com> wrote:
>
> load_unaligned_zeropad() reads a word that may run into an unmapped
> page and recovers through an exception fixup. It does the word loads of
> sized_strscpy() and of the name compare in dentry_string_cmp(), path
> components in hash_name() and hashlen_string(), and the trailing bytes
> in x86's csum_partial().
>
> It is inline assembly on every architecture that implements it, so
> KASAN and KCSAN never see these loads, while read_word_at_a_time() at
> least checks the first byte of each word. A use-after-free or
> out-of-bounds read of a name handed to path lookup goes unreported, and
> so does strscpy() reading from a bad source, which the kasan_strings
> KUnit case expects to be reported. On x86_64 with generic KASAN:
>
>   KASAN and string KUnit suites      failures
>                                   before    after
>   CONFIG_FORTIFY_SOURCE=n              1        0
>   CONFIG_FORTIFY_SOURCE=y              1        0
>
> Check the first byte at the start of load_unaligned_zeropad() on every
> architecture, as read_word_at_a_time() does. All callers only load a
> word whose first byte belongs to the string or buffer they read, so
> the check does not flag their intended reads past the end. Add no-op
> stubs for the powerpc selftest that builds the header in user space.
>
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  arch/arm/include/asm/word-at-a-time.h                           | 7 +++++++
>  arch/arm64/include/asm/word-at-a-time.h                         | 7 +++++++
>  arch/powerpc/include/asm/word-at-a-time.h                       | 6 ++++++
>  arch/riscv/include/asm/word-at-a-time.h                         | 6 ++++++
>  arch/s390/include/asm/word-at-a-time.h                          | 6 ++++++
>  arch/x86/include/asm/word-at-a-time.h                           | 6 ++++++
>  tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h | 3 +++
>  tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h | 3 +++
>  8 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
> index 5023f98d8293d..f672aad2e30e6 100644
> --- a/arch/arm/include/asm/word-at-a-time.h
> +++ b/arch/arm/include/asm/word-at-a-time.h
> @@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  #ifdef CONFIG_DCACHE_WORD_ACCESS
>
>  /*
> @@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret, tmp;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         /* Load word from unaligned pointer addr */
>         asm(
>         "1:     ldr     %0, [%2]\n"
> diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
> index 824ca6987a516..11ecca99057aa 100644
> --- a/arch/arm64/include/asm/word-at-a-time.h
> +++ b/arch/arm64/include/asm/word-at-a-time.h
> @@ -40,6 +40,9 @@ static inline unsigned long zero_bytemask(unsigned long bits)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  /*
>   * Load an unaligned word from kernel space.
>   *
> @@ -51,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         __mte_enable_tco_async();
>
>         /* Load word from unaligned pointer addr */
> diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
> index 54653a8634149..49c6a1f65c493 100644
> --- a/arch/powerpc/include/asm/word-at-a-time.h
> +++ b/arch/powerpc/include/asm/word-at-a-time.h
> @@ -5,6 +5,8 @@
>   * Word-at-a-time interfaces for PowerPC.
>   */
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>  #include <asm/asm-compat.h>
>  #include <asm/extable.h>
> @@ -168,6 +170,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret, offset, tmp;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm(
>         "1:     " PPC_LL "%[ret], 0(%[addr])\n"
>         "2:\n"
> diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
> index 3802cda71ab7e..fb7e2904dd7fd 100644
> --- a/arch/riscv/include/asm/word-at-a-time.h
> +++ b/arch/riscv/include/asm/word-at-a-time.h
> @@ -11,6 +11,8 @@
>
>  #include <asm/asm-extable.h>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>
>  struct word_at_a_time {
> @@ -60,6 +62,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         /* Load word from unaligned pointer addr */
>         asm(
>         "1:     " REG_L " %0, %2\n"
> diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
> index eaa19dee76994..59393cf065964 100644
> --- a/arch/s390/include/asm/word-at-a-time.h
> +++ b/arch/s390/include/asm/word-at-a-time.h
> @@ -3,6 +3,8 @@
>  #define _ASM_WORD_AT_A_TIME_H
>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>  #include <asm/asm-extable.h>
>  #include <asm/bitsperlong.h>
> @@ -52,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long data;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm_inline volatile(
>                 "0:     lg      %[data],0(%[addr])\n"
>                 "1:     nopr    %%r7\n"
> diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
> index 422a47746657a..1319e1d87a9c4 100644
> --- a/arch/x86/include/asm/word-at-a-time.h
> +++ b/arch/x86/include/asm/word-at-a-time.h
> @@ -3,6 +3,8 @@
>  #define _ASM_WORD_AT_A_TIME_H
>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>
>  struct word_at_a_time {
> @@ -71,6 +73,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm volatile(
>                 "1:     mov %[mem], %[ret]\n"
>                 "2:\n"
> diff --git a/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
> new file mode 100644
> index 0000000000000..000c92de6baf2
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* There is nothing for KASAN to check in user space. */
> +#define kasan_check_read(p, size)      ((void)(p), (void)(size))
> diff --git a/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
> new file mode 100644
> index 0000000000000..39c97bc15531e
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* There is nothing for KCSAN to check in user space. */
> +#define kcsan_check_read(p, size)      ((void)(p), (void)(size))
>
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477%40gmail.com.
