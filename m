Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAE316195
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976970; cv=pass; b=Xgo2tCOgYEngrvJIRbNmPmRTCFecweEA6Kh0obwc3Nd5llJJpXFiI+F+2TQZpPbBD6M+4RrwAipmVuSdh5Kn17M+7Blz+CjMjTHGeLiI9HfgWIJTjzDSGWkoKsIbHwbP1pLzkD4qbwPKWSKZfATBkSze6C+GNhA1BknkHylJ9CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976970; c=relaxed/simple;
	bh=WTRVHRp3YZnZVbE+0ZoSdIPjJ/az35/laG/IbVwaY3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtaBYMyZAxAclWY/cGN1f40+82OUbUXwLwNcJoBAyS45txLbaEUJKl9TG0DVnyKUb1jIfZWK6s5WHhQqGzw0DiOs5jFQmCYTEPxLDrNcRllLPhKeFQkXbxvqcmL1v3SdQPSvYv6XwEV1At8SJT2u63CxPkhUbQDUDuc3/JojK/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPEFYjmW; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPEFYjmW"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128bae6a35aso242764c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976966; cv=none;
        d=google.com; s=arc-20240605;
        b=WDyWCL36dprar+Yk4Dl9emZbfan5c+ziY8CaHIqaxbUTl6h0GMKA39tIcZhKrGyKfp
         2du+5lAhhy1YGtPKcRFATdJ3NQa/hJTwbV4IoFeH9KusFpqaORHTr8ciG2ioK3kw35lG
         jYO0YTqs0+rmPC0qadiRpXtfmGhscli3PxaB7IN7k311bRDqO3iO5XQdyD59W31Q6C3q
         7VJxlqEJZjJAuERQDPTo9VQvENcDae8X1MajB+LJhjJmqRLDNTFzODs6/qsbD1syRjP8
         +uSggZ/Nu/b+HJ+2bAzrIogbqBlx/AYsKoLe1Rvic5eq+oYI11Mlt0vhlqpgPbTjc9oI
         A43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hmCH9wEuQvIKAkIe3dk/Nd8jQ97KUjGLE+pTGY9wyZI=;
        fh=DcBEtgi6Uinzc8Hc5QS62rfdU9JJ8wQcUwBS6kpmx3M=;
        b=XpGNuMG92NxQOtff9EVwR+DE4edoarddTQdckQM4sLtTxKg5vvrCBQUoliSUVdJwV1
         mEgCbDpaE+Qt63/EOie1Z8wE2Pe7irxIkwA4yypxE/IXazVV7B5yV8tU5GjCUWxNcvxb
         5k5/2Xaigyz/lcoaQkb2a6TaqJ0g+rC8kkSjlYDjN0wtOTT/Cb3gF27AfIFEt3pd+hwf
         RoGQh9uM0wG8s+CbkLykJ3uuhSRA52VGtTCJqXYcbpoclTVQjamVxxVnWMt2VgTmHh32
         zkuu+bJEazonlYSHDtW031Z1VHTolzYS0TYa8KGKOdJGxObWvUFXRXzppMORJnuPJVIN
         3dwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774976966; x=1775581766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmCH9wEuQvIKAkIe3dk/Nd8jQ97KUjGLE+pTGY9wyZI=;
        b=RPEFYjmWEKeAgqRxKPdWHE2heLDNY/RoMjWk2+Cgudw8yFsUUJLHt56vK1TCUfOfXx
         tEMx3hVh4CkkWaTve+bHJ//V7V0cgBHevePROUWh4mdx+Y7qeZ7YCUT3ymyOpvEpLTuA
         m5wjm6ukdM6cj6LxdC+6PtFDK3jalNQUybs80JcJ+brnn8x/sFBqTCn9cos7AG7ySBl3
         C8GCoy+gi/gqXOoFEnxZnDAglw2QRQECL9wX0mlkD9ZTFLpX3/Z/Pqk1++rxDV8EYXKm
         mkFoS3hoWd4csJAvMh6ZH0vGmso3l6npcKPddYk/A4DOnsOMq78m/Up2RWzQFTV3h663
         bx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774976966; x=1775581766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hmCH9wEuQvIKAkIe3dk/Nd8jQ97KUjGLE+pTGY9wyZI=;
        b=dM7dUrPw7phzLKB0BdrmMsXuKVQdDBM0ipqQxomJg2+Nagw/02Lpl2H5yITsMQabHr
         mpk9Y5r+DK44S3QFJ2bbqoE6/8kepm10o94v+ompQyF5UaHlK7L0vt1rEKMdYB0ASNN+
         rOyuHshhragmHO97kMC4IJnSbrVqM8wfeH+SRKKvvRBELZLBXkLPretgDXYMrLGQOk4n
         X1tVdcm8vb7vkXwZdyV23hPUE8Zj0EFD/j9JOzCMrzqW3NTiiAUq1GkL8p7ZwvZpZ1D0
         0WYfD6CKEQy5y54gzNl3fbzVQ+dyBJ2Nm4cw2GN7YzgEzE35HMlao9mKoEiZsE4ZEsOM
         Ly2w==
X-Forwarded-Encrypted: i=1; AJvYcCWBYD6xFTjtlVEW52zYjoYEL/8yiaajfV6FLCjYasvS6LrgfeVne6aKkYIoJS9KqGfMVfOW4Hm38FW+fW3zc4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRysb1yHqsJy6HWPeunoBX660Xf6omiVSdrE78vgYXJsWKq4oD
	MN8BFuckhX43vxo8Ra62uu8skA1KGmE2QZej9YtxLNeLRe7wQ7HrQTCM7H3gB5bs0KQCx4ibtCh
	fJW51z2FlK17fwcvraWL1Jzc9aDNxC1I=
X-Gm-Gg: ATEYQzxIB3ZRlzuhbqan/9kW7pjiPLiIlpVKBYsujf8squaqxMjhLMTsoLD1x8ZjK6t
	sG24/32OdC5LpsWkTDEpH6awiJ3NYbAaa3GAAuyLAzNVhrEkSs0ZMDfsHBeMkBNGbAZQRa2SvWK
	nJsBPnAUPp31T62czaN8gWfo1Ca2ooq5YcIiWnxRd4GcEitbUd+EKbUiUOBCuN5iMBRHsrKVomG
	2lWNP8TThZ0WSykbWvXLebvHbvEnCSwVRAooTthwctgn8jUEVFyITkcpKrvbhRyh8l6D2XFCgEY
	xAVyIYex2IO4z3Qy+3iMGN9AnLb5VVUsLLEp309mO+IzCyEfFBRtcHN8FPbbxdLD3sEbUgWWuNy
	21skGeSziwOG61oXw+xDW4vuX/h2WPPfpMA==
X-Received: by 2002:a05:7022:660d:b0:128:d279:b8ea with SMTP id
 a92af1059eb24-12be65beca8mr58281c88.5.1774976966237; Tue, 31 Mar 2026
 10:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
 <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
In-Reply-To: <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 19:09:11 +0200
X-Gm-Features: AQROBzBS6-knL1zyoKnZ9aw9c60rLyHZCDFo7ofTsu_CS53BZFovGzzWB07mGSA
Message-ID: <CANiq72nH1cMgpQGGkbwCQd4bSEVarWteaQaXeZh3FNyNKauKKA@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 7:01=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Also, I am a bit confused -- does the compiler flag automatically
> recognize the names like `__ob_trap`? i.e. I see the docs mention
> using the attribute,
>
>     typedef unsigned int __attribute__((overflow_behavior(trap))) safe_ui=
nt;
>     typedef unsigned int __attribute__((overflow_behavior(wrap))) wrappin=
g_uint;
>
> But then we don't actually use it?

Ah, it does, it is a keyword, and I should have read the docs better.

From a quick test in Compiler Explorer it seems to be fine to define a
macro like the keyword:

    #define __ob_trap __attribute__((overflow_behavior(trap)))
    #define __ob_wrap __attribute__((overflow_behavior(wrap)))

That could be a bit more flexible in the name we pick on our side and
more like the rest of the attributes, but if the intention is to
eventually use that keyword in standard C or similar, I guess it is
fine.

Cheers,
Miguel
