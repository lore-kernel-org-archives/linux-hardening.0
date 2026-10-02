Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F43C4555;
	Fri,  2 Oct 2026 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980156; cv=none; b=lZu/3/C8RNlPTaHnVSJbukHbsBQCpiA6r/j38C0dVBu8mmf3dbhkYFhNy7I6ghqDm7Iz23EmrNUSwSWKaLkxuy3n5PB5UY2SvtKNN0LM8bTjLAgh2IIw6/mpbyKfTd8YD8e67vckibrj3ALZwqj0Vsw6srOtQGbr5RPkgXzxqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980156; c=relaxed/simple;
	bh=7NqPI33wWj3E3HGOhRNy1PdMcEnBLLWf3Cm+Xw+Pbtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta7/G6krL+1LxeKmbOOBAfGyCoIBO55siXATbFg5piusjWIIwV7lOyz/QSUYGltrzUVNbVtufkH0Kpyt7AsRs4hVtKBgM0mC43rL/hzvJVbI3HiqAFE81ghwL/KKQfs8Dk89/4L6KgeYqvUiYBnVZqE+NkhE08NJlg1kfjUTKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRCVkEFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRCVkEFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC71F000FF;
	Fri,  2 Oct 2026 22:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790980155;
	bh=3LDJZikpkdkKQKzaoHH23Q/qctw3NfStM2vrlGtB09E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lRCVkEFu/g3U8/pLg2nCTSt7SYCYTyH9AN7U/6z9HXSuZ+zwDWhYtk8laPi8XuFkY
	 pWkWEnrIdUo8Sm6Am7r5D92dCCpN+I+eugyDbt6trBHgZFmpDnCnuXRPmODz+OuEDl
	 wX/O7GVJHH5C4klKKhOPs2PmXsSXalAFCCCcdKW+VxhvUfUgATSCDDKqKOp154xty9
	 +mBZYh5KoXpb9fX6tm9podxVkjCQvHEeWx3gWbHPm7b5u1LrrYi2/SL0/G0F9SEyl+
	 0ZGmRcuAqO10Pmm6BMYp6elNVXm3wpkKCcca0V/ECCq+t/hPpVBQZK2XuFkyU4H/mH
	 lhdmDf/7k8UEA==
Date: Fri, 2 Oct 2026 15:29:15 -0700
From: Kees Cook <kees@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
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
Message-ID: <202610021527.05F3D63AA@keescook>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-6-kees@kernel.org>
 <arJVktqS-CL7zNX0@pedro-suse.tail5790ac.ts.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJVktqS-CL7zNX0@pedro-suse.tail5790ac.ts.net>

On Tue, Sep 22, 2026 at 11:20:40AM +0100, Pedro Falcato wrote:
> On Mon, Sep 21, 2026 at 12:58:17AM -0700, Kees Cook wrote:
> > A bucket set holds one row of caches, cloned from KMALLOC_NORMAL, and an
> > allocation of any other kmalloc type falls back to the general caches.
> > Extend this to handle __GFP_ACCOUNT, so that a single bucket user can
> > isolate either GFP_KERNEL or GFP_KERNEL_ACCOUNT allocations, as is
> > needed for skb data, where AF_UNIX uses:
> > 
> > 	sk->sk_allocation = GFP_KERNEL_ACCOUNT;
> > 
> > The coverage is selected at bucket creation time:
> > 
> > 	b = kmem_buckets_create_types(name, flags, 0, INT_MAX, NULL,
> > 				      BIT(KMEM_BUCKET_NORMAL) |
> > 				      BIT(KMEM_BUCKET_CGROUP));
> > 
> > The prior kmem_buckets_create() function keeps its name and defaults
> > to only KMEM_BUCKET_NORMAL, leaving existing users as-is.
> > 
> > Only the accounted type is offered. Nothing wants a reclaimable or
> > no-obj-ext row, and of the twelve places passing GFP_DMA to an skb
> > allocator, all rare hardware: b44, b43legacy, prestera and s390 ctcm.
> 
> Well, yes, BUT I don't think silently falling back is a great option.
> I would rather things be done Properly(tm) and kmem_buckets allowing
> instantiation of most/all kmalloc cache types. Given it's security stuff,
> I would prefer being quite explicit over silent.

The types that fall back (DMA, reclaimable) are already isolated in
caches of their own, away from the normal ones, so the security goal
holds for them as-is. The one fallback that would undo the isolation,
an accounted allocation on a set made without the cgroup row, will
warn now.

-- 
Kees Cook
