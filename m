Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D244B67E
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987655; cv=none; b=LLIM0umcmBks3YJC5csLzphYoPHoHQgosQGK253FZJtDaHAI169jecJNBtIGL8C9467RHPYqQReetX9NyNz8abzHniHbvlCAB4cU85oJEUv7yWVzhfBN7Z8D/+dHhniLOWctcogmt9jx/cU/925c9RYs1/gYbE6TS2Gu7YISTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987655; c=relaxed/simple;
	bh=d6r1zB/UdxoLPJPFYvR0HJRmpyXXRkjD3BCCWDdorSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJt6r7q2tUswfkgZ7GLsUSgTuqrgLItNwY//CwfYJxPQZDsprIB5RADLoli19RdfnnmAPokF67n6h8mBrbd+aEEzXi5an8YEmUsYNFTu4LLhvNDvHs8okYieDet+pUyeP8TF58NSOqaVSWn8B4Xx+/7UXNlfs3SxzXTX8JXzMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FeTrFvHD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FeTrFvHD"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c04152730so129048966b.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774987650; x=1775592450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv2mdBoBk4QdkqU81qWETh/yEJGWnlakuOpSzMhOmBw=;
        b=FeTrFvHDnvtlO6EL+LwPGUl+LyVUPRoc//jZfcZlVaF7k8WuTmqihmDlRIOqoipchY
         R/xgDEXnbEDv4dbVh1jvnJP7/UIWAyNStLwwfx9BZ+l6iY8nY3D/nQ0nkOj63iCLPR/Y
         TD+c7yxA7D4p5kTTrTKRP2rEkx73SrPFyQ1CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987650; x=1775592450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv2mdBoBk4QdkqU81qWETh/yEJGWnlakuOpSzMhOmBw=;
        b=nPaDF0rlt/6Um4IRQvN/S600QqdKjQuoprciyhunrhBQgsLdcFq18gu4F8zDC75WXo
         faIkjnzrNMZYh7dSV878PGC6tvSiCRo5UmnM2b1aWU3gl1r2voxR9CrBB+wjFmUT5Ru/
         rWHZGFHnexCy+hNtEqmTkuvnPhWdhirmmRvRy6VQ4tUh05DanQWN1sNa8+ltZ1kDkpJL
         +usSqgWjSgexMYWfd++S3+sd+z/BS2RWu9ZPT7EnjTCsFFOU63GOrm/qKhyJRBAdR8XV
         8dOZQohs+cIZD+DtLFn39E89fk8joZqkUDi5paxFA8BrzaB0NBBi8+OToslSKviyy3Ve
         I1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzMhBoidu0hJwzhDtVvQY1PbNN/YeTxKASmjrM4L7lMJE4m3wVe3X9HDc9kGl4Je3uXpviPhdG9le7b3w/SPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FEqYLuUX8m/GHXuKRS2BzVamKIrvAjwMk9rY8fgQ8thLOrVt
	TMuYLEHwzZzrRvXUHAZjkJEXRbefhJg+zoXe0IN6pkNYulgJNgujlL50/73ppdhqkXJ72coV4y0
	1cdGdC3+uVA==
X-Gm-Gg: ATEYQzxwmCKQsB6+DEHJPuFQx9ICZqBjMst2Cd7z/PUsqZfLfpN8JfOvjujsql5+kGR
	d+T/YRfXj/boB0p5ilHlx+HVm+GAYwmsN/ZkWeP8xlNeEY6CZvcuNuZqcQCGJOyepJOXtantmKu
	LYJT868406BFHBI32mX05zvrYtIS3PMCz/wP8zftPVtTZJXTpgG86p/vJ4nFif7mi+DekDb0RFZ
	LYTbT/kDi2qWafnRsY2cbuP7JlVeKF8j4VvYFC4m3e6XUGdC/X8L5apkz68G6Z/aEKNilbOm/dF
	nefPJYlwcyNqjXCH74NJ2K9WLlDpQ4Q4bj+PX6ASu0m06d8Zoq/9nbDSd2WBN5wBJq6uRJ1w6UN
	RjX5z13AET9v4+mMQyd5LQBkWoIqTqiikDXuItkN9pjQFDzmo1jrQE5OAoXIkW2MiBRa6wm7EXL
	U8nT8X64RrIuVVnchHGmoZk6oxMOfrQO16+7gxlZ9d+nMwTH60QgmED4yS6rgEe69n1m3YscoP
X-Received: by 2002:a17:906:3956:b0:b8f:9bea:ad6 with SMTP id a640c23a62f3a-b9c139173e7mr48294766b.18.1774987650096;
        Tue, 31 Mar 2026 13:07:30 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b2253d4sm452466766b.56.2026.03.31.13.07.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 13:07:29 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c04152730so129047066b.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 13:07:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyHxttBoNMWCA4RUG456rZqRhfffCnkxFDUtrpetTLSvYwgFvZ5j2Mh9tld13YKo7jZtdJClShQN8aT94t+0I=@vger.kernel.org
X-Received: by 2002:a05:6402:540d:b0:663:9739:6265 with SMTP id
 4fb4d7f45d1cf-66db02afce5mr564572a12.9.1774987334624; Tue, 31 Mar 2026
 13:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com>
 <CAHk-=whjwHjmB0_2yXsOjDa7Mi_yFSx3AMd3vGk5r70WocvZZg@mail.gmail.com>
 <CAHk-=wgKB5f3MM40FGGUWUm_9eyESe2PAqCa6uZ=YTi0CdPwDg@mail.gmail.com> <202603311155.503B3DA5B@keescook>
In-Reply-To: <202603311155.503B3DA5B@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 13:01:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6YWV3hHs8i0P=2A2CVjCY=SOaYeayEodXYa+CMqNO4g@mail.gmail.com>
X-Gm-Features: AQROBzDJ5SIQIXss3ygEg5-CA2RDbG130aEFCjGxmwQlRnW2FPPkeTaugvbjtMA
Message-ID: <CAHk-=wh6YWV3hHs8i0P=2A2CVjCY=SOaYeayEodXYa+CMqNO4g@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Finn Thain <fthain@linux-m68k.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	llvm@lists.linux.dev, Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nsc@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 11:59, Kees Cook <kees@kernel.org> wrote:
>
> The syntax problem (as made clear by many other people, and even you
> here in the first half of this email) is that no one will use function
> based math primitives.

I don't think that's true.

It's just that they have to be made simple enough to use, and have a
good *reason* to use them without the end result becoming horrendous.

Ok, so I just spent fifteen minutes trying it out, trying to aim for a
really simple syntax.

Look at this contrieved example where there are two different overflow
things with two different exception handlers. I decided to add a
"default" label that is just called "overflow", so you can write code
like this:

        static int testme(int a, int b, int c, int d)
        {
                return addo(addmulo(a,b,c,addmul_overflow),d);
        overflow:
                return -1;
        addmul_overflow:
                return -2;
        }

which obviously isn't pretty, but it's still at least somewhat
readable. It does a "addmul" and an "add", both with overflow
handling, and returns the end result.

If the final add overflows (which doesn't have an explicit overflow
label name), it goes to the default "overflow:" label.

And if the addmul overflows, it goes to addmul_overflow. It's all kind
of obvous, and not syntactically all that onerous.

And it does work:

        #define TEST(x) printf(#x "=%d\n", x)

        #define MAX_INT 2147483647

        int main(int argc, char **argv)
        {
                TEST(testme(1,2,3,4));
                TEST(testme(MAX_INT,2,3,4));
                TEST(testme(1,2,3,MAX_INT));
                return 0;
        }

results in:

        $ gcc -O2 ov.c && ./a.out
        testme(1,2,3,4)=11
        testme(MAX_INT,2,3,4)=-2
        testme(1,2,3,MAX_INT)=-1

and in this case gcc actually did everything at compile-time, so code
generation is actually good too: the compiler will optimize this to
hell and back.

But even *without* constant arguments, the compiler can actually
generate good code too:

                .globl  testme
                .type   testme, @function
        testme:
        .LFB11:
                .cfi_startproc
                imull   %edx, %esi
                jo      .L6
                addl    %edi, %esi
                jo      .L6
                addl    %ecx, %esi
                jo      .L15
                movl    %esi, %eax
                ret
        .L6:
                movl    $-2, %eax
                ret
        .L15:
                movl    $-1, %eax
                ret

that really isn't bad.

So the code is legible, the code generation is fine, and it's pretty
flexible. And are the macros complicated? No. This is literally the
code that did all this:

        #define __default_exception(a,b,...) b
        #define default_exception(...)
__default_exception(,##__VA_ARGS__,overflow)
        #define overflow_op(op,a,b,c) __builtin_##op##_overflow(a,b,c)

        #define __overflow(op,a,b,...) ({                       \
                __typeof__(a) __res;                            \
                if (overflow_op(op,a,b,&__res))                 \
                        goto default_exception(__VA_ARGS__);    \
                __res; })

        #define addo(a,b,...) __overflow(add,a,b,##__VA_ARGS__)
        #define mulo(a,b,...) __overflow(mul,a,b,##__VA_ARGS__)
        #define addmulo(a,b,c,...) addo(a,mulo(b,c,##__VA_ARGS__),##__VA_ARGS__)

Now will people ENJOY using "addo()" and things like that? No. Clearly
it's still *easier* and even clearer to just write

        return a + b*c + d;

and yes, that is more legible.

But no, I really *really* don't want people to be able to just
randomly say "I'm just going to kill the kernel if this overflows".

                 Linus
