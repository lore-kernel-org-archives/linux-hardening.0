Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960B2D7AF2;
	Wed, 30 Apr 2025 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046567; cv=none; b=P0MZFn6CRwt+d0bmSFSMaOZzNOot4cRLAc3P3uLVJfcgFNGeYmZx/ctMMpGLCg/4JjLtb9S4XiNDOwUzBylqOQSP0JyyYbd/K92OnxDgv0PSb5xsSbPgIoqnE45ayw06vZhbQ2dTEhJiNf04yNMWQwz+Wm2hm+UXkbHc3d015jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046567; c=relaxed/simple;
	bh=5WlOBIMyZu14MsuChvx0QeTj/6eyRZleYM4wcV0ju5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AROoJXxL0hrB6up6ZlOcu8LOAmthIWfpvAo5Xo1mLc2SkeD0Lx5OG3XuXSnpbpTNFB30+hp1zxLISuHV7vn7k4KkqE2KhiPnHuBYwGUiRdPGzcpDJsbueOhgrb3nNn4bm8XQNfZIsUxEEcm+j0/LCceloMoG5H4MeuTR57JB6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prsN5laj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prsN5laj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879C4C4CEE7;
	Wed, 30 Apr 2025 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046567;
	bh=5WlOBIMyZu14MsuChvx0QeTj/6eyRZleYM4wcV0ju5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prsN5lajAa/gzMCh7ksmln1lnlfRi/xq4xOeW87f6UT0DCG3nSAI0VD1eEfR/eWBY
	 /Er9SN3dHQZLfXYsoa1RwBC6edLYp8Bznelt4WfdI7bMIcilVA1Hhh5fL10b/aaVwh
	 g5juk+gvVNvFV3N5AKp5qfxjT4kH2g5rKCtLl0RbU1vTMOHNrtZgBgEQjkXYL3i5Dy
	 e96Zip9BB4mK4ZgtbA0mNzlYwNrqJyoD/9MLxEWq9fM208GnsPavZbC7f7IuIAQpNn
	 XGvXR7J5m2dSc7XBXKSBdOCz5iugroSl9686DfDSl1CPh9WUr5+mdQpPvphaYQbLk9
	 lJjt7/O64yVWg==
Date: Wed, 30 Apr 2025 13:56:04 -0700
From: Kees Cook <kees@kernel.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Gnattu OC <gnattuoc@me.com>, Nitin Gote <nitin.r.gote@intel.com>,
	Ranu Maurya <ranu.maurya@intel.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Angus Chen <angus.chen@intel.com>,
	Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Remove const from struct i915_wa list
 allocation
Message-ID: <202504301345.659CB6B@keescook>
References: <20250426061357.work.749-kees@kernel.org>
 <7f1ad610-5a37-4f74-8eee-5f37556d9576@ursulin.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1ad610-5a37-4f74-8eee-5f37556d9576@ursulin.net>

On Mon, Apr 28, 2025 at 01:09:46PM +0100, Tvrtko Ursulin wrote:
> 
> On 26/04/2025 07:13, Kees Cook wrote:
> > In preparation for making the kmalloc family of allocators type aware,
> > we need to make sure that the returned type from the allocation matches
> > the type of the variable being assigned. (Before, the allocator would
> > always return "void *", which can be implicitly cast to any pointer type.)
> > 
> > The assigned type is "struct i915_wa *". The returned type, while
> > technically matching, will be const qualified. As there is no general
> > way to remove const qualifiers, adjust the allocation type to match
> > the assignment.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > Cc: <intel-gfx@lists.freedesktop.org>
> > Cc: <dri-devel@lists.freedesktop.org>
> > ---
> >   drivers/gpu/drm/i915/gt/intel_workarounds.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> > index 116683ebe074..b37e400f74e5 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> > @@ -156,7 +156,7 @@ static void _wa_add(struct i915_wa_list *wal, const struct i915_wa *wa)
> >   	if (IS_ALIGNED(wal->count, grow)) { /* Either uninitialized or full. */
> >   		struct i915_wa *list;
> > -		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*wa),
> > +		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*list),
> 
> Will the sizeof stay, and if so, how will kmalloc be able to distinguish the
> type? Or we expect one more churn on the same line?

It is expected that when (if?) this happens, there will be a pre-rc1
treewide change to convert kmalloc to kmalloc_obj[1]. (So, yes, this
call would change, but it'll happen separately.)

-Kees

[1] Here's what v4 looked like:
    https://lore.kernel.org/lkml/20250315025852.it.568-kees@kernel.org/
    v5 is still under development, but will look like this:
    https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=dev/v6.15-rc3%2b/alloc_obj/v5

-- 
Kees Cook
