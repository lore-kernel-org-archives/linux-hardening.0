Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A102E22B5;
	Sat,  4 Jul 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783148337; cv=none; b=fAR3L7V+hNmKzQUVrWqStQRz/6jdyUo+fNbPjsitKkrBHoh1wUgCaEvD6s6+ee9zP6BvLYivVTvWJ8PHf1FiUm9vCK7/d4v+SxrgtPclzCRrAF7gpRp1tVlqd82c84oxKpnLgxYBGVEeSQQU5XmSrfWXrtUbX0e9CNWaFAiOls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783148337; c=relaxed/simple;
	bh=B9Fx88WEfukv7fpx7vgVdh/EHWxg96ARSLx51oy9WiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baDo/aSAcK1GB9DF/b5RD7blCoigXuqGzwTwz/CpvPbdx6eB230DoQLKhUP0G4BoCJPURMF8xAbyg4jj/v1sLpDGFFPcT2LENnLBFs6xNNtrI1LhZXF/i7QOnR69Oqz1WnV3EBr0wNTvKz6TIXNuMV8DtsOnx6fWz3W4bm3glZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zTghH1S2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zTghH1S2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E577E1F000E9;
	Sat,  4 Jul 2026 06:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783148336;
	bh=twxwYxRmy/ED6kdut27R9zoWYJZWRuovBYug6VGDQO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zTghH1S2R3TvjyyEYlf5+GkKS1W4kHPJyIzBYOknmXCccDaU6p7Kg7GlMNw1gbN0o
	 OJ9XFwBMS2wWs+sjpcEwz3GRSTfIzyIMUHV32MitbmYkzqCkRqRv5HNXm2evY5KE/f
	 fjA7h3jO1Su11fdyuKp1UHhVq7wXgTD9A5F2YYXw=
Date: Sat, 4 Jul 2026 08:57:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:MEDIATEK USB3 DRD IP DRIVER" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:MEDIATEK USB3 DRD IP DRIVER" <linux-mediatek@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] usb: mtu3: allocate phys with ssusb
Message-ID: <2026070400-radiator-plaything-c266@gregkh>
References: <20260703220308.294247-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703220308.294247-1-rosenp@gmail.com>

On Fri, Jul 03, 2026 at 03:03:08PM -0700, Rosen Penev wrote:
> Use a flexible array member to combine allocations. Slightly more
> efficient to have a single allocation like this.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: add max() call to prevent negative values.

That is NOT the correct solution at all.  Please do not just throw away
error values and assume all will be fine.

greg k-h
