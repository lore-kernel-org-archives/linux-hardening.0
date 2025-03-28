Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99466C2C9;
	Fri, 28 Mar 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179527; cv=none; b=SVS8puYI/sVkIfG28psgu/LM29vCuUiMYVQjKKji8faBA6WlQzEWmZnm96nfIUl/jgV/wvqg/LfTFFjb+1rjOf+BKRTcQ8lgztskhe97sTES/SzkMRDOuuvoFi2v34LcF3CTMUZNqqCqN2NgDQrru879ByhHxGxK/IuTwur1AvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179527; c=relaxed/simple;
	bh=Z1+7i1vTmCOw5i24VT2mVE304lGnoLubsdk5KvyhnHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFqDLO13Bajx0BYrZA0uVwwNpOEWW/OfNoeLekpc7Xx3ZM2akuxXHRSC+hduFG8RqXrXMz9B9PuXFhIhMlyKFH4bhedB0so9pRhV63KsbZCO8bbQAiZGYGFuLBv368WdetnofI7APQIuQgpFbkqLGLVGGDQmnSMeknPo+/wbsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyJpGqmv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyJpGqmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1675C4CEE4;
	Fri, 28 Mar 2025 16:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743179527;
	bh=Z1+7i1vTmCOw5i24VT2mVE304lGnoLubsdk5KvyhnHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyJpGqmvMdcLrvgJ0dJCh+2fFfdQa7vlrfroQdLsOJNj1rRFeSSG8IHYm6prKW+I8
	 dlO8UkjHpuYxWoXEX6ZQCQIK9OLtXve3Y3ZchyZUxSOmDHDIS+F1tvzjdtN7Ic25p6
	 kiNbQ/p82fQRztS/PzGeejxiBeURfv1/Uz2I/qG9sA25p/NIN+K3L75YEFco0Yeg5h
	 i/xjVyVERStzxHJ5WRx3aHJmnMESWh4zaSZsAWBwgFTbJe2Wm9Y5JDHF5c2tZtTMMA
	 238O6OLNx4or8PcbQfNKGFfMTWo/m5922g/xsSTrkPdifNwnP66YuRvEogsmICzgTF
	 qSlsvz1pB+Akw==
Date: Fri, 28 Mar 2025 17:32:03 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] drm/nouveau/outp: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-bPA6S56T0k9JCg@pollux>
References: <Z-bFsmWjr5yZy6c6@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-bFsmWjr5yZy6c6@kspp>

On Fri, Mar 28, 2025 at 09:52:18AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/gpu/drm/nouveau/nvif/outp.c:199:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Avoid using magic number in if statement. (Danilo)
>  - Use sizeof() instead of __struct_size().

Good catch -- I guess the original code should have been a bit more obvious by
passing &args.mthd, rather than &args.

Applied to drm-misc-next, thanks!
