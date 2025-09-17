Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A92749CE
	for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144026; cv=none; b=N4bVDqhn/R8DR8aySR1SpofhjgSVQAC8M21AbJ2Kx9XcJ+HV/2HekRHdGcHEycJbyDkf9VJlnPJpg2h1URTs1oPqbUMMxV+kthfMFsGAIMRI1hptFuRBrn/FnMzY6+jQw3o/v4IsJm5oYJlAtkl0/Ton0sRTCdPxAKvcsZiNBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144026; c=relaxed/simple;
	bh=tUaJE3X1vVo6YKP0mMY9izVrGIR3jWnj/oBZ5Al2oKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPdUa7pydSzKeLAYG4Viwz1fK3Eu/sUdzHKonLXasm7kVRgNCR2WnOJQaRwkpufiKEj+cew1qFtZ+EvSMQlMAQleMKq01Aj8hDk8WwVc745GqDHVfFpnFcDzyvOk0MpuLBf7X3jZmWrZ5v9Klgd7IpDNnHhV1nLSkGAcLz/vnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj5mGUhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj5mGUhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A1C4CEE7;
	Wed, 17 Sep 2025 21:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758144025;
	bh=tUaJE3X1vVo6YKP0mMY9izVrGIR3jWnj/oBZ5Al2oKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gj5mGUhqhU4txuKfW3/fBVDOxW/TWedpbOT/KEKhq/I/LGCRvGCdrb4HN9OCRHNXI
	 xCxmpBaauddWXgcjwmEhPplNsp2+Jf6skK+4Liu7ghqPJMF2P/qDhoDZGbR0rutd5Y
	 sm3dX19mF+A8QQpFVGVhcTPd6p0SjhzvKOujtrmDYXHPJrIeppoTlk3JM7Ah1239Bl
	 fuEgBKbt5SeAyb5hFCMM0lKcNkYDS42Yf2TFvae81nwV+MdfnUfzwmLqVduCB1qvQQ
	 Eeozvo+21uxg5IrJ2A4ziC+ix6SW+Jdkl2RAXUQPnozWoFMilswcQWOnz70fN9KrQK
	 75vF8yy5+rRZQ==
Date: Wed, 17 Sep 2025 14:20:25 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>, Marco Elver <elver@google.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <202509171410.6D18849FF6@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-1-kees@kernel.org>
 <D6E2A1BD-5D42-4492-B190-A2B845D8B0EE@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6E2A1BD-5D42-4492-B190-A2B845D8B0EE@oracle.com>

On Wed, Sep 17, 2025 at 05:56:17PM +0000, Qing Zhao wrote:
> Hi, 
> 
> > On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
> > 
> > To support the KCFI typeid and future type-based allocators,
> 
> Could you please explain a little bit more on the “future type-based allocators”?

Sure, here's a link to Marco Elver's work:
https://lore.kernel.org/lkml/20250825154505.1558444-1-elver@google.com/
The "alloc token" is a bit more complicated:
https://github.com/melver/llvm-project/blob/alloc-token/clang/docs/AllocToken.rst
but my proposed __builtin_typeinfo_hash would align with mode=2 in the
Clang proposal.

> And why these two new builtins are necessary for this purpose?

Andrew didn't want strings produced when they were unused so I needed a
second API for getting string names. In either case, the result needed
to be compile-time constant. Also, I wanted to mirror the existing C++
typeinfo API that has "hash" and "name" accessors separate.

> > which need
> > to convert unique types into unique 32-bit values, add a mangling system
> > based on the Itanium C++ mangling ABI, adapted for for C types.
> 
> There is a redundant “for” in the above last sentence. 

Oops! Fixed.

> > Introduce
> > __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name for
> > testing and debugging (to see the human-readable mangling form).
> 
> In addition to the testing and debugging purpose, are  there any use cases for
> these two new compiler provided builtins? 

For _hash, yes, using it for type-based compile-time constant values
provides a building block for having type-aware logic in Linux,
especially with the allocator. For _name, it's a nice way to get at the
typeinfo for getting a stable string (right now there is no way to use
typeof() output for any reporting).

-- 
Kees Cook
