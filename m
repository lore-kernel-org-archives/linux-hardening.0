Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CD1D415B;
	Tue, 19 Nov 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054511; cv=none; b=fFH2VC996MMIpmur1uaBRhoE3EcGzUY2007N3gyr74Y11A/Xpy/Sg7hpNZHzM5KONzSqLqRfod+ijEmnb1/iin5I1GBUmCb19BwKX9qdKzJim/NyurHWOTgw0Y1rbfOtJ2/905/EAmxLfxr51JHCTICLUMC7VZsvmLsdOswnv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054511; c=relaxed/simple;
	bh=ldY6WBWPKHHhYPop1SiXo3e9JekM5N8ocuy8u2zGjI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSaSJJ0JzUlWnsCoQpLHzVsACxRtUUOnw8hQTr7IrCJMJBf8u/zQKDqVvRTBqyvPLNxKluVPjND+5N9Zo0miqvb+bro4qCHYw2w7Nc02BJZu8hBIXVm89YUk9QdG6XnYvJzInoxBVGJgeYPbd6p27RTMIVJljJK+d7e9V8/Dxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=plf8DAX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="plf8DAX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6501C4CECF;
	Tue, 19 Nov 2024 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732054510;
	bh=ldY6WBWPKHHhYPop1SiXo3e9JekM5N8ocuy8u2zGjI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plf8DAX9AAyb/t+kWO7ybvtl8xgHZHU2wBMyBSe7T7MptghG1YljV+CMUnAdTZpZD
	 B7naqHX+jsKVD9z5M0GXSGyybB3lczKbYDrOt19gonje9YusEFR6QhY3Jx+6VeYPgh
	 ic4o/wwJHPZ6Sk8kSIiuNjxnGZfFYivEpUeO/J8o=
Date: Tue, 19 Nov 2024 23:14:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem.
 corruption
Message-ID: <2024111914-overuse-cider-7734@gregkh>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>

On Tue, Nov 19, 2024 at 09:55:27PM +0100, Brian Johannesmeyer wrote:
> We discovered a security-related issue in the DMA pool allocator.
> 
> V1 of our RFC was submitted to the Linux kernel security team. They
> recommended submitting it to the relevant subsystem maintainers and the
> hardening mailing list instead, as they did not consider this an explicit
> security issue. Their rationale was that Linux implicitly assumes hardware
> can be trusted.
> 
> **Threat Model**: While Linux drivers typically trust their hardware, there
> may be specific drivers that do not operate under this assumption. Hence,
> this threat model assumes a malicious peripheral device capable of
> corrupting DMA data to exploit the kernel. In this scenario, the device
> manipulates kernel-initialized data (similar to the attack described in the
> Thunderclap paper [0]) to achieve arbitrary kernel memory corruption. 
> 
> **DMA pool background**. A DMA pool aims to reduce the overhead of DMA
> allocations by creating a large DMA buffer --- the "pool" --- from which
> smaller buffers are allocated as needed. Fundamentally, a DMA pool
> functions like a heap: it is a structure composed of linked memory
> "blocks", which, in this context, are DMA buffers. When a driver employs a
> DMA pool, it grants the device access not only to these blocks but also to
> the pointers linking them.
> 
> **Vulnerability**. Similar to traditional heap corruption vulnerabilities
> --- where a malicious program corrupts heap metadata to e.g., hijack
> control flow --- a malicious device may corrupt DMA pool metadata. This
> corruption can trivially lead to arbitrary kernel memory corruption from
> any driver that uses it. Indeed, because the DMA pool API is extensively
> used, this vulnerability is not confined to a single instance. In fact,
> every usage of the DMA pool API is potentially vulnerable. An exploit
> proceeds with the following steps:
> 
> 1. The DMA `pool` initializes its list of blocks, then points to the first
> block.
> 2. The malicious device overwrites the first 8 bytes of the first block ---
> which contain its `next_block` pointer --- to an arbitrary kernel address,
> `kernel_addr`.
> 3. The driver makes its first call to `dma_pool_alloc()`, after which, the
> pool should point to the second block. However, it instead points to
> `kernel_addr`.
> 4. The driver again calls `dma_pool_alloc()`, which incorrectly returns
> `kernel_addr`. Therefore, anytime the driver writes to this "block", it may
> corrupt sensitive kernel data.
> 
> I have a PDF document that illustrates how these steps work. Please let me
> know if you would like me to share it with you.

I know I said it privately, but I'll say it here in public, very cool
finding, this is nice work!

> **Proposed mitigation**. To mitigate the corruption of DMA pool metadata
> (i.e., the pointers linking the blocks), the metadata should be moved into
> non-DMA memory, ensuring it cannot be altered by a device. I have included
> a patch series that implements this change. Since I am not deeply familiar
> with the DMA pool internals, I would appreciate any feedback on the
> patches. I have tested the patches with the `DMAPOOL_TEST` test and my own
> basic unit tests that ensure the DMA pool allocator is not vulnerable.
> 
> **Performance**. I evaluated the patch set's performance by running the
> `DMAPOOL_TEST` test with `DMAPOOL_DEBUG` enabled and with/without the
> patches applied. Here is its output *without* the patches applied:
> ```
> dmapool test: size:16   align:16   blocks:8192 time:3194110
> dmapool test: size:64   align:64   blocks:8192 time:4730440
> dmapool test: size:256  align:256  blocks:8192 time:5489630
> dmapool test: size:1024 align:1024 blocks:2048 time:517150
> dmapool test: size:4096 align:4096 blocks:1024 time:399616
> dmapool test: size:68   align:32   blocks:8192 time:6156527
> ```
> 
> And here is its output *with* the patches applied:
> ```
> dmapool test: size:16   align:16   blocks:8192 time:3541031
> dmapool test: size:64   align:64   blocks:8192 time:4227262
> dmapool test: size:256  align:256  blocks:8192 time:4890273
> dmapool test: size:1024 align:1024 blocks:2048 time:515775
> dmapool test: size:4096 align:4096 blocks:1024 time:523096
> dmapool test: size:68   align:32   blocks:8192 time:3450830
> ```

You had mentioned that the size:68 numbers were going to be re-run, has
that happened and this really is that much of a boost to that size?  Or
is this the original numbers?

thanks,

greg k-h
