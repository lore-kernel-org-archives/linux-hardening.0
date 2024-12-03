Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A208224F0
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733199115; cv=none; b=heVU+11PVzwYADjNI6URI6hljnwrfsa7jGBnANPBZOrC0rJNU2Tnd0srHfcp6l32JVWEK0LaTiIjysQt3fVdhTmq2ukJbKX3F7/jwrYJYDZ5KDi112iCYARf7Bs3EKteGy5sNveO/8uXhAcYlOLOJLWc5mn4Wx2HDgBt+GLmRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733199115; c=relaxed/simple;
	bh=HtbhxHonBmgw3sYx9neVIHEiCb+8KlhvtG8gX9357ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwoDofHNYNNm3m9VvIl5tcRxFtThw+DhrSFQRO3hXECbIuSx9d5HgG9E5f7GKmmGDTSU8ZfEk8+ahdJHJwZSMfXGLY8Vm45eS4gdjDVQHj2lrgAGvDdhJhwZiVZ3wFiMEyMyhyckxxhjIgpkejtbGof68m3Xvb0Uii5PKYbJJAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fXoxw5yG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXoxw5yG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O+XAXJC7qu7TYDODtxKCg34vNlWfHvrDTW1M0kJoD0w=; b=fXoxw5yGxDZqwToKSkXEJfnjdY
	RzXtYlQFusb6pp4MVbaXM4/yfHCyaUKUJwx1DSsdMu4nKG7MHql1WiAGg9pAVpHy/rqQxIPVgVAto
	g4EmScfi3b9LYBZD9GfhasSLuhX8YfsUVq6YCV5ZD6lZLSDgV7WW1xOqS/MsNg1a1qteMo7OGD6qw
	MzlON69mQzSZic0l/a6QarJYi2YiJi34hNl37G507j97o6w+vnZMWVnTEAAgy1apotRyZl4alr6N+
	PA6Q2m41oqnbX6G3rRDiiXHgcNfjPERXMuf6xjWudz4jc69ZSq2r403/S7/b+Y1HhCtmiGkV5VWgn
	fNZ3fqeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKGI-000000094Eq-2cLz;
	Tue, 03 Dec 2024 04:11:46 +0000
Date: Tue, 3 Dec 2024 04:11:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ze Zuo <zuoze1@huawei.com>
Cc: gustavoars@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	keescook@chromium.org, urezki@gmail.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z06FAoq59x07-hoN@casper.infradead.org>
References: <20241203023159.219355-1-zuoze1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203023159.219355-1-zuoze1@huawei.com>

On Tue, Dec 03, 2024 at 10:31:59AM +0800, Ze Zuo wrote:
> The commit 0aef499f3172 ("mm/usercopy: Detect vmalloc overruns") introduced
> vmalloc check for usercopy. However, in subsystems like networking, when
> memory allocated using vmalloc or vmap is subsequently copied using
> functions like copy_to_iter/copy_from_iter, the check is triggered. This
> adds overhead in the copy path, such as the cost of searching the
> red-black tree, which increases the performance burden.
> 
> We found that after merging this patch, network bandwidth performance in
> the XDP scenario significantly dropped from 25 Gbits/sec to 8 Gbits/sec,
> the hardened_usercopy is enabled by default.

What is "the XDP scenario", exactly?  Are these large or small packets?
What's taking the time in find_vmap_area()?  Is it lock contention?
