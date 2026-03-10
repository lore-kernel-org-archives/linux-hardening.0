Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052FC3ED127;
	Tue, 10 Mar 2026 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773130365; cv=none; b=MXIh4mvby3I4Yc6dLpm4BlgTg+nxr1hXcPGHsWreMsIqaW61Bz19XIKTyBdGZ6EAHRz1YXJSnJetxesdQBHq6m4m9x97ghdAWz22+7nKqi7IptulMef/SuSzqvSKZ5pg35+zFFLoIfpoYJipdMJRKfqKZ0MfMqnDrpXPAqE70dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773130365; c=relaxed/simple;
	bh=vixXyBmtAnLl2OyUavsNTcpAxyqUPXyYYcUyrFNX0DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWUCwpH4H2K9tkouWsQ/XowuoahLs8+Ynl0whjO5tXZzBWSbJaA1h26Zr+xV3uvTm6dDSxxKj1ABCB5zHAX2peJa36bba8iqSxFj4BB/gpUEmcKWukdOcLGZUhN5X+vpA9BSDCoum24UErnKNV6uFgqbMl1fuTr3nDo6h3aigWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zmbtjt4j; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zmbtjt4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773130363; x=1804666363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vixXyBmtAnLl2OyUavsNTcpAxyqUPXyYYcUyrFNX0DM=;
  b=Zmbtjt4j3JE0eJtI6crN5zR69zrY+dJ6zYeEUNclBQphaWHr3/iNAM8m
   rljIKZbsGlQ13qf1Yd9sfOOb1sIBiabpjvgx+tynAu9ceBPAXLdjcKcTd
   7MeFxO8+wLcD1fDHWRYIp/GquyS5Ddd+wXnTSs/FujGStC778DwKlJIr4
   yhgyZDiKVVV3Zspjhgsc7oBCILB0zHbLhozCYOzGnT0E0FEis6VtubWxw
   iB7ejE1AayS10XQP2cJGvAE2hyQeOWaqbyIN5zmihZmTDxZlu98bHmE7S
   3G3o0+VDc0O2czwPPrsdvE2OlP6mRMAMdQMfm4XZsncP1WkvF+M1ezeob
   g==;
X-CSE-ConnectionGUID: hOBRFZXdToeySMWwHdQbxg==
X-CSE-MsgGUID: EmmmH34VQzihg9w/pTHnlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="96788719"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="96788719"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 01:12:42 -0700
X-CSE-ConnectionGUID: iCHMQkmMQNGsrNJWe36plA==
X-CSE-MsgGUID: vFA/5GVDQ2eBjGWdles5xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="220209543"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.33])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 01:12:39 -0700
Date: Tue, 10 Mar 2026 10:12:26 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] drm: dp_tunnel: use kzalloc_flex
Message-ID: <aa_SahEg_NzB_PJN@intel.com>
References: <20260308211220.33759-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260308211220.33759-1-rosenp@gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Sun, Mar 08, 2026 at 02:12:20PM -0700, Rosen Penev wrote:
> Simplifies allocation by using a flexible array member to remove a
> second kzalloc.
> 
> Added __counted_by for extra runtime analysis.
> 
> Simplify assignment loop. It always returns true. That is,
> max_group_count is always equal to group_count.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/drm/display/drm_dp_tunnel.c | 26 ++++++-------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
> index f442430d8de7..aad1605b956e 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -188,13 +188,13 @@ struct drm_dp_tunnel_group {
>  struct drm_dp_tunnel_mgr {
>  	struct drm_device *dev;
>  
> -	int group_count;
> -	struct drm_dp_tunnel_group *groups;
>  	wait_queue_head_t bw_req_queue;
>  
>  #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
>  	struct ref_tracker_dir ref_tracker;
>  #endif
> +	int group_count;
> +	struct drm_dp_tunnel_group groups[] __counted_by(group_count);
>  };
>  
>  /*
> @@ -1893,7 +1893,6 @@ static void destroy_mgr(struct drm_dp_tunnel_mgr *mgr)
>  	ref_tracker_dir_exit(&mgr->ref_tracker);
>  #endif
>  
> -	kfree(mgr->groups);
>  	kfree(mgr);
>  }
>  
> @@ -1913,33 +1912,20 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
>  	struct drm_dp_tunnel_mgr *mgr;
>  	int i;
>  
> -	mgr = kzalloc_obj(*mgr);
> +	mgr = kzalloc_flex(*mgr, groups, max_group_count);
>  	if (!mgr)
>  		return ERR_PTR(-ENOMEM);
>  
> +	mgr->group_count = max_group_count;
>  	mgr->dev = dev;
>  	init_waitqueue_head(&mgr->bw_req_queue);
>  
> -	mgr->groups = kzalloc_objs(*mgr->groups, max_group_count);
> -	if (!mgr->groups) {
> -		kfree(mgr);
> -
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
>  #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
>  	ref_tracker_dir_init(&mgr->ref_tracker, 16, "drm_dptun");
>  #endif
>  
> -	for (i = 0; i < max_group_count; i++) {
> -		if (!init_group(mgr, &mgr->groups[i])) {
> -			destroy_mgr(mgr);
> -
> -			return ERR_PTR(-ENOMEM);
> -		}
> -
> -		mgr->group_count++;
> -	}
> +	for (i = 0; i < max_group_count; i++)
> +		init_group(mgr, &mgr->groups[i]);

This breaks the error handling.

Hmm, actually it looks like it already got broken by commit
8e6da25bd60d ("drm/dp_tunnel: Switch private_obj initialization
to atomic_create_state")...

>  
>  	return mgr;
>  }
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
