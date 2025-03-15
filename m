Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36F1F8901;
	Sat, 15 Mar 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063956; cv=none; b=dfvZERqJUKt7IqFM2d24zD6SwMF2UNAdfS13sQvn7WxNi3wieF+5+MPUaymvwfcfGDP2tjccp0/cvfa0K3Igu41j/OIa7HdjClb2rijdcToMZ9PmI76kud5wklyebP6Td7HX+6l2Ix1s7xVpmVWg++lrCWi66FTcuyDSfA5Ih88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063956; c=relaxed/simple;
	bh=2JrTR70esOK5zGWVnspLubUzr2Qx3iJY8knG+uUwLAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDbor59o+NHw38DwWs/OzsCarnpW/oXerpVFTCsu7U0CVjLSlzc/GRkrCVAA9Lg6yxFDyuR7HWpNt8z8RB2PZfwwE0AiAchJC1WhQ/Cj6uZJIDo0+lp3gLIcdYMz0h1TNN5+o+bZ0LxF2E3ePRNN5wLf40pLMHfI7IIpZdl7uCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHt+C34V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHt+C34V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CCAC4CEE5;
	Sat, 15 Mar 2025 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063954;
	bh=2JrTR70esOK5zGWVnspLubUzr2Qx3iJY8knG+uUwLAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHt+C34V1chKfmMKRkxrpxwm/Cdh5e9nRpXvV9BH/I9MK3LhQfviQAiL6v2BSJwzK
	 nupIG83rrP/oXzqf6KIgo1LfQTrBd4Od2G4yvKvvcCy0IBprSXed2H+AMBiJv5HefF
	 k6aSLX/IP+UY/RYHDUfZzZoIt3aPtSKr3g9c9p8d1jJK7EE1swSh2WqqZ5z4CxNJIR
	 o0uViE0R6A66KpfwcChTj93bfMLM2AsUIj1endUTXYgjdanwo8l5LCrPdiAJE/BlE3
	 /XEwVeeRzB5v8cX2weGcM6S+RZrV2vSZyIrNJLJ7smrXjZRUPbRjze7Kn6Lhd/rN1p
	 gqlJNg7riEStw==
Date: Sat, 15 Mar 2025 11:39:08 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
Message-ID: <202503151137.CA3D422F3@keescook>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-2-kees@kernel.org>
 <17076519-33fd-4fac-a718-784b9597c9e6@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17076519-33fd-4fac-a718-784b9597c9e6@embeddedor.com>

On Sat, Mar 15, 2025 at 03:48:30PM +1030, Gustavo A. R. Silva wrote:
> 
> > These each return the assigned value of ptr (which may be NULL on
> > failure). For cases where the total size of the allocation is needed,
> > the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family
> > of macros can be used. For example:
> > 
> > 	info->size = struct_size(ptr, flex_member, count);
> > 	ptr = kmalloc(info->size, gfp);
> > 
> > becomes:
> > 
> > 	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
> 
> I wonder if it'd be better to keep the gfp flags as the last argument
> for all these `*_sz()` cases:
> 
> 	kmalloc_flex_sz(ptr, flex_member, count, &info->size, gpf);
> 
> Probably, even for __alloc_objs()

I was following the pattern of the other "alternative helpers", like
kmalloc_node(), which adds the additional argument to the end. I have no
real opinion about it, so I defer to the slab developers. :)

-Kees

-- 
Kees Cook
