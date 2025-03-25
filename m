Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9227DA73;
	Tue, 25 Mar 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931914; cv=none; b=pcKouYjABC5fKmgKNh7Bq68ygw765u74e8C+T6xzuXdug2VvpxUn6AmUW49E77/H9rIy6eVRxd+p29QKLlkvdWsraP5UCHpf6/etZaE08QXllm7TozvmeK067RINw2O9Ll3j/hPFElj8G+4Nx3ULLxxfwFBPH2JbNj66suDguIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931914; c=relaxed/simple;
	bh=xGYquhQCBrhq2OSfhRrStIcjF6AppssofRH9M5AUzbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgt5LdyYZd7URFr+FjXasi3BYycBlMd9qRNSitAUkLGHLPWkpFUB+McfsxobEkk5DfuZY0qckPvgWznKfDAgUiZ5AF6YQ7b1Av78UcU/+vU7zK2ndwCyHq6AxVefs7ijlaMVZaGtekcdsx0FSjNdXZolXEY8rUb2Z2e5hx66UJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/VzJZYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/VzJZYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500A7C4CEE4;
	Tue, 25 Mar 2025 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742931913;
	bh=xGYquhQCBrhq2OSfhRrStIcjF6AppssofRH9M5AUzbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/VzJZYoLKtf+M1/ZFVlJVERgZhOI5sX9iBIKBC19rg5IpwfmNoYHDWxwHFThqoBK
	 u1mMlajcwQx4PH7oOBGSGWPxJ/cA25CuGB8DNvgJ0WRUIrs6CN8k9uXboWPjW3Etbq
	 iwD8gqCU8jMVvqJsbFz3+xoUYScVnJ/l6mQ+u47jD9o/64WdZvWmJ+hH4hZvw43VdC
	 3esxSCJplc7cVi93uM0qo1Aa1Z9PvEPm+FCVzi5IH3HZbevIRWBLV1hsa44m4T3+qx
	 nPy2bAJtJDry0sbjsks/GARUeVYYfXgxDbVYdH1DJhUOvUkbgQMFB6RhxFuIZhiwY+
	 d2b9QyO+2nO9w==
Date: Tue, 25 Mar 2025 12:45:10 -0700
From: Kees Cook <kees@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] [DEBUG] slab: Report number of NULLings
Message-ID: <202503251244.CA3E0F8@keescook>
References: <20250321202620.work.175-kees@kernel.org>
 <20250321204105.1898507-5-kees@kernel.org>
 <e3437446-798d-f4f3-11d7-675f8886575b@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3437446-798d-f4f3-11d7-675f8886575b@gentwo.org>

On Mon, Mar 24, 2025 at 09:16:47AM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 21 Mar 2025, Kees Cook wrote:
> 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 2717ad238fa2..a4740c8b6ccb 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -469,6 +469,8 @@ void __kfree(const void *objp);
> >  void __kfree_sensitive(const void *objp);
> >  size_t __ksize(const void *objp);
> >
> > +extern atomic_t count_nulled;
> 
> That is a scalability issue. Use a vmstat counter instead?

Yeah, this patch (marked "DEBUG") isn't intended for upstreaming. It was
just a quick hack to get a ballpark statistic. :)

-- 
Kees Cook
