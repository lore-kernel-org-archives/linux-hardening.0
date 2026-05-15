Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3804381AF5
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827043; cv=pass; b=dzhfECylcTBvWK8OztFVywY+652geKqxpQtNsiqOFXKn6ZVRV25HNF7R4pemVSWZy2cMCXEhdVqHGKH4Np3+N/TIFf3/wg610s60aMtcTalPmhSP5ASbiZn4DFkQSHhl+ScnZPjmktHFOEOt50AoFS03y6brLbx1r7clju4q5Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827043; c=relaxed/simple;
	bh=/jqHs8uGFL/YrVYfbB2cdUqcQe4D+MVqyjDguazmLzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVBz5ePj5X2ig5b0TPJ81JB3ozlakAcsQpaUMlfIU9wEZ5Bs1MDk+rrlaVscOat4XDu7jxaX/Ai251+OvOxKbpf6UINWHcV4QMBV98S8UJraZcTfIUEDxn3bIOgNy5xKlBAGbVWJY3ZDKSa/fG/qu/IUjWdA36A6QlYc7ZpAKoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYd+jD82; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYd+jD82"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd373f83042so554774866b.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 23:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778827040; cv=none;
        d=google.com; s=arc-20240605;
        b=ftjkUo+LEA4iIyuES+Hf8+a/Ll3c6CblBD/QWEoG5/HfzuNnhvEjTv1cltAi9DzMiS
         hpxnkoMtOJRVCUHCmTSS3A++tJ9kFqwQoNYwIUakQrXPL4rURhY2F+inkTPrQ/U35okN
         vCodHNmFHQ2d7lDhG5EoTiGkQll6cv5AOHFGaXhi+3Nk6QtV9TAKjRkOjd4aKAy/1X42
         X5qrKSYd2eTs9LmxOcYBbXPgUwebn6jDYESFP8RT0OKUlJwkS3rDdWgSliNJ1AdZcVzx
         r4fcFqmVkvTQffc2AP8wiDuLCVMOBXHzU1DFoWYBgLqkT6S/YuejLQHWBdtNGhRPqq7N
         Y22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4LMCqVFSjOu6qSrwojx1FavaW0eHqSxzlXVygC4r2vs=;
        fh=RNWZO7O9GxeX+3av/d8fT8xMNFMGzSlnpitH3AMMI/Y=;
        b=W6+FCyfEJseSbdSKmb7ohZuuBHdIXb2R/REtPp2a7emw9HaZa6/MYsoLMALRk6thky
         Nj/dUpbawWQ3WGj4Qbm52AH/ThFrufst2bAY9fUfjjtFIOeqpL1MtEw3bJx4e/4WA3Iz
         y1fpFWckE9mK6So5ARd+JsBGVO5Ftwe1bYI0dx3bIj/fT3FZ/9klSYw7stNwji8OnFD+
         u4GEaDUM9aTIH4DKJxK+OHKl08OyPIzDnBtyPmGd+JSx3vWo5kaNk9YcG30x79EIwds5
         bxwXU+nxTPvry1soUebuMZrb+GEqmXrsXJ7Ncm4UkmKE9ElHd0tRBWXIOK+qSYeJ8qPV
         GENQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778827040; x=1779431840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LMCqVFSjOu6qSrwojx1FavaW0eHqSxzlXVygC4r2vs=;
        b=qYd+jD82mDInQWNXnqHgzRJp6nhHlNcpfFuzYBEh53o+5LkdkZcxLP6eIyz2wtbISl
         z9LpKDlQpg3M8GtV+4NeERHa/Cp6V72A4kOj3GAD5ALysXMpqtgp2ciIDGZb7zbPWYUj
         UvwRC9Zoq4pQ96c902QpR5X+8LIWMX31KaNWslx3nP2h+EcusZjxuzAsGR5ytv0P+UYE
         Z8uInxZy86CmbVaXyc8GM9yKn1h/TdcPZZHqRVKhiFCqfhylifXKdCRQJn76AG0j6SWQ
         Bn8dnlTcZcF5nh+CYnzXo5oh1JgaZOraK1As5FNvUbTjC/V6CDdGqU2bHweEu+uKiaYg
         +mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827040; x=1779431840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LMCqVFSjOu6qSrwojx1FavaW0eHqSxzlXVygC4r2vs=;
        b=PjjpLjbZM9/cNUoU/EgwZ2MKnZ9Vea2nMwC/ImiJogH+QAvOW4SRCEmb/VhO/3fqUo
         rMbwSaI9TCJPKjhfQrZCc5rKAJngf+OmEjgG4KUT5/hUyMZAR6QKFMKMw/sR/ojsRaCm
         YUevEAMuOH9SAQNVC0v8mwKXcwuWnmrh83AiCXv0fQx3lDzj05+HDoGc9X74baj6efgA
         GUd3loCswLWK7gLoOvF2K7j2ST8P9errqXACFmxTDMzx8n8dvKNvsPX8emiTZSn9rkEs
         HXvtrFY3tZLMKwv/cihygb1/007aMajsXvV0q1uEoXV1Ifu2eqxd4/QMKcPd7PFfOtd9
         rlsw==
X-Forwarded-Encrypted: i=1; AFNElJ9DAZu5XLE5pw1FjAVOHtXBagq0+ipZCTZRNq1maFIoo5Bg17mdYRdLamZdksiIeUZmluWWrAeM+uypcmvumwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57dkSxKfeSdgf3RxjS67VT/DJ4ehwXoBkphlpY6HmEJBhpITf
	LfIvFaF1R9Oo5Mp4DFLUudPDWFomBO9JZ6zxO2DnFN6ZKXCghdpsdktd64rO/c+LeiETGeuClQ/
	rpXonP00eNVLRU9YqY8MUqX786iWtI6c=
X-Gm-Gg: Acq92OGQPUmpiF5SxKZ0ldzI+5lEjqwtcXZ2V/ZPPxqWJtTtnyRQ6AqoT9en3fpVyul
	osCmg2ky8rUkmLn9riQqX8cQCN9VigCdEzPxjKqFX49eD+jrctOP++ErLVKmo/QGWRTooPzL+Hs
	ldT40q1yJDndlWlGWydWy4ycZQe99edNIaJwWaEFj+9KRL/RrBvjj58tTgkeG6nsBSAmTaKir5m
	HyIDHPm4x3bgp4ZhDRXpLKvs4MuN9bgB8z60nTqp+2D+ebz0zhAILaIE4NKGKi7Q0gOl8lbsBdt
	3RYAJi1lWLLaO14kaid2WSuJtiA0Q+JtjLBsQaPsXWISyWuezYVmJhgbt/azfw9+LXOgKgNakFp
	4MseWVaE=
X-Received: by 2002:a17:907:c247:b0:bcd:c899:904e with SMTP id
 a640c23a62f3a-bd5177d9a69mr147258366b.7.1778827039790; Thu, 14 May 2026
 23:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514121359.931999-1-milant2002@gmail.com> <20260514121359.931999-3-milant2002@gmail.com>
 <202605140916.09FBB1A4@keescook>
In-Reply-To: <202605140916.09FBB1A4@keescook>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 May 2026 09:36:43 +0300
X-Gm-Features: AVHnY4LTtUgH9l_UEKEjClBIDSN7f6fhD3s_31tgGoM3D-Skkze3R3ylHD52Z_s
Message-ID: <CAHp75Vfb=J6gQ=YbpA8OxTpti-n2CaAGh+Ro1iZJWRxwbGd8eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/string_kunit: extend benchmarks and unit test
 to memcmp()
To: Kees Cook <kees@kernel.org>
Cc: Milan Tripkovic <milant2002@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andy Shevchenko <andy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>, 
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:19=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Thu, May 14, 2026 at 02:13:58PM +0200, Milan Tripkovic wrote:
> > From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
> >
> > Extend the string benchmarking suite to include memcmp().
> > Extend the string unit test to include memcmp().

> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202605140827.Qg1DZpcB-lkp=
@intel.com/

What does this mean? The absence of the test cases won't ever be
reported by LKP.

...

> > +#if IS_ENABLED(CONFIG_STRING_KUNIT_BENCH)
> > +static void string_bench_memcmp(struct kunit *test)

> I think I'd prefer, instead of a ifdef stub, to do:
>
>         if (!IS_ENABLED(CONFIG_STRING_KUNIT_BENCH))
>                 kunit_skip(test, "CONFIG_STRING_KUNIT_BENCH not enabled")
>
> here.

What about having two functions?

static void do_test_string_bench_memcmp() // choose better name
{
  ...
}

static void string_bench_memcmp(struct kunit *test)
{
        if (IS_ENABLED(CONFIG_STRING_KUNIT_BENCH))
                do_test_string_bench_memcmp(...);
        else
                kunit_skip(test, "CONFIG_STRING_KUNIT_BENCH not enabled");
}

...

> > +     for (int o =3D 0; o < ARRAY_SIZE(offsets); o++) {
> > +             int off =3D offsets[o];
> > +
> > +             for (int i =3D 0; i < ARRAY_SIZE(lengths); i++) {

unsigned int i

> > +                     size_t len =3D lengths[i];
> > +                     char *p1 =3D buf1;
> > +                     char *p2 =3D buf2 + off;

> > +

Redundant blank line

> > +                     u32 iterations =3D (len < 512) ? 100000 : 10000;
> > +
> > +                     for (u32 j =3D 0; j < iterations; j++) {
> > +                             (void)memcmp(p1, p2, len);
> > +                             barrier();
> > +                     }

> > +                     u64 elapsed =3D STRING_BENCH(iterations, memcmp, =
p1, p2, len);
> > +                     u64 ns_per_call =3D div_u64(elapsed, iterations);
> > +                     u64 mbps =3D len ? div_u64((u64)len * iterations =
* 1000,

Instead of casting just make iterations to be u64.

                     mbps =3D len ? div_u64(iterations * 1000 * len,

> > +                                                                      =
elapsed) : 0;

We don't usually allow the C99 definition initialisers inside the
code, even for tests.

(With that the last will be a single line.)

> > +                     if (off =3D=3D 0) {
> > +                             kunit_info(test, "bench_memcmp_aligned: l=
en=3D%-4zu: %llu MB/s (%llu ns/call)\n",
> > +                                        len, mbps, ns_per_call);
> > +                     } else {
> > +                             kunit_info(test, "bench_memcmp_unaligned(=
off=3D%d): len=3D%-4zu: %llu MB/s (%llu ns/call)\n",
> > +                                        off, len, mbps, ns_per_call);
> > +                     }
> > +             }
> > +     }

--=20
With Best Regards,
Andy Shevchenko
