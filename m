Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642647C116;
	Mon, 21 Sep 2026 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033211; cv=none; b=gj85sI+es65EDj+B5MlUtTYXEW+BIoKRMKnc7VxhRYc8mMIPt8oAnseEoLyBNkUxycqb87ZYpqyX1n3jm2WvwbMVYNpRQU/5yiElPihmOiaKg6Az6ZuhQgdYV0PXAxcy65lhdaSbaZAJfaNOoAd+H5nBNnoLC6CcgUmP3yNw4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033211; c=relaxed/simple;
	bh=L/D1VBpSzR1XeQJNrXqUys+cTWArQNCxiy9cWg8e9YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAn6yOo9fC9vrDWYVMHgcdH6hFgGrvbSuqUfKUmZ8F9X5hO+YOW7uVxhigBpnmT7RGBooXO0rMU6vqRVcsejczTAbliz4hO0E/heG1pg3Hm9V4v4hLofCWYq4VgOGhpazghvgwkpW4go07zx7szXDTrEwdTPnVS8carqCPNALWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsfpG4wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsfpG4wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF721F000FF;
	Mon, 21 Sep 2026 23:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033200;
	bh=hM5mTuDQ4dfNK5Z8XPoMxZFJdoiMu0qCdKMcLrxKa3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JsfpG4wqpOafQFBopqW3RNxUYW2gAwzPzWoeHVqBzw8tKKe1B0s4t63iQSWnV8EQ1
	 rSGPeW4M7vzIvlk+heYi85lhmuPaRw4CEYvxRFoMudbkW//0iO+tB/IICwZJPAYJR+
	 jf6H2CYP/ekh2L58Vi5xfINtZos2WrvrwYrJSBmFAMg8V9w/mUIXUsP6Dxb5kHLenH
	 ZH5/C25uUC4b793UVhAx4RRACAJzZdJaQQE08kzGuwQ5EgOcWrsH9yKQSPLFppbHHZ
	 dnO93SqbtdBPl863CAVJvqPS9wsaTfT7c/g0CxDGpB7QRrgYkcgDEiEi60mZ/7mBtZ
	 S8Oeg4uEOfhaw==
Date: Mon, 21 Sep 2026 16:26:40 -0700
From: Kees Cook <kees@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mm/slab: Let a bucket set handle __GFP_ACCOUNT
Message-ID: <202609211625.B1F704163@keescook>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-6-kees@kernel.org>
 <arEvspsSl3bLyYgs@thinkstation>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arEvspsSl3bLyYgs@thinkstation>

On Mon, Sep 21, 2026 at 02:25:57PM +0100, Harry Yoo wrote:
> On Mon, Sep 21, 2026 at 12:58:17AM -0700, Kees Cook wrote:
> Didn't take a deeper look at this yet but this is causing an error:
> 
> MODPOST Module.symvers
> ERROR: modpost: lib/tests/slub_kunit.ko: symbol 'mem_cgroup_kmem_disabled' undefined!

Argh, modular build. Of all the things I tested, I didn't actually test
kunit modular build. :P It's so easy to use kunit.py that I forget it's
doing a monolithic build under the hood. :P

I'll get that fixed.

-- 
Kees Cook
