Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D1DF5C;
	Fri,  2 May 2025 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746152674; cv=none; b=R5HXUdA7b6FYC/R9kZ5Z2hfpBLTFYlyMHGyJ2MoqrBHQc8Z04gXFNTpt2w/75+/64QpcjOIuszjx5BvtXCLaG6WUR2/ObVmfpFyTGthRyl+mBbEDV8+xOBcrfDmG72gJSZqQ9/fuwujKeUiM3g68ns45X9wGY+Nq2TsaBSdgAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746152674; c=relaxed/simple;
	bh=9qorAgROyzpc7oWL9m+ZvRKdYuQX6eAtBtcRGl9pkxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUTDVtMCss13TNfdlupN26yTXENtmAjPo+EonqJFi0owTpQCkYESuQqeerY8Hs2R5dP5MS2LpeQlM9A5VLzJbJzL0r3wzmzjaN+32DhTNvsV9gLf7neTtlI6Mq3b9P9hPdcm1YsoQEDeW6ASNYrRaWTDxR+rpmKvn/Z2IXNk3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psyiX3dR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psyiX3dR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BC3C4CEE3;
	Fri,  2 May 2025 02:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746152673;
	bh=9qorAgROyzpc7oWL9m+ZvRKdYuQX6eAtBtcRGl9pkxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psyiX3dRMKLr+DvQKKgjcLzhf1zkolzhwG3dzJr5p+Gi0rPeEvCrEZvlipKRqlMNt
	 j5Osy7MQup2WIj3xt8cZ04OqVuSV40t6xO5Zr5es7tfcC2ybuH6X/FI8dHc/ObAzq8
	 HOPj3O9+bk2qTI3THqGc1jiPtHinl3mbt70U/YduxBw/Ce0++Z7M158B7YxSGvaYy2
	 uV64G0EZ36BRl1boeFRFl8+kcQjpxVx1q2+ZE7ScKJDfFTZkaVc3mgfEcQ0TaIXnS7
	 O1LIL1SoEMmmTmmCx4JkTtaT217ltYQJksu5/+somXtMsKO1IJfhfLxKLQuqKYNWcD
	 Z5XPZy2GHNc+g==
Date: Thu, 1 May 2025 19:24:30 -0700
From: Kees Cook <kees@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
Message-ID: <202505011922.04F401E@keescook>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>

On Thu, May 01, 2025 at 07:13:12PM -0700, Matthew Brost wrote:
> On Thu, May 01, 2025 at 05:24:38PM -0700, Kees Cook wrote:
> > Casting through a "void *" isn't sufficient to convince the randstruct
> > GCC plugin that the result is intentional. Instead operate through an
> > explicit union to silence the warning:
> > 
> > drivers/gpu/drm/ttm/ttm_backup.c: In function 'ttm_file_to_backup':
> > drivers/gpu/drm/ttm/ttm_backup.c:21:16: note: randstruct: casting between randomized structure pointer types (ssa): 'struct ttm_backup' and 'struct file'
> >    21 |         return (void *)file;
> >       |                ^~~~~~~~~~~~
> > 
> > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> 
> I forgot the policy if suggest-by but will add:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Yeah, and feel free to snag authorship entirely if you want. I only
updated the comment, really. :)

> Thomas was out today I suspect he will look at this tomorrow when he is
> back too.

Cool, no rush. It's currently just a warning in -next re-exposed by
randstruct getting cleared for allmodconfig again. :)

Thanks!

-Kees

-- 
Kees Cook
