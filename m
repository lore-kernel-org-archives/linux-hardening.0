Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326923098E;
	Thu, 21 Nov 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732160247; cv=none; b=W2qw4v300gtfaj3BFCju154G/rY9A3QH2lMPtK4OUCVK0p1W+K5xCM4YJ60pfvzHz/2mcYhE5Vv7lll9kGXmrw2PT/oM0ABk7OKjPolJrLHwcSPFlIT3a86vzuACLrijduiw+tLvrx/E8/049WUSRG00DghS0jrxmDnR9Mzxw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732160247; c=relaxed/simple;
	bh=3UP2eHaDWDrJPiKnzRnbJl7JGs1fZg4KYMdG7Ofx+cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxYHZBQfNnaBzn0zAQtUKSNGsCktMOwiAl+b2dPLI0wVcRT0+f5CnvgPhvyAJQItTfHOWukZxcF3HARpBrRTTZTjYFG2gFaubaGZOv6HGk9j9lQe6DOrlsZ3apEwlWql04su2LKgNA3u3dPJ9SwRLNZcxDiLafOgFFqIAGgs4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVpv6bUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVpv6bUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7413FC4CECD;
	Thu, 21 Nov 2024 03:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732160245;
	bh=3UP2eHaDWDrJPiKnzRnbJl7JGs1fZg4KYMdG7Ofx+cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVpv6bUNY4qYtP9yhhbnckfD6mzXease6np9KXJhVUPOnNVdlCXNAOeYSdJJXswRD
	 wPZx8UzBsQAaBbIZbIq0ZMfFFcRA0/Kvj2ezhYAS8KLMZaHHHKM4/VMWnkkfljYvon
	 HcjpK7/1vajS2QvUwLELYTkHnSLuF1HR6XyBxoQJ1WyyVBfmZQDqkcLWxmMnwfH+86
	 RC5bohq/nHs/iJYIDnIyBLnQEKTy0fKMgUlhUCzc7sOzCqquOJBuHbtjluz6l3Lrba
	 K/pLV0nAHBFb75XpEYacCSyfiC5cVCLgFsJP00OLB41vP3G0EA12xezNFwFdpTx7qN
	 d+GF25WnOusXQ==
Date: Wed, 20 Nov 2024 20:37:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem.
 corruption
Message-ID: <Zz6q85eMTko7P-Y3@kbusch-mbp>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org>
 <Zz4vzSRcdjvWNIgK@kbusch-mbp>
 <CAOZ5it1v3zxiavxctm-d32bT9aO701Os1-EnEeG0KCUhBPLMnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZ5it1v3zxiavxctm-d32bT9aO701Os1-EnEeG0KCUhBPLMnw@mail.gmail.com>

On Wed, Nov 20, 2024 at 02:58:54PM -0700, Brian Johannesmeyer wrote:
> These results are consistent across multiple runs. It seems that with
> DMAPOOL_DEBUG disabled, the patches introduce a significant
> performance hit. Let me know if you have any suggestions or further
> tests you'd like me to run.

That's what I was afraid of. I was working on the dma pool because it
showed significant lock contention on the pool for storage heavy
workloads, so cutting down the critical section was priority. With the
current kernel, the dma pool doesn't even register on the profiles
anymore, so it'd be great to keep it that way.

The idea for embedding the links in freed blocks was assuming a driver
wouldn't ask the kernel to free a dma block if the mapped device was
still using it. Untrustworthy hardware is why we can't have nice
things...

Here's my quick thoughts at this late hour, though I might have
something else tomorrow. If the links are external to the dma addr
being freed, then I think you need to change the entire alloc/free API
to replace the dma_addr_t handle with a new type, like a tuple of

  { dma_addr_t, priv_list_link }

That should make it possible to preserve the low constant time to alloc
and free in the critical section, which I think is a good thing to have.
I found 170 uses of dma_pool_alloc, and 360 dma_pool_free in the kernel,
so changing the API is no small task. :(
