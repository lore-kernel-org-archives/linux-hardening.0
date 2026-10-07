Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F9476CF0;
	Wed,  7 Oct 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365817; cv=none; b=AlnnTgyy8hvtCKB97Q2B+e/ErYoho2ppFsp3lgoKW3d9iXka8JfgjJxjdrtKcFpKmrlo79Vi2MdMIG/L4zbyfnEB0POE/4SW7LvQMs0XLl3tgaCOpQ1YeThOaTM6kpV8/QF3W79ScNseyw6hOEqHDrjL+XEaUIWC491TLVxQOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365817; c=relaxed/simple;
	bh=GbUMDGByiIlcp+WrpWlazRAUcVLY3mPJK9tWMwQjoFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+pJ3Hp8uKITcW0NJom44qxZOMRQtuxqqSSIE/OEbfROrvl+pzOP25EzoVzRyMJxONHaZeLbU8erYZiLHXXPOFYTSIzJtjdf6K0zergK3qYfwjCYEd2lE9dY1T6RMxbfoUKN2Y793sumon23imeJPs+eeSQoQP00JQvN1VX2mSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2NiXlCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2NiXlCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAC41F0089E;
	Wed,  7 Oct 2026 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791365806;
	bh=4DhdzIwt3MRMXaMV4Mj6A2R3zODdLzHgKo1UW7l68sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o2NiXlCwdU4gv6MFWdHENW5pLNJh35tkFSRuUzZrPS1mnmicHzbkYy1jHQ3HnsH0Z
	 JYoUq4rMncg6icJmodIpK8LYzwRHkye7PNbrfgA76xdNJIGVZf7NNcsA19zYI666Gv
	 T0wdGfCCXkYKiFtY5WYKDP9IW4ceaYe1pOJ4p3rK8mNsZsGR7qHZ72TsbLDoNLPx/M
	 auVqwzQv5K9OKt+QeLk0VPirxFXb17AiNyvByWDqzrsl9kRM0UxYF5XIDkRMcuCUca
	 LaHUNUfdbGYOwplUUK/D4o1/BSJcNhJ28FAF3K05jyBsyLqbOwntvmojBTARSaapCK
	 kvMr+wnqeOsKQ==
Date: Wed, 7 Oct 2026 11:36:41 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, ardb@kernel.org, gustavoars@kernel.org,
	ndesaulniers@google.com, justinstitt@google.com, broonie@kernel.org,
	elver@google.com, alan.maguire@oracle.com,
	namjain@linux.microsoft.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Message-ID: <20261007093641.GA1527653@ax162>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261006094358.2948476-1-morbo@google.com>
 <202610060642.7C4125F@keescook>
 <20261007090915.GA1504630@ax162>
 <CAGG=3QXPAa-i4r3Vv6-q25A6EvsxGb5RDLn02z1=a5zo7W-7Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QXPAa-i4r3Vv6-q25A6EvsxGb5RDLn02z1=a5zo7W-7Vw@mail.gmail.com>

On Wed, Oct 07, 2026 at 02:32:45AM -0700, Bill Wendling wrote:
> Ard,
> 
> What's the reason why x86 doesn't need the KBUILD_CFLAGS flags? Is
> there something that breaks things?

I think it is mostly historical. See Kees's series to address it:

  https://lore.kernel.org/20261006204210.i.137-kees@kernel.org/

-- 
Cheers,
Nathan
