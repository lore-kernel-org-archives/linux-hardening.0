Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FD3FA5E9;
	Wed, 14 Oct 2026 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792021492; cv=none; b=YNETRWgQTKIv+Gpdz46t/akUvzfuTIeZenKY7UQOThcc7izGVXqgABuKLV+N6R6FRikU7N3MPQf1tC8GXL2DsNPK7RIELkB+zX8gTuO8PMLXLK6oiGoiMr0hePlfujRzxaUuQyPQY9nAGQApxKvvW7tdGZHL1MnWXvouTPOBMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792021492; c=relaxed/simple;
	bh=2tQhN29/ettj8MvVtb3MCzfWA7J40BXpsadZ2mPhSEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/JZcJK/IuezTDSPZeOB5ORFMTrrD7Fx4M/BIy6z8c6VvCNJhO522t1R3PopIoVMqbYp/AhrnxWpC169IxqOuv4tlyuzs2h6WBOzHAgp9/dozOl2daHi/8BRKSO/RsK37Xww0D1GXEvkejVaAp+Z6OMDPTQ3V1pje1/nfogAHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcMvEtJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcMvEtJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5011F000C4;
	Wed, 14 Oct 2026 23:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792021490;
	bh=xwEMDdQ5390h8jFpcnvdtF9Q8xygdupduQZ85MMzDhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QcMvEtJxSceJ9dht4Im1wSwg1qBmNBlh4NY7B7IHIsSJ+taVS/b+bJ83l27mO9qkI
	 ANNM0w5bMLmOjdkO4uMwYPgz+LSYlpKKexaK5HpOsMxI6psSbPbd7V6RSfDHcc7pPD
	 Uj5R4DNb6IrMRSYNQbOv71WU8ZsNpI1dQw+xnEv/8lNMO8YLkjBgDLW3o8xdhQkeF6
	 ++JRBQqi1egnr/oooLksHexWqSzeDJFFCH5OGIuK40hoHz6u/GJtKEBiF8a+0tKgfY
	 nu4Ok3vozy6MjCnO+4VMDCIPVIP4qmI0endFbvXXzDZASJaq5D1rZPSIPzE0TjWF8C
	 24jI96Tmcz5Pg==
Date: Wed, 14 Oct 2026 16:44:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Ian Rogers <irogers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	llvm@lists.linux.dev, linux-doc@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] Compiler Attributes: Add
 __require_explicit_initialization macro
Message-ID: <20261014234445.GA182939@ax162>
References: <20261014225811.i.852-kees@kernel.org>
 <20261014225818.3457479-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014225818.3457479-1-kees@kernel.org>

On Wed, Oct 14, 2026 at 03:58:15PM -0700, Kees Cook wrote:
> From: Ian Rogers <irogers@google.com>
> 
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to indicate that a field must be initialized explicitly by the
> user when the object is constructed. When an aggregate initializer or
> uninitialized variable omits an annotated field, Clang emits a
> -Wuninitialized-explicit-init warning (enabled by default).
> 
> Add the __require_explicit_initialization macro to
> include/linux/compiler_attributes.h (which is included by
> include/linux/compiler_types.h and include/linux/compiler.h) so kernel
> structs with error-prone initialization (such as mandatory callbacks or
> cleanup handlers) can enforce explicit initialization at compile time,
> as discussed at the Linux Plumbers Conference.
> 
> Also teach Sphinx (Documentation/conf.py), kernel-doc
> (tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
> attribute macro.
> 
> Link: https://lpc.events/event/20/contributions/2392/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan
