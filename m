Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36524EF8B;
	Tue, 15 Apr 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751149; cv=none; b=SbVvwO1n3tnkTZjMd8TqLJK1cg6SUp1veSyjX5opQNxCfCActJiA+kkWc0VyjTivxSYWNx/Le8sM15g1y5IclZdNSxrj/30kZgUigYw4PAPk5Mkag3pwTHmd0t0RDBoKm1C8XIRFHhKr8Fs/nzScP7QCANBDjb6Ac8+nZLHzXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751149; c=relaxed/simple;
	bh=px5sZwlFtUXz9d0axH6/X5j10VDhNgZDqEb0NbztXM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj+tGCOC4/LEltEWd4N7nQ0gjRQKaoQP8uuskOkNsodz/c39lQdNAx2AwjlFVCzMTXYNM5PS3ieu9eNdT9dI0v7bnpnognVeOfcXIRziqYtlXeH35JM7ro+qVNCGk2RNaogg8uBA/c4ykjOSxL/7oA5HQklvKaZD01HDZZdfgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQu5Lc0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQu5Lc0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC17C4CEE7;
	Tue, 15 Apr 2025 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744751149;
	bh=px5sZwlFtUXz9d0axH6/X5j10VDhNgZDqEb0NbztXM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQu5Lc0SosJj3qbHJaXGdQPw2XsWlZYvoEGOwBpraeBOm4LvdI7RcUItTDmDyUfdd
	 bBlyR4p7zC3Az6bxWZrBADmtfhRiQccAbcaqNn1c9LyCBeOI0a7RZLIcp1fJ95fIkt
	 zakkhXhAU7WX/tFDq1b6jzeSucnwszWTOiL7JcLl36zOl+Hi+AptIvyzad/uKBvNd7
	 XDG7X6qKOW+S/zEPxNS0bUYzNEODDAE9lq1DOByMk6Db//RCDKQtOBk3KRrcN2Ptrx
	 1FNgh+N0vXM50nulNB1VNSA38R5E+D3wRqWwOepcStA16m/qWRSZvciPgzFcAdCDD3
	 1kOGBWUZXFD2g==
Date: Tue, 15 Apr 2025 14:05:45 -0700
From: Kees Cook <kees@kernel.org>
To: hhtracer@gmail.com
Cc: tony.luck@intel.com, gpiccoli@igalia.com,
	liaoweixiong@allwinnertech.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, huhai <huhai@kylinos.cn>
Subject: Re: [PATCH] pstore/zone: Fix return value in psz_init_zone() and
 psz_init_zones()
Message-ID: <202504151404.B106097461@keescook>
References: <20250413072745.3949-1-huhai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413072745.3949-1-huhai@kylinos.cn>

On Sun, Apr 13, 2025 at 03:27:45PM +0800, hhtracer@gmail.com wrote:
> From: huhai <huhai@kylinos.cn>
> 
> The psz_init_zone() and psz_init_zones() functions return NULL on error,
> but psz_alloc_zones() only checks the return value using IS_ERR(). Since
> NULL is not an error pointer, this causes psz_alloc_zones() to mistakenly
> treat a failure as success and return 0, which may lead to a NULL pointer
> dereference.

Have you encountered this failure?

> 
> Update both psz_init_zone() and psz_init_zones() to return proper error
> pointers using ERR_PTR() instead of NULL.
> 
> Fixes: d26c3321fe18 ("pstore/zone: Introduce common layer to manage storage zones")
> Signed-off-by: huhai <huhai@kylinos.cn>
> ---
>  fs/pstore/zone.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index ceb5639a0629..57ffcf76f254 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -1157,7 +1157,7 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
>  	const char *name = pstore_type_to_name(type);
>  
>  	if (!size)
> -		return NULL;

Because as far as I know, this is by design: a size 0 prz means there's
no zone. Nothing should ever try to use it because the size is 0.

> +		return ERR_PTR(-EINVAL);
>  
>  	if (*off + size > info->total_size) {
>  		pr_err("no room for %s (0x%zx@0x%llx over 0x%lx)\n",
> @@ -1203,7 +1203,7 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
>  
>  	*cnt = 0;
>  	if (!total_size || !record_size)
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  
>  	if (*off + total_size > info->total_size) {
>  		pr_err("no room for zones %s (0x%zx@0x%llx over 0x%lx)\n",
> @@ -1225,7 +1225,7 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
>  
>  	for (i = 0; i < c; i++) {
>  		zone = psz_init_zone(type, off, record_size);
> -		if (!zone || IS_ERR(zone)) {
> +		if (IS_ERR(zone)) {
>  			pr_err("initialize zones %s failed\n", name);
>  			psz_free_zones(&zones, &i);
>  			return (void *)zone;

I think the code is correct as-is. Have you found a place where the prz
is used even when NULL?

-- 
Kees Cook
