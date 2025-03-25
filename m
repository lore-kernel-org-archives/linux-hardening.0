Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8A1EE021;
	Tue, 25 Mar 2025 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930718; cv=none; b=ZPoOqzVPoLRT7NUAgkQEE7jsPvufmdyIjz8ahTuCY56YeXaijRuZoL06Ef/KR8/4O0XZkkAM4sbkVSsNSPNsBbEXanoOJHFHDkkq4Ci18RmYTgYF2wbJGDMCCOIMN9E3TjWHduDks9MDnlUWmsRoZR2Sxaj8I0WufWy12bF5mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930718; c=relaxed/simple;
	bh=gWkyMtHS0xcBwH8pzvQMA99qjRWL1D1RwXbikwYpbbQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyKmYaT9WFQu1pYiCH98XpX7rzxLh2wjgGhukfmXjO2PX7n6MKSviqIzHex9ufRAqRDeKVBOYJmj2nvParalUB8ncJnNr67555AfWGA3p+cXfUT+zphm7LF/YQoYwsL66wuqugtONhe7LJwX/m7VvR8hCwgc3+FEhD10t7fIDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u09sutxW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u09sutxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F170C4CEE8;
	Tue, 25 Mar 2025 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742930715;
	bh=gWkyMtHS0xcBwH8pzvQMA99qjRWL1D1RwXbikwYpbbQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=u09sutxWpIKsjUQ+MH69yUowYtWZxZ4KGn3wLnw2xE7v6LvUD3MAoZ2hewgTTWe63
	 mHH3gj2ujyiTyWwt+r1P4IkG2/xiKiB6aQrZAXbIayd49rgkfOkX/McMC8hCKOXQ1x
	 cvEnMZRvBkWfWFWbYGE9iig2CQ886gNfIsYhBZYEMvxWrXdZocp+KQOsu+FLqIzqbS
	 IW/Z+eqdXx8NJ70r2DBL+IUinTSJ/oqgO0lQko7jQDf/0T+znkW2bGXGuBS6vCFnmI
	 6tyJWdCoEdHWsXRGCTmRCWNcP0vGV2zrpa4T/w+1ObsWUYMoRdZ3+UPy/7MIHQYvje
	 aDBUBdfEP0a9Q==
Date: Tue, 25 Mar 2025 12:25:12 -0700
From: Kees Cook <kees@kernel.org>
To: Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Add __nonstring annotations for
 unterminated strings
Message-ID: <202503251224.F128AE971@keescook>
References: <20250310222355.work.417-kees@kernel.org>
 <01070195c306db7f-9f28efdd-9456-4db3-b6c6-343298bd571b-000000@eu-central-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01070195c306db7f-9f28efdd-9456-4db3-b6c6-343298bd571b-000000@eu-central-1.amazonses.com>

On Sun, Mar 23, 2025 at 12:42:41PM +0000, Damian Tometzki wrote:
> On Mon, 10. Mar 15:23, Kees Cook wrote:
> > When a character array without a terminating NUL character has a static
> > initializer, GCC 15's -Wunterminated-string-initialization will only
> > warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> > with __nonstring to and correctly identify the char array as "not a C
> > string" and thereby eliminate the warning.
> > 
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: Zhi Wang <zhi.wang.linux@gmail.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: intel-gvt-dev@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  drivers/gpu/drm/i915/gvt/opregion.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> > index 509f9ccae3a9..f701638d3145 100644
> > --- a/drivers/gpu/drm/i915/gvt/opregion.c
> > +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> > @@ -43,7 +43,7 @@
> >  #define DEVICE_TYPE_EFP4   0x10
> >  
> >  struct opregion_header {
> > -	u8 signature[16];
> > +	u8 signature[16] __nonstring;
> >  	u32 size;
> >  	u32 opregion_ver;
> >  	u8 bios_ver[32];
> > @@ -222,7 +222,7 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
> >  	u8 *buf;
> >  	struct opregion_header *header;
> >  	struct vbt v;
> > -	const char opregion_signature[16] = OPREGION_SIGNATURE;
> > +	const char opregion_signature[16] __nonstring = OPREGION_SIGNATURE;
> >  
> >  	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
> >  	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
> > -- 
> > 2.34.1
> > 
> Hello together,
> 
> it doesnt resolve the build issue with gcc15 gcc (GCC) 15.0.1 20250228

This was a recent enhancement to GCC, and that 20250228 build does not
include it. (GCC 15 is not actually released yet...)

-- 
Kees Cook
