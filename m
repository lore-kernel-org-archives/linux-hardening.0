Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740323AD;
	Wed, 31 Jul 2024 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384103; cv=none; b=ghbgjN7VeG9xqTptcMHNcROQ77YHb3PA9wsfeKFlhGYVhCt61GmMRSTeygHEkJxymUoTxcyPRCmzu5k1AL95aW0Q3X0u1x12GMupTeZ80ggTW+zUJ9uhXOfLns+k55ALSxG7y4miuLmmmjAVF4TmSXkdSrpWpW91cUQeyPvr348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384103; c=relaxed/simple;
	bh=4g3nEjvAJJAVFmDYcG/ukBo2D4pJnpU3tLxdbiy1AkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch5hUa6o7loDTXjxRzgPbdw2eFvVO8SIklPEOOWUjuAtuAxlRTQpGxfK8weqeMEXwdZTlt06+zdH2b1g2W8H2zpfKTYoA9uE1aLaooRL2mPb+SKTd4KdpJ40Qwd04zbQh1k41U8PelbGlVes5ChR4WmsBDIq6/y2CQugYZ8NMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y05ljamg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y05ljamg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0195DC32782;
	Wed, 31 Jul 2024 00:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722384103;
	bh=4g3nEjvAJJAVFmDYcG/ukBo2D4pJnpU3tLxdbiy1AkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y05ljamgNDQACK1N10wbYOGQ7ZLJL+4vBOz5QdeRDzHF4S7Kw2i4Kt50PfYepPIeq
	 iZAMdcuJFavrTyRYT2tVT3FngOT/ElMKJeZzo/uJcNSZIjH9hClbpF+7M1H+Aj2XDK
	 FtjZT7l82mDQgxO7QAvQFTHoseVBqj2t14nENnU9qTyseqTwUwiFi5BoIG/jAZ2+wV
	 oBrb5S5fC8po9adj2vq+FnNBJImffJBEah0Eqjs2i0kF9K7G573bwGt4Z6gk0XQBcE
	 khGCuKeTDIVT0p+j0mQARfSODu0TyVtk9xEF1xmCvpSL7a25mJOa7yl/uiDcSUZSOw
	 XBzUwNVOifYdQ==
Date: Tue, 30 Jul 2024 17:01:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: core: use __counted_by for trailing VLA of struct
 sock_reuseport
Message-ID: <20240730170142.32a6e9aa@kernel.org>
In-Reply-To: <20240730160449.368698-1-dmantipov@yandex.ru>
References: <20240730160449.368698-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 19:04:49 +0300 Dmitry Antipov wrote:
> -	unsigned int size = sizeof(struct sock_reuseport) +
> -		      sizeof(struct sock *) * max_socks;
> -	struct sock_reuseport *reuse = kzalloc(size, GFP_ATOMIC);
> +	struct sock_reuseport *reuse =
> +		kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
>  

please move the function call out of the init. It doesn't fit on a
single line so what's the point..

> -	if (!reuse)
> +	if (unlikely(!reuse))

And why add the unlikely here? Seems unrelated..
-- 
pw-bot: cr
