Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505509;
	b=UfbcMbI0HBomcP4ZHLC6aESsKK6UYsCzj5RUqu+181VQdGOU5tq0mjxiV0zw/fDZzmSu
	 r4xjIjXfp+crtr4xh3pRnwnoRzaDiG96ogVRdeBGyaaDXFo6VMg0qxdMNdmpiQ+Ohac18
	 UfGBdNuZfDsP1i9zexbnqCFRT4bNtnBGNb/b7Gfdq53ubO64kpkizSMoqRq5Uuzveiva7
	 paaUPl5g1BDmCA1IRmE1MSe6/4enzkgQ00vYYax3ARCptxsZY/06Y8YC/DMiVr+d09LyT
	 vCP4Bq64FruRQIL9Tl/2ml4vToGJxk5CWKkxuaUm1yRVMDt/S+BYlEWFVFW1gRQBqtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505509;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4jMDsjxbugAtOBoa3f8eeISPB7oA1q97U22gbE5A4js=;
	b=Hr3QrOBV69g6DHy/LGYjjClOjl8c7ZDZf7kZPex4YHHMJ60LKVMOS1qBXde2wBXU159e
	 2eL23VYpofOI8U4XsMcpnjhpN9mdTXY6LnpFASWrA57mShgcytugVZ4cmsMsnRWmKnWLL
	 kihw8IIFigqyJmJEpVxdTI0h4s1iG79Fcesjly9TyDM8pYIBfoMKsegWDcge5Nq9tsNEw
	 mb1Mwkch8ZTcfWFhoCIMDU8eRX3cB3EG3hfinbWVnKxEuoQhKQCD8dqYTcLxwkrMCg+ao
	 3piE3eypxbD1qTcol18y5vKyl7dQTrDzO6715xRZDbqOELm010WmZZqds7InPxgwCYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVV98mWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672E606A31C;
	Thu, 12 Nov 2026 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVV98mWg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4CE1F000C4;
	Thu, 12 Nov 2026 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505509;
	bh=4jMDsjxbugAtOBoa3f8eeISPB7oA1q97U22gbE5A4js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hVV98mWgXMP/hfkd+VaQdraV7iMpieTzO0IW/C60fgRY6UR/kBdglVO6kkx/Wl8CR
	 vKJWcfcHLuU+bnUKBDZQZMGJbYf0f2OVEtQ1OCY7R7QyOutruuPguFAIXT4rRv86GG
	 o+68lSSJYLzngPMKdXiEVuHaTEWIX3Bmahipz5CZMOINat9EhRJlsH9wCSZi2pRIWB
	 tQNguPAOQ9IfquTis+ue8zGp6tX+6iw6u2QudTcXhXGsSqRIFJWfuNB4xL+KjLJiRL
	 6U3+3d0cQoCBuGNNHh0Jx7Go3QCdOocdXuKNUk24c9WIOr8AGmmnLx3MznAsN7YVjd
	 o5fak9hmirsNw==
Date: Thu, 12 Nov 2026 09:45:08 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>,
	nicolas.dufresne@collabora.com, benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: verisilicon: Replace strlcat() with seq_buf
Message-ID: <202611120942.A91A689C5@keescook>
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
 <20261108200800.2b3b15cf@pumpkin>
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
In-Reply-To: <20261108200800.2b3b15cf@pumpkin>

On Sun, Nov 08, 2026 at 08:08:00PM +0000, David Laight wrote:
> On Thu,  5 Nov 2026 00:45:18 -0800
> Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:
> 
> > In preparation for removing the deprecated strlcat() API[1], replace
> > the strscpy() and strlcat() calls with seq_buf operations when
> > constructing Hantro video device names.
> > 
> > This preserves the resulting strings, including truncation
> > when the compatible string and suffix exceed the destination
> > buffer's capacity.
> 
> This is just stupid...

David, this isn't very helpful. I realize there are other threads where
you get into more detail, but as a stand-alone reply, I'd expect more
constructive feedback (or none at all, or a pointer to an earlier thread
if you feel like something needs repeating, etc).

-- 
Kees Cook
