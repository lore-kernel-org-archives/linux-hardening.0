Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B059B668
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889594; cv=pass; b=ThMN7i6RSUKHjuklcfZ6m44qwLgJ5+JgSEBwbWfBKG4+8d69kj3GFFEra1S8+oTrJXfA97Ojwe04DoIVVEyeYGStSZQJLuP1FpmH+CqYb77BNlSssa9NkDpjf6jONqr0YzcnhWbsvIBtKvU4LcWf1eS0KAiY9rP6nhIMPzBxyio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889594; c=relaxed/simple;
	bh=zTx949XbmqR6qpQKYtG5ZH3ZNyvLQjleLfr40Xjf4KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REPH6tcDug3Gv41v2jN9aUnXVKHBUi6tCikukFT9GHwQxPpXuMl+p1h8oEeJ78IxeixDxEvAPmMoKpbtvQIgZ1O+S4+eX3gvnHVg4Lx+5SaPGBD7Zd//Javw9Hei+eKLXah7kvmTFUjcHw/kOF6456kA2W1N5rUf95YP3m9RNYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaM5l5JI; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaM5l5JI"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7855bfd6ab6so1356735137.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Sep 2026 10:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788889592; cv=none;
        d=google.com; s=arc-20260327;
        b=cGFH97S0oADHPxE8cUmeeGYVMYCxHLhsILGcqRW1GYu5euhYhhDD+EafKYbkRvCG7L
         ThTxXz3cr9GCwFzbJgNYCxAeVOWQNDTxkKBPN1l4huUAV35W+LA23utV63HJi74hRBdD
         XMlAGGl3n7BuSgztg7KNH8BZkMuXuTNAKG0Vc9Nf/sk1zjMrs2E8R3aPMVB87Z5k4bTk
         WlkAQ9C2I+mlDFdYyEI+TtiS2Rg1wd3UXjTB/owSFN8DYwbSky1qg3syQTiSTB7LxA6T
         HSW1MnGs84jaaUOnRXloeca2cBENbJWYaAOeSaDK+Or3PjAeybBiLXad0NDhB72ckzra
         rw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kPCalDfao8jKIEIfhb4jRSIfu+lDsUxUD97zK/Glsx8=;
        fh=JjDYT4T4+2AQHoa65Gb9TQnKgg8Tu8bdgtOHp9w5GCo=;
        b=cwNktv9Q0TPPtdla0QZKoNy+QS93faezJsSiqm03byWz/x/2Gxlf2Zitc5FLDV/D4G
         Q4bfVv9TSxI0K31Q9laaTmZEjoVdoG6IOEnn2LuM05RjwvZD503ElUMTz7sxspMPPhLx
         PDYfMpoCp1aya2mDd9VHqrmX4TKJzlnL987yoy5ka2UhxOVHtM+IKiz7b4P9PiPpLHae
         4ne7DVEJj/hYFj9+b7JfSeag8wr3hobphyCN/2boTbUM5htOEcI5JVyT4BHvi5V7/e39
         BkIkpQc0Ac8t4/jAQA9oSqosaQZVmT5IicbIT6E3B6u29xaDmh/OS57N2rGoOqQfNv+W
         COBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788889592; x=1789494392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kPCalDfao8jKIEIfhb4jRSIfu+lDsUxUD97zK/Glsx8=;
        b=iaM5l5JIfpDYUGqKBZrDYNAXMyev6XWNosOay33MUW4VDPixwZDsLBcy2bGezTh5sc
         UVZfod8HsT01fXTwEgZTlUvB/KfKq9+TTT1XCY/tqLB49zMLhrOva62crQ1MzYukrdx1
         UJrEe7oiAizwCEbaQNiGPSCco8JhREDJDzRKpZvQmLnrPkNWU53xwzlj9Ph/tgrLleNu
         QJAgNBTYAUrj7i1q91AfNqdlscqPdCE/fAU+4zG5bHlwRxORLGFqDBU2Fr59OYlT+Dww
         sUaaf+1puAQBHycPTGKTYmuW0WwsNn7xijVgcP2s5vi3BpD8Fru7huG1g8/gixbgTKkF
         0GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889592; x=1789494392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPCalDfao8jKIEIfhb4jRSIfu+lDsUxUD97zK/Glsx8=;
        b=ce3uA+OQS64AiL1BWLTzGfebrU0Uk5+bqrU/kgN6uJGXE8QAROH5GvqYHUJ2qagO4Z
         1wKRPfLqGovb1z06nmaXRsp+sxvZ0N7xlUoit5BHCJkeu3IlQHxRxA84BbEeyYqsbOi7
         z7Z77cnwGD6mu5J1gVeulM2rPhLU1OMoIzNZveCuJkfyC5XK4idXciXq6V/5qu4vr5b8
         oJ4nCP5XRn4ck9Kb9ECBJs51n7HLuBxCxGlYqu59mVhCyYoFMBQa5SmeZ98vPBqZ3v89
         X1I/KelKq1IXJ/WB0mbDqTmcYO5sj/S3dQ8PFasmybKdVnlNnOyMWKhiBg7oiEEtmRAy
         6bkA==
X-Forwarded-Encrypted: i=1; AKwUvBwrn6QeRQMX3cE9pfL9dx/p7FVbxhQzr+TyqQ9jsK/xms+s6dg/85iqB6kq3pzgw4+6P+FTLu3QQB2iYFv/QQg=@vger.kernel.org
X-Gm-Message-State: AFuF++lrVWlGx4NTwgIJRPfTNwIFj7otK+xMYFa0reyvB+/+c/+XFqwl
	6o++e8JYW3dMV6XTfoZzMXHeJ9slifXmcVJf7H22/24SY7+920X9bRRB7NPOWKCIBUUTNQut9MJ
	7KINtBleBsKYbOq2kAVKhdfQAztewKypaNHwvl/M=
X-Gm-Gg: AYBFou1cb9J+dtm1DedbMIinrQfvxQE2hYTDZpgzLRHNz4/wADoGDq+IuLqBq54Y7fP
	en9xOOtxtIkH6PWJYhGubpBp5ookLDWkZFByjsTvu78kOjL7d6gTzbVyoc3HPJ0gq0hSWWZA89g
	z1aeu+9VJ6dwRRDhgZW/mDljj3BLH7PiyPwMoCKkeutBL/QiKwj/rpFbCVEdSUse7RBij/HDah0
	dV5dqyYNF/eN0S3MDWQCRbJYxEIEf7CVOYKf26JaDinGaTo/XxC1FxBsDEdKLs9ZX8Yc2aOi67l
	nP+wWQaXBjm6O5u1Y43+iG+pMq0z4OQiRvknAVel7z//Ftj3uypWyuj3FrtPKWr6G3p2+dPIVIQ
	5M1oWrCQgZOhkiCT90CKJxKzp4IUsFoGgYhcNW8sbOA==
X-Received: by 2002:a05:6102:5091:b0:78a:8a0:7126 with SMTP id
 ada2fe7eead31-78a4aa97d5bmr10542013137.10.1788889590772; Tue, 08 Sep 2026
 10:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com> <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com> <202609041634.6429DB8@keescook>
In-Reply-To: <202609041634.6429DB8@keescook>
From: Bill Wendling <morbo@google.com>
Date: Tue, 8 Sep 2026 10:46:14 -0700
X-Gm-Features: AcwNN1WQOblEmTevCorxNEjZglo0ARJzg9aPL8KCbxvHTHINPMTy-U2-vlpgOf0
Message-ID: <CAGG=3QVSnRON0Qi6ZLhiJk8E8GyQdr+Xf+HKLp1szPVQ__fgsg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
To: Kees Cook <kees@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Aug 26, 2026 at 10:00:35PM +0000, Bill Wendling wrote:
> > Add a KUnit test suite to verify the insertion and sorting of mappings
> > in struct uid_gid_map. This test suite validates both base extent
> > insertion (<=3D 5 mappings) and extended extent insertion (> 5 mappings=
,
> > which triggers the allocation of the forward and reverse pointers).
> >
> > This is especially useful for verifying that the __counted_by_ptr
> > attribute added to 'forward' and 'reverse' pointers works correctly
> > without causing any runtime bounds-checking panics or traps.
> >
> > Assisted-by: Gemini:3.1-pro-preview
> > Signed-off-by: Bill Wendling <morbo@google.com>
>
> Various style nit-picks as dictated by
> Documentation/dev-tools/kunit/style.rst
>
> (We may need to teach Sashiko about KUnit style?)
>
> > kernel/user_namespace_kunit.c | 92 +++++++++++++++++++++++++++++++++++
>
> Like below's naming, this should be named after the suite, and in the
> tests/ subdir (even when #included), so it should be:
> kernel/tests/user_ns_map_kunit.c
>
> > +config USER_NAMESPACE_KUNIT_TEST
>
> The suite and Kconfig should match, so this should be
> USER_NS_MAP_KUNIT_TEST
>
> > +     bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT=3Dy
> > +     default KUNIT_ALL_TESTS
>
> I think you need a "depends on USER_NS" ?
>
> > +static struct kunit_suite user_ns_map_test_suite =3D {
> > +     .name =3D "user_ns_map",
> > +     .test_cases =3D user_ns_map_test_cases,
> > +};
>
>
"Roger that" for all of the above. I was waiting for more comments
before proceeding, but I think I'll send out the "visibility.h"
version, with the above fixes, so that we have something concrete to
discuss.

-bw
