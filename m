Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5922B9A9;
	Wed, 30 Apr 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040006; cv=none; b=vFziL3Yl5XwbwpZg+wZIMyOe2ElE5icnVUphXOjwJpmy5KPjo82TfR8tKL9KCkkVyNzvGbB36ZkgkxDOc2irNSau/OwPgSbWIMfQYT1xXoE2bNWILRK/gCZE/9RS9KAlNMHXsXhC31G2GwBQi+oNl6uaDLFY5INcBxJWCf5nY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040006; c=relaxed/simple;
	bh=54IGMiZoSITdqFuruS1CfT7kOBbA4cCLxrOaIZ38igM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNdAzw0POg0tpSKrii6SpBms1A3q/4jusQumgm3GWbpFr6w5dbzf0PtzGTH30+UXMbeeRkUugjwOLOlIVtcXgvt5tHRzdAmuQFRAlYAh/eFE8i21+9I/YtDdx7jZpoGZoYOO0qLL/rAJzrh3CMlZ1QDMqYv48efMzmqHjhgoDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBx6xqXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBx6xqXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1458EC4CEE7;
	Wed, 30 Apr 2025 19:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746040006;
	bh=54IGMiZoSITdqFuruS1CfT7kOBbA4cCLxrOaIZ38igM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBx6xqXfwDFmrjbUs2hgy2zDbXK/vNdfjGIhlftSbWHOroXMr0YsmGSPUq4eq6YD8
	 x5newvh0h4h85IG+RYltJLxbn5aRj9gONt/DE4L/+fHLyMWheN/sWg+9HPqVmla6Gp
	 kDBktrQ0ZytBmKKOWAzQEOQvnXduiLQswyTxOyOAixXqEXBIc1NiAR46Q1ZMPcGZzg
	 yl/wMbQvxBTC4y+vql6tMc9EbKiIO6Bn5U9YhGajsz9LYHLSCOyqNgfn4s0FyD76hs
	 vnQUkmvLZnC8pbVmmovexV2Q+0ct24Sd1wt3PcNAq7EVEyGlM1S4F6Rc9Gf3jJGo8c
	 zw4hU+IXA/XmQ==
Date: Wed, 30 Apr 2025 12:06:43 -0700
From: Kees Cook <kees@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Adjust vkms_state->active_planes allocation
 type
Message-ID: <202504301205.B3AD2E7@keescook>
References: <20250426061431.work.304-kees@kernel.org>
 <823d4d24-da80-4834-95ca-d5698edfe18f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <823d4d24-da80-4834-95ca-d5698edfe18f@bootlin.com>

On Mon, Apr 28, 2025 at 10:18:34AM +0200, Louis Chauvet wrote:
> 
> 
> Le 26/04/2025 à 08:14, Kees Cook a écrit :
> > In preparation for making the kmalloc family of allocators type aware,
> > we need to make sure that the returned type from the allocation matches
> > the type of the variable being assigned. (Before, the allocator would
> > always return "void *", which can be implicitly cast to any pointer type.)
> > 
> > The assigned type is "struct vkms_plane_state **", but the returned type
> > will be "struct drm_plane **". These are the same size (pointer size), but
> > the types don't match. Adjust the allocation type to match the assignment.
> 
> I think this is an issue, can you add the proper Fixup tag in this commit?

I think trailers updating tools like b4 will pick this up:

Fixes: 8b1865873651 ("drm/vkms: totally reworked crc data tracking")

Would you rather I send a v2 with the Fixes added?

> 
> With this:
> 
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

Thanks!

-Kees

-- 
Kees Cook
