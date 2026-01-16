Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F72248AF;
	Fri, 16 Jan 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552527; cv=none; b=WUitxXhO2jV5YT41/6FoXeUQacfSf45SpAyXT2nxnNNRt/Ufx0Mr2eI+H7FrPQV2dZmCnBAPYu9666GGimZUgg1oLc4t473HEr3dZC6CUrv/W7RJhbcwXHnuZWowzKaFsHxquDdrA3H9S+hsBE3IgHll7YKutWM+bjJt/0mnJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552527; c=relaxed/simple;
	bh=MfiC48edpB9sTJfMsLlAMB/nKxE5voranOulwGp0Hls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP5GJqMKgLzGoE/KIDmmrSNXvemEDIiz8x6xAEy+sKGC9OrNIrhQjuu3X54cfD+GFuwKCM6SJTXWRe8xhENJmUIgtYSK3+PVx0chtJY3QTrAtAsyg5W+xfwGzD5/NYqja3fEok4A/iNkCascEDj/FQRwb/Pmmm5IaDs6Mz+yw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XPjanmFR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XPjanmFR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/VsCbWyWdcxFjd+Uge5eeXc6nn7oO1+NFmqAbfOwDU8=; b=XPjanmFR+snAbWtctULtoif8sf
	4/p4rRkN7qUGngefg6Tbxss3aSrrjzvR/pbAWkjAunHDrcJ5Vst+yLPJwPRwpLGwtGlSVCDXY5ekc
	VGs56PCvrUyiHEL4OHEeubjbQ9XmQ0kxS2QkFIH3dd0nQOFteZv/kSG/D/CuOZh9NBzlVlZZMg3Ga
	L+gW4lx8KtWzRUXrfpHm/LkKkXgvAGe8gSFqjTouz1roCRqg7P3KiqT2pBDrNGer5Y/bPkjcIVzhc
	Qm3tTqbTpt2+IlAJw8QxsWyVGKhaXB7RorVsJBWbntOHQPJ+0faEEC1Je2FK3uZn24Az4GASRocdN
	cke9Q64g==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgfIa-00000008Isk-3mWk;
	Fri, 16 Jan 2026 08:35:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5271230065D; Fri, 16 Jan 2026 09:35:16 +0100 (CET)
Date: Fri, 16 Jan 2026 09:35:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
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
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	Jan Hendrik Farr <kernel@jfarr.cc>
Subject: Re: [PATCH v2 1/2] Compiler Attributes: Add __counted_by_ptr macro
Message-ID: <20260116083516.GI830755@noisy.programming.kicks-ass.net>
References: <20251121193957.1655580-2-morbo@google.com>
 <20251121195504.1661783-1-morbo@google.com>
 <CANiq72=kqJApbOJ0hmC_mAYe6DO8YqXSFaLJOsbPhkXfxmvJHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=kqJApbOJ0hmC_mAYe6DO8YqXSFaLJOsbPhkXfxmvJHQ@mail.gmail.com>

On Fri, Nov 21, 2025 at 10:47:45PM +0100, Miguel Ojeda wrote:
> On Fri, Nov 21, 2025 at 8:55 PM Bill Wendling <morbo@google.com> wrote:
> >
> > +/*
> > + * Optional: only supported since clang >= 21
> > + *
> > + * clang: https://github.com/llvm/llvm-project/pull/137250
> > + */
> > +#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
> > +#define __counted_by_ptr(member)       __attribute__((__counted_by__(member)))
> > +#else
> > +#define __counted_by_ptr(member)
> > +#endif
> 
> I guess there is a reason for this name, but it sounds to me a bit
> like the thing between parenthesis is a pointer, i.e. that perhaps it
> is the pointee that one that counts.
> 
> Hmm... what about `__ptr_counted_by`?

Kees promised to drop this attribute once GCC-16 releases by basically
doing 's/__counted_by_ptr/__counted_by/' and unifying things again.

This split out state will only exist for a very short while until GCC
has a release with this feature on.
