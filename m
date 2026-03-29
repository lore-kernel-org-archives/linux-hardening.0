Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720535DA78
	for <linux-hardening@vger.kernel.org>; Sun, 29 Mar 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790497; cv=none; b=j4A0FsJuDHS9I8I6bjxzt+AU8KfI9SRtKC5905z8IbiE4zeByapGSWUxaSnLz5T/4igLHbUj/etwOt19FWFB9g+wzGQEOFthxemkTi1mJ3hebCxDJQ9BY3sungqK1yAzDzoGtfrwMxQWWHeOixwFKYhdJicyAvff5xMFV/C3n/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790497; c=relaxed/simple;
	bh=/KhAtAsI3s6fcGSybeyA8ZeIbLVIX7i2Xg+KtYf4xzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaZakjeXM1BMRqnFeoY45cbWaMQWATa3qJcNqmcb6FobgqSBzakc5yCMWzOeuydMFXEr8Y8aJgxqJSFYjEjEZ9NDWLO3+hEcF2o/vx+l7LFW41Pw+Pi2YOPfhY7YEKWNC/DBxdv9gAwxegwzwQDJ/liqRPpvnZgpVatE+iRQEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNQKXjUh; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNQKXjUh"
Message-ID: <49794f9f-8a35-4e36-af19-26b68c89decd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774790491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plT73sepgzsaXNz8WWASbGNtwjS/AoTdnhNGVsEsc48=;
	b=LNQKXjUhxTCq+I/Txk5shY2T0DxUff5Sr/1Y09v6XmiGyArezhnHdqBpPOeWy7p0brpAEU
	DlWAQdu8IYo2+GenLiCeGd+vsa0gc0adg4QUX8YZkTVLrE9igXwvTO0h4FCIGpuWioaygv
	SxbSc4hWjf8P1wLAWxHQpGyiz4eyk6c=
Date: Sun, 29 Mar 2026 15:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260327030056.8321-1-rosenp@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260327030056.8321-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27.03.2026 04:00, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Add __counted_by to get extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/infiniband/sw/siw/siw.h     |  2 +-
>   drivers/infiniband/sw/siw/siw_mem.c | 12 +++---------
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index f5fd71717b80..2b327a899a1c 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -119,9 +119,9 @@ struct siw_page_chunk {
>   
>   struct siw_umem {
>   	struct ib_umem *base_mem;
> -	struct siw_page_chunk *page_chunk;
>   	int num_pages;

Shouldn't we replace 'num_pages' by a 'num_chunks' and change
memory allocation and release code accordingly?

>   	u64 fp_addr; /* First page base address */
> +	struct siw_page_chunk page_chunk[] __counted_by(num_pages);
>   };
>   
>   struct siw_pble {
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index 98c802b3ed72..08047fcf0df1 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -50,7 +50,6 @@ void siw_umem_release(struct siw_umem *umem)
>   		kfree(umem->page_chunk[i].plist);
>   		num_pages -= PAGES_PER_CHUNK;
>   	}
> -	kfree(umem->page_chunk);
>   	kfree(umem);
>   }
>   
> @@ -347,16 +346,12 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
>   	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
>   	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
>   
> -	umem = kzalloc_obj(*umem);
> +	umem = kzalloc_flex(*umem, page_chunk, num_chunks);
>   	if (!umem)
>   		return ERR_PTR(-ENOMEM);
>   
> -	umem->page_chunk =
> -		kzalloc_objs(struct siw_page_chunk, num_chunks);
> -	if (!umem->page_chunk) {
> -		rv = -ENOMEM;
> -		goto err_out;
> -	}
> +	umem->num_pages = num_pages;
> +
>   	base_mem = ib_umem_get(base_dev, start, len, rights);
>   	if (IS_ERR(base_mem)) {
>   		rv = PTR_ERR(base_mem);
> @@ -385,7 +380,6 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
>   		umem->page_chunk[i].plist = plist;
>   		while (nents--) {
>   			*plist = sg_page_iter_page(&sg_iter);
> -			umem->num_pages++;
>   			num_pages--;
>   			plist++;
>   			if (!__sg_page_iter_next(&sg_iter))

