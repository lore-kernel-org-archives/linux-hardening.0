Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A171B5827;
	Wed, 20 Nov 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118165; cv=none; b=br+Ub0MBJOYis5BYUj3JMR8v758ARaun0A9XL/LFn/44h10+YWy++PZErs/N86TWj0nlXgrCiCJjIivca41DrOS4dXjHv1h8Zl2e/0kZZq3jnLyA0GF7XYw7kts2nwds1QFAia76eaD0HR4cidQRkI05WJXH0w1qf3y5yvoZV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118165; c=relaxed/simple;
	bh=dTJy5yTaJCywCkIvTApsDa6gTTCYEhUQN23orW3/WDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3QhitN41pgAi6HhIp8XWcEXst8XBehEBRgUNI1NetSIMoJoKET52N0CWdav4SbYYRApXKsqhCD5FLEu4E3G+njR1w44NYdA1rCwZUb5N00rFExNZDohmTtZQyZ21wiV8BeEUkY4di/OC7sbAsQIOSjxfGCNAx7fGtp3swEqmos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxEb/bkq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxEb/bkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01076C4CECD;
	Wed, 20 Nov 2024 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118165;
	bh=dTJy5yTaJCywCkIvTApsDa6gTTCYEhUQN23orW3/WDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxEb/bkqBfGFJoP3WnWDQ1Ve0VkLDvG7ASQST/odICAMqQwl2qv0/prT5iHfa55aK
	 WoSLIalsGlyZ6vMZTrZoL7TrylF/EQXmMGf8fyVmmdGITDXnWNVWq8XKfMHpXOnoVR
	 aKF/GuWgFysXsawoOaDy/E9YT3tRca4M+sCSUl4uCPYhR6/ONkvUfmdP42ZLs8Hrgk
	 j5n60HlhjHWJ4P8W4AxEyKyRuem2gyj4iukVtQerx0KV1Bb7VtOxFbWRbxrA8kLIuv
	 mjEXhJItT2tL4Mn1uLSmumS23QQcGgj2GAREMVLZqkZVB8OW1wO04DQsjrquFODggA
	 sjcLESVkroPVA==
Date: Wed, 20 Nov 2024 08:56:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem.
 corruption
Message-ID: <Zz4GkyBC--Sb9ta4@kbusch-mbp>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz2r73CFtfuRmjup@infradead.org>

On Wed, Nov 20, 2024 at 01:29:19AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 09:55:27PM +0100, Brian Johannesmeyer wrote:
> > We discovered a security-related issue in the DMA pool allocator.
> > 
> > V1 of our RFC was submitted to the Linux kernel security team. They
> > recommended submitting it to the relevant subsystem maintainers and the
> > hardening mailing list instead, as they did not consider this an explicit
> > security issue. Their rationale was that Linux implicitly assumes hardware
> > can be trusted.
> 
> You should probably Cc Keith as the person who most recently did major
> work on the dmpool code and might still remember how it works.

Thanks.

The intrusive list was overlayed in the freed blocks for spatial
optimizations. If you're moving these field outside of it (I'll have to
review the patch on lore), you can probably relax the minimum dma block
size too since we don't need to hold the data structure information in
it.
 
> > **Threat Model**: While Linux drivers typically trust their hardware, there
> > may be specific drivers that do not operate under this assumption. Hence,
> > this threat model assumes a malicious peripheral device capable of
> > corrupting DMA data to exploit the kernel. In this scenario, the device
> > manipulates kernel-initialized data (similar to the attack described in the
> > Thunderclap paper [0]) to achieve arbitrary kernel memory corruption. 
> > 
> > **DMA pool background**. A DMA pool aims to reduce the overhead of DMA
> > allocations by creating a large DMA buffer --- the "pool" --- from which
> > smaller buffers are allocated as needed. Fundamentally, a DMA pool
> > functions like a heap: it is a structure composed of linked memory
> > "blocks", which, in this context, are DMA buffers. When a driver employs a
> > DMA pool, it grants the device access not only to these blocks but also to
> > the pointers linking them.
> > 
> > **Vulnerability**. Similar to traditional heap corruption vulnerabilities
> > --- where a malicious program corrupts heap metadata to e.g., hijack
> > control flow --- a malicious device may corrupt DMA pool metadata. This
> > corruption can trivially lead to arbitrary kernel memory corruption from
> > any driver that uses it. Indeed, because the DMA pool API is extensively
> > used, this vulnerability is not confined to a single instance. In fact,
> > every usage of the DMA pool API is potentially vulnerable. An exploit
> > proceeds with the following steps:
> > 
> > 1. The DMA `pool` initializes its list of blocks, then points to the first
> > block.
> > 2. The malicious device overwrites the first 8 bytes of the first block ---
> > which contain its `next_block` pointer --- to an arbitrary kernel address,
> > `kernel_addr`.
> > 3. The driver makes its first call to `dma_pool_alloc()`, after which, the
> > pool should point to the second block. However, it instead points to
> > `kernel_addr`.
> > 4. The driver again calls `dma_pool_alloc()`, which incorrectly returns
> > `kernel_addr`. Therefore, anytime the driver writes to this "block", it may
> > corrupt sensitive kernel data.
> > 
> > I have a PDF document that illustrates how these steps work. Please let me
> > know if you would like me to share it with you.
> > 
> > **Proposed mitigation**. To mitigate the corruption of DMA pool metadata
> > (i.e., the pointers linking the blocks), the metadata should be moved into
> > non-DMA memory, ensuring it cannot be altered by a device. I have included
> > a patch series that implements this change. Since I am not deeply familiar
> > with the DMA pool internals, I would appreciate any feedback on the
> > patches. I have tested the patches with the `DMAPOOL_TEST` test and my own
> > basic unit tests that ensure the DMA pool allocator is not vulnerable.
> > 
> > **Performance**. I evaluated the patch set's performance by running the
> > `DMAPOOL_TEST` test with `DMAPOOL_DEBUG` enabled and with/without the
> > patches applied. Here is its output *without* the patches applied:
> > ```
> > dmapool test: size:16   align:16   blocks:8192 time:3194110
> > dmapool test: size:64   align:64   blocks:8192 time:4730440
> > dmapool test: size:256  align:256  blocks:8192 time:5489630
> > dmapool test: size:1024 align:1024 blocks:2048 time:517150
> > dmapool test: size:4096 align:4096 blocks:1024 time:399616
> > dmapool test: size:68   align:32   blocks:8192 time:6156527
> > ```
> > 
> > And here is its output *with* the patches applied:
> > ```
> > dmapool test: size:16   align:16   blocks:8192 time:3541031
> > dmapool test: size:64   align:64   blocks:8192 time:4227262
> > dmapool test: size:256  align:256  blocks:8192 time:4890273
> > dmapool test: size:1024 align:1024 blocks:2048 time:515775
> > dmapool test: size:4096 align:4096 blocks:1024 time:523096
> > dmapool test: size:68   align:32   blocks:8192 time:3450830
> > ```
> > 
> > Based on my interpretation of the output, the patch set does not appear to
> > negatively impact performance. In fact, it shows slight performance
> > improvements in some tests (i.e., for sizes 64, 256, 1024, and 68).
> > 
> > I speculate that these performance gains may be due to improved spatial
> > locality of the `next_block` pointers. With the patches applied, the
> > `next_block` pointers are consistently spaced 24 bytes apart, matching the
> > new size of `struct dma_block`. Previously, the spacing between
> > `next_block` pointers depended on the block size, so for 1024-byte blocks,
> > the pointers were spaced 1024 bytes apart. However, I am still unsure why
> > the performance improvement for 68-byte blocks is so significant.
> > 
> > [0] Link: https://www.csl.sri.com/~neumann/ndss-iommu.pdf
> > 
> > Brian Johannesmeyer (2):
> >   dmapool: Move pool metadata into non-DMA memory
> >   dmapool: Use pool_find_block() in pool_block_err()
> > 
> >  mm/dmapool.c | 96 ++++++++++++++++++++++++++++++++++------------------
