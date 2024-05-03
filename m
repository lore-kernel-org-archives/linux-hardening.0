Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1E282E5
	for <linux-hardening@vger.kernel.org>; Fri,  3 May 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768825; cv=none; b=RlZQI/2SBJA9l6NmyHJrrrYK+wOY2U97BuUU9SUMjC74GKKJccdys/T90dhHxhz3vTSQT85UuQHevt+74qMAZvgmYKBV54j5+HxLkIWNPwzscMETBr8q65aeEznLAV3smlo1XjlwmI5r3IIOr5LlqJT1mxmkmPu6vCkLRAJ1grI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768825; c=relaxed/simple;
	bh=FzWh89LnKN/2rPVaiDqcCRxHJiQvPMtsLZtBAhKO/80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMwQrVt8OhqjywX+sjT6okKa8ytFB9PasOpT61Aoypa1MJsFyZE1zh7zqlCgQ+IRg1tKVXyg2v8AgPILkLInb3i+cFNnYipT9TvxYUjetys1t1Y8QwPWPRFut+/xjoGZLZSxTWdApRp9zfmsnrAB80hUr/xrSgJOuTi3R0cHD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fz3bhjId; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fz3bhjId"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso1475130f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 May 2024 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714768822; x=1715373622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDVI2lxNIEoHBnfc+c1mdxSwHaEoO/v2D+NGdQ5K8Ac=;
        b=Fz3bhjIdUieLRuYEOE3uyb23Ld5Lm53vdvJQp5O1U7TcMrhYJ9XUWlJfZGxfoTAZ8x
         yr/F3sUOAZoJDb6OpPk0ylskwvXSDbb5G1xjXHPZqU7PittfXMRibVFu94L5slv4gewr
         tur57wWgzbNFKLO7SWC/RqI7r87dAcmCqphkSIVSlhT6A4z65XV4gIJ0CUDWFhZw/4jE
         Jhejt9mtI7RF5kPPJhhNI299Bztlnh9qUi3dH2kNJSSRxgmIZ1MUZZgRv1xH7DitLXUY
         zyoUMidA/joOEB09HGpDDwwPmBNX2yFS/xPMohi3rT7U93ZkWQusGe38+xRexTyPiU/r
         dCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714768822; x=1715373622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDVI2lxNIEoHBnfc+c1mdxSwHaEoO/v2D+NGdQ5K8Ac=;
        b=PMxncIeIWsY8foPSqNK0EAnryYq80V/tzzwCJ33dYd8680le3x14GHmazPOYXMdao/
         WJmnBwM8bMaSAYg1TVYlh9tWT7aYBqVGV07zm6nQtledfLTShYcGqcLWUF4ot3oULLMo
         wftKDHNXlS0zAf4J2IXgLzEwt8QnF7BHM2N0nmarf0dI09cJrOmbBIMhZT4WgLpkMdnY
         meG4Ieg16jKQLI4D8K9UsO00ZNhPj8X4n39iDV3kpPtx5QOg3hZS1Nl1RULiNOQ21jgK
         rI5GyjPbDH+m8JVxMgqbZ87izwV99cOOp+xi5dWIK8gM6aZ+vOlPY10oDyfPvCFOFi6N
         KbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXmPYITt4cZJAREJbB5/0jp3jDHRge+d+hgNtzcDWfHw8LwUTkzYZC3z7NWDLVDghvqqcQMlIYYvKjBJhyelVf1X/nnspJIGHYCtwKJ6MLc
X-Gm-Message-State: AOJu0Yz4D4jhK7yg7eIFXeUbKtdv5nrtdnvzfL7EO4AxKYCFQxz0THu2
	b1udt7pGIapJxpNW98/5E44wA5G/Iqb+Crdf3VEszMLCLVVvLDwy8HFuXHmsWXo=
X-Google-Smtp-Source: AGHT+IFe4iSXZoJhuPdxqGmWEAclAE1SSjrlr58XewUMveIRQamI8LNDgaNu5eHGZFYo5X1d1Xs5ew==
X-Received: by 2002:a5d:47a7:0:b0:34e:8f88:e1f8 with SMTP id 7-20020a5d47a7000000b0034e8f88e1f8mr2101178wrb.30.1714768822193;
        Fri, 03 May 2024 13:40:22 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c359100b0041adf358058sm6770889wmq.27.2024.05.03.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:40:21 -0700 (PDT)
Date: Fri, 3 May 2024 23:40:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] gve: Avoid unnecessary use of comma operator
Message-ID: <00eaac4f-f8dc-4140-9eec-0c17bc6012aa@moroto.mountain>
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
 <20240503-gve-comma-v1-1-b50f965694ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-gve-comma-v1-1-b50f965694ef@kernel.org>

On Fri, May 03, 2024 at 09:31:26PM +0100, Simon Horman wrote:
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','.
> 

Huh.  Interesting.  I wrote a check for that in Smatch.  The only place
where it would matter would be in an if statement.

	if (foo)
		frob1(),
	frob2();

It's unexpected that frob2() is included in the if statement.  But I
was never able to find any of these actual bugs so I gave up.

regards,
dan carpenter

