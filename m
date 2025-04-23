Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C428B51F;
	Wed, 23 Apr 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422521; cv=none; b=cusutiDrKh7XN8TO2XzFgt5jHws62oVJeGBQ+jC/pg/JOXZ3A06WZwMbHySFxfctax79doIFKRkgcrj8qbJLN/TTQ369qAtGyLo6vBY+rP8gMqyi/9bI7DQP48FBN845y/+bOI6iIQ73Ro516TbUc5+7MtpRWt0+59fUE3OQxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422521; c=relaxed/simple;
	bh=//m8VnyHey5kZRFQFNZt9DP8+X2ITGVIWL9+APTAHNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSiwXXvr6H/2MRnYxJFrbJuoZO2Hn67bwfMdtEOt3MckinkS69RWZqJAbCeh1v6HZqsG2DT8kmqBqLW3n/r5R9kpnwEMfCt5f7qAzJ+gT/isEoi8WLUiKeBDwbAE0Cpt0OwD/pDa+BAvn6RGD7RXch/hVuIPT2PYbm+feDxRNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hooqSaCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hooqSaCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD814C4CEE3;
	Wed, 23 Apr 2025 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422521;
	bh=//m8VnyHey5kZRFQFNZt9DP8+X2ITGVIWL9+APTAHNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hooqSaCw0kWAuhSqnJSDCEvzqQ60ibLr8/gaspSWdPYbFHALwCx9EVFOsYVkaqhTw
	 CW6F6M9Mr4Sm2qdxM9J5Ct0tQmkzRZasatLvc7wYhiTymVgbpZVuZ6nKmZOYaXyCWl
	 nrM6H3TZOplq03906zpjZ8tIUKA0ROZ1L6OW9Bw43n/S4dr/uUyOG9Ttlbsu7IZjDU
	 zF/A7r20qxNmQL7jkNpnr/IMITb7VMI3kzzNm9R2TknJW375c5Xm/kGDkaoZ9TOy3S
	 +IT4NdJdT1NVlWnWevKdcR2Znh3cpMhOfsSOR4ESrsFjsdtjMm/zWLkCs8wHtGm0Py
	 7M+GP1DXPuZ7A==
Date: Wed, 23 Apr 2025 17:35:17 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: outp: Use __member_size() helper
Message-ID: <aAkItcD5VuDg1Qt-@pollux>
References: <aAe5o_-f5OYSTXjZ@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAe5o_-f5OYSTXjZ@kspp>

On Tue, Apr 22, 2025 at 09:45:39AM -0600, Gustavo A. R. Silva wrote:
> Use __member_size() to get the size of the flex-array member at compile
> time, instead of the convoluted expression `__struct_size(p) - sizeof(*p)`
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next, thanks!
