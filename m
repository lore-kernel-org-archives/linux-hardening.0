Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14B49B44A;
	Thu, 17 Sep 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680739; cv=none; b=YmERPEheOw/2+5ByuyLe5HJdDx3AGRxizN4txRb5mNhDfXBOXs1UVJXHK3NGdvUas5H1+h3eQzPrR4PxPlr7KhRdEfYbjrk8tPDJ8/XX5KTaogfGXQ2plpegDO33V5OAIlZpJowNPDmHZi2/1frA/voBIXdoXWG5BL6PW+qjSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680739; c=relaxed/simple;
	bh=el1WHaS1dYYEDt96LaHzK2Xdh0bUebajf8pZOHrBkP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtt3HRah0AfqIodQs+D1TBO0KQzTM0o/CwkV7eV1tCl9FtQ8Bm8Eu1TvKu7y149aoyWiM4z/l/I7LKHzzlBHjsV8fXVVBOmoPZDlt7nB3p+J+mVTBgOAa7MXFYYby7FVGa1IdEn+ODRMyRm747+Td0Vn19rUJutkZQPAHnJFVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTKvqfx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTKvqfx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FBC1F000FF;
	Thu, 17 Sep 2026 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680738;
	bh=WAitvtvDwVCfK0MvrLl9cl3GHGpBKB8z+LgVcEI8TDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZTKvqfx6tRci4+eC7stPSKnuWLqGDFQ7XCvfM4AwtF7uAbkmaZuNXRI6NAr/8PGbo
	 YYiDENx2SmdtEntZ5ntcEvvs6kBVaLw2Wx/73rk2MUPCHY05GG7a6xLuA9Yvb9A38b
	 1nERfcHIe0YOMRvRJuTNSTVqQ4cqJlu7z4SiwWZ44bQi0aX+X865iayo3zhrNw4bO9
	 dXp/fUsWFvT+JAd+P8/giaZvZ/sTEKjqZYgbIDyxqHt2Kz4RIj7qd9aHJrGRrUmmhu
	 1uWENc3ITVpis9dSJc24OtC2xGgajo65vAFdNir7pahrkiMp5KfcLEbDf+bkfWbAQO
	 0Lw+UQTATl1iA==
Message-ID: <37f07dcb-9b4a-4767-8d0c-471148729c20@kernel.org>
Date: Thu, 17 Sep 2026 22:32:15 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: Add const to pattrs allocation type
To: Kees Cook <kees@kernel.org>, Srinivas Kandagatla <srini@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260917211423.i.786-kees@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260917211423.i.786-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/26 10:14 PM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "const struct bin_attribute **", but the converted
> allocation type would be "struct bin_attribute **", which is the same
> type without the const qualifier. As there is no general way to safely
> add const qualifiers, take the size from the assignment target instead.
> No change in allocation size results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> drivers/nvmem/core.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---
> Cc: Srinivas Kandagatla <srini@kernel.org>
> ---
>  drivers/nvmem/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 0556d140170a..19edc9ab0282 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -485,7 +485,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
>  	/* Allocate an array of attributes with a sentinel */
>  	ncells = list_count_nodes(&nvmem->cells);
>  	pattrs = devm_kcalloc(&nvmem->dev, ncells + 1,
> -			      sizeof(struct bin_attribute *), GFP_KERNEL);
> +			      sizeof(*pattrs), GFP_KERNEL);

Thanks for the patch, while you are at it, there are few more instances
just below this.

--srini
>  	if (!pattrs)
>  		return -ENOMEM;
>  

