Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250384964E;
	Mon, 23 Dec 2024 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734932782; cv=none; b=UFQAX8pgrsLIjVU8qS9YcrGNH1Ql75DACuYoBUBy27U7g31VLGcFteAdSquhWLRilRejtYGBxWOf4vUpjGcDIabzTF1LJBCiwEdp5R+es4IGjqVsNfgk4U/q9+K0AVaYziWOp3o4PXUrgLeWKxbQ3c2wbigd7JqYicCJxjeRiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734932782; c=relaxed/simple;
	bh=XCvH+FILd2NWK3aQ7uOcKdu7BhXBbolellxLjpsyWB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMO5kG92bFYbqJ951NyZnQrZew5LE2wT+I+lHWKrIQn0qAWqOs26/O/vY3a+S5NuX4j6GhmP9dUTbzYQp4gSV4HmD5SZwwwrJpETsXQIXa5nukKD1LTwH9NxdyO4ADQ8hnDliIunH3kyPJviZyqbrIqlDh6ZCZoLBgbRlAx9B6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVpF2xyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVpF2xyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5562C4CED4;
	Mon, 23 Dec 2024 05:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734932780;
	bh=XCvH+FILd2NWK3aQ7uOcKdu7BhXBbolellxLjpsyWB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVpF2xyAVltRZUvMcCKN4AhbNAPpcz9HNhMvNA/q6JWfvUUGr9eMIeQyBipH7kJSg
	 LFFalWdKxNvZO+x+HDg8kFuwEhe0Si2fjlpf/IdfsQM/RZTBXUb+f1XD0PrbFq7tJf
	 h4/GBAAH0V1bYsN0q2Sz2w9xAXspMd6+fIUVckfYtDDK/6ZKg2g1mJx+qWOxeKsSkS
	 fvI0PYEoDn5qXLJQf4joCIW4xQjvgNaCsupIef8D0zyEsN1xYJ1w6S1SBzV6VGAgNP
	 OODbxaVzbyq11b8AHn2CnZ8OvwFBdUPOEcx6thq41sHj1s8xL6LoJG+ATF+mpIU3U9
	 M3uki84SjeZuA==
Date: Sun, 22 Dec 2024 21:46:17 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, linux-hardening@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] alpha: Replace one-element array with flexible
 array member
Message-ID: <202412222144.61622A2@keescook>
References: <20241220192020.1667-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220192020.1667-3-thorsten.blum@linux.dev>

On Fri, Dec 20, 2024 at 08:20:20PM +0100, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct crb_struct.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/alpha/include/asm/hwrpb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/include/asm/hwrpb.h b/arch/alpha/include/asm/hwrpb.h
> index fc76f36265ad..db831cf8de10 100644
> --- a/arch/alpha/include/asm/hwrpb.h
> +++ b/arch/alpha/include/asm/hwrpb.h
> @@ -135,7 +135,7 @@ struct crb_struct {
>  	/* virtual->physical map */
>  	unsigned long map_entries;
>  	unsigned long map_pages;
> -	struct vf_map_struct map[1];
> +	struct vf_map_struct map[];
>  };

Seems like this could use __counted_by(map_entries) as well?

...
                for (i = 0; i < crb->map_entries; ++i) {
                        unsigned long pfn = crb->map[i].pa >> PAGE_SHIFT;
...

But yes, this appears to be used as a flexible array and should be
adjusted. I see no sizeof() uses that would change. So:

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook
