Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583E24110F;
	Thu, 17 Jul 2025 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795873; cv=none; b=rBylCJ5pkbjJcyNa8aMBj1xhv1MFOgq+9PON01LWl8GvdDrxV8+LJOoMjnEDY6NqnN4BP4X9YrOXNBM+y1RAy+eRbru6J0XKebQIay8C8GLiRbKl6HbFwTOr7fmGdlSRQmKEu+KQkF//qkiAsc7sTo+lqUCifrYjIdrpMPlTuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795873; c=relaxed/simple;
	bh=p+zcJCk2jQCao3tbaNCKX2gTkeKcqcP1LFqr4M5zOWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbjUe9WpPSZoIaLrmmMCWX2A8slxHEyZsuzOmiU3qeLkFTiQMHscOj0oHA2gWicb1Gt2pxQ8N3dDGV3jZD2WPPSUTm30dXIwy7n8ryJjxMgUBmkH19AtD3MHg8oube4ZJWq9Iqo5TxbayzkZ2Z0GlsA0O+bbs0jeBIFuEi4I01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzfaH+Fh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzfaH+Fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48199C4CEE3;
	Thu, 17 Jul 2025 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795872;
	bh=p+zcJCk2jQCao3tbaNCKX2gTkeKcqcP1LFqr4M5zOWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzfaH+FhFmxrsnixPz4XGiqkapozOWi8ChI7CSEpCZPXUIYgDLoaIe0U5ADzTbQJ7
	 f1OqUQWtXS1H/Pr2YdLygl9awACVlG0md/OtapEra+hfYKeuBztSV2Ryr5syzFO+Jz
	 o4UqzSAWuhqu62sWGMkoLiQQuo2cfuXvkrxxr6NcECBDf7WjrzrvuejOEt8CsO0VSv
	 cRIhC8TeBImb38mMiUC8+KqWNwkv/slpjN6FvPz6YACfYPzKS7JyX/A73nqxxiNf3f
	 353JwtjtJggSriJkQRXcu63oXn2G1Icb9B5kCoDHuVXsWo7/hIPFWXRmatT02Q/+2X
	 VHhSRY2NMGoPw==
Date: Thu, 17 Jul 2025 16:44:31 -0700
From: Kees Cook <kees@kernel.org>
To: Martin Uecker <ma.uecker@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <202507171640.F649D58897@keescook>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
 <202507142211.F1E0730A@keescook>
 <d43ebab47ee70cd11bddf78c424ec341b4c797cf.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d43ebab47ee70cd11bddf78c424ec341b4c797cf.camel@gmail.com>

On Tue, Jul 15, 2025 at 08:24:29AM +0200, Martin Uecker wrote:
> Am Montag, dem 14.07.2025 um 22:19 -0700 schrieb Kees Cook:
> > On Fri, Jul 11, 2025 at 10:58:56AM -0700, Linus Torvalds wrote:
> > >         struct seq_buf s;
> > >         seq_buf_init(&s, buf, szie);
> > 
> > And because some folks didn't like this "declaration that requires a
> > function call", we even added:
> > 
> > 	DECLARE_SEQ_BUF(s, 32);
> > 
> > to do it in 1 line. :P
> > 
> > I would love to see more string handling replaced with seq_buf.
> 
> Why not have?
> 
> struct seq_buf s = SEQ_BUF(32);
> 
> 
> So the kernel has safe abstractions, there are just not used enough.

Yeah, that should be fine. The trouble is encapsulating the actual
buffer itself. But things like spinlocks need initialization too, so
it's not too unusual to need a constructor for things living in a
struct.

If the struct had DECLARE which created 2 variables, then an INIT could
just reuse the special name...

> The string builder is for safely construcing new strings, the
> string view is for safely accessing parts of existing strings.

seq_buf doesn't currently have a "view" API, just a "make sure the
result is NUL terminated, please enjoy this char *"

> Also what I found really convenient and useful in this context
> was to have an accessor macro that expose the  buffer as a 
> regular array cast to the correct size:
> 
>  *( (char(*)[(x)->N]) (x)->data )
> 
> (put into statement expressions to avoid double evaluation)
> 
> instead of simply returning a char*

Yeah, I took a look through your proposed C string library routines. I
think it would be pretty nice, but it does feel like it has to go
through a lot of hoops when C should have something native. Though to
be clear, I'm not saying seq_buf is the answer. :)

-- 
Kees Cook
