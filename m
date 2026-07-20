Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456035959;
	Mon, 20 Jul 2026 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591265; cv=none; b=jjDmdLh8OvtoAUL5apLshHhpwt7n9J7LOumnsqbG711QlTBjUBVihTTkcLWy24QTE/lgQL+Ms2XUxoUcV343xq6yS7IvqfdnKRpE/9aP/oD25TCY55LVl8yV0gJlnNl4zx+1bzo6SDCTi1BrYjNo7WX15mzNQUEs6yuDJl7GjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591265; c=relaxed/simple;
	bh=I7fQQKNEvL0++a6FEa/7LDfVNXtiKwvmBkh6BzYT0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLHlrFtCtvLgn6zX1vAB8eu22e9jrG1d184hKWvDt9sh0tGhq9ZNpur7NIp0txI7VS5VhEJFEF5sXnOCBFkeqNd2SB5UpWYcEa7GyGa+WLcKRyjmMCDMhGhbjlr/1vP66hd+Au+LB5w8UMGdoBdpIfys6n2azHLH8e12XtBTYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPi2+iDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPi2+iDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E2D1F000E9;
	Mon, 20 Jul 2026 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591263;
	bh=JqJbBB31IZlMVBpvUAy0JToGwhE9Zu8UfXK5fA1sM24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UPi2+iDP9i0mKRkvKZ1ywILA7XF/6tYW6HTn+sj+chWNQo02tbbIJG+mtP8lnBz3K
	 WUZYh3ZPtxGhxSX4H2+GOUsPYKc0e9hGNVQXjYwFn4ranjsaOCUIISHj376WDyyHpE
	 pmEbjl7SEzo35wb5Mfcw2mZy1zXZDPK30I+IR7ZA7rwtqHUQRPTa77dVJse5/pvF63
	 dQOR5WZOHTzNnVcjivimnCJSd/uWHt0baqO+8Zuta/ZKpXwHzoHVYrDg/acqGbNVp2
	 T56z0zONKXkKWTN6jJtWMgyky7SqCL5mA5Hz5QBPwqJFKCBAcDbKOviPSDdEPaZMEG
	 9yZPTwM5POhRw==
Date: Mon, 20 Jul 2026 16:47:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ian Bridges <icb@fastmail.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Replace strlcat() with seq_buf
Message-ID: <20260720164742.79708366@kernel.org>
In-Reply-To: <akiCtALVjd9TF8Xl@dev>
References: <akiCtALVjd9TF8Xl@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 22:49:08 -0500 Ian Bridges wrote:
> In preparation for removing the strlcat() API[1], replace its uses in
> __devlink_compat_running_version().
> 
> The function accumulates a variable number of version strings into a
> fixed buffer, which is what seq_buf is for. The seq_buf is anchored at
> the end of any existing string in the buffer and each version string
> is appended with a single seq_buf_printf(). The output is unchanged,
> including under truncation.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]

It's fine.
