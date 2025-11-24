Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7C2D8782;
	Mon, 24 Nov 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011944; cv=none; b=meXvhdqwVcYol/II8IVFtusKyhq1M0OpEz9UGPRkUKSXvLH2RA+X5AcsrpzyIJzGOCR8VVsf0+vIO5uoC7SfttFEuc2p6E9VXw3riqGUZJo4kGYVQ7xPWUhn64g8UrX/j1brmevFObwigKa0WSIwLqab3XzrgrP53/AnrEK/zuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011944; c=relaxed/simple;
	bh=t+5nJNWM+Y9E1sZZFzFFdEKO5nYArGysP+lyxJ+WiWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3G+isYpgnrcaF51hbMiErxlMSvFeciTOQDodFN9soufWdCkFkbXTTlbpc7mqWPI+GTUQAxdI5OWnff+SRta7hlk1/fK/tZ8g0xdPXk1j4421vEVap5qhfanKwZSzJpaiAB6Q12zJlnJeVW3xUQKnqPct1HkEZZHdVzFBKMYI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDbj0ZQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDbj0ZQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A0EC4CEF1;
	Mon, 24 Nov 2025 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764011943;
	bh=t+5nJNWM+Y9E1sZZFzFFdEKO5nYArGysP+lyxJ+WiWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDbj0ZQGFEs1XljlcIAl5AguNWlJ2sdwfP5PuvL1kBcnHlpVMc0xttNSffAMR1DfK
	 JTJXG3YjCb9GKC6nsQRhf/Uka9XG0q8hHih9tvEWurJ+QxeYXGj19IKUU0GS1CvSht
	 DaHyXRnSe/Aqf21+xtYu4zGuaJXEuRhh3jqcGCfB/IpDBYFDgotbgGttBLck1n7p3u
	 t9xcPkZJxd30PJOz4thDrZvu2CR7bQK2zA4bMLE7OXXN6jk0LNLrCPzZsqkc8A49NX
	 SStDT2QQmUxLLLF1hsbLkW8LQWAnTDtD14xB9qDvVZ2FeHtGoxLWUmI4DLzcHMBqBI
	 TJOD2z3d6twYQ==
Date: Mon, 24 Nov 2025 11:19:02 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] memblock: annotate struct memblock_type with
 __counted_by_ptr
Message-ID: <202511241117.CBE8ADC2@keescook>
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

This is a fair point, yes. The documentation and discussions around
counted_by are very big in my mind (and for Bill), so it was mostly a
consolidation/reminder and some extra detail on prior solutions, but
for anyone new to that annotation, we should have collected common
guidance. I will write something up.

-- 
Kees Cook
