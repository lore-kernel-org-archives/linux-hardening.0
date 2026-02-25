Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853813ECBC0;
	Wed, 25 Feb 2026 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040494; cv=none; b=HZUrvU4ApkSLspArjNSKUBSVWOvKzlKiIUI3uTOHI7RiSdos5E2zLdq8WkluvRSEKVPRcfP47yWANLIlzrsw4474NRQouxFDm0BIrBooZieVVO4Rpxf8XQeT+gHw3k84Hi5lTyHWCxxxnwoLaRDPddgJRKECGlFPsVrzvxfF/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040494; c=relaxed/simple;
	bh=EfgKCiH4LT3KqQiGbcQFoTpH2C7Iohqow3BAjy2YggI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7psl3ym1+C7l5jKfh5kFY2JBN6U91s28sgwyJXxDZTHaut+/CEOMo2urLWcLUpBavODZJpglCBGoFUyz9HMjSOqxbURBCKD74w/2MEr81r6rGZ9UaspYM35r5g5Z3wVvqFseZDGCa1VYlLSCeHVx6T9U+JK5vbnj3d8rhCTSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAEBcLqx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAEBcLqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39552C19421;
	Wed, 25 Feb 2026 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772040494;
	bh=EfgKCiH4LT3KqQiGbcQFoTpH2C7Iohqow3BAjy2YggI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAEBcLqxCBxcuCKDvmYjsmnLQEKLDsGKgxKdqE7Kp348V6nAEWwJgqGJtaI6iymT7
	 RZgQB2SBCXYVFfxc/TZ3kUz9IyITdxWQaKHoqalUWKNefe52kmegj1o5j/usqD2UWW
	 pwkG+fH+z7OtPAHHcngQ30IQ/zVmp/h6G7mtvyBWcJhDDhUhmdx2d3RlBpN4Dd54lE
	 kg0k5/VLT5YuoC7Y/tfRNBqD60CfOTohNcE+NOS8gaHLQeIA5QqM37tHKK6Dd98iwW
	 l5xbdiz671yprQhAgqbNjXTpJRbqIs/3WogRrsx/X00BQObWdXzHizPJ45SIxGCVEl
	 8crNUb/t7ITUQ==
Date: Wed, 25 Feb 2026 09:28:13 -0800
From: Kees Cook <kees@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/amd/ras: Fix type size of remainder argument
Message-ID: <202602250926.E587F86@keescook>
References: <20260225014317.work.103-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225014317.work.103-kees@kernel.org>

On Tue, Feb 24, 2026 at 05:43:18PM -0800, Kees Cook wrote:
> Forcing an int to be dereferenced at uint64_t for div64_u64_rem() runs
> the risk of endian confusion and stack overflowing writes. Seen while
> preparing to enable -Warray-bounds globally:
> 
> In file included from ../arch/x86/include/asm/processor.h:35,
>                  from ../include/linux/sched.h:13,
>                  from ../include/linux/ratelimit.h:6,
>                  from ../include/linux/dev_printk.h:16,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/ras_sys.h:29,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras.h:27,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:24:
> In function 'div64_u64_rem',
>     inlined from 'ras_core_convert_timestamp_to_time' at ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:72:9:
> ../include/linux/math64.h:56:20: error: array subscript 'u64 {aka long long unsigned int}[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds=]
>    56 |         *remainder = dividend % divisor;
>       |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c: In function 'ras_core_convert_timestamp_to_time':
> ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:70:19: note: object 'remaining_seconds' of size 4
>    70 |         int days, remaining_seconds;
>       |                   ^~~~~~~~~~~~~~~~~
> 
> Switch remaining_seconds to uint64_t to avoid the problems.
> 
> Fixes: ace232eff50e ("drm/amdgpu: Add ras module files into amdgpu")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: YiPeng Chai <YiPeng.Chai@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: <amd-gfx@lists.freedesktop.org>
> Cc: <dri-devel@lists.freedesktop.org>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 01122b55c98a..91e16b0b98f9 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -63,13 +63,14 @@ int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
>  {
>  	int days_in_month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
>  	uint64_t month = 0, day = 0, hour = 0, minute = 0, second = 0;
> +	uint64_t remaining_seconds;
>  	uint32_t year = 0;
>  	int seconds_per_day = 24 * 60 * 60;
>  	int seconds_per_hour = 60 * 60;
>  	int seconds_per_minute = 60;
> -	int days, remaining_seconds;
> +	int days;
>  
> -	days = div64_u64_rem(timestamp, seconds_per_day, (uint64_t *)&remaining_seconds);
> +	days = div64_u64_rem(timestamp, seconds_per_day, &remaining_seconds);
>  
>  	/* utc_timestamp follows the Unix epoch */
>  	year = 1970;

Hm, 0day noticed this creates a problem on 32-bit systems:
https://lore.kernel.org/all/202602251312.pq8yvrww-lkp@intel.com

>  ld: drivers/gpu/drm/amd/ras/rascore/ras_core.o: in function `ras_core_convert_timestamp_to_time':
>  drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:99:(.text+0x23e): undefined reference to `__udivmoddi4'
>  ld: drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:100:(.text+0x253): undefined reference to `__udivdi3'
>  ld: drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:101:(.text+0x265): undefined reference to `__umoddi3'

I will investigate and send a v2...

-- 
Kees Cook
