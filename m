Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620044E651
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776826; cv=pass; b=SVPPdGzyBYcW4sPLl77bWvKQREQfcAqxpeN9XEP5e9yGptfUQUFquku7Q7jKAhSWt/Xi/QJxWmQE2DHPqO/zppy+CAZ2tKwmnLuiuVWbdLXEfcqrVffrBynzh6QkZ2CZdhNhy7X4GJZFnFEdIsRQ8/Jf41CMF2Zvj+bmnSJfEN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776826; c=relaxed/simple;
	bh=DLRhVFUdg+p/7Ncqbi3cT+hpMW0oIOjZT9fcaEqNBng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2tDqHb608+FrdsE5fQhmompEF6uS879JW5jHHEvqChpK19gzGcZzkSqv4TRYSdJv5LkhkygqOzx/f1dy/oC/Toayo9SwuYDFHcfZmgnSZ/ANrYorUk41TZ3QBCKMi6Sva7cZKgPdt+uuNgFGZn7P/Wx7rMUnU9tOMLoW0MEV9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeGcgsP/; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeGcgsP/"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-783a121c597so622891137.2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 13:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787776820; cv=none;
        d=google.com; s=arc-20260327;
        b=biwwAB6RiK80Q0FKdk08MJQBa0A7k/2UhSUJ8GvrU7Qp/cSk1cdQzBMK2Opugdeeaz
         1o5b88AUgcw8r3rHSDoKVeMhFpVqxFPXS73Zgwx5DBtC4wRce/7POijAao3bzLXOPGtf
         W+luDUH2Q7PNhTTJSvUrIRCOZXQibz1/0AXIV1tBy7L8hCZG2srdOo6mUftJvjiYUs8P
         1OXb6G2xqRgE3logklQ/Q4WacPYGx2ZmXWqvdWLdJfVC4QjpNs3TIXPz1N/FYlPmn0FR
         sS/QweV5/rxnVfEwm/L56XlYnAq2o1ZkV7DqVA3lZ4aYl/IT3GFBwdZ4vPMnuIE3hlD+
         Ba2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lB1QrtcktRM6zvfmeGkEq0i93fG3paSF09YYzfmPgSY=;
        fh=jJiU9n7ymJvSF6mijdZI8AgJVwGw9yq9JMnbhVK4aog=;
        b=EQs0Ir7j+MQh7X6tqF0eiBUBUA3kXiXp0wKCCXN8sdPOoC01rHlymL2n3ldIzQe+Lb
         /3GSZQqeykcb6UFEG5xw7J/MGFna49G53Sy8JH8YMoGtL0GrvIWWdyXMmye3EFaE+ZNj
         HXl/JRBv0CU/nFlYdVUyEawQJxrTL6E+lzB/RCby2KbSbqxJYfZi2wDFd2F5TxdXXyZN
         MK2xhaRovhg85YOYSu88zpZN7OqFTRpodwudKAML2Y/pszIB2XRt5fZAqVBknuD7Sx6W
         hof0dI3RT+AhnDy9Hqy9ouY/mZEWFgx555bSGKG0JVwbq/WlU+Rm8T9YqFJkMgenLqUx
         3VmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787776820; x=1788381620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lB1QrtcktRM6zvfmeGkEq0i93fG3paSF09YYzfmPgSY=;
        b=JeGcgsP/jcNsg91bIjD229nF878UYWIi5aNa1V8P0NoUPD5cRCKKSKJ3PXfRX0suMW
         jB+LrRhIDePOIqg4iWYbLOF0UXN/okuE2gCoiY2gALKcRKOdyT9dWLJrRvgbSUaygGlM
         yRNH74uAOHCw3DWFSCxMvvU7ecCLjWMAjYhV2ao43lLJpj8ZX+u1DQ4U0APjCJO20+1l
         GCyz9nnB6vKBDOTdmXMwTAgNaIYiIzSlCV3cnZwImZjrS/lDEQ6U//6osG+emCvoyFDO
         BPRinfXKG1j3LmwyL7KrgmQ3I6EBS1+imsidsvcImC8ADrG46lqB1tIERYo8tNO0ZPJP
         WzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776820; x=1788381620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lB1QrtcktRM6zvfmeGkEq0i93fG3paSF09YYzfmPgSY=;
        b=UhveEvKXgPPFzEOCNjDSG6zifKcZH/+Dlp55zwZBmLIKssOdBEn3m8Dyq77GyCeLfk
         i/ev2h9XEKJ1ZUMh+v+2br08OwwZf9xs9nBLS8mxmP9rs6GvPExuj0clLzzRoig6+KOY
         gZM7YBNkdl1lmcy359HaIf1QFPmPXxdzwZJQtp9yJ+Biu8LcGt4Im4I93nwZRM4cmjuw
         nADWBHoFxfriO8/S+JXhzwv+PMYmoI3clil5e5dHO17R8VSFFEtKmpKpukblUEP1OLOm
         a3jVJteEvBXTxDo6+o5cFpgreYJAYDHQzEW3+z0JHxfpCatokQ+oRzv3sNjgVsWHClaS
         qW7A==
X-Forwarded-Encrypted: i=1; AHgh+Rqad+RMMLiKGarSByvIt5oO0Ij0qYTj6lX4XH0vtY9B0CmE5lpQC+1BZ1GCoQ0B9nRelDIGDJChBhviDMV/FbU=@vger.kernel.org
X-Gm-Message-State: AFuF++lI7Xoo0DbaD4HX8G6WRhATpOYQlzsQwB6BIahGbbYUMO+wroyL
	tV5EJ7SrnGQ4fN26tOQsz3PQ/HeLtcJVag5ol2OgIbEUAViulmecDIhjLUahQbGCfOw8iwhjL9E
	KivZeul6KXk59tci2bweWObmscZGaP9+hsuEkkr0=
X-Gm-Gg: AR+sD116s3fCFmVDI/m4/xriZwy6JW0nNNwrg6TQ5jNTDN0rEHB/dMWQcAJNBIvq+YL
	CbQxy6PM9cyX57pZFeQyhYTeLvut688cPu86LfN7ciAjINkPvLvGCb7e5gd85G09a1GdDXwOaoT
	2UxDbGLJVPbRtMGeBjKdioI295MOkRRWDulLqkkbY1SjvCv8TJSZrLzYUjsiliT4cDaWpIG1L6a
	tJAnX9E8vTWpw4bWHCU0KxJYw+URE7D1Kz0eDfWxMfS/08RoifRCtjk6lWpCUUocmqSehI+9Of8
	XT+H3zT+wDzDONv4hYph6FVIhdyrjT2HR3tfjFvURKYViJy54D2tXbjd+J5grXTCeS8qtt9Nvsh
	kR+ddWaFU24InH772tOASe/1T/issNBymVoBkRFQ7BA==
X-Received: by 2002:a05:6102:448a:b0:780:31fe:bcd0 with SMTP id
 ada2fe7eead31-782c0bfd665mr3789233137.8.1787776819645; Wed, 26 Aug 2026
 13:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com> <20260823125155.1136740-3-morbo@google.com>
 <20260824080214-8b12767a-8b04-4344-b48a-cd2966ad36de@linutronix.de>
In-Reply-To: <20260824080214-8b12767a-8b04-4344-b48a-cd2966ad36de@linutronix.de>
From: Bill Wendling <morbo@google.com>
Date: Wed, 26 Aug 2026 13:40:03 -0700
X-Gm-Features: AcwNN1XcBuT8Hu0A7Z9qKDs8wo_Jfo1FVXqJxHd5jnUUUXSA_JKZFdnR9NqrXew
Message-ID: <CAGG=3QUCowcrBT-7ZUyOOrX5fjQtFSmRyqvnYkZX0tO9+MKp+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] userns: Add KUnit test suite for uid_gid_map
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sun, Aug 23, 2026 at 11:13=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Sun, Aug 23, 2026 at 12:51:48PM +0000, Bill Wendling wrote:
> > Add a KUnit test suite to verify the insertion and sorting of mappings
> > in struct uid_gid_map. This test suite validates both base extent
> > insertion (<=3D 5 mappings) and extended extent insertion (> 5 mappings=
,
> > which triggers the allocation of the forward and reverse pointers).
> >
> > This is especially useful for verifying that the __counted_by_ptr
> > attribute added to 'forward' and 'reverse' pointers works correctly
> > without causing any runtime bounds-checking panics or traps.
>
> AFAIU patch 1 is supposed to not change any behavior.
> You could move the unit test to the front to make that clearer
> and also validate it.
>
Patch 1 generates code to assert if a memory address outside of the
bounds of a pointer is accessed. So it does change the behavior.
Should I still move the test case?

> > Assisted-by: Gemini Next
> > Change-Id: If0c2c197a35cd7429cf0d2d6e3b33f0d9f0be66c
>
> Change-Id should not be used upstream.
> See Documentation/dev-tools/checkpatch.rst.
>
I had removed it in v2. :-)

> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Nicolas Schier <nsc@kernel.org>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Anand Moon <linux.amoon@gmail.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: codemender-patching+linux@google.com
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  init/Kconfig                  | 10 ++++
> >  kernel/.kunitconfig           |  3 ++
> >  kernel/user_namespace.c       |  4 ++
> >  kernel/user_namespace_kunit.c | 87 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 104 insertions(+)
> >  create mode 100644 kernel/.kunitconfig
> >  create mode 100644 kernel/user_namespace_kunit.c
>
> (...)
>
> > +static void test_user_ns_map_insert_extended(struct kunit *test)
> > +{
> > +     struct uid_gid_map map;
> > +     struct uid_gid_extent extent;
> > +     int i, ret;
>
> (...)
>
> > +     /* Now sort the map to set up reverse mapping */
> > +     ret =3D sort_idmaps(&map);
> > +     KUNIT_EXPECT_EQ(test, ret, 0);
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, map.reverse);
>
> KUNIT_EXPECT_*() will *not* abort the test when the assertion fails ...
>
> > +
> > +     /* Verify sorting is correct */
> > +     for (i =3D 0; i < map.nr_extents; i++) {
> > +             KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> > +             KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
>
> ... leading to a crash here if map.reverse is invalid.
>
> To also abort the test on assertion failure use KUNIT_ASSERT_*().
>
Roger that! I changed them to KUNIT_ASSERT_*.

> > +     }
> > +
> > +     /* Clean up allocations to avoid leaks */
>
> Pointless comment. This is true for every single call of kfree().
>
Kiboshed.

Thanks!
-bw
