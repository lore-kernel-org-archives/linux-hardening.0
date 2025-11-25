Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D959254AFF;
	Tue, 25 Nov 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072543; cv=none; b=Ly1w5WD08BgerO4frTs3ROs3/0TeAEhU1NyWOCk3noxHUq//widJVgm5x47FLy28MWwlJj47dq3HPLrV0KhRiRGDPmZne5sbj4lLELh8eMFulyrd6EQzTsLvdRnkguVZ6MST5dYhPDebT8R0NdtnkYVCgUcnRwfwPO23sA1Du+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072543; c=relaxed/simple;
	bh=EZEFgzwKtEIgXMiMD00SocZBXA5FusLtrAHuJeoOxAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLvA3a4lyMpCfbdUMWaz4cS7NymlrArPi9Q+Gyg2udL1UXOF2wrrrClOV+QLcd8gUlSGXOVswau6PiC7/3q/ZjugJXyCACHcOdbPK7HPbN9LpfmkxaXdn/9RaePH9+zYJPdaBT6TNaSPpnKHLEdVPsCY9wqMATP95UQwe8Dgmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D170vsed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D170vsed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF23C4CEF1;
	Tue, 25 Nov 2025 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764072538;
	bh=EZEFgzwKtEIgXMiMD00SocZBXA5FusLtrAHuJeoOxAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D170vsediSym302YA7i6jtCyqbam0J3ZnMX8COM/dyuLyoVSXcxbpIvO3/iP+yJ4y
	 8acujUW2vueKrIEa69G3CxyE6JDC4awoJmKO2DITgEQ4qmDwJmXn2ExK0C8oLJEh0G
	 tq/amk7sIpOWlCGolOD39TL1bVSEe9AX5+qEFpt+LKHsql7MP03Sk6Toqs29czU0bc
	 MVMGidXne71SKxMuScY3M26FWK/4fO+l4CWjREe8Xu53vaP+rHHnRNWVt2Kg3WLJad
	 8bVcGMOCRLiW21+6zCxQN8hB7XJViOJL6wKMmI6QLqlcUDDAsl7m2q0P7bwU6BtGt6
	 u5KfUJS7i0Emw==
Date: Tue, 25 Nov 2025 14:08:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] memblock: annotate struct memblock_type with
 __counted_by_ptr
Message-ID: <aSWcTjgiUKjKINw8@kernel.org>
References: <20251121193957.1655580-1-morbo@google.com>
 <20251121193957.1655580-3-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121193957.1655580-3-morbo@google.com>

On Fri, Nov 21, 2025 at 07:39:44PM +0000, Bill Wendling wrote:
> Add the '__counted_by_ptr' attribute to the 'regions' field of 'struct
> memblock_type'. The 'regions' field is an array of 'struct
> memblock_region' and its size is tracked by the 'max' field, which
> represents the total number of allocated regions.
> 
> This annotation allows the Kernel Address Sanitizer (KASAN) to detect
> out-of-bounds accesses to the 'regions' array.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  include/linux/memblock.h | 2 +-

Please also update tools/testing/memblock

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 221118b5a16e..ba7f7c999a45 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -91,7 +91,7 @@ struct memblock_type {
>  	unsigned long cnt;
>  	unsigned long max;
>  	phys_addr_t total_size;
> -	struct memblock_region *regions;
> +	struct memblock_region *regions __counted_by_ptr(max);
>  	char *name;
>  };
>  
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 

-- 
Sincerely yours,
Mike.
