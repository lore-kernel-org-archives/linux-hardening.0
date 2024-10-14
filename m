Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980631D0F61;
	Mon, 14 Oct 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945843; cv=none; b=GIO37sOo7CwV/7oulPXV71DrPfbMVArwxT6bdjzRAMwix8Nc4q7trRxU2ON2rBQUyujmPf8/l0Jn0tWiF2io70xJI/mfnDQT19Btd3jzpG2Rmex1K/fxYTFuHkrbvFexLh14DX7hVU0HxAUOfIU6i1ZWzyX7cNHQG5uvLvbBnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945843; c=relaxed/simple;
	bh=sxJBnWVh7J6MjJ9oBAwciomAVXeFtNxyj3zLblO2gi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFzvYwKRtHBtvIqPTkqfcoWBnKxj+hos4//xUC4lbZ7jG6rEpErJXYxPp/nSfLSg5GSwaUSd2/qt15TZHi7yu8mVZ0GyuWmayBVkUFUCvq60LZVuJooRmTKawPGiIcDBoHblkvGyf1K2hs+k6HgD0k1Z/KQIsBaACxdl+fupM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trlF7r/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trlF7r/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60A4C4CEC3;
	Mon, 14 Oct 2024 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728945843;
	bh=sxJBnWVh7J6MjJ9oBAwciomAVXeFtNxyj3zLblO2gi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trlF7r/c+Q5H+ZJnQO4jMY33LRU5hksjgwCaMfrLDzpF7s1Vsvz82s8lpzL+S5rw3
	 F2rsweRP7bzXrv4gJ8yxp/KLJmQP+pIVMLoc+GGY2HwvnywGPqJb31S6SxTlGNW8UA
	 JFBpZmGyjS3i01CpgkEIVQsgpcdyobNKCdSxVj4NmqOgy4j+rpSrTewPmBNQjFWUjR
	 715SCZmoJLlD2Kctej5qnDUVROGkEZ91BATrE4rSsdRA9+GcB/fFPl1CalRHXpHTgE
	 n4g5z2ZHDqbDWKmt7LLjx8VEvzuQtalzi/IOEFlvEmNVX1YoiGcMG/HGRegQvz+AKD
	 WjmQH45G1w3Ww==
Date: Tue, 15 Oct 2024 00:43:57 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Zw2erZCs2aX_pCRh@pollux>
References: <ZsZLFS1CsHkKjw+C@elsanto>
 <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
 <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
 <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org>
 <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
 <81E112F0-51CA-4171-8DA7-59EC8AE14510@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81E112F0-51CA-4171-8DA7-59EC8AE14510@kernel.org>

On Sat, Oct 05, 2024 at 09:04:11AM -0700, Kees Cook wrote:
> 
> 
> 
> >On 03/10/24 12:36, Danilo Krummrich wrote:
> >> On 9/13/24 12:23 PM, Danilo Krummrich wrote:
> 
> I am reminded that I should check all my MUAs to render the date as YYYY-MM-DD so my brain doesn't explode when I see people "time traveling". ;)
> 
> (BTW, what MUAs do you both use? I use Mutt and K-9 Mail, and I need to check the quote prefix settings in both...)

Mutt, and (unfortunately) Thunderbird for HTML stuff and a few other rare cases.

> 
> -Kees
> 
> -- 
> Kees Cook
> 
