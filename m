Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646601FE47B
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760671; cv=none; b=sQjE5DHpCLGq2dhhh+2Sx49SqAJ3Olj6UmTSv5QMEXpbGblEbfRnE6OZpHWUpjWfX3mqsfn1RfaS17gpMIS+T6K7mLk2XyNEo3xy2qG5n2iZg/tNVQiUWBUXU5/j7nSeMql2hnP+p/X0xLkcFtdeXSLKcwNhqJIPxHvnoYTTnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760671; c=relaxed/simple;
	bh=v54A+/Zdu2HXbjttBWtYojGtMqKcYZlSqb3H23kTBH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MLGmCUmNIkT7mMlyXCPm60xqmKLzAFq2QVlsDLnkkpFxKqPBSbHWEh9yx7o51P7znzD+HPjxV1Z9v0g9UShF4IDv7zuuZ7I2sncdzENQjVj8xe++7Q/9JSHm5MeWTVmOK6VvF1kOai2zj6pZbs35HDG6TbLFBjzCN8AphZmJNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=c81pQGcj; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="c81pQGcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1781760654;
	bh=bQG6iJV+5JLdSLmD3sFrXrkeliBPtohtiawuJ67GHYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c81pQGcj7hjJbO2h9DxDCgV8IiBXFgjSXhWcGEok0EXBeY7Ku5droiDz61O1MkSZ1
	 bDNsJHrRGimbkwHeWFrupvHb9Y7l+r7GjJMno5Pe3H7qD1jkkAhBvx/7TKAsJtZjLx
	 5KJDyMVVWzdqnREmGGLHq9Cyjhn33MVroEVtrMqM=
Received: from [192.168.0.221] (84-115-215-85.cable.dynamic.surfer.at [84.115.215.85])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4ggq7y31fRz2xJj;
	Thu, 18 Jun 2026 07:30:54 +0200 (CEST)
Message-ID: <91666e2ff131490d75cf758182d9c47f723e2ec8.camel@tugraz.at>
Subject: Re: [PATCH] c: handle .ACCESS_WITH_SIZE in build_unary_op for !/+/-
 [PR123569]
From: Martin Uecker <uecker@tugraz.at>
To: Kees Cook <kees@kernel.org>
Cc: Richard Biener <rguenther@suse.de>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org, Joseph Myers <josmyers@redhat.com>
Date: Thu, 18 Jun 2026 07:30:54 +0200
In-Reply-To: <a54bcd41c5fc4f4550df157c00dab43939669b25.camel@tugraz.at>
References: <20260618051246.work.269-kees@kernel.org>
	 <a54bcd41c5fc4f4550df157c00dab43939669b25.camel@tugraz.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116


It should reference PR125604 though.

Am Donnerstag, dem 18.06.2026 um 07:21 +0200 schrieb Martin Uecker:
> I was about to fix this but did not have time yet, so thank you!
>=20
> To me the patch looks fine. I add Joseph (C FE maintainer)
> for review.
>=20
> Martin
>=20
> Am Mittwoch, dem 17.06.2026 um 22:12 -0700 schrieb Kees Cook:
> > PR123569 fixed wrong code with the counted_by attribute on a pointer
> > member by suppressing creation of the .ACCESS_WITH_SIZE wrapper in the
> > parser's pre/post-increment paths, and added a checking assertion in
> > build_unary_op to ensure no .ACCESS_WITH_SIZE call reaches it.
> >=20
> > The other rvalue-consuming unary operators (!, -, +) still
> > rvalue-convert their operand via convert_lvalue_to_rvalue, which
> > produces the .ACCESS_WITH_SIZE wrapper as before.  They then reach
> > parser_build_unary_op then build_unary_op carrying the wrapper and
> > trip the assertion.  A minimal reproducer:
> >=20
> >   struct s {
> >     int n;
> >     char *p __attribute__((__counted_by__(n)));
> >   };
> >   int f (struct s *o) { return !o->p; }
> >=20
> > Unwrap the .ACCESS_WITH_SIZE call at the top of build_unary_op via
> > get_ref_from_access_with_size.  These unary operators consume the
> > pointer rvalue rather than the pointed-to data, so the bounds-checking
> > wrapper is not useful here.  The assertion is retained: after the unwra=
p
> > it documents the post-condition the rest of the function relies on.
> >=20
> > 	PR c/123569
> >=20
> > gcc/c/ChangeLog:
> >=20
> > 	* c-typeck.cc (build_unary_op): Unwrap .ACCESS_WITH_SIZE
> > 	from the operand before further processing.
> >=20
> > gcc/testsuite/ChangeLog:
> >=20
> > 	* gcc.dg/counted-by-unary.c: New test.
> > ---
> >  gcc/testsuite/gcc.dg/counted-by-unary.c | 32 +++++++++++++++++++++++++
> >  gcc/c/c-typeck.cc                       | 12 ++++++++++
> >  2 files changed, 44 insertions(+)
> >  create mode 100644 gcc/testsuite/gcc.dg/counted-by-unary.c
> >=20
> > diff --git a/gcc/testsuite/gcc.dg/counted-by-unary.c b/gcc/testsuite/gc=
c.dg/counted-by-unary.c
> > new file mode 100644
> > index 000000000000..b16b819d63b6
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/counted-by-unary.c
> > @@ -0,0 +1,32 @@
> > +/* Verify that unary operators that rvalue-convert a counted_by-annota=
ted
> > +   pointer access do not ICE.  The original PR123569 fix suppressed th=
e
> > +   .ACCESS_WITH_SIZE wrapper creation for ++/-- (which keep an lvalue)=
;
> > +   the rvalue-consuming ops (!, -, +) still receive the wrapper and mu=
st
> > +   strip it in build_unary_op.  */
> > +/* { dg-do run } */
> > +/* { dg-options "-std=3Dc99" } */
> > +
> > +struct s {
> > +    int n;
> > +    char *p __attribute__((__counted_by__(n)));
> > +};
> > +
> > +int test_not (struct s *o)    { return !o->p; }
> > +long test_neg (struct s *o)   { return -(long)o->p; }
> > +long test_plus (struct s *o)  { return +(long)o->p; }
> > +
> > +extern void abort (void);
> > +
> > +int main (void) {
> > +    char buf[4] =3D { 0 };
> > +    struct s s =3D { .n =3D 4, .p =3D buf };
> > +    if (test_not (&s) !=3D 0)  abort ();    /* p is non-null */
> > +
> > +    struct s e =3D { .n =3D 0, .p =3D (void*)0 };
> > +    if (test_not (&e) !=3D 1)  abort ();    /* p is null */
> > +
> > +    /* test_neg / test_plus must just compile and run without ICE.  */
> > +    (void) test_neg (&s);
> > +    (void) test_plus (&s);
> > +    return 0;
> > +}
> > diff --git a/gcc/c/c-typeck.cc b/gcc/c/c-typeck.cc
> > index 6bce8c427543..0f96de200743 100644
> > --- a/gcc/c/c-typeck.cc
> > +++ b/gcc/c/c-typeck.cc
> > @@ -5779,6 +5779,18 @@ build_unary_op (location_t location, enum tree_c=
ode code, tree xarg,
> >    tree eptype =3D NULL_TREE;
> >    const char *invalid_op_diag;
> > =20
> > +  /* If ARG is wrapped in a call to .ACCESS_WITH_SIZE (created when th=
e
> > +     C parser rvalue-converts a counted_by-annotated member access, se=
e
> > +     PR123569) unwrap it here.  Unary operators that consume an rvalue
> > +     (!, -, +) read the value itself rather than dereferencing into th=
e
> > +     pointed-to data, so the bounds-checking wrapper is unnecessary an=
d
> > +     would otherwise reach build_unary_op while it is not equipped to
> > +     handle the wrapped form.  PR123569 fixed the ++/-- side of this b=
y
> > +     suppressing wrapper creation in the parser; the rvalue-consuming
> > +     ops still receive the wrapper and need to strip it here.  */
> > +  if (is_access_with_size_p (arg))
> > +    xarg =3D arg =3D get_ref_from_access_with_size (arg);
> > +
> >    gcc_checking_assert (!is_access_with_size_p (arg));
> > =20
> >    bool int_operands =3D EXPR_INT_CONST_OPERANDS (xarg);
