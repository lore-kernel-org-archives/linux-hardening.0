Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED0274FE9;
	Tue, 31 Mar 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980975; cv=none; b=u6hnaC4rHUmeW+TWs2VMCnHD3ncVwozPeIiXW5bpl0lad9nWIbcFsq0yE6TAbxCnE7yjbeOjb5C7xY+2K0xU75SZdvSkaS/sywmXYEAm0Lt6WYMIZ2RY7nINhgqJva4SA61ahgxNwpCg9Fu0JVHm4TOtUAfpCdr2gC0y5yr0smU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980975; c=relaxed/simple;
	bh=qcgk0ntimioPEt6rCnMW/7mFr35llxPRbrDrGXsFq3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQPfglFPS6grR6v8GMLr8ovWFInyrjfP0BKRIt1SzlRKorORR6qzDqvKKB8B7lWcEaSKzpAz8gubKfVf44i16UvEqjIYKi51pOd3WNhPF0wnHjmvIGRUjCJ8kxYmmomPIZJrOTrOEdfmQIGXzvA7lbV3sVp9llrNveSZD0h7PNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so/hNNds; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so/hNNds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55093C19423;
	Tue, 31 Mar 2026 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980975;
	bh=qcgk0ntimioPEt6rCnMW/7mFr35llxPRbrDrGXsFq3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=so/hNNdsPYcxIQ5tji/YSH/7VFVBX6rl2vKmWKuOlceN86CDz3NwNhH4HJ0Kh0yAb
	 rjbDD6fyVFLaPdfHfrYorT6iGExp3SrvPAcx2WIF4CcGXtLrP4yghblU9x2jEzhQsc
	 4Knh/LRzHbRoLdvSTHGqWKV45pXmcEVE7GCfvAi7hHTlL54EtXHGuO/BtciFOc9KP3
	 dBIcKpR8zNagOKGbmUSGH1c83WoTYXOm+4aaomvtdf2NA6nQUZ3AxL8t1uRmXdHTMi
	 4ySZeQhGpCu4DTInvNvQRs9Fe5AHSE2hKp0QYKpXtMRuL9XBs3i/XBtniaVH5ipTkc
	 nMG6SnIQgVpiw==
Date: Tue, 31 Mar 2026 11:16:14 -0700
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Finn Thain <fthain@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	llvm@lists.linux.dev, Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nsc@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar
 types
Message-ID: <202603311100.F39B5DC3@keescook>
References: <20260331163716.work.696-kees@kernel.org>
 <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com>

On Tue, Mar 31, 2026 at 07:47:44PM +0200, Miguel Ojeda wrote:
> In the Rust side, even if those "explicit" types like the
> `wrapping_u32` you suggest exist, we generally use the methods on the
> normal integers instead, e.g.
> 
>     i.wrapping_add(1)
> 
>     micros.saturating_mul(NSEC_PER_USEC)
> 
>     self.index.checked_mul(page::PAGE_SIZE)?
> 
> etc.
> 
> The advantage is precisely that it is more explicit and avoids
> confusing the operators when copy-pasting code and so on.
> 
> So that could perhaps be an option? Kees et al. have been thinking
> about this for a long time as far as I recall.

I went through 7 revisions of creating helpers/accessors[1] (and
function-level annotations) and it ultimately went unused. From memory,
this was specifically from Jakub Kicinski (found breaking up readable
math statements into a series of helpers too bulky), Peter Zijlstra and
Mark Rutland (wanted strictly type-based system)[2].

Link: https://lore.kernel.org/lkml/?q=%22overflow%3A+Introduce+wrapping+helpers%22 [1]
Link: https://lore.kernel.org/lkml/20240424191740.3088894-4-keescook@chromium.org/ [2]

I view accessors as a non-starter given the near universal pushback
against them in C.

-- 
Kees Cook
