Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B9184;
	Sun, 20 Apr 2025 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745108615; cv=none; b=SF4vlS999K5kP27vzBZiqr2/gwEp3FLQ3nLxwkbkwOOR1/gv28HDlMIarWWIzzsgagAen8YHllQAmxoBfZnuIqLUiguqhMpXt+rOvzeHChmN6Vq6WDegvMHCEk7tdSOYEZzqbJc0xXnbIgWqKa+sQh+v/6H97++dYWswNUGxeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745108615; c=relaxed/simple;
	bh=7qmMOGLeorS24oT0CEaQyLEoiAXlG4rNvAsRmJBGfqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlLBI5zXT2k5cjD7j8UrV1ilB/A/IWKFlpyDh/RswQfBlfaXwOfTrTMVJlGC2FIprT4P9K7vvFF+BnY6082EEKQCIcnhBqrx8hU6oZKDQrEDbFV1FxQkzqYjEhUNlau+ZmTHJ3NBc8LiZVDAdSls4t61wWSb1JLqkU7OWNBTiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sSK4ydse; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sSK4ydse"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BaUykwIv3MMI2li2GGwFv/eaFgK+51gBnlvsi2PcbeQ=; b=sSK4ydse1q4p8P08II3rpaBzS5
	w0eI+SD9ZfE0+8JNdMhmVyjz4nRcJGBAObkOBd69xcS5Rjlo8DC3z6NXUfxwPQ15zV7e1TY+22nrP
	Kdsv2rnTC8sbmbbpSUNsKo7XS42Atibj4teZYZoZ+7KkDu9Of/wxztmFakf0+Sd/K+6leTrHv6/2Z
	m9PW9d7PW7kcAdKIMnjuYFopxXMmweWxX3seTrRHSiF0Lq3lbDLjUcYTzD4BZx462vYAMvljEcWRT
	21pqm5AtLoTT0H9aXMLnBkzd8i0IMxKMlZpBm8lHsqcc8Tq2DyDYS0ni0K5cWbzlMdO5TPyStQQDk
	5GxktKKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6ISw-0000000ARBl-3EKu;
	Sun, 20 Apr 2025 00:23:22 +0000
Date: Sun, 20 Apr 2025 01:23:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: Replace sprintf()/strcpy() with
 scnprintf()/strscpy()
Message-ID: <20250420002322.GP2023217@ZenIV>
References: <20250419114011.164512-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419114011.164512-3-thorsten.blum@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 19, 2025 at 01:40:11PM +0200, Thorsten Blum wrote:
> Replace sprintf() with the safer variant scnprintf() and use its return
> value instead of calculating the string length again using strlen().
> 
> Use strscpy() instead of the deprecated strcpy().

FWIW, an idiomatic variant would be
	size = snprintf(NULL, 0, <....>);
	buffer = <allocate size + 1 bytes>
	if succeeded
		snprintf(buffer, size + 1, <....>);
