Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B62FFFBE;
	Fri, 16 Jan 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552989; cv=none; b=mqqJtI/APjt0Jye7OUnJKoGT1G8NTHGDqyT0bzlZZ++W0uPv9Cri1YqJqF+gD1wAcVk7BFeC7R6t+d+N/waYQetHisyjG1peDiqyTaT+c754vT3Qc3CrI03PXpRvy7TVS5kMQMvqnCPD7fsR49ervWrAVUeD7HdPvHQFrP/Yv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552989; c=relaxed/simple;
	bh=2Mihsu/KGu1HEDMVPkSvpGOjSGj9ETiHpitUA7jM8IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW9IzsNlhYA3gtSc43eba2J6IpCulRcASjVTYSk8GGLQVjaix1Yr3VgDcQxZ6iFDPleMWIKfzhg5qzNS214SuGig+fNh6tLXNDDA6cL7CDczSd8a8bhLTeqtExHm787qa+r1LU9x/kc6xRkoiIIAk+NA1L8jdnPs/2WhZiI5pSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JLOwxzV2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLOwxzV2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JvAazmr6dMrme+XeMG64ySoeTZV4DFrMHH7EkzuBwRY=; b=JLOwxzV2Urr8h3nR9Uh7dN+w3F
	s7D0/kOGPcqZMREOXgXsSc2MyOJ5ntSqw4KnflB4SiccGK/+f25r+5TAkSWSMPg7DPvll74TobeeV
	c0I4LiG9h9bEzKtrFW/ZPhDbpLGJ77cCFmt66FBkcmOxlfLZi4y9IDu476nuOdxsP6Nmq/ehp/WfM
	wnKEfKzrmQiRV3VWr5pq3DxmQyhleWyD3M77RIm+nizZlfTOaxDy8CJo/8bA/udP1G8IDlFXYRCcB
	xqtDgdjDETWldebzBAMAVGx03iskEBt8qxiDo0S3Nzn0/3ZgYqbbECZCdNCSHpmC0D2tvanL4LCoq
	n65iiYYg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgfQ3-00000008JgZ-3MEt;
	Fri, 16 Jan 2026 08:43:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 566F630065D; Fri, 16 Jan 2026 09:42:59 +0100 (CET)
Date: Fri, 16 Jan 2026 09:42:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] memblock: annotate struct memblock_type with
 __counted_by_ptr
Message-ID: <20260116084259.GK830755@noisy.programming.kicks-ass.net>
References: <20251121193957.1655580-1-morbo@google.com>
 <20251121193957.1655580-3-morbo@google.com>
 <202511211525.05CB7E1AEC@keescook>
 <20251122141614.80f1a845cd694b1b470107ca@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122141614.80f1a845cd694b1b470107ca@linux-foundation.org>

On Sat, Nov 22, 2025 at 02:16:14PM -0800, Andrew Morton wrote:
> On Fri, 21 Nov 2025 16:30:43 -0800 Kees Cook <kees@kernel.org> wrote:
> 
> > On Fri, Nov 21, 2025 at 07:39:44PM +0000, Bill Wendling wrote:
> > > Add the '__counted_by_ptr' attribute to the 'regions' field of 'struct
> > > memblock_type'. The 'regions' field is an array of 'struct
> > > memblock_region' and its size is tracked by the 'max' field, which
> > > represents the total number of allocated regions.
> > 
> > As part of any counted_by annotation patch, there needs to be discussion
> > in the commit log about how it's been shown to be a safe annotation
> > to make. e.g. in this case, if all allocations of "regions" have a
> > corresponding "max" assignment, etc. If just "git grep" can't find them
> > all, using something like Coccinelle or CodeQL to search for struct
> > memblock_type::regions assignments can work.
> 
> How is anyone to know these things?  I can't find anything about this
> in include/ or Documentation/ or in the relevant commits.
> 
> There should be a comment at the __counted_by() definition site, please.
> 
> And possibly write a Documentation/ file then change checkpatch to
> direct people to that file if they add a counted_by?

There is:

  https://clang.llvm.org/docs/BoundsSafety.html

