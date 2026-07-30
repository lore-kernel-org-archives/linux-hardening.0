Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F433438F;
	Thu, 30 Jul 2026 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425893; cv=none; b=RqMO9b3HE/cVEK9T0efVD+sLS4Sg7u8GJ0EeMk4QaIb+XKc5F69+i9RNl2LeAL+xh0vbV1kJCcp0L7HNpND6QPQwXTWBj15s3jf9vkU+mowrgcT6k4fivkclj9KBkDdBVYGcqscRoYEtO0RWXWrmFzUjFLRudsqTJo+dY50K7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425893; c=relaxed/simple;
	bh=Zw3rEm7AZ+rXSOOyewiS2m8CQyVqCYTiYpi4j722crI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uly+gxnwElqjkZCY//Let9yk0CVyqHdnSeaCw+3brWC8foEgSMExEOaqc5etEOM96637T9CBiYZUYPyn/d9SnMl+yjOQYd02IDu8ywUcTKY1Q/i9MBbHhmbw+NUL7xgUodN6QbyJPn2724wMjuRoH8rPuMKU+PQounAw2z9kAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=IXo+rmTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3yIjzIL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="IXo+rmTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3yIjzIL"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 824F27A00B3;
	Thu, 30 Jul 2026 11:38:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jul 2026 11:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785425890; x=1785512290; bh=gYj31P3x7L
	fo0tCOpZV6bE7FSyxjEiMixdAb1/qa6o8=; b=IXo+rmTrqGGSJ7UrIx6plOWD+T
	V/cMUzUS+/LqEJyqa6CTXDabmwOKJca9dPdWKAXWeTE8Ky0OfCAPR611y1BI7f86
	szRQKuIET03/qdE9fv6h80TNayzcR26VEQkq3PIU+YH0vdlPAH+Gche3HWTM4u/x
	eMI45a6ti96yWB59mILHUX3hRXzxi6/9xyChHte1EPCt5RPGvZLVej1Hu42ZDyog
	huTUnWUqPExwLbS+iJZPXlkM5J5B13rCBJ/xTnfRYXmH3j1SZuVehZnGZ874yt4u
	yG88Tc9I6+ihsRkn3o/ur5eKp6FAZvB8iVM2Ay/msLCY3kg9rOXVyLFsUZtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785425890; x=1785512290; bh=gYj31P3x7Lfo0tCOpZV6bE7FSyxjEiMixdA
	b1/qa6o8=; b=e3yIjzILuK/TLjr/uH+ofB+UJeOw2CXkefDXNygm3h2Gc8T5f6a
	2YwAtrRFlpONyAp+DXA8UL3/0f3mLGKZwIzvmXtz0MAplSsy2yDUiTPfDxEkw7OT
	cwOpryChkpQe87GWM7iS/jbmL5NDq4aFBVg7qtCVVgs2IyA5ojfwGJ4+nWiOeZ0f
	S1mLyFapC5oqj3PbQOyNE33q44SFTqfnUZxKRns4y0tI8hb/J6KUP47Ryz9K3Nfr
	/UB6/1FbuXOw7jGBBJtLrKd65bXGhA7rzA5HLBVQV57aNCDio+fIOYicHipv/LVt
	R32qixFASqETc5HI/Z0/dzONsvxVas91d+w==
X-ME-Sender: <xms:4W9raryjZl44BDwdI4R2bZWbELtt8TngRNhKVJYZVGXS7zsm06pu3Q>
    <xme:4W9ratX-a7RtMz2hBX959hDdyQVP4I6rfvIn-5jJATQL9mR3JL2aBqwxcdoTG22oH
    27afW-tvfyI1zh_to-4A-QlMMMunsaf6_96TzK73hU6rITUnR_iyw>
X-ME-Received: <xmr:4W9ralM6Je-PhEb0JUGMU52weqNEa2peP65UjOuIxv7qph6bRzSQ1fmtTSc>
X-ME-Proxy-Cause: dmFkZTG0mQzgEl9RCnaToUdhTTm3IcBHaYpZ0/LAoRJhABRR2sRxPIzzQIuT/8SD/Puue7
    aMPvzZ46m3zxc76jw9WMVCbhiJ9DaQdOb98AQWav2iALDgZGa2S8D0VtYkvIO4wNP7C982
    raVaILMhRf/M8ynohqocgiWiPwUCRGY1E0HWkNch5HqFoJFPZVpAWW/TSy36qvoiGlBViG
    24AosV2RQIGlpaCysk8gNNvQVmBKcotPxeggM3ws7z8/9nyBVMAj3nxPNpsGKKi1SWCK60
    Sdg6kViv6BI6KbjF0xhcpEm9AmV77M9kNRcF1bE/FbnT7+zuAvl48qEIpASEiJTGui35Bu
    xYZQiltQ34MjDupYBjZahOLqGW05CyWgDHcYczA2QCA7XuFsTvsvghJzL84oeEyUGD7GcR
    n7w6tFEKzLx7DbztI4SpLui83IyBLXOKRyV38oqU5o+SaEQ9boOGcw9xorrVCsPgsvG966
    3sDJy+/6i376wiyDmzj0ARKJ/icMyAb4RRaQ4zlrd7OJpG1ywLVu5fLvA+3F74k1Dwtijb
    uBwvGXAH0dlgJFYCDdnzeCx9AqRu0UJKPk61Oaxx/tOWE7SKMxkvU3rLtD0Gohpd6Rj3pw
    5hh40cQLSEnXyqQsz28YwTps2pThlvbYEXhgHaC5wI31D3CaNOwrVQ5Hq8fg
X-ME-Proxy: <xmx:4W9ranBiLZLl0gyTjq0IJFTWH17Ch52FB4X-s_q8YmZJjRI8dKHwsQ>
    <xmx:4W9raqdHkHbIWieiamVScE_3gs6XJyuSh-OapQ2B9taw3t9KyTyiVw>
    <xmx:4W9rauOpq3CKWJMlo4GHFTpUDNzIoqAo6fNI21-t438rt-uWo8sf4w>
    <xmx:4W9raiLWO9Oqh8jyBIZwZHez2Yy92MBEtG8EErF_cdoBKrCh-eT2Vg>
    <xmx:4m9ranvrnzMzQRgNCvZqX-bWVXeshB-mW0MRuR6YmKrsjFgkuNDDLkrk>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 11:38:09 -0400 (EDT)
Date: Thu, 30 Jul 2026 10:38:07 -0500
From: Ian Bridges <icb@fastmail.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/generic: Replace strlcat() with strscpy()
Message-ID: <amtv37G-IDDAU7al@dev>
References: <amolHJpiluNmBsDU@dev>
 <87tspg3kx3.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tspg3kx3.wl-tiwai@suse.de>

On Thu, Jul 30, 2026 at 11:07:36AM +0200, Takashi Iwai wrote:
> Since I've been already working on a cleanup of the relevant code, I'm
> going to change strlcat() to append_suffix() (but with strlcat()) as a
> preparation, too.  Once when we decide to drop strlcat() actually, we
> can change the code in that function.

Thank you for picking this up. That covers everything the patch was
after, so I'll drop v2. Happy to test or review the cleanup when
it is posted.

Thanks,
Ian
