Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5D14F108;
	Tue,  9 Jul 2024 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556929; cv=none; b=u6ZkntjW3tns4kKUaIR4A9ArqRCB75mxEqMZ1kQzrvN5OUgL4atI/YgHuTPEPRay9+R/kp/50V9t1x+IeytI1wvDz5UiZG/HHPS9dAF5gDfyVs/STTgW2/Zd9aUmc8IVfH+SIoB3sDu08WDmzeUeji+RWwijKQrDjaPf/8XjziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556929; c=relaxed/simple;
	bh=/od/8NDo7YI4mcGiqROSpWSo0Vq0Svc7ugQRRWHIgmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiN9AR/6oReREKTrbUAL9PNhj4sajiIB9XBgQpR+efn6FnvZQMrF58UKfEH5mAFceqXTC3hHcLRRGeK+jP1JHg/kZaIMeGnn/sUs24vzkLDu3/FGilxGXKkujQWqDtRRjkAtoo/68wjxeJJrGwaeor6Oei2O0YZOU3BAmrLLBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmTAyWIB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmTAyWIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3159C3277B;
	Tue,  9 Jul 2024 20:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720556928;
	bh=/od/8NDo7YI4mcGiqROSpWSo0Vq0Svc7ugQRRWHIgmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmTAyWIBox6iTlNcpEjiozvHqqsaSQqmssiA3sRSEjudjhFFGUH0gF1m+YjkY2CtY
	 DnGJk2CEvBT5c6skfOIQJWLXh7PMOn59Z9DucZ2qCfblOXYDhOWttvty4yVVgXun9C
	 83539ZtY6woapgUb+Q3j2dnxwApt8TQa9hYehkmqHbC6p79ZnYv9wzQT4+XuN0eYWU
	 FP1neFvEGOaNw5A0e0d0siPkwDYeNTj/8xxV3aGavRaE5m6o1gz95s3ZRP3pJUMthC
	 Z+GvVb2J8T+GBT6MD8sAZvonOjYhPsd5ro0W4wIdcMnvesgHrjlbKYHgPBb6KHzuyf
	 Mr+LX/keb3nuA==
Date: Tue, 9 Jul 2024 13:28:48 -0700
From: Kees Cook <kees@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] slab: Allow for type introspection during
 allocation
Message-ID: <202407091327.AEF6C020D@keescook>
References: <20240708190924.work.846-kees@kernel.org>
 <a1fd42b5-50b7-1360-4fd0-8f590dc08e02@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1fd42b5-50b7-1360-4fd0-8f590dc08e02@gentwo.org>

On Tue, Jul 09, 2024 at 10:26:32AM -0700, Christoph Lameter (Ampere) wrote:
> On Mon, 8 Jul 2024, Kees Cook wrote:
> 
> > 
> >            obj = kmalloc(obj, gfp);
> 
> Could we avoid repeating "obj" in this pattern?
> 
> F.e.
> 
> 	KMALLOC(obj, gfp);

This appears to be the common feedback, which is good! :) And we can
still have it return "obj" as well, so it could still be used in
"return" statements, etc. I will work up a new RFC...

-- 
Kees Cook
