Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14910E9;
	Thu,  6 Jun 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689809; cv=none; b=Vb3J+dU3Bi+3g4osKDd9/aYb7gPVjHkfrQ//r8b4Ot1Ge9alxGYrQnZ9ECgSSu9KftC34gnzvHPV28XG/ayjk2/hNj+3yHTKElK6MvAnxF7Y6ivxF0dONg5avUmCUrUJ+sbVLg6RZVCnqzBGA3ipC/C3Z67arsBzsfxGMzLlTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689809; c=relaxed/simple;
	bh=UyKx9bZ3hdWJqpE8irQpBb9zB0JEyFwgJeYquJTXVQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8+8TD6j+EzR181UvbJEGOO9tlHUUJzLe7ML6SFDJF39q2djt8OVze4dqbc7omANPGXAkUbz0FoKIhI4SomxSwBGIyOINca4hZTAMVbhPCKr75Uq3UQ5zi/aAljVtoAwCRLK5VpyrkUcU8edaTG4vm5wpcghXMRKeKB27slr4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPnFgcJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPnFgcJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB9FC2BD10;
	Thu,  6 Jun 2024 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689809;
	bh=UyKx9bZ3hdWJqpE8irQpBb9zB0JEyFwgJeYquJTXVQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPnFgcJGEj5N5/dPqf2Tyyk5EUu5cc0pIq+VB5l3LP6blMU8tjart5hB59I15Z73n
	 splLPXmqPZpKmuEJLKeiaJLXBcT5f/KYObaQOcfBeqU27WxUdgxBMlkqdZtP0j9izg
	 O8s8VejL6vVX2vz0m8PoWpvFPvGSnvDjvcYTOFe40VQlVEZ7olrA8S5HRWA+J7+ydh
	 ZlNXXzMraOiPBByzgnsSkHYMVdqVTjIVwjKDNhngxy2Fp3GyIGn4UhKCdR02just/U
	 iiUEzZwESqYWvR9y33/MO2wh3bSqumcIKevR9pTs+R4HYrOphs2xm8zPfao6gxtzc/
	 CDvnIPIXjyjXg==
Date: Thu, 6 Jun 2024 09:03:28 -0700
From: Kees Cook <kees@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: tony.luck@intel.com, gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr
Subject: Re: [PATCH v2] pstore/ram: Replace of_node_put with __free() for
 automatic cleanup
Message-ID: <202406060902.4F06AA0DF6@keescook>
References: <20240605214944.22113-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605214944.22113-1-jain.abhinav177@gmail.com>

On Wed, Jun 05, 2024 at 09:49:44PM +0000, Abhinav Jain wrote:
> Add __free(device_node) to the parent_node struct declaration
> Add changes to incorporate the review comments from v1
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> 
> PATCH v1 link:
> https://lore.kernel.org/all/20240415161409.8375-1-jain.abhinav177@gmail.com/
> 
> Changes since v1:
>  - Moved the variable definition back to the top of the function body

The history and version links should be below the "---" line.

But more importantly, please base your patch on the upstream tree,
rather than on your v1 patch. :) (i.e. squash your v1 and v2 together).

-Kees

> ---
>  fs/pstore/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 14f2f4864e48..f8258e4567c3 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -644,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  			    struct ramoops_platform_data *pdata)
>  {
>  	struct device_node *of_node = pdev->dev.of_node;
> +	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);
>  	struct resource *res;
>  	u32 value;
>  	int ret;
> @@ -703,7 +704,6 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  	 * we're not a child of "reserved-memory" and mimicking the
>  	 * expected behavior.
>  	 */
> -	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);
>  	if (!of_node_name_eq(parent_node, "reserved-memory") &&
>  	    !pdata->console_size && !pdata->ftrace_size &&
>  	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
> -- 
> 2.34.1
> 

-- 
Kees Cook
