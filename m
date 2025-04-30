Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880E2C0335;
	Wed, 30 Apr 2025 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046615; cv=none; b=QLm3WVhlQegwNR8pbG5V3jZCbUxAnM/fDZdquWc19xk+iqa4Z4rdJF+djkN8WcGmJ50kN0xLQlHJeIJ9RPK9Ov1shexmYxi+iF5yMQYM2C0MkOS1kvzIEJX6154QydQHa6iIRbYun9YtFBKn3XX9NVqDXMclZnOhtLJZHSRPA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046615; c=relaxed/simple;
	bh=Aij4i/GLYEGdgGGA4PGBamSpajKust3Y5rfCQeLlqoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEUMy1GU3vqHKJkwdljcJw5vKn+qqtNlByJQBzzElCiTRWYv0B0JZ+/MhTkL9EmmCNzVfyKZTeRp/+Fw0SP6e9Kor2DeBowRG79H00Cy00qrEcjP8LUZRUO+73qGFrc+E+fjAKvstjo5GrvWsR+V386wVCs0mLbX4d7Mh389xug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGc/+ILO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGc/+ILO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A155C4CEE7;
	Wed, 30 Apr 2025 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046614;
	bh=Aij4i/GLYEGdgGGA4PGBamSpajKust3Y5rfCQeLlqoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGc/+ILOaykX0mvy8HkZ/uI+yGK6P+MQY2ujpGz/vhPimWQi9axqMXH4tWh7GysiR
	 c9UViOIvKI1HZiQrH42M4O4ey5O6P1AzL4aYnKU5wsB458yUej4Ab7HzBJiVn5k2pN
	 l3BLfkGpMinO1WzVg1c8heV90NZEaF/ljI9MTfwE66nle66Pewx/sPJyIPvNus7I6r
	 wf+xQWu2JE9Ghpn6MQ3HIYbzAVluDtgMkFEDSPFognVknEMSRbaSBH7h1nYWvtTQf+
	 le487fiOezLPdpRoNXUyRJsk40ErSQZWLZDl9O5RHjv725GHMo+gx8RSvyNsy0cjNi
	 fssO6uwU+tsfQ==
Date: Wed, 30 Apr 2025 13:56:51 -0700
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
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
Message-ID: <202504301356.CB1EEC719@keescook>
References: <20250426061357.work.749-kees@kernel.org>
 <874iy8y0nz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iy8y0nz.fsf@intel.com>

On Mon, Apr 28, 2025 at 02:40:16PM +0300, Jani Nikula wrote:
> On Fri, 25 Apr 2025, Kees Cook <kees@kernel.org> wrote:
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
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> for merging via whichever tree you find best; please let us know if you
> want us to pick this up via drm-intel.

I was figuring each subsystem would want these individually, so please
take this via drm-intel. (Or I can take it if you'd rather not.)

Thanks!

-Kees

-- 
Kees Cook
