Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585823B27E7
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281344; cv=none; b=fWKe2TmFHl2vCK3BRngJokGG0UHMTQ9UAIPkTXEp46kSD58Oycx+PiAEwmtFde+5ivDQpW5bEdURLGOuo3JLsY57EUndeNA/p8dhtmjC0MiooebIScPhZsKlUcdpqy2pcnIV1VS3zga8tXs6Q4EJBoXnmCVVdC0LeQPeo3ztg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281344; c=relaxed/simple;
	bh=ZjNZoI+rGqLRyY3RwMj8Agbv0dAl9XH/ttIPMSUr+3U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a51nTZf8BsW3jQZBgXlCVSx9mxT8+3EgLqQI5D/vkUmTO9sA1Y9YFw4Qv1CXMUHkAI/SJJY0PbEAW/7GsH6RaqDsS706UuMKU4JjAq296mHgtvJxk2USiMyunRB2MgDygIh2/LgNqCTi2U4dLBBpjTsUXYusxQcgr8wie6NKAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4sEPz/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4sEPz/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62B71F000FF;
	Tue,  6 Oct 2026 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791281343;
	bh=Pit7TIoPf8Hm7UQIvsoa+f0tkbDqlmehivHW56Xafno=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=U4sEPz/LFbpwFIR9JgSy46s60mOk8INEwamr/dyEPnSI2g9WWuP2JxSnBusC6db+V
	 ZfxKeCJLOn539Q7jhHABn9dyuU0x2RJWZybBv/4KFwUHuUOyG6yD87mKpssftB2MEi
	 FJ5e1OcpCt576g/dLc8aKBwYzHEs6bBlZg4+FdRoaqLJ4g3JWNd9A0bteeNnRrKg2G
	 7AU6lQF0IH4TJ3+wwtTHCNbTvl7kTB+oe6SIgPTDU23IgGHPpMdoGbJm9+8xMeynd0
	 9SNmrKUzkE0sGwa4nenY++I7i1tF2GO2qAlZvVIfr+CMBv7Fsnldxegs7D/CyeB3Mj
	 YfmzfQWSGZR4w==
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfauth.ams.internal (Postfix) with ESMTP id 73F85198003A;
	Tue,  6 Oct 2026 06:09:00 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-01.internal (MEProxy); Tue, 06 Oct 2026 06:09:00 -0400
X-ME-Sender: <xms:ucjEatjqd2KS91mJP5iD5kxjg-gpMH9w0v3P22wgNsKtK1yS5phLuQ>
    <xme:ucjEavblStUXJdfFXfKLdNOwsWnIbBbvrW1dTfUnwYNl7FA8kdPEuWbESeApZWHv5
    PAWcO1XVKLJ_lSFpLx_C9g28zXxowJAqWMkji7JH66lBpg96SHksmIpIw>
X-ME-Proxy-Cause: dmFkZTGGdtQL4KJ/yz/XyXqolrCqNbVBG5rtYaAIwxjM//tDvJw7IYP8SBY86Dv6h0AeE8
    cMAUKKarzN4jJmXnPMvjjV7ugSWLOJ57BNtImrwfyweOa0WN51y47SRkhwI2TTH1BXH/Cr
    WPBWNud37nt/wKLse1XgIZEusaWLWsJ5eCVOYJNygOdkz7bSGyyna8NWrslB2ig9d71KP9
    0mXpNZttPZ0jbit2kpkzcdx6gavXdzg5v3F+Z9rG5TSHTsxZWTJaOAtfyCXEwKW3VbsAo+
    ldWach8O0DMUW402p6KWBxg9FQkrWxVr2PB9OnVQ5QQympaJ7Ko6uPZGNY2V0rwrCFQDX+
    6K8kRC1TEddxdt75CjCL91Z9DftHH+fvGrkrncUqWD4PDa8+2YWMMdAymeGS9o9s7eGnzR
    KT3aiYPNF+CU9RuMvpObtoGhwq5HUu6QI7CzIubmFKpE1zAg4/FysN1ajmZxrglqXwyRmU
    wrBgNUFT5chMAd5yov4cM6OZAslX53512y5Aff6oI8unZ++VoR3Kg4+oILb+hojA234mnv
    tugCXpuVzwP1HNF/1su5jI+Je0Ee6Lylbx0dNLsXdW7AAuPbfAXz08U78hbtG+CEUTjHmg
    MFMaYsst55MNRJIiQ7nG8An5i7FrHm+H/9Hub5rzVPBWCnPggN+6IxKdtfAA
X-ME-Proxy: <xmx:vMjEag9lEAboEdhlMfS6Yui2Ysben86piXFlGHTIkux5IirEJhOGbA>
    <xmx:vMjEaqYc9w6ObkeGqBwKeexe6KiDTa9JIPBUyJh2dqg82MgzjwMpXA>
    <xmx:vMjEapcH-7zKecoK52ed5RAnRiuaiEmC1VRGl0A-usqiXsA0b8w4ww>
    <xmx:vMjEagTbVkon90cJEvsOXTA9T5OkhO0W01ZTJxgNBqYBZ9qNkB8nXg>
    <xmx:vMjEark13RO5Y6MI_CWEln_yJSiZVO21InO5r0_kDXzHwmbf42B5tsaT>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E31EEF80090; Tue,  6 Oct 2026 06:08:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 12:08:35 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Bill Wendling" <morbo@google.com>, "Kees Cook" <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Mark Brown" <broonie@kernel.org>,
 "Marco Elver" <elver@google.com>, alan.maguire@oracle.com,
 namjain@linux.microsoft.com, "Peter Zijlstra" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <3cd11b18-30da-4dc1-9585-1112778aba38@app.fastmail.com>
In-Reply-To: <20261006094358.2948476-1-morbo@google.com>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261006094358.2948476-1-morbo@google.com>
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 6 Oct 2026, at 11:43, Bill Wendling wrote:
> Code that runs outside the kernel proper, such as the EFI stub, gets
> nothing out of the counted_by annotations: the bounds checks they feed
> (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
>
> The annotations can also break the build. A __counted_by_ptr() that
> names a member declared after the pointer needs Clang's
> '-fexperimental-late-parse-attributes', which the top-level Makefile
> adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and does
> not get that flag, so it fails as soon as such a struct is pulled in
> through a common header.
>
> Overriding the macros from a Makefile doesn't work:
> 'compiler_types.h' is pulled in with '-include', which is processed
> after all -D/-U options, so it re-establishes the definitions. Follow
> the '__NO_FORTIFY' precedent instead: let a build define
> '__NO_COUNTED_BY' to turn the corresponding annotation into a no-op.
>
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we need it.
> v3: Add the version to the Subject line.
> v4: Use __NO_COUNTED_BY to reduce churn later on.
> ---
>  include/linux/compiler_types.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index c5921f139007..05e2b637f1cd 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -371,8 +371,13 @@ struct ftrace_likely_data {
>   *
>   * __bdos on clang < 19.1.3 can be off by 4:
>   * https://github.com/llvm/llvm-project/pull/112636
> + *
> + * Code that runs outside the kernel proper (e.g. the EFI stub) can define
> + * __NO_COUNTED_BY to drop the annotation, since it gains nothing from the
> + * bounds checks. __NO_COUNTED_BY should be used sparingly, because there are
> + * better options for opting out of bounds checking.
>   */
> -#ifdef CONFIG_CC_HAS_COUNTED_BY
> +#if defined(CONFIG_CC_HAS_COUNTED_BY) && !defined(__NO_COUNTED_BY)
>  # define __counted_by(member)		__attribute__((__counted_by__(member)))
>  #else
>  # define __counted_by(member)


What happened to counted_by_ptr() now? __NO_COUNTED_BY should disable that too.

