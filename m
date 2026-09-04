Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6C517BA3
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554243; cv=pass; b=RCKMPWIiMq3F86Roc46xJ+M9nUqWMOMXp3MW1b6UqBCkzaDkoNqTqf4BnHEpoEFRvyiN16nfpLlsZivg2h76PiWJeseNhb1oQ9nHZiM9+SlT24fr0NVuoZVaQIDblCpDOdnQRa2+f59HWmnqpQkaIzV+NQRm9IuSTevrBEXnSYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554243; c=relaxed/simple;
	bh=hXqIs6NKWpjCgu2MVL74gvCX+fXPqf8iqn2c1Bg7qUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdksP69AaPpH2eelaTROws4kdOlrFbBZJxDvLoJT2/2MJ37KHsyClECP7OXl5t+gGXHNorGaHjUn9ypiTTAjJv1gst77oyEICM/55AvcLZAcF5nIdPBfC8Mwav/+7+OsnFfEOT5H6k1q5p3rCvf2UxO5WyjO3+8Z8LGJenJzOqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivYBEsnz; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivYBEsnz"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98076bb236eso772178241.0
        for <linux-hardening@vger.kernel.org>; Fri, 04 Sep 2026 13:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788554238; cv=none;
        d=google.com; s=arc-20260327;
        b=ITtSWK99Wz1DeCynZRboCnO8T/8gNRfkw4xBMfay2EB7zY/DyQ+IbvMc/mD6BcE8uI
         XvGqxRW+pQCVrBCF0nvZ8o1vNT6azSj5dTm8hs8R3NWnD8eyVyc4B2axad9fcEFu1e4E
         hWdU9cjr8tIOvNM+cHmgfWLvaMh1htlc6bWPQvASO2j4ks/lV6SdULD1IX4PdIf+jrUN
         Z3Z3KvY3IRqOLjOgFu73cvnmU3AnFRxapeEZN4hQZwCNTr0xOXz/QxfWyVy9HTZcOsgB
         oF12hsNgBqaoPGyiLO6FvMgOO+V8B0Hc1Zp/14ImiEQxTjtJUrU6Xh6AYSo3XZve+tEB
         V7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gUtXqmfjcs6ycFdx5iUr4K9C9AZKEG2ScK2idEW8YAY=;
        fh=Uj5H+6jmySGpKYJMc3t7U8oEPzO94ZF9OBQGj93woEQ=;
        b=Ac+sOgLZ7BvuFShEmWgJsrcdxZnyzAJKmg/n/RaQ9Jfe1KWfzHuh+p/TpAJU3UzoUh
         xnjoiCrR3dPrK9EfdHXsy2FjaDnsCKd/ASTNNXzMUjZKlEfoNqe2jkqQPNwfr2litCr1
         1YzZQHxAHGajkjgPZFj7VxMYFLJpZ4WhULpNOw5/OC0JWEk5IIVJ3SAFwpbd4V/9a6JK
         8+mZiMlzl2KgZgAH4C0zlAP2HqbzwtnuMBRp3GYcH4oK/I+tplWfW0XqApUHMrDH8x1S
         SQgkyd0mKmS10J958qHB6zs7I0tATSZ6ybY5hwncSHeyPW3tA8C/y8vLS5jnnHhSiZpr
         YC9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788554238; x=1789159038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gUtXqmfjcs6ycFdx5iUr4K9C9AZKEG2ScK2idEW8YAY=;
        b=ivYBEsnzKXBuaV89QEQvfR29XHJ9zLCrVNxxvHPWAiUL/KDwLjrQ1hw6WzXDdV7/tk
         8gRJUGU7bxUoeek0KyyE4V98i7drlR/cfljpvxjOAM8DeOpMfrbKCDWjuFW8HSOTgX9z
         2dvm+rwZKUitDn82QWmVWAbdpXgycj46B7UHFG+7+G87W/Pl2a0vWbqSLc3MCqpkgzF0
         K1BdendvVN0CdKawmDBjKRbhUJdW3I7jnIxjuLIe9EE9JmxNxPZspIl3r19SiCWsNblo
         jyuK2hrr7gD7OTZwThpp5Nz2o0PEVbc9lJpjfHI5zCsRFL5imKk3o71MpBrxchYBkZnh
         MnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788554238; x=1789159038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUtXqmfjcs6ycFdx5iUr4K9C9AZKEG2ScK2idEW8YAY=;
        b=K0q+aQ/4Wv+IEo1KebkQEjhazOLXgFYvkwsMh3/IxQCl2e9nUOla8jgSqi3TpRdNB9
         QWF2+EP1o88Z85rhk9SJkVFylscvXb+OTAVhVRYdh9JysWNPYAp+EB7vdMmQBNjPMWFo
         xd661r+0oWZpgy0A1Hh3h14BkUgN7Wu+yCcDEHSp52UGgKK/ujnueIbDidx4P2hdeSRp
         zAzYfqHFSBY4b8/uUaDQ+bckX7Pu9wLLmS/rCNBDVKfp/0xh6UMadhRFFIODXBHfsjaa
         YaaHyTGOXegqDuo2lXdO4tkqf/mEb3pB76KdcyEgQfBRcaxswL5Lutm+8GLsl6xxOtiS
         GwRA==
X-Forwarded-Encrypted: i=1; AKwUvBzYe7lpeqy0/mgJjZvxzgfC83zlpZahJGCk9mhtC+zWR/ENp8u5Y/YTHYpo6E1HHtZ+J7H67Dl0haiTDf55m74=@vger.kernel.org
X-Gm-Message-State: AFuF++ko+/0TidtSFMDTlWdOlgatIRWrG/i4W7AlgrzqzQ6w6QemRA9/
	8LrZEDG7KJQ5/l0Q2C71G+JWdZhKCLSfIfG78Ns/0cfsEwyTHwKuhgIb/xfG2IXf2msApXLo9ws
	74t+LO3jthP0VW00AVUwdXHbT/A91SCPmRidJqI4=
X-Gm-Gg: AYBFou3kkZdYwgknTF2VRe4vd/SpKY2wNzJ4Haq9044FCSLdEeZ5vFg748Zg27tBIxL
	P5K2OAZ/JrxnFN/3XhMh6GqVDrzBOkUwIOuGdRQxFb/rL9qVI7h/8+hD/twliySXadEmqZ9GH4/
	lko/nZwjPWbJRBczelx6MAfzRSJdQS1/Si9Hc3FHy0d3OSq4PMww4eiZY812x47OnJmD4pDzXSC
	jdTBgwxsPcT1Xh7NYOYp9hH+MpG2/Lm6zA0yzRyeQkJcjNw95Km6aOnG8SHETxepYvcZhULcoTO
	VEDq9svhGHyMjq38TkOUuO9p5GjyW7yDFZeOx9gDxrpW35MmYyOxH8woWnTbSqCGQ+PuHzZBdYN
	HVQLJ0vlNaRpCl8p8jRiArA==
X-Received: by 2002:a05:6102:8023:b0:789:5fc6:3693 with SMTP id
 ada2fe7eead31-78a4a6f8278mr3111487137.6.1788554237103; Fri, 04 Sep 2026
 13:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com> <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com> <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
 <CAGG=3QWPTL5z8MfAxJLpHb0P-3Ah6K+FzgrVHyRRcvRK7-6dSA@mail.gmail.com>
 <20260831111423-400ed79e-6e52-438c-aa9f-f289e6dbdee5@linutronix.de>
 <CAGG=3QUAY4BDiJM64uTX8C1A2WPg6dPRexbgUQZoi4QKkkpP9Q@mail.gmail.com> <20260904091410-3a87d211-edf8-4ead-8b91-004a4a96a161@linutronix.de>
In-Reply-To: <20260904091410-3a87d211-edf8-4ead-8b91-004a4a96a161@linutronix.de>
From: Bill Wendling <morbo@google.com>
Date: Fri, 4 Sep 2026 13:37:00 -0700
X-Gm-Features: AcwNN1XImuKrmCltho50p6HuLyQptPS-JDyeDNoxsWcoVgONU3oXxirpNjdJhYM
Message-ID: <CAGG=3QV1G0=19riYPPWhTXrW2X0YvyESdY=GesWm2F_8FEZwMg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Bradley Morgan <brads@mainlining.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 1:02=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Thu, Sep 03, 2026 at 01:21:27PM -0700, Bill Wendling wrote:
> > On Mon, Aug 31, 2026 at 2:22=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > > On Thu, Aug 27, 2026 at 12:27:30PM -0700, Bill Wendling wrote:
> > > > On Thu, Aug 27, 2026 at 6:37=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > > > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > (...)
> > >
> > > > > > +config USER_NAMESPACE_KUNIT_TEST
> > > > > > +     bool "Test user namespace map insertion" if !KUNIT_ALL_TE=
STS
> > > > > > +     depends on KUNIT=3Dy
> > > > >
> > > > > Urgh.
> > > > >
> > > > ?? What's wrong? It's identical to the conditional for EXEC_KUNIT_T=
EST:
> > >
> > > Sorry for this non-descript review comment.
> > >
> > > > config EXEC_KUNIT_TEST
> > > >      bool "Build execve tests" if !KUNIT_ALL_TESTS
> > > >      depends on KUNIT=3Dy
> > > >      default KUNIT_ALL_TESTS
> > > >      help
> > > >           This builds the exec KUnit tests, which tests boundary co=
nditions
> > > >           of various aspects of the exec internals.
> > >
> > > The problem is that KUNIT can be built as module, which would prevent=
 this
> > > test from being built. We have include/kunit/visibility.h to export c=
ertain
> > > symbols only to tests and avoid this issue.
> > > But I can see that some maintaines don't like this pattern, so maybe =
they can
> > > chime in at some point.
> >
> > Bradley commented on this earlier (which is why I mentioned EXEC_KUNIT_=
TEST):
> >
> > <comment>
> > The test is #include'd into user_namespace.c, which is builtin (USER_NS
> > is a bool), so =3Dm here still compiles the suite into vmlinux. With
> > KUNIT=3Dm that calls kunit symbols that live in a module, and the link
> > fails. Make it bool and depend on KUNIT=3Dy, like EXEC_KUNIT_TEST:
> >
> >  bool "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
> >  depends on USER_NS && KUNIT=3Dy
> > </comment>
> >
> > So there's a conflict and, because I'm not a KUnit guru, I'm not sure
> > which way is "best".
>
> It's subjective. So as mentioned before, the preference of the maintainer=
s
> should go into it. The aproach I prefer requires a bit more setup boilerp=
late
> but make the tests usable in more circumstances.
>
Because user_namespace.c is always built-in (USER_NS is a bool),
compiling the test into vmlinux causes linker failures if
CONFIG_KUNIT=3Dm. Using the "visibility.h" version also strips static
from insert_extent() and sort_idmaps() or exporting internal user
namespace functions into the kernel symbol table, which isn't ideal.

> > > > > The extended test below already tests everything the 'base' one d=
oes.
> > > > > Do we need both?
> > > > >
> > > > The one below tests the sorting algorithm.
> > >
> > > It *also* tests the insertion, no?
> > > (Especially if the conditional on UID_GID_MAP_MAX_BASE_EXTENTS is rem=
oved)
> > >
> > Correct. So there are three types of tests we should run here:
> >
> > 1. Insertions and accesses that don't go over the initial extents size.
> > 2. Insertions and accesses that do go over the initial extents size.
> > 3. Accesses outside of the number of entries.
> >
> > Test (1) is a "smoke" test, where the struct is tested and no
> > sanitizer code is used.
>
> A "smoke" test is useful when the more complete tests can not be run regu=
larly.
> But here both test cases will always run right after each other. Test (2)=
 is
> just as cheap as this one.
>
> *Not* testing the overflow checking here sounds also weird. Test (2) will
> excercise the same code, which is not using the checking, anyways.
>
I suppose this depends on one's view of how testing should be done. I
prefer to have small test cases which directly test a specific
feature. Other test cases would still run the same code, but they
focus on features. So yes, the same code is ran many times during
testing, but that's fine, because testing is meant to test one feature
at a time. The benefit of this approach is if a test case fails, it's
easier to determine what feature is responsible.

> > Test (2) makes sure that we can still go over
> > the UID_GID_MAP_MAX_BASE_EXTENTS size and the sanitizer won't
> > activate.
>
> Nice.
>
> > Test (3) (which I'll add in my next upload) throws a sanitizer exceptio=
n.
>
> What is the point of testing this specifically for user namespaces?
> Normally we expect a used subsystem to work as advertised.
> It is that used subsystem's responsibility to test that it does so.
> If there is currently no test that validates __counted_by then it surely
> should be created. But not here.
>
This would directly test that the attribute on the struct field is
caught by UBSAN. I'm not sure how we could more directly test it
otherwise...

-bw
