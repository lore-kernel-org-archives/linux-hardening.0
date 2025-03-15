Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8B1F8901;
	Sat, 15 Mar 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063673; cv=none; b=YSkfJ1+r/Zkfkpbu+alldXej0mT9eNl81aEPQnx1Ke1oJiCMLmSL0QUq9mk0SG1OJz0Z4383B2dU2eIF7qThmYEahvQu7ylauS0JkHunPuFXVnwKuDo6ankkjp1AH2n9K1Sfx6Vz5Vn4A2FpEuYvKKi4LCO9PVvgwdDsanp2jJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063673; c=relaxed/simple;
	bh=X4xpNZ8s/sLlkBevw/itk2vfx1DtriwGopjBQDhHUlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECnX6CQSj9qCLpnn3/i9vSEIUMedF2NBAia8SCCTyDX4/Rh+8n9x1WYNIL5jYdidBfFRTJIXNffrSAc6i8J9743NUD5SqVEvgvmDRK/qre4e5Yv9Ibjz/tLcwK6qgWKq/8wK6JJQliracX/Ilgk3Bjog5udlpg+1bT6ywIUqK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDoNB7Dz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDoNB7Dz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A38DC4CEE5;
	Sat, 15 Mar 2025 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063673;
	bh=X4xpNZ8s/sLlkBevw/itk2vfx1DtriwGopjBQDhHUlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDoNB7DzA9Waok4Oz0gdSnJmuGJvm+LFo0WJ6WFGPyGHM6uPTy82o13K5gjCZPPZg
	 pX4v/5/QL+pdLvPQb4aTmjjK0yhu2FrFWvAHMsaLdWwlaiUDgGBY2/Ys4dthN/BZWM
	 vtTlvLY6dWn8a8lm89kCObmxMFyL1Fq289hdcj/j6rPyy6huex/JAHIt2wBvoypqYK
	 3Ka9NZDENVsrASqFqZumU2REmTbbul8+mTQ/3ihRLHHXDmKst+fGdeKhVNETK/fn9j
	 E6lHMRFqfhQ/Rfthh4hWxx8p0VSXirdabbR2UkvwIO1BLrHkiASgsWyb5MqNd/XL2L
	 F9h7+7zTM/cvg==
Date: Sat, 15 Mar 2025 11:34:28 -0700
From: Kees Cook <kees@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-hardening@vger.kernel.org, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and
 family
Message-ID: <202503151133.3FCFCB70@keescook>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-1-kees@kernel.org>
 <03d69156-1cee-43bc-901b-5f85f3aa7575@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03d69156-1cee-43bc-901b-5f85f3aa7575@infradead.org>

On Fri, Mar 14, 2025 at 09:53:41PM -0700, Randy Dunlap wrote:
> Hi Kees,
> 
> 
> On 3/14/25 8:15 PM, Kees Cook wrote:
> 
> 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 0c7e3dcfe867..e2b81cb5576e 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -440,4 +440,40 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
> >  #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
> >  	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
> >  
> > +/**
> > + * typeof_flex_counter() - Return the type of the counter variable of a given
> > + *                         flexible array member annotated by __counted_by().
> > + * @FAM: Pointer to the flexible array member within a given struct.
> > + *
> > + * Returns "size_t" if no annotation exists.
> 
> Please use
>  * Returns: <text>
> instead so that kernel-doc can make a special doc section for it.

Ah! Thanks -- I hadn't realized that the ":" induced special sections. I
think I have a bunch of other kern-doc clean-ups to do as well.

> 
> Same for patch 2/2.
> 
> > + */
> > +#define typeof_flex_counter(FAM)				\
> > +	typeof(_Generic(__flex_counter(FAM),			\
> > +			void *: (size_t)0,			\
> > +			default: *__flex_counter(FAM)))
> > +
> > +/** can_set_flex_counter() - Check if the counter associated with the given
> 
> Needs a newline between /** and the function name, as in set_flex_counter() below.

Whoops, thanks!

-Kees

-- 
Kees Cook
