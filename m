Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26B3D6484
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274096; cv=none; b=i7EhBenGlbFF+OQgPRqYuaybx7aGLuYq8dKBOXUMtq7fuCoFSRQMsJmgAB5HxLGXYw/82jrJm5sCeeCOezrZGmKJGvHsQQ6UlJDGWlcKB/wQkYaSNGGkSkb1SlKz0u9Hn7IYPo8cUXhb842avrtiEKRMZxmOA67dBgsM0jfm6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274096; c=relaxed/simple;
	bh=cJw40BTd+8MV8SOzfIm55naJLTh9TRdvvh9+bLZT8vU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gQS3Xs0IqGYTP2xHUCzcQbHqEB0dbWeO13PAZfs6Afy2kielS9lmNxiRraz6uuNyAb2hfEFHNN1WVG8zPq/r1TRSDBRblPJ/YeumhzerFrYb3oOqQJHhYXZ0AaCEdqWLyP0G4u8xPXxIWziXCRyjOKfc9JY3/qIjVu360FXR/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3mYI0ft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3mYI0ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FC11F00893;
	Tue,  6 Oct 2026 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274094;
	bh=iiOXzSA2iRIayYD/KFf7MAtf5CePax6vsVXarDyyXKk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=g3mYI0ft5nlmeHmCa6HWlfjSqyWBtEVmg4waJRnfNdCmU6lWHEnM+bmIY8mr59zzs
	 c8P0+M95BJvEqXTt3c/J2o9jl/GF1/Lv0mqu5lrX9q9MJ4I6zVZaORM5WSd9UhEl0K
	 q6bVjdAYj6jZ6PNcrG1bOUzQaLVMaWJnCb+R4iu1FpAjzN1e7Z9jdSxIFckAhMzT+G
	 rNT/7D2z3Mc5RV3ydlMY6SQ608dw4CZQ80tsroOsFcMehzqMmeh35uMeX47G15V4tM
	 b3qLdbt4YIY4rZRYyOQGklToTxDpkzdwZp6aClQtRk8OoLIR8D3evKe8K9brWy6eLI
	 xfV9iN2/qYeXA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id A5EE3198003A;
	Tue,  6 Oct 2026 04:08:12 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 06 Oct 2026 04:08:12 -0400
X-ME-Sender: <xms:aqzEat3SV1L-iM4EpYFhQ9eDlxiPNJ5xh1qlZ3ve-5hRp9KkE0jiXg>
    <xme:aqzEau4pItyN9RZ_Y0mNmMUWQcxbz2lpHQ2cf21pLqNJPbeE7EcGn1VDeJYMsw5Vo
    1jR294sEZZDCvKhPYAGYXd30iHOLDotrSsdfuuJ6jRfA9ktuITPXNtX>
X-ME-Proxy-Cause: dmFkZTFToCI5pFS3yTsMz7zpkmo/kBWxYnz1cVpf0jsW1JwGAaMTw39F3bxo7/7xJ2OsRZ
    j3pRAYO1cHgimYl/iAvmdQ1ATZh/ihFXI91nvq94FneGbk59cr5nAgNnUl3nA5cd40YFpL
    hMIFZUjiw/9+Q8MVkt7D2n2li7y6RFO2RveA1SZxyYYzFAVGbBB81LaYDGEgxbaUYgk/y2
    VPEewPb51GcCiqOV2zFej+H+VWtjFtGPofQF6nWrCVIVyriHYiMBGvh2MvOfu4uSYtmhqb
    LAYrBH+7gfrxyrhbYXhIeZu8Gd4gCrtSDtzmHuNWgV8cRjJDq2VB/bSHaGE4Etgc8AXxq6
    UTFaWkmTg0KeiUnmAtt+l0mm/E7rfjLtm01rEG9V0Lr2NguOvR6CyAZIqEgKf+hLGVctaS
    D/FqgI2zIcFlfobCnLE5dqr32iMjTN1+M9mqbUP/98mbE0Q0KqAnUkuGpgfJjoGtTY4DoQ
    IyK8r8huhwDbxEZlrXbtuTUCuqTT8A3tTWMyYHLoDj15YSQndijX+8Pona+eM578GHUrpp
    XL9/O44XQIoIDiCfDthkmLGUXR0cSqmvCZrX9P190TupMxVGyqiXJ9mkalaIBZdnVobDZW
    QekLBA6FdunbUT/EZvZfDRiQpa1B2Ra/I3j67L0Fq9aOl4SCkm1ckmA2b9gA
X-ME-Proxy: <xmx:bKzEall_deV2b2pjTt5AwGns2uX2FXHtLjIY1Cvi-eN_d7XvKU7Haw>
    <xmx:bKzEarNDsl5NTyUeX628vKnFblqB2D15LeE9m8_eSBgvg-gWKJ6REw>
    <xmx:bKzEahxFhMpl4U3dPW033utnuUfiIO_YBYtGvn93t2GDW2SIDjauPw>
    <xmx:bKzEagu5nyljGoRAs4EEuaY0zl5_4xLavr7GV-WOB7l-o_gA1-MKuA>
    <xmx:bKzEasawkO2-zI0lEPdaCmdkCaPqkTveSmvaKTsEx1dj8G8-v-LmVetv>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id F086AF80090; Tue,  6 Oct 2026 04:08:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 10:07:48 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Justin Stitt" <justinstitt@google.com>
Cc: "Bill Wendling" <morbo@google.com>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Mark Brown" <broonie@kernel.org>, "Marco Elver" <elver@google.com>,
 alan.maguire@oracle.com, namjain@linux.microsoft.com,
 "Peter Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <e9e04143-22ff-4396-9b33-333231366f64@app.fastmail.com>
In-Reply-To: 
 <CAFhGd8q3Hs9r6ezCA5bFATcZcq7AZyC7Cai8muk5o-AwOMLW7w@mail.gmail.com>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261005192052.2589382-1-morbo@google.com>
 <3176a197-baf8-4e5f-96a0-8c79d32a168c@app.fastmail.com>
 <CAFhGd8q3Hs9r6ezCA5bFATcZcq7AZyC7Cai8muk5o-AwOMLW7w@mail.gmail.com>
Subject: Re: [PATCH v3] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, 6 Oct 2026, at 09:30, Justin Stitt wrote:
> Hi,
>
> On Mon, Oct 5, 2026 at 2:25=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
>>
>>
>>
>> On Mon, 5 Oct 2026, at 21:20, Bill Wendling wrote:
>> > Code that runs outside the kernel proper, such as the EFI stub, gets
>> > nothing out of the counted_by annotations: the bounds checks they f=
eed
>> > (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
>> >
>> > The annotations can also break the build. A __counted_by_ptr() that
>> > names a member declared after the pointer needs Clang's
>> > '-fexperimental-late-parse-attributes', which the top-level Makefile
>> > adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and=
 does
>> > not get that flag, so it fails as soon as such a struct is pulled in
>> > through a common header.
>> >
>> > Overriding the __counted_by_ptr macro from a Makefile doesn't work:
>> > 'compiler_types.h' is pulled in with '-include', which is processed
>> > after all -D/-U options, so it re-establishes the definitions. Foll=
ow
>> > the '__NO_FORTIFY' precedent instead: let a build define
>> > '__NO_COUNTED_BY_PTR' to turn the corresponding annotation into a n=
o-op.
>> >
>> > Assisted-by: LLM
>> > Signed-off-by: Bill Wendling <morbo@google.com>
>> > ---
>> > v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until w=
e need it.
>> > v3: Add the version to the Subject line.
>> > ---
>> >  include/linux/compiler_types.h | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/compiler_types.h
>> > b/include/linux/compiler_types.h
>> > index c5921f139007..8bde6798b4ec 100644
>> > --- a/include/linux/compiler_types.h
>> > +++ b/include/linux/compiler_types.h
>> > @@ -387,8 +387,13 @@ struct ftrace_likely_data {
>> >   *
>> >   *   gcc:
>> > https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
>> >   * clang:
>> > https://clang.llvm.org/docs/AttributeReference.html#counted-by-coun=
ted-by-or-null-sized-by-sized-by-or-null
>> > + *
>> > + * Code that runs outside the kernel proper (e.g. the EFI stub) can
>> > define
>> > + * __NO_COUNTED_BY_PTR to drop the annotation. Such code may also =
lack
>> > the flag
>> > + * Clang needs to parse a reference to a later-declared member
>> > + * (-fexperimental-late-parse-attributes).
>> >   */
>> > -#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
>> > +#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) &&
>> > !defined(__NO_COUNTED_BY_PTR)
>> >  #define
>> > __counted_by_ptr(member)      __attribute__((__counted_by__(member)=
))
>> >  #else
>> >  #define __counted_by_ptr(member)
>>
>> Apologies, I may have been unclear.
>>
>> What I would like to see here is something like
>>
>> #ifndef __NO_COUNTED_BY
>> #define __counted_by(member)  __attribute__((....))
>> #define __counted_by_ptr(member)  __attribute__((....))
>> #else
>> #define __counted_by(member)
>> #define __counted_by_ptr(member)
>> #endif
>
> FWIW, Bill's original patch had this explanation
>
> "The two are kept separate but parallel so they
> can be folded together once all supported compilers handle
> '__counted_by' on pointers."
>

When opting out of this, whether or not the compiler supports
all variants of counted_by() is irrelevant. The same #define
should just opt out of all of them.

If the need arises to be more granular here, we can always add
that later but I don't want to have to add

-D__NO_COUNTED_BY -D__NO_COUNTED_BY_PTR

everywhere today, and go back and remove the second part once
all compilers have caught up.

