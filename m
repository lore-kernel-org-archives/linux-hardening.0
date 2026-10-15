Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A02248867
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041898; cv=none; b=EL8V6DDL9jGDN6FJO2ReXa9iq1VT3isJ7QjY1LgjkveeDnqmxeoqPDCQ3ihwJO3m7qJoZvReaowZbPHObX4fnzdKysU9r2KAyks/xrOSmwyN8kXDkEBfP/6bD6tvSyHBwT3bjYcRHxltMEq3ALWq1dOk3WFztoMrtYVxoXPjn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041898; c=relaxed/simple;
	bh=NhFDTQHNwPGqd1QC9lVDk4xO2I/350KBRt9z1Nv0UQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbawsWNEQV2TTGuTAYrV9jHAy8jzLldr1cqxfV1tIVyO5kVQmVc9V55riv7hQil+QWVPdWAON9Be1p7BZ7DS15FQ3mgHTDaNxWVy3TK7HfmWRGRMG05mCHNZ+OUq31v4yb+JoQoFG9p2jY7TSt04261c0smesPW38MrGMtB0JTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1lG/a9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1lG/a9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445E41F000C4;
	Thu, 15 Oct 2026 05:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792041897;
	bh=J6ufJGndelTyNdZSldPHzjcUk4X871jm3pUa6/qAhBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C1lG/a9qkZNt5807cqIC8Qz4O1utslegVlUy8UvSAnWVjKujd8EqAJuotu1lf+Z9G
	 Ga/Eoqm0VeGgC1r1rGXBL9F8V0yDX/MFIldbfsTKyBqPYaE17svv04mTqfCE7A6oOi
	 ZAIWGWHqFEubMIdLOGQpkXQHU12HbU7KvoHdhaoXZd2Y/Wu6gZ0FL1dsAql/xDwzK/
	 OwFrqn9n6Me/CYFne91jAHkPmVAyrsrBW5Th0Kv2UL+1giuixlEi5YoqEZrRK2fgu1
	 0A7d1Hnzrypgv1e1EjRF8E286dS98NUFJuTdjXnu788BmEYexPfvjbAgdRymajC6E4
	 PeFIdSdS0/xsQ==
Date: Wed, 14 Oct 2026 22:24:57 -0700
From: Kees Cook <kees@kernel.org>
To: Richard Biener <richard.guenther@gmail.com>
Cc: Jan Hubicka <hubicka@ucw.cz>, Richard Biener <rguenther@suse.de>,
	Martin Jambor <mjambor@suse.cz>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipa-icf: Compare access path type sizes without TBAA
 [PR105438]
Message-ID: <20261015052441.7d2b3c-kees@kernel.org>
References: <20261010050537.i.784-kees@kernel.org>
 <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com>

On Sun, Oct 11, 2026 at 04:50:41PM +0200, Richard Biener wrote:
> >     In function 'small_to_big', inlined from 'f' at t.c:22:3:
> >     warning: array subscript 'struct big[0]' is partly outside array bounds of 'struct small[1]' [-Warray-bounds=]
>
> I think these diagnostics are dubious with -fno-strict-aliasing which
> essentially says you can access every object via any other objects type.

The source has no such access, though: each function reads and writes
members through its own types, and every byte touched is inside the
object. The "struct big" access to a "struct small" exists only in the
body ICF picked, so the warning is about code GCC wrote rather than
code the programmer wrote.

> So instead of this I'd rather work towards inlining the original
> body rather than the ICF prevailing one.

That does seem like it could be better, but it's not clear to me how
large a project that would be to accomplish.

This patch seems to DTRT, though. It doesn't appear to regress merging
in a meaningful way for the Linux at least.

> And force-disable these kind of diagnostics with -fno-strict-aliasing?

I'd really rather not. Linux builds everything with -fno-strict-aliasing,
so that would remove these checks from the kernel entirely. GCC's
-Warray-bounds is still off by default for the kernel because of false
positives like this one (which is why I'm trying to solve it), and I've
been working toward enabling it, since it finds real bugs. (I have a
stack of a dozen real issues that this found while doing a recent pass.)

For example (since I don't yet have links to the above stack), here
are some random examples from a few years ago: a response struct passed
where a bigger error struct was expected, whose "error" field was past
the end of the object[1]:

  drivers/thunderbolt/xdomain.c:226:22: error: array subscript 'const struct tb_xdp_error_response[0]' is partly outside array bounds of 'struct tb_xdp_properties_changed_response[1]'

and a u64 remainder stored into an int on the stack[2]:

  include/linux/math64.h:56:20: error: array subscript 'u64 {aka long long unsigned int}[0]' is partly outside array bounds of 'int[1]'

But if you did disable diagnostics, which did you have in mind? If it's
only warnings about an access whose type is bigger than the object while
the bytes it touches are in bounds, that's narrower, but the first
example above would still need to be caught, so I'd much rather just
get ICF behaving nicely. :)

-Kees

[1] https://git.kernel.org/linus/19813551701d0
[2] https://git.kernel.org/linus/9f3d543a9f737

-- 
Kees Cook
