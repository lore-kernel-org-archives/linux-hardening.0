Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0871E32B7
	for <linux-hardening@vger.kernel.org>; Fri, 21 Mar 2025 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524928; cv=none; b=SfdCqwSYGpFJrfzTsrRxjh/MgWwJeMPcTirbGpByKtSxRCfIfW8tgwzwWCW5xKLrqEsMoA7ruW6da8TP9Uh1RElYqmiuED5rsCrMLzDaMKNJkwFNjBHgWUSKA7dWObRGLJexbw/bqNWwo+HjOf2rQIksXksMnrOE8fUlgSgGWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524928; c=relaxed/simple;
	bh=GqXRT9Mj0QQF8+zoU//BIotvHNU6s/WomEB85g4+M8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmZ+a1dnhPCzbRbDxE0tgL2f05IjG8TIUUIFcYjw/qlnkUMYdER+XYoUyfxc/xFBrn2wqqpotSchv2pIBzQrfm2ezs0fmPTKjmgo4BDF9kwgJwkEdhYZaDjhIN18HWXLrRRvYiyuG3f10/yQXOzRseg4vJfe4dUgk7ELb/DYSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNAu3Zw7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNAu3Zw7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so5433a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 20 Mar 2025 19:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742524923; x=1743129723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O8FFjA3hcgQ8XDHydtzreoc5IOsI1FD+LSzQZJbGkI=;
        b=MNAu3Zw7IncQiRxhNZx1NpYjESDIjcrvCCU6F66d/xbcHM3RYiGD2dr39iD1p7/RJT
         HiE69v/ZEcsj1yMwUzcTO8HHdUIzpxiUYMrzt0thiaEjSKS9ZMTt+9WAiOuwbhEfQDTL
         Te0M9CHefiLUQiqVcwej8nQeG+w4XrwWDWBzx+dMTBaHWVHebk7SIV96NP7ks5M3zSyB
         ZObM2rIKluqOLs8LB6/mKu+ZnOYcg9ya02rHYPfafOZU9zx/ncHAE/VpPcS3gddYHFe4
         mZQHVH4z+zZ0/jC3/6sHWofPmfRWfR5QLoEIGsAkvkyM0WYMK/e+sH9dFxM6f3XOsOn2
         Jflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742524923; x=1743129723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O8FFjA3hcgQ8XDHydtzreoc5IOsI1FD+LSzQZJbGkI=;
        b=NxXGe5yhk9A+9hl3FsrjhfkNVkNVu1oZPIAY/CTrsT98Z2Pto0FlqTC9Fua+Hu7FYA
         nZYoqLJv9ZkVyZUO7Ymjp3Qeqz77kZFBiBwbQXoPuqz5FT6nmeB0058XDrPzvRGdta2P
         CX/6PNrx9NGi/30gmb3jF5zscdWDQOAm3nuDFwgAfGdwjqx1rNAZCA23GqWeWs0tGaed
         Ss6YBx1YIWtImAp0lUly9H2JVEEWuy7yLQyL17jETiaNajQsb4q01VnZSC5wKCZNp9xX
         csor6fOJU19xqAO2p/JEtrcCHzWwZ5EXtcf/XCR5kzGqhjtJ0tnT4vPKtMlIfMFgeogD
         jF4A==
X-Forwarded-Encrypted: i=1; AJvYcCWOqdgDiUgP6AnagQK5HHoIog3DresFKGqSUyl5b5EHP1ISOfX/Zw95Z2X7iFru7FGuHAugyHL5n+3RUDcRakw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTdi5zS9audafq4j3r3QYRGiMYvTE7D29T55J7DJlPhFriJuP
	RIEeup136x0iTT4g6x4wRlEHF+jcaYHpwjQwgJ/JPBGLaq2ZXsiqPsPoTT85zBxIoutsyoMZdmB
	j0ro+sU72t7e4dHtP1//2SmLZWoReWJU7a0vA
X-Gm-Gg: ASbGnctLdvq3r5YmkyXKD+ZAQTfT6OCm1DV6NF5vmsr/ERJlBYDovEnAvWFEAxIv3xG
	EowXe1EDD748PxeGlUeB4xdBhiuEWM+OImphLsjveXPx3PxPCi4qvLK2YUWypPzOkgkX/A9eTXR
	kvGFzEE+SSPQw6dqmtaLBtU/13fH+Xvv4N1oa6SgnSmO+fBXZcOFfc+qY=
X-Google-Smtp-Source: AGHT+IHOXKmMdZDx/zHgype/m05qi/GswNz7l+pOv7uCTCxdggJGQMw2FvJ3qLXemOkS/xcOSlApQYGzrEpAGMI2DMk=
X-Received: by 2002:a50:d607:0:b0:5e5:be08:c07d with SMTP id
 4fb4d7f45d1cf-5ebcfee3421mr30310a12.7.1742524923099; Thu, 20 Mar 2025
 19:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318214035.481950-1-pcc@google.com> <20250318214035.481950-3-pcc@google.com>
 <CA+fCnZfG79JmGG9rj7KbE=9yX-EM4e8CXDSm5F9=YEmgyX5v3w@mail.gmail.com>
In-Reply-To: <CA+fCnZfG79JmGG9rj7KbE=9yX-EM4e8CXDSm5F9=YEmgyX5v3w@mail.gmail.com>
From: Peter Collingbourne <pcc@google.com>
Date: Thu, 20 Mar 2025 19:41:50 -0700
X-Gm-Features: AQ5f1Jr2sdg2WCeju5nnmXrNh9jqK16Q_xv8y9FFZD-yPNesP3YY2srT1TECdII
Message-ID: <CAMn1gO4k-d+8ZwndJhF5Sudr+kWDABe+3Wq=iBhcg3tDwJ60Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:25=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail=
.com> wrote:
>
> On Tue, Mar 18, 2025 at 10:41=E2=80=AFPM Peter Collingbourne <pcc@google.=
com> wrote:
> >
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > When we invoke strscpy() with a maximum size of N bytes, it assumes
> > that:
> > - It can always read N bytes from the source.
> > - It always write N bytes (zero-padded) to the destination.
> >
> > On aarch64 with Memory Tagging Extension enabled if we pass an N that i=
s
> > bigger then the source buffer, it triggers an MTE fault.
> >
> > Implement a KASAN KUnit test that triggers the issue with the current
> > implementation of read_word_at_a_time() on aarch64 with MTE enabled.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Co-developed-by: Peter Collingbourne <pcc@google.com>
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a2=
52274120e77b1898a
> > ---
> > v2:
> > - rebased
> > - fixed test failure
> >
> >  mm/kasan/kasan_test_c.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> > index 59d673400085f..c4bb3ee497b54 100644
> > --- a/mm/kasan/kasan_test_c.c
> > +++ b/mm/kasan/kasan_test_c.c
> > @@ -1570,7 +1570,9 @@ static void kasan_memcmp(struct kunit *test)
> >  static void kasan_strings(struct kunit *test)
> >  {
> >         char *ptr;
> > -       size_t size =3D 24;
> > +       char *src, *src2;
> > +       u8 tag;
> > +       size_t size =3D 2 * KASAN_GRANULE_SIZE;
> >
> >         /*
> >          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCR=
YPT.
> > @@ -1581,6 +1583,33 @@ static void kasan_strings(struct kunit *test)
> >         ptr =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > +       src =3D kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> > +       strscpy(src, "f0cacc1a00000000f0cacc1a00000000", size);
> > +
> > +       tag =3D get_tag(src);
> > +
> > +       src2 =3D src + KASAN_GRANULE_SIZE;
> > +
> > +       /*
> > +        * Shorten string and poison the granule after it so that the u=
naligned
> > +        * read in strscpy() triggers a tag mismatch.
> > +        */
> > +       src[KASAN_GRANULE_SIZE - 1] =3D '\0';
> > +       kasan_poison(src2, KASAN_GRANULE_SIZE, tag + 1, false);
> > +
> > +       /*
> > +        * The expected size does not include the terminator '\0'
> > +        * so it is (KASAN_GRANULE_SIZE - 2) =3D=3D
> > +        * KASAN_GRANULE_SIZE - ("initial removed character" + "\0").
> > +        */
> > +       KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
> > +                       strscpy(ptr, src + 1, size));
> > +
> > +       /* Undo operations above. */
> > +       src[KASAN_GRANULE_SIZE - 1] =3D '0';
> > +       kasan_poison(src2, KASAN_GRANULE_SIZE, tag, false);
> > +
> > +       kfree(src);
>
> I have trouble understanding what this code is doing...
>
> So the goal is to call strcpy with such an address, that the first 8
> bytes (partially) cover 2 granules, one accessible and the other is
> not?

The first 16 bytes, but yes.

> If so, can we not do something like:
>
> src =3D kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
> strscpy(src, "aabbcceeddeeffg\0", size);
> strscpy(ptr, src + KASAN_GRANULE_SIZE - 2, sizeof(unsigned long));

Yes, something like that should work as well. Let me send a v3.

Peter

> Otherwise, this code needs more explanatory comments and it's probably
> better to move it out to a helper function.
>
> >         kfree(ptr);
> >
> >         /*
> > --
> > 2.49.0.395.g12beb8f557-goog
> >
