Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE49351C06
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122374; cv=none; b=UhXzeLTNQrJx28l0LE7nUr3tesEZRMJAwj8pxOX7HF4M6dGdfXqqfJzFqaisxBQRGwPYeZ/ZECRK3PXRW2BACZrIquVgB3AMhGr6AmH7R/nSyuzwH0jm8dcy7McdEOKI3I1abuZKeRWAv7qXp/WDIgnmST1E+tOss7mplHxChvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122374; c=relaxed/simple;
	bh=hAAGMOTzTjw3mbvVoMS7j/10d17Sf8q4MAcdbZ5V6T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBjym2pXSMeLvjVVnxk2pxZgzimLQykw7gfvaSi8bPedSRWBtsuEFqihcKLL3pna+nr8pqXsqMUd4V618eHBrkWCYwolUfuq63ndy6oUTZO8jOtcgNz61SF4y06tSNGdF/+J/bNcF4CqYGbtAI0I6E9Dnu1jEqWhkOImd2Fv5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azomE42A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azomE42A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457441F00893;
	Wed, 10 Jun 2026 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122370;
	bh=NPcPUl/bhtnsLwm/RNkedD8BRig/8nnruCSmDRj7j5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=azomE42Aw/ypMbXUpo2lTENlRXg0cMrqUu0bM0hM+Xj4MqZ7rZtkcO+s/iu5ZI/dx
	 ECTnpTeqCn+1BxDk3nhtfcv/pqimDk7TEuxKaBo8UW72X8IFEjF0FA435qgWNRmR2m
	 wfyGOHi8P03hpuYoAbRRsUTqCtWp8i6SnnPf3sgN9pnUAf7mMNjheAxziDGOqQeYU7
	 CZAPgId957iA0lMvD9Y2EA0Wvwq/NUKE+8fJA6xTfPnPmScr8GZjhi3kMfjvPbapaR
	 ME1W4qNZvroO2R7iQbGXjHNoJKpR1BwBHDkONL7kYjUZYaApZz8FOe/xaiwSoRS5M1
	 ZNajdC1D+dCxA==
Date: Wed, 10 Jun 2026 13:12:50 -0700
From: Kees Cook <kees@kernel.org>
To: York Jasper Niebuhr <yjn@yjn-systems.com>
Cc: linux-hardening@vger.kernel.org, franzen@sec.in.tum.de,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC 0/7] Bootpatch-SLR: Randomizing Linux Kernel Structure
 Layouts at Boot
Message-ID: <202606101302.B3C79CFA86@keescook>
References: <20260605202511.79272-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605202511.79272-1-yjn@yjn-systems.com>

On Fri, Jun 05, 2026 at 10:25:04PM +0200, York Jasper Niebuhr wrote:
> my name is York Jasper Niebuhr. I am a Master's student in Informatics
> at the Technical University of Munich.
> 
> For a while now, I have been developing Selfpatch-SLR (SPSLR), a system
> to apply Structure Layout Randomization at runtime, and its Linux kernel
> implementation, Bootpatch-SLR (BPSLR), as an independent research
> project in my spare time. I am now beginning my Master's thesis, which
> will build upon and further evaluate this work. This patch series
> contains the current state of Bootpatch-SLR.

Thanks for working on this! I asked the Sashiko folks to give this
series a review, just so you have some more immediate feedback:
https://sashiko.dev/#/patchset/20260605202511.79272-1-yjn%40yjn-systems.com

I'd love to get Ard's feedback on this series too; he's done a lot of
poking around at layouts, annotation sections, etc.

As was mentioned at the KSPP meeting (thank you for attending!) one
aspect for further down the road will be getting this implemented
directly in GCC and Clang (since no new GCC plugins will be accepted in
Linux). But in the meantime, I think it would be best to move the plugin
into the existing GCC plugin infrastructure in the kernel (see
scripts/gcc-plugins/), as that should better control when it gets built,
make dependencies, and when it gets enabled for various build stages.

> The design goal of SPSLR is to eliminate the need for runtime lookup
> tables or similar indirection mechanisms. Structure access instructions
> are patched directly to reflect the randomized field offsets before
> normal kernel execution begins.

The implementation looks very similar to relocation fixups; is it
possible to create a new relocation type for this so it more naturally
fits into the ELF image? The .data/.rodata annotations likely need to
remain a separate section, similar to how existing things like fault
instrumentation works (i.e. from the sanitizers for things like KCFI,
UBSAN, etc).

>  * Patch 7 ignores BPSLR-generated files.

You can just fold this into the patches that add the build outputs.

> I have also attempted to port BPSLR to v6.18 and later releases. While I
> got the system to build, occasional runtime failures currently prevent
> successful operation.

I do wonder if getting the plugin merged into Linux's gcc plugin
infrastructure would solve this (i.e. it would get run/not run at the
right times, etc). I suppose it's possible it won't help, of course.

> In particular, I would be interested in pointers to areas that are
> likely to require special handling, as well as assumptions made by the
> kernel that may not be obvious to someone approaching the problem from
> outside the subsystem in question.

Targeting task_struct is quite a challenge! I wonder if you might want
to start with a different subset of the __randomize_layout-marked
structs? I know there are a bunch of filesystem and network structs that
maybe aren't quite as sensitive to early boot like I imagine task_struct
is.

What did you need to make exceptions for in the task_struct? I suspect
that may also be a hint as to why getting this ported to the latest
kernel isn't easy?

-Kees

-- 
Kees Cook
