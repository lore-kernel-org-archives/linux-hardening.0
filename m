Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739B293C67
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881702; cv=none; b=Bke9dVg+v+ypLrKjmptEOFq4gIKi6adTqGyn8+66aaAozy0i2wVlEmLt99t++TtbY5N8/EzvveiCfrfohEuct9ITSG7div/jUuFO76i5U+FOgE9XqMz3AOjahhieB8LB0l840GMGKAAMQjlHJKy9t60FlbZQ+HFff4gwIxXT+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881702; c=relaxed/simple;
	bh=P/bSqtL2IcNiFIBFWz48MnCREeUKmBoK8JlXKJD8PYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYjAFF4D95dFGltGI3AyTen8Xj5/cKlTuOnHNGR1kXMdR8PGV6yGoLt7pYl32uMKgBQAar7wy36sxmhq4kAHVSzRqgotlZcd1trIlwWBJ2DNBN2IKMEqqsNp2/sjo1i7JAqSYO17RqEvx9cMTtKocAfugK2EK1e05bKas6poub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYaGOFXe; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYaGOFXe"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-702cbfe860cso24228716d6.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751881700; x=1752486500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frbjbKfca0mgstlmUpI74NtNTt6lUs+p9/a8UNKkFt4=;
        b=IYaGOFXeGK6KPh4UXnIvGGLoas9zc4CogJFviBdhTiVvHnSKDxwISd8V6v3oNtNS79
         5YY7TKfQvYXITui9NPXYn7y/9Oe5CmgG4k/EHl3gQbGlWLGBg5Scz5q+yWwz8Zd1YIif
         hvd0OFhMeAuR6xsp/6F50vESGfzRtSd8CNT7zuZgtHnbiGy/L7n7XtiYhIoxGc7lpI2Y
         Px9kdy2QRQ1u432dttWA06gSudnsgcF9pEkWhTnLZkgcZJaQBpFa9ODXODEzoZPgyb7o
         8a7EtnYyiBJ//eMqJhu6Dd9cdYqxytd6F9l/OvvPwXJIDJQT1VEbnat9heQC+1stFRIY
         HhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751881700; x=1752486500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frbjbKfca0mgstlmUpI74NtNTt6lUs+p9/a8UNKkFt4=;
        b=EAgPFmXW59QXOenef0x9sL0URhFSKjdYD79iAj3exG73Ybka8/cStPJK/35cpr1PHo
         WkeswnHUaGhXiOACB6IXNb/hkpSYKaO3enWjuXIJSo/OyL3QM5kl8cocQogTDgvosBr/
         kvFlWKuk6Kyr6AmLlkaiLhUKU58gvX697XDsnr9lssD5vbBwnDdvYUpta2CVWEJ5XrGA
         g9ghPYpWwQhiViPKZ7yE4lVaFaieDRWCCvv6USyuIzIwCazuvkpdwR9TCSC9fV5WD3Mb
         pNKZsWh16ht18jGBpNZnfqjjMx6nCi48YV4H7v779J8vsBGZRkcmg6iqsPqUkCVJdC/0
         tdEg==
X-Forwarded-Encrypted: i=1; AJvYcCWs3VO53iVe7cfhJtTYhktw/49nIOi6QMUiyD/mq3xgb9VfISAup2oPvQcpG2xo6+TZB/SvZT0oWoOLOQtjZlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymGv5ByEUes1hZM5wmYlNhibJeIRiLA87QijrHcG0bJvugwJV1
	2ACXqKDvJnnTpMlrOl4y+wwvhzFqvfrKXDBOVnKtT9WfYAp8zfC1UcXGJvwJEpPLwvCshSLQomZ
	tlaSUT/y/KQXOTyXEMhE5SC8pC77xvNjfqsF2G1i6
X-Gm-Gg: ASbGncvi/1nZqvYgAjW1i2BZ4lj88mJEL/puLwCRoUEPkTWiN/VYrFpMwnzkJFPi5SI
	6XeqFSy25gd/+BjlsGIUmd6/tmSsIa6K9HdSCpaEp2Ngv0zcDeiYZauXRrLL6eD21/xqOe2hKn9
	SRwAsCcHH4n2urZLQcjYSjWWsQiwvYqZ5bQ7rxYQW2beXymfJ5lMLhXYmbF+RsbZuLz/QT3ncmQ
	g==
X-Google-Smtp-Source: AGHT+IHcO/y74R/A4icF5JMOnPuik0+R72LDFyPIAjvRILtiYXcsXDsbfAQD1GOxerZ6cpwinFaAl6Ff+ph2u1beSIo=
X-Received: by 2002:a05:6214:5d0f:b0:6fd:609d:e924 with SMTP id
 6a1803df08f44-702d16b5b13mr143596346d6.36.1751881699546; Mon, 07 Jul 2025
 02:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751747518.git.alx@kernel.org> <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>
In-Reply-To: <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 7 Jul 2025 11:47:43 +0200
X-Gm-Features: Ac12FXyyIGAsATyNgJop_7rvBktTGUGYSMPyLaAqY218kgxIasAxME7dbvT6CZY
Message-ID: <CAG_fn=UG3O-3_ik0TY_kstxzMVh4Z9noTP1cYfAiWvCnaXQ-6A@mail.gmail.com>
Subject: Re: [RFC v1 1/3] vsprintf: Add [v]seprintf(), [v]stprintf()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 10:33=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> seprintf()
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> seprintf() is a function similar to stpcpy(3) in the sense that it
> returns a pointer that is suitable for chaining to other copy
> operations.
>
> It takes a pointer to the end of the buffer as a sentinel for when to
> truncate, which unlike a size, doesn't need to be updated after every
> call.  This makes it much more ergonomic, avoiding manually calculating
> the size after each copy, which is error prone.
>
> It also makes error handling much easier, by reporting truncation with
> a null pointer, which is accepted and transparently passed down by
> subsequent seprintf() calls.  This results in only needing to report
> errors once after a chain of seprintf() calls, unlike snprintf(3), which
> requires checking after every call.
>
>         p =3D buf;
>         e =3D buf + countof(buf);
>         p =3D seprintf(p, e, foo);
>         p =3D seprintf(p, e, bar);
>         if (p =3D=3D NULL)
>                 goto trunc;
>
> vs
>
>         len =3D 0;
>         size =3D countof(buf);
>         len +=3D snprintf(buf + len, size - len, foo);
>         if (len >=3D size)
>                 goto trunc;
>
>         len +=3D snprintf(buf + len, size - len, bar);
>         if (len >=3D size)
>                 goto trunc;
>
> And also better than scnprintf() calls:
>
>         len =3D 0;
>         size =3D countof(buf);
>         len +=3D scnprintf(buf + len, size - len, foo);
>         len +=3D scnprintf(buf + len, size - len, bar);
>         if (len >=3D size)
>                 goto trunc;
>
> It seems aparent that it's a more elegant approach to string catenation.
>
> stprintf()
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> stprintf() is a helper that is needed for implementing seprintf()
> --although it could be open-coded within vseprintf(), of course--, but
> it's also useful by itself.  It has the same interface properties as
> strscpy(): that is, it copies with truncation, and reports truncation
> with -E2BIG.  It would be useful to replace some calls to snprintf(3)
> and scnprintf() which don't need chaining, and where it's simpler to
> pass a size.
>
> It is better than plain snprintf(3), because it results in simpler error
> detection (it doesn't need a check >=3Dcountof(buf), but rather <0).
>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  lib/vsprintf.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 01699852f30c..a3efacadb5e5 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2892,6 +2892,37 @@ int vsnprintf(char *buf, size_t size, const char *=
fmt_str, va_list args)
>  }
>  EXPORT_SYMBOL(vsnprintf);
>
> +/**
> + * vstprintf - Format a string and place it in a buffer
> + * @buf: The buffer to place the result into
> + * @size: The size of the buffer, including the trailing null space
> + * @fmt: The format string to use
> + * @args: Arguments for the format string
> + *
> + * The return value is the length of the new string.
> + * If the string is truncated, the function returns -E2BIG.
> + *
> + * If you're not already dealing with a va_list consider using stprintf(=
).
> + *
> + * See the vsnprintf() documentation for format string extensions over C=
99.
> + */
> +int vstprintf(char *buf, size_t size, const char *fmt, va_list args)
> +{
> +       int len;
> +
> +       len =3D vsnprintf(buf, size, fmt, args);
> +
> +       // It seems the kernel's vsnprintf() doesn't fail?
> +       //if (unlikely(len < 0))
> +       //      return -E2BIG;
> +
> +       if (unlikely(len >=3D size))
> +               return -E2BIG;
> +
> +       return len;
> +}
> +EXPORT_SYMBOL(vstprintf);
> +
>  /**
>   * vscnprintf - Format a string and place it in a buffer
>   * @buf: The buffer to place the result into
> @@ -2923,6 +2954,36 @@ int vscnprintf(char *buf, size_t size, const char =
*fmt, va_list args)
>  }
>  EXPORT_SYMBOL(vscnprintf);
>
> +/**
> + * vseprintf - Format a string and place it in a buffer
> + * @p: The buffer to place the result into
> + * @end: A pointer to one past the last character in the buffer
> + * @fmt: The format string to use
> + * @args: Arguments for the format string
> + *
> + * The return value is a pointer to the trailing '\0'.
> + * If @p is NULL, the function returns NULL.
> + * If the string is truncated, the function returns NULL.
> + *
> + * If you're not already dealing with a va_list consider using seprintf(=
).
> + *
> + * See the vsnprintf() documentation for format string extensions over C=
99.
> + */
> +char *vseprintf(char *p, const char end[0], const char *fmt, va_list arg=
s)
> +{
> +       int len;
> +
> +       if (unlikely(p =3D=3D NULL))
> +               return NULL;
> +
> +       len =3D vstprintf(p, end - p, fmt, args);

It's easy to imagine a situation in which `end` is calculated from the
user input and may overflow.
Maybe we can add a check for `end > p` to be on the safe side?
