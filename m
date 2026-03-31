Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FBB2FE042
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976530; cv=pass; b=eXmsbsk1vDyFeN0hZGDpPqbG5V6esB8QykQKQpzHKAscuOUZRuPfu5kEaNN1vt5vj/MdfMVOdIwiNo0BcMz04BSdxGOQF5K8ugkGTYrykpgCyVPAH9nReLv6QZ1zQ4gAvb+g6EHnTIc9JfrGCqqgL9j4mom19G/WVEPCBXFRtNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976530; c=relaxed/simple;
	bh=g/vQPQS0w9Xxi55W5EhGbOlAIubJN7tvka1LWWLiAXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN2tbTwWctFiikgrwRk7oxeaUqq/edqtRK+Uf2eqUvdaWzhT+x/iCXAl/EJf7yxevNkxfgErdsh1HNQnoGfvAnd8lE7fvzyJxx+BtGTJeTKWDgIySAxOBxWOv4ufjwpiSYR2Wixptqo1B1bCR2u0vVlz7lf4zAiNHxS3whIMzQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4MYfcI8; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4MYfcI8"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c7e5f38a69so27096eec.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976528; cv=none;
        d=google.com; s=arc-20240605;
        b=J6vfy0lgTmy3gTZESUgwFqG8y5R7SKkG5hfprkkx6jTPsrVCjDBw6IAz21oY3iP+qH
         iXmeqHLW6WX7wXsM5NgJmHwIDgI10ukJ5mRUCLJQ1edi82zypNv1mKpf3sRYCQrZ/Hg2
         MatkltBHOpS0WJZeaPzaZtHypRL4jfNgvdjD2MTh7fPQpLYWzXvrU9oZDcpL5ERXNZC3
         A8T0grnjfPRROsSNxw5wCnAYDM+Z3XjR/XKgHYrF7McLlN4AYOSYFFW8V0dT8/3xW+bi
         6Z0F7YD61dNJiylKKwp7S2al4ayXX0u8UMHx1bvXIk/VW40kyLnLKqA1lmfyJLxwsIkS
         MQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IU4m3ma81SYxNj71QUeHGIKcLWU6SzNh0VTIbMzWeYY=;
        fh=7VI/hmixivRnfNii6mPlV60oiUld3yJGdnT8U3ylHYk=;
        b=kbS21wW4s/wzzPbSXQ42LXw2vEKPX4LRTWrVRE8fdAJw+RehwBDxfcI27gGVU1vT8v
         A5/5YHDa2CUg/hdf5a64j6p1yLaDgq+gHZfHT45PYGIm2/dV1Pgv+4eGfiZAw/QMoFDV
         GvliiCSXB+s7kjXIuLLV7b2lBpKMORbrMWQpkNxGg/Ja5MzuQCLu3cmdInBpwaNqoS5r
         r6s/FIvFRN27J1HsZ8dXZHvafvqShS73lEFv96OsAA3TcF+UgYduXIT4PKXc5G7Rsxum
         FTtdsYtB12X6wIim3EqJjwzED8QX8jhIZnH1x7UabLzluXHRQrGTj9i17kxkVGd4/DAG
         0wKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774976528; x=1775581328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU4m3ma81SYxNj71QUeHGIKcLWU6SzNh0VTIbMzWeYY=;
        b=h4MYfcI8slTRlGMHt1sQIa64V5DXkkM2nRCsSYDP4oWK8+qzdbA+zJqcCdGqnXOMS5
         mgSuxxfmZhRiCIoKC0/6HTMbXMt7u2IAtQRwvb5O77jWrHxW2XYOE9y5hrNuU1n4+zR0
         e1XnmQiNA+sSvBSVH4vROfkT4PLFPzDHkJqSmbcWB7YHp9fGU2uH5/0H/l+xqlpwsbgR
         UCSf5Sm0s3783Xsc5fVL37YeD1MMnILpPWekNfUXVzA92b7/0h+ehNgcSOOUXFBVZctj
         VAGCLbIP43kiaKdaLoR7D38heKXa0NoSeRPKT9iG0Aw3sZOac7kV19IyrIRKqFYo65Lo
         52bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774976528; x=1775581328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IU4m3ma81SYxNj71QUeHGIKcLWU6SzNh0VTIbMzWeYY=;
        b=n7N1u1kxGzDP8DjJmrfcCR9VLhJ8p0fXDGtwMLNM4awmASeT2KbGpiKKwya5ACfzo1
         7prH7EQCVK0Q0ULWNoN4u94+t5sOtjJSo36xG8GZ7iDa9biTFPYzep2mAtQyeQg9PMDx
         vNMpjjJ7QZlT+H/9E1am145WVIGzE6ufCOHI7ySWOFFeHtShnL7EGguxEIp5rYr4YT0E
         JteWYzqDo0nPDnE6dA7W59R7m0B7M/aG2ta80+GfTjA5tM5bIUORaZJ7DFEJECQd3fRb
         AAmOgqnWcAe54z9EWEEKnT8ICY0ZpjG7dfLQnSUOXoyYVGJLP2q+xnmSvut31kISWmnD
         nyhg==
X-Forwarded-Encrypted: i=1; AJvYcCUqexn4SIY137CkFN78u2ooU/lGk/wAWfikICR8+k4qB2k2BZfG6MB7GlJcyDRCAIfN7gOxswF0WL6hrY9/S1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyScLoDyHxUFhT6b0g/FllQp91BLHcj/xgaXtkZCWThKIzsNrLT
	r47LJqkES+oYLPYdSX4SctCH3+3fvwFuG+DifK04I+AicXmFPEXHwEwjHKwOSCb18kgZuPoa6Eg
	DYCBPu5lUNHkCiYBY4Nk7isaIT0T/swc=
X-Gm-Gg: ATEYQzypPp7jI6ma9lKg343wh/MAF8Y6gyupCOMmEf6HqR7YWiGDp5aSz82vmfFzRQM
	2JGAX3jPcd4NMw/Bw9Elj+zPJUhRK2vj6Bd+TvUOK5vaLnKlOLQNNZVXer4dZPAixP3NCVq3nHM
	Gl/1nkapBRR4pGjmpXom+YMfjkjYojs9sdeuZpCGLZPc/VjPKwZpNG0odQKPb1+pvoONOJzNbrF
	J22ImUhL/1tyTLl7te2iu6mE4PSAskemQqtoiXva6aloU8nfAqErPcjZVGOg45WF/3YeLkTdUoj
	Wsnb4VZ+tUJm9ryssl7SYoJEHzIbLBvpd82odyngUZQ5CLm/tBY8YYKX7rmJhoihzvRibxrAHL2
	qKfipQFByS1f9Fjh1eeXJYug=
X-Received: by 2002:a05:7300:8c05:b0:2c8:aef9:cf3c with SMTP id
 5a478bee46e88-2c8aef9d5bbmr578311eec.8.1774976528009; Tue, 31 Mar 2026
 10:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
In-Reply-To: <20260331163725.2765789-3-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 19:01:55 +0200
X-Gm-Features: AQROBzACBmAh1Gj6cURe9fgjRYkC4LMT-gxdC_n35omwVPBYsPI5mIuUgNZG76o
Message-ID: <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> +/*
> + * Optional: only supported by Clang with -Xclang -experimental-foverflo=
w-behavior-types
> + * passed via CONFIG_OVERFLOW_BEHAVIOR_TYPES. When not available, define=
 empty macros for
> + * the trap/wrap annotations.
> + *
> + * clang: https://clang.llvm.org/docs/OverflowBehaviorTypes.html
> + */
> +#if !__has_attribute(overflow_behavior) || !defined(OVERFLOW_BEHAVIOR_TY=
PES)
> +# define __ob_trap
> +# define __ob_wrap
> +#endif

Should that have `CONFIG_*`? i.e.

     !defined(CONFIG_OVERFLOW_BEHAVIOR_TYPES)

In addition, since this depends on a `CONFIG_`, with the current setup
we would put them elsewhere instead of `compiler_attributes.h` until
they are promoted to be "unconditional" (i.e. without the compiler
flag):

     * Any other "attributes" (i.e. those that depend on a configuration op=
tion,
     * on a compiler, on an architecture, on plugins, on other attributes..=
.)
     * should be defined elsewhere (e.g. compiler_types.h or compiler-*.h).
     * The intention is to keep this file as simple as possible, as well as
     * compiler- and version-agnostic (e.g. avoiding GCC_VERSION checks).

However, thinking about it, why is the config needed?

i.e. if the compiler is not passed that flag, shouldn't the
`__has_attribute` simply return false?

Also, I am a bit confused -- does the compiler flag automatically
recognize the names like `__ob_trap`? i.e. I see the docs mention
using the attribute,

    typedef unsigned int __attribute__((overflow_behavior(trap))) safe_uint=
;
    typedef unsigned int __attribute__((overflow_behavior(wrap))) wrapping_=
uint;

But then we don't actually use it?

Or should this just be like the rest of the attributes, i.e. we
actually define them here?

Thanks!

Cheers,
Miguel
