Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F0207A0C;
	Thu,  6 Mar 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250419; cv=none; b=FesnnneNxxzzlALYgPPxYRWxUmQFuzu5ft/RQXP+h1oGCd2rrrxf2TnoSNz6NJQyUMeX2GP2S1a+H/H0QunVlsuFEkFsMRQLAZghVJ/m9xO94OuwMEMub75SFIUrsZ0Bo3mvI3KPo6Pie4CcTruYiUHvN/UCbw2ja89aZ2Pl8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250419; c=relaxed/simple;
	bh=0VpliImmG86Msb5QugbBGL1IxHKkWNHzdJ7tQXOtduc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt33WZajrrfIW8S9lxs/AZMQey31xgd5cy1bA9W9aaqCz2c7Pcy9A4wrw0mXSz4hAOiGCXwEh8sMZ/ul5NpmzBMOzuwFHJYYTQS09laglJ8sZzuFMsZMgC0iyXUE/2btmVSZlwSe/MA37cqGY7/I5Fw/9X2tHeYXnep/iyEnaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C2RuRoQp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C2RuRoQp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gdO7zNS5LHjDSS9JwviSOHy7H4jHw46+tgqmsiiyB48=; b=C2RuRoQpiDfK931ICvlZ4xT00G
	kiG2QBuXica1/cWXvJj5kdky1lnBFz5WgSNmkr+qniLG7N3wLYGxW8m+KuMEKcEmgNsiYTpIg+A0k
	iz5kdMfjVGCKIaeqGqrUWD7Z7k3J9ZUI6jd46aLHmNn90WpO6yal/10+nkF+zJ0q2fAGeVYRsaCQj
	xVcH7e0NYAmIUKm2cgcSOb58c0F5xMQQlFpSWWve/5VDekqzwoA5CBTVMAefda5m4w1d4EYnq0L90
	HjSIE2i9aBNcclKaMsPw9k7zRyxwQP9m4RKeMfnt/9yLE/cYT1p+rxErnNdz15/chztFyPLb6TIcj
	BBpHmPcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tq6m8-00000000yHP-0Esq;
	Thu, 06 Mar 2025 08:40:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3B58C30057E; Thu,  6 Mar 2025 09:40:15 +0100 (CET)
Date: Thu, 6 Mar 2025 09:40:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH] overflow: Twiddle with struct_size()
Message-ID: <20250306084015.GP5880@noisy.programming.kicks-ass.net>
References: <20250305134315.GB16878@noisy.programming.kicks-ass.net>
 <202503052213.D38DC337@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503052213.D38DC337@keescook>

On Wed, Mar 05, 2025 at 11:13:00PM -0800, Kees Cook wrote:
> On Wed, Mar 05, 2025 at 02:43:15PM +0100, Peter Zijlstra wrote:
> > Hi Kees,
> > 
> > I keep getting hit by the struct_size() brigade, and I keep having
> > trouble reading that macro.
> > 
> > I had a wee poke and ended up with the below, WDYT?
> 
> Ah, and to clarify, this is just for readability? (There have been
> some tweaks to reduce the macro depths and other things in other areas,
> so I just wanted to check that wasn't, or was, part of the rationale.)

Yeah, the current thing nests that flex array macro thing, with the very
same arguments, which means you then have to go read that.

That combined with that nested constexptr toggle makes it a bit of a
mess.

> > (I also tried to create a __must_be_flex_array(), but utterly failed :/)
> 
> I spent a lot of time trying to find something for that too. :( If you
> do ever find it, please share! :)
> 
> > ---
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 0c7e3dcfe867..2123d0e238bb 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -352,9 +352,10 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
> >   * Return: number of bytes needed or SIZE_MAX on overflow.
> >   */
> >  #define flex_array_size(p, member, count)				\
> > -	__builtin_choose_expr(__is_constexpr(count),			\
> > -		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
> > -		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
> > +	(__must_be_array((p)->member) +					\
> > +	 __builtin_choose_expr(__is_constexpr(count),			\
> > +			       sizeof(*(p)->member) * (count),		\
> > +			       size_mul(sizeof(*(p)->member), (count))))
> 
> For both, I need to double check that __must_be_array() is
> always a constant expression. If not, we can't move it out of the
> __builtin_choose_expr(). But if so, then yeah, this is nice.

__must_be_array() is BUILD_BUG_ON() which must be a constant expression.

> >  
> >  /**
> >   * struct_size() - Calculate size of structure with trailing flexible array.
> > @@ -367,10 +368,12 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
> >   *
> >   * Return: number of bytes needed or SIZE_MAX on overflow.
> >   */
> > -#define struct_size(p, member, count)					\
> > -	__builtin_choose_expr(__is_constexpr(count),			\
> > -		sizeof(*(p)) + flex_array_size(p, member, count),	\
> > -		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
> > +#define struct_size(p, member, count)					       \
> > +	(__must_be_array((p)->member) +					       \
> > +	 __builtin_choose_expr(__is_constexpr(count),			       \
> > +			       sizeof(*(p)) + (sizeof((p)->member) * (count)), \
> 
> typo: above should be                        (sizeof(*(p)->member))
> 
> (hint, to test this code use "./tools/testing/kunit/kunit.py run overflow")

D'oh. I sent the old version :-(. I actually did a kernel build and
fixed this error, and then went and sent the old one :/

> But yeah, this passes the overflow tests which include the constant
> expression tests, so __must_be_array() is a constant expression. Whee :)
> 
> > +			       size_add(sizeof(*(p)),			       \
> > +					size_mul(sizeof(*(p)->member), count))))
> 
> This one I'm not such a fan of. It feels wrong to not use
> flex_array_size() here -- we're performing exactly the same
> calculation. 

Yes, but now you can read it without also having to untangle
flex_array_size().

I did have a version using size_mad(x,y,z) := (x*y)+z, which is more
compact, but then you have the problem that you forever forget what
order around those 3 arguments are. (x*y)+z vs x+(y*z) etc.

Much like I can never remember the struct_size() argument order (at
least neovim's clangd lsp can somewhat help with that -- if I can get it
tamed).

> But it's possible this has cpp complexity reduction
> benefits from avoiding the stacking of __builtin_choose_expr() and
> __must_be_array() macros...

Just so.

> So, yeah, I think I could live with this. :) Especially if it means we can
> start using struct_size() in code you look at. :P
> 
> But please include this selftest update too. Since your patch splits the
> dependency between struct_size() and flex_array_size(), I'd like to test
> them separately now:

OK, will do. Thanks!
