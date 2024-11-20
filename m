Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE817BB2E;
	Wed, 20 Nov 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095441; cv=none; b=ffAeohE+B2qTmp0IQfkuyqE/SdvACgUsKr1DUcL25FNpaFv/cB7WGd2xmzkaRmPLkRkUGPAgyB7FTyTqdCeQEEtCbaoEuzh5/JbCKQ6ABhGxwb2fUVGwsYdoiyUXvA2UY85RXffFRYZ3yCpHawQT0gsdLUg1eLmlbJpm6TYKxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095441; c=relaxed/simple;
	bh=X4fvx7OYW3IFbkZhVwXE01Sd/Yz9bZAt3sV+EvA250I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfl3ovQGJO0IwzZAdSXwHoJ4uKkCA3vNCwh0UYc4Jos2YmkkkvkRUNJfvdUHNaxBTnT+DynVrbrecE4MHXY3kLZWeXHb/Z4DclaogFjs3UgYti3OyPmYAb/6nCqu+sipYq8xQX76zoXnTPDSbAwgibQ63qN6vO0bgXtgW9MPHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CG44vEbZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CG44vEbZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=R7oiEFYEVMIo/khuiHsimbHdxohCO0mg/KK57Qh3Fjc=; b=CG44vEbZh5mNOR1judhvLEF8IO
	ZgJJOJfpVUUSSMmuYuL0lTo/HT25YjiaVzEP5Txt5AdxmhJH7dEb54GCxcOczM3qdQu0YRF1ZzUMk
	HjM7xxk8Xnj+OmiSZC4+vzZY9j1HcdGNfgdOFCgCuf0ZWG0b1J8lHiVaNdPdiRdFGFzoRAtFCFByz
	9LSkzdkhGE8YtsCOEgJt8q/3sRwB+JQbG7LMXvn1enX/7Cc8D4WWYw8C3NAPY9ZEHv2Yd9Sg/SIx7
	au+G68Jlf4nmVkyllC48AiRnJKwRRhD5nEs5ECzZZk0OL3KiShyzrY8Seve+8Swa1IZU7p86zE55E
	yZ7P+8Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDh9C-0000000Evv9-03kO;
	Wed, 20 Nov 2024 09:37:18 +0000
Date: Wed, 20 Nov 2024 01:37:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC v2 1/2] dmapool: Move pool metadata into non-DMA memory
Message-ID: <Zz2tzVqql2RMSFN4@infradead.org>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <20241119205529.3871048-2-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119205529.3871048-2-bjohannesmeyer@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 09:55:28PM +0100, Brian Johannesmeyer wrote:

> +	page->blocks_per_page = pool->allocation / pool->size;
> +	page->blocks = kmalloc_array(page->blocks_per_page,
> +				     sizeof(struct dma_block), GFP_KERNEL);

Given that you now need an array of the blocks anyway, it might make
sense to switch from a linked list to a bitmap for tracking free state,
which would be a lot more efficient as you only need a bit per block
as tracking overhead instead of a two pointers and a dma_addr_t.

e.g. do a find_first_zero_bit() to find the ﬀree slot, then calculate
the dma_addr and virt address by simple offseting into the dma_page
ones with bitnr * pool->size.

