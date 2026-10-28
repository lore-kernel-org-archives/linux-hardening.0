Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793211145;
	b=LzbWkLESZP1zKa1Fjo6YQYaQJQTLrY+GwzK+J8mmMw0N4O+F8ImFAjigZQnxMUaqFgDg
	 PhvGi8bWi3wgwaudmn/uhQmPL5vYBGTGJmbijHYJMNfbnrK4nD22g2QrHOuvrxyZQAG74
	 Ir22dETSK7tUMHFwp9sLDfg9bV4Vb/5S5syOdaBNa9lO2NfhCoyegCAajf1dzMHBmDFtn
	 pOahLnmcmaHwodh1SJUieoJdRqSKlW8tM/djz7pfYn/FPjZ/cvIRCreUcC8PcHCI4Y4AX
	 ANcmUe2YRxaI/3XZDSQE8Xj8ip3K3YhM7Yu9h6ulR/AFhI0UE8Yd5oBZ/PfqxRXpIBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
	b=WNcbvbu0WMNDNJ4eEhx+NKCvOB244QWMZZ77785qRUE2TxcAobbRyLiTIwWQw9EedkEf
	 +zVZyJk/EKHasTtZwyXGL9SLDwGZJg7X5+o0jZbwkOgZ94YGhxazzbQTQtd3amsvheE+A
	 wb41g9aRwEmfOZzGVKuPoMUbszTGx+YWTegsAbfDFqfrVdalP8VoFPMB+/ei7znqEX0B6
	 aDVbGBGakhF91tG4h3i4UZDuLxBcFyrl+Q24ilYW1bfr6IILJt6ruVWvia8J9DsLBM/n8
	 a0m6PrQ+QKoN8fwvpAmtr9yie+QMeaqmOQiEzXPZ5rjcWoTeUJ3Ud4vUYB5LYxvmwJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALSf6WKa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D3606A97A
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 18:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 352D3606A97A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALSf6WKa
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6790c2eb033so219562d50.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 11:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793211144; cv=none;
        d=google.com; s=arc-20260327;
        b=aXaE72J6e3+tKwIe18iSEYHMBI8WHyQfbPN76DhvgVx60ezPelylyUrYR3TgJbeUS8
         IZOFnCsPF+dPccenErNikphbVzf5KaxUL54EW7WPU+5MpCDaNSpWKTn4OMukMAuID/bI
         qJnUWckW+r8k/FC8PHpOwAP1cR4krxZfGmf08Ybg0XQAgIX42u+/WWARWeMNVv2ra8pk
         o8mIw4KMByZ/rRi74HT3OeLz1gttCqlcgN9bGXX3pEg7ziiKCpQ7OkddBdSgqrduPsPm
         JgZY64p2P1AnkGtfTYBfTy4M78Ps/SxPGPG+bCUBZFRnD9huh31kWZw8qvhJ7gEAY6c/
         THnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        fh=tZqvU4qe5subJ6NoobY+p7jFakWfscJJdxKpCSJHie8=;
        b=bMIB+Uyf9i13XE9pO/v4sAd67efTzpFt5K9J55JhSBq3lh7Dz+foBtVEt4EQ2qskDx
         zTNP/1E/Y/LlZv9smwcioXi63jrTuB9jOgyhcso3Mpo+6vAqnh+4cEP/vQW8vLqP7hD0
         8XKIuB9HaWHhpSpUDSYNQT4TpjGl+jKgZAU4pfrkl/grM5PAcZH86rTUl/aW/h2qWqE1
         1wvOPUHVMI4udCtF/yxJCWNUkx7UEAlqSdEenu3JDErTvqpz5qABa4M+wxbugjWlH4GR
         EzbWxsPNvzzsPCFiz81h++/LJusWKCj0ps+76zBWG8a0iYeicfmc/F1j31IJmj6xHbgg
         YAqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211144; x=1793815944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        b=ALSf6WKanFx5JvmwlsLgV8fFdqXM6xTDgPgW9yrrFjM6/vBGqYK5MP8vdjEFd6Sd98
         NBVXpxDxP5phBJEQbTM6ZF819Et3/utRfYgAYvVe1/7CPYGeKwjbZCJN2+eWDd+DPgOJ
         /JYgpa/2NylgB+nTergZPvZ1EvWvqMF606I1SYcSYUg7ByrEMXm1mMsFZ652rdG5agyO
         B7s01u4kNZ/56+zsY+mpL/w7IdzRejnSTJl0usSaFROTaNzSYew6f1rFzZzNTYa/jteU
         Duz/k0QuEMkQ11mraTPIuGOS/qrwrzXXpBwPJitSAC/lEqMeD/uihh/wLI3vDBA6yzMf
         CDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211144; x=1793815944;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        b=JB2Dnsa941NwAHAIGEcEm3DgmDbAVVD+nCHBmqlGpxnbNBBZn4XLsRjX/+fxqcn9F8
         bHcYQSlSsz6u4vnaGPaZXZsPwPmz5gEtekuKnvhwJxcpBX7diLhS37m6oxs+9DbI67XQ
         1i3dku6g7ybR4vYJrZQ25YepmPMZgyII3EwBfaNDHgCBITzW967Lz4g7EJJOM7cgzMlj
         rc3ITMxkFKziG5hCdSfSQeqMPncBIt6VhpPQnxs20CO2qb41GccQP/K6duRRCjMbbFbe
         kBcCEOvTN2z42qPgzfP0MkwC1qLCc4Qqzh8/2zcwilzXDv51VLQxi9uUC3nDTP8HhHf0
         qZ5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzIxBScf74cxGdaHbdccEBU3SE6rZuu3V6fdHfJIcm6iZAD01pL5cZaVuVHoH7RhmtSL3TehG4mMOZQla419IE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRIfW5mkM+oyx95PS+Gbihb+j7bwThOdxZSK2u6jx2tEpWszRh
	hTE4NA4EaF2+LEA2I5BvBcY/YvrExVAYSEx2wH5Gn4z1uhUByEFAFHaCp6jgsLAMVTRxDTkJO+C
	EnQJK8iAjH+mxDHjnomRRqE34QxaMtzs=
X-Gm-Gg: AYBFou2NSlz8N68aCP7acb3Zs7fZWLKhYs/NeCuTCxSgwAVofsL2MpZfhPVhmr7u3hq
	SgCKtF1YGh1zknUn3G2VXytGo1B3coMkmdd2EIIaQkndgtrtAW6Ch7eYOegSicIeD604k/8Yp5R
	8i/hhMxClEyfJPs/upx8V4TlxREVOF3NLzM+Hik6RQDBCkl9yeny5q+jiOuwAF29DgX++P7ysBa
	nxs6ipDyEaL/wlaWBdTFu4pAGRdmZUbctGUu2QviGZhApORaUylWYHyQOVja9vyReQuhJbZNgLd
	Cmd+uLUlXY03jWX8HlE0OLGi55fMdtkGEKnjxxxBqzERmd0KHr1gxNDtGVs7hrmZrHABpo1P9b5
	/viJgmA/kxxiUqfKyB/ih774Ez8NwnQRIILw=
X-Received: by 2002:a05:690e:a4e:b0:675:6f06:5642 with SMTP id
 956f58d0204a3-67a7b9945d2mr4650525d50.1.1793211144098; Wed, 28 Oct 2026
 11:12:24 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:12:22 -0700
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:12:22 -0700
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
 <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 11:12:22 -0700
X-Gm-Features: AclHuK-o5YV67AfwlA9WNsjqOxV_ScugEYWYzUg986KltKOOqPQjM_oQFfVaIog
Message-ID: <CAPAsAGyEUL1fj2-1=NGBDDO-z47cOHmcFDFexY9T_1_1LCMQJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

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
> Check the first byte with instrument_read() at the start of
> load_unaligned_zeropad() on every architecture, as read_word_at_a_time()
> does. All callers only load a word whose first byte belongs to the
> string or buffer they read, so the check does not flag their intended
> reads past the end. Add a no-op instrument_read() for the powerpc
> selftest that builds the header in user space.
>
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
