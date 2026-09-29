Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F24346771
	for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2026 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643595; cv=pass; b=Nu1ssxxNzZrWiFbn67Nzw7INqNGuUjnqhVmXeymwIsLfFSNhMlA77A4LXaYD8C6EIDp3zPG2njpGu7ZZFScFWc6v4mTlVJa0UQ9I5daD6ukkic/Q6da8/1j+0nL0+1+ek65kBXXRcGDg5oNhfUlHtLzGg0D52RTY03iY/9UNN0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643595; c=relaxed/simple;
	bh=kdstfPQgPrtTgN4gUdooa+ekBKEl2NJeeJ4iI2g35zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXVkZkKozn9ACrDqNHBrFBPFEGn2T1/ZfKH0bNKoJAqNYydJ+rpgSUb7lK+TU4QwDnMfDVCzpCAajJ6UZMR8Ae37DVZi2mkT4INblPFPDyIwBUqFjIgrz2Vtj1MPaYMLhUjxxKYIvnjnY3kRMAXnPijX9agHg3xS9xeDG0yLARg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRAWytO9; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRAWytO9"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c8602so2004459241.0
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 17:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790643593; cv=none;
        d=google.com; s=arc-20260327;
        b=sCN39rys2sjBVYaJnCE+zVwA6FWXf4Qa2jfgMA0xY+vNdlz9TCDP4s06oofvFToBUW
         30TqJEWIxqQJPjBl6eNeosFjNZONl0RroCmTSC3i2EJRRI8Z9TLzZuUG8FUtF0tMqWyk
         FTBn7IEnJl3qAkHc66VugZRTsxVVrzBqSgkzAp8/w9+5jtrxoFvEUyMkwOWmco5wMUfJ
         cH8UJYfQ55aSS/bbtPMVnYWG7SDTGH4HhyYTQ9bvS/TQKzaiyMUNSQB9TEZEDd251Jlr
         7po0jpYJIgGoc20tw+PUQ8WUHAtYPHNSZvDWhOp84NH+NoepCeSC6hF7Ao84a9PQHdT3
         mU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0ADxDwdLkQq+vcZGCf4NIyg5yF4IrOepz6gtzfzxe0=;
        fh=JxD7DBwAS74+kPMJHJAO3fw2iOUgHVD3cL5CIKPuaEg=;
        b=YLjdlo39y5UwYmKHkKKEneuLwjQ2xU57gsLgOkM0CZ3zTOSORy7hM1HUNSwtSZkLaR
         zhLYC0ycYJsKgNYDk+ktbnD4rcfHTAgzGsMumt05P4kp2zV+ILLH9oA+IvsN+hd6qDOa
         mr1Y36RuLp/vKuMokxMBBeBJYw3AyZ8Byk/FS6nL95pQC+gqvEKi+rA73Ce40ROUGfgx
         51+z3zT25wYIWeLfUmzaFNszEslr+XH7tYjb7RoeCm5lbuRbvHIQv1OdKSHSerX5tKWm
         /0TmF5Qe3Yqnz7qQRE2QQo0uk0SEdDoFqAZNHlM9pKcmFaAHARsKa5dfs/vMxiZ+yFfB
         2cXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790643593; x=1791248393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0ADxDwdLkQq+vcZGCf4NIyg5yF4IrOepz6gtzfzxe0=;
        b=sRAWytO9hW7eRbW6bWWAnf1jOwlXuKHzL7lzqJ0x2Pwcaal0BH44JNDqOGeJRx8WNi
         RLmERVQHi2fbsA8p5VaAm2ajFK/aFFIGjG1m3lYzajH8PtCS1UoccZmotYlNFqugCiDU
         SOQzyRlF8cJmbxweUH2Gz1xqkUl6O7oTbYKxue5o6vjBa5MS8QiVUODJw8SbGo/BB1zl
         Bb0E69uDMm5Ni/w0fMlsc5HvNix+q1H+Pg8RI9B/HqIGgO4ZxBmVv3C5GIHjGvcPC/HA
         DN8AtXkke6TOnO76wpPYeN8QqR43yN+mVfERbRvuPiMsdVChcCsSr2+fXFfGkBCO3Rwd
         JB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790643593; x=1791248393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0ADxDwdLkQq+vcZGCf4NIyg5yF4IrOepz6gtzfzxe0=;
        b=nbZ3VV1elTNVP322Knag37gSrpDEK3DzGM5/FymHg70zA/NLnV7OmHuIr2LZbKvc1j
         6Lc/cVSexgo43FV7rfYJ1fP+8whDp4fmaU5qezaEJwY/pkQj5UNYd0xD5uoXq8n0LfHD
         fsb1Z0eBONwrpd+Re9S0NzQxWSiGrUibsU8Am0VpP5jxPpUNuCm5SWU1k+HGNamO+G2D
         UqPf3OiAjqP+puBIaQJ0IUxfO1N2BueX93Ba8ByCcDtAwmiTsmUyfQkIByp6fCB82Viq
         3ShyobavI+vPbxayogX9QqlABXaAJN/fq4iSxTDVCKzeLDOuZQiieTMnoX5P5Nrza5K2
         Xkwg==
X-Forwarded-Encrypted: i=1; AKwUvByYx3JBQJ8uiLZZOc44e/zCQFLb5ewpECNjXLy/uqD6SnEXxDU8P98ZaHBoqfrYLhPXQtqOtddA8dOqmsizm0Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzWBqg7B53bwQsN75evyFe6fcuiYQuQ8UZluwIMdiQYrp1tNJd
	isF4YejXnZDoCXNP7OEnq1uAL21F19nOcvaDgnuL1q68DouRDRkSPzuRy7SE0gWKgVAnAcWhGui
	nQ18lduHArReioQ0SoLKFkpaXrjyP00pJaj89RQg=
X-Gm-Gg: AYBFou1W8TkjXo3fjyKoBPKejhh+7qfXNFllfKSMchJQbEgD0HUPT3Mhfn36r6JRrF6
	tRR07f9Z0/wzRTcXJRbj3WY/A7MB1+bUsKCqog4vtI5wPTKoCtP2grrGjPT23ZuIMrykua7n4wr
	YFbzC/uMwVn44kJEB2EOed7wiwH6uyVHizUgASOQJiARtdt3+otxlAhGLzTrMPbOmrtrrg/Xifl
	avhAhELdFovKKmKwcPhD9dLd7d77LWmvwa7ZBge1oY7DS1J46qtzTdjCwgRLpR9gCVJTyNwE0Xe
	jkQRamsb+Mh75wE/GDc9vG5Y0JcA1xAIO6A3kLZSEDcH3U7OfP/ml9fZk/bcpZVz4a2susW6oMn
	UV7AWum85lPmX8P7JWik/
X-Received: by 2002:a05:6102:8645:10b0:7b2:3925:9587 with SMTP id
 ada2fe7eead31-7b23925a3b7mr2618011137.17.1790643592416; Mon, 28 Sep 2026
 17:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928231737.2092716-1-morbo@google.com> <20260928164235.041803152d3f340d4c59e59e@linux-foundation.org>
In-Reply-To: <20260928164235.041803152d3f340d4c59e59e@linux-foundation.org>
From: Bill Wendling <morbo@google.com>
Date: Mon, 28 Sep 2026 17:59:35 -0700
X-Gm-Features: AclHuK80UuTfMLELvaE_jdAE5HpgJUaUpVSxG6Fx0aY5YOmC9Nc8zrqkCvUINPE
Message-ID: <CAGG=3QXLkQKiwb0VfpfWKYwSEaBLp38FAo-P0Nja0Sq8CvBbNA@mail.gmail.com>
Subject: Re: [PATCH] kasan: add KUnit tests for __counted_by and __counted_by_ptr
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 4:42=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 28 Sep 2026 23:17:37 +0000 Bill Wendling <morbo@google.com> wrote=
:
>
> > The '__counted_by' and '__counted_by_ptr' attributes associate a
> > flexible array member or pointer member with a struct field that holds
> > its element count. Supporting compilers use these annotations to
> > compute dynamic object sizes via '__builtin_dynamic_object_size()' and
> > perform runtime bounds checking with KASAN.
> >
> > Add KUnit tests ('counted_by_flex_oob_access' and
> > 'counted_by_ptr_oob_access', guarded by CONFIG_CC_HAS_COUNTED_BY and
> > CONFIG_CC_HAS_COUNTED_BY_PTR respectively) to verify that:
> >
> >  - '__builtin_dynamic_object_size()' returns the expected byte size for
> >    annotated flexible array and pointer members.
> >  - KASAN detects out-of-bounds read and write accesses beyond the
> >    annotated count.
> >
> > Allocate the test structures in 'noinline' helpers and hide the
> > returned pointers with OPTIMIZER_HIDE_VAR() so allocation-size
> > attributes and compiler optimizations do not mask the '__counted_by'
> > and '__counted_by_ptr' checks.
>
> Thanks.  Are any of Sashiko's comments pertinent?
>         https://sashiko.dev/#/patchset/20260928231737.2092716-1-morbo@goo=
gle.com

Yes. I found a better place to put these tests. I'll send a v2.

-bw
