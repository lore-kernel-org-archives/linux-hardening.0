Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256702;
	b=14Cwoq8+yzzrrA+ITrHCBwFzeO5HoxoGu0BUof4Nde18CfgKiB1rD3zM1f99J6u9POFu
	 zt/xGdaPvFO+IItHfXMIAuwp+lIwYO+L0ucVy89V6OO5QHKO1kz6p1NZ10KkWkFteAEVv
	 onz4ueWn6H4oLKzLhOJwrHaAG8LTLZ+5zyr2uhgIvNA/vA/QkgoElEh9pHWuj9PiaHx3o
	 sXrD1sxeil90xZ9JaG3HONLlx1BrlMzb6VnSE+ZCB+LD/Jm9eflMgXO8Mz5698VKZt59F
	 7KHJxyp7Dt9tvN+SjzKKjM/+E/6P1gS9Ii0cIHmpRBa33c4eyiN0hhPp992XbMwiu9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256702;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iUTOQBuZvFfgrneGsHjxGBAwowTnNnzKKaKeYNawjrw=;
	b=Ewc2lpL/pSqxpVCx2VPUdpJgLMHxV9y/fDYMqaSeQmcQICaAVNB2Pe2Sq5s4vOaIRSEy
	 BnVhwgoBBkLeHCdrrZNLHlcyWgJ5QeQlmb9zHRSk7KIO+0//VkI/yAs1nrT3NQlzwDg1Y
	 TRNbKlJdfN6Ou955iwlL5G3D0YzX4dDGZahFXT9tEbjnntOL2eFfnddI3kFEBCvmcxpRT
	 xdYFMQr0rEOjK3rOTKj1A3glS1DTPYl0jeERueaQpShTZnrCVMJIyOtpSot/iXSa+Anoj
	 vLZfkyXiqX+McHJCWSQ32j1GEH6VqAEdErQG5VUIr4R6iv4VIYRQXIAXTHW28vGDzNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yWMPu4Rn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8B606A333;
	Mon,  9 Nov 2026 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yWMPu4Rn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9C41F0089F;
	Mon,  9 Nov 2026 20:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794256701;
	bh=iUTOQBuZvFfgrneGsHjxGBAwowTnNnzKKaKeYNawjrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yWMPu4Rnd9pcQqdJrpS0L0B16Kw7I9eg7ICKUjdAB/frctP6gaq93Jvg5x3kRUcyb
	 tNgNBxIk+SNjfw8qrqQyWTQsV4areDiaTxg8j0KIyBAE9fYhuFYv8NHOjOjStA1vjr
	 FLO1i25JwBOYhYDo04YKx/0kS8ZQn9sx1F7i/Q2E=
Date: Mon, 9 Nov 2026 15:38:16 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Vic B <linux@vicb.net>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] security: Restrict unprivileged access to /proc/config.gz
Message-ID: <2026110958-outlying-dreamy-b249@gregkh>
References: <avCF9zEHV48EHjgG@vicb.net>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avCF9zEHV48EHjgG@vicb.net>

On Sun, Nov 08, 2026 at 03:23:51PM +0100, Vic B wrote:
> When using CONFIG_IKCONFIG_PROC, the built-in configuration is
> world-readable through /proc/config.gz, which somewhat weakens existing
> address hiding defences, as it allows an unprivileged user to simply
> read built-in config from the running kernel and build their own copy
> with identical System.map.
> 
> This patch adds a configuration option to restrict access to
> /proc/config.gz to superuser only.
> 
> Signed-off-by: Vic B <linux@vicb.net>

Full name please.

But really, a .config file is not a secret, this isn't needed, sorry.

greg k-h
