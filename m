Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1068BEA;
	Sat, 14 Dec 2024 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137247; cv=none; b=u/sqdGJzc7LEjwkbQW1F2WleG4HULDmLQu1YuXLDgmXEoM2rrHybsj1qYWrPo4RmGwheSz2c0hzE784/3c81uxKLBI989c+QD2IFtB0t2otunHtnku8q5xfKPoweW7LhY6QQn6NHZfno4BzIH0D6LzRU5fSYsLCBoDhst7xLwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137247; c=relaxed/simple;
	bh=f/cGxHEBgEAswVErS6yOfLz3KX5La9tpLLWKDmDDBTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msD8ZEnF5afXDKfbskRsvV4JWDpnUAQ4hLyoJl1jD/RuL28wMLsIKIXr7CEKuBkXHdx7MLpuuA1G+yRQhJU8xkXFP1NOHFnj6Iot990nrTr5cBYU+nPBI4Q0P5TMdZjpw9g/vUZgOxoPFWX54biemG5ehGYKqMkUwRGYelNQI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvQl4Iaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvQl4Iaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B503C4CED0;
	Sat, 14 Dec 2024 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734137247;
	bh=f/cGxHEBgEAswVErS6yOfLz3KX5La9tpLLWKDmDDBTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvQl4IajUd1IvkCmYAOLtCSL5J5lYUk4QKVX/Wxu8h2XzhdvJdpu/we1XRLtWstFx
	 dHPv7+cwzDS2BwZw/wbGAEzHx3vlZGKVBbtGzQK5dTXbHshhCOz0f+0HggLTQG8X3T
	 rk212XIk+ss4aVU/cgUIrv0TBralW/+fOtcxN0psolDcZbCvUdf9PHcsGpMSM8GgGS
	 NRxytRh2imu0ecmpFm7rTkkrX6cSKh8yAzO4zf9Ir7emM8/V/YQCXcwwb7Mu3jZXj7
	 Ezv2Dx5fUegHQEcIOiCQqBWAcWql6RYI6LI+esS0U5DBluCM1mnWaAyblVoOW8WS9M
	 7GBuyE2m164Ww==
Date: Fri, 13 Dec 2024 16:47:23 -0800
From: Kees Cook <kees@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>, Qing Zhao <qing.zhao@oracle.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH] fortify: Hide run-time copy size from value range
 tracking
Message-ID: <202412131646.54417C4E6@keescook>
References: <20241213020929.work.498-kees@kernel.org>
 <3fa35755-f822-4a54-b8fb-4fdc16579c2f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa35755-f822-4a54-b8fb-4fdc16579c2f@linux.ibm.com>

On Fri, Dec 13, 2024 at 02:49:20PM +0530, Nilay Shroff wrote:
> ./include/linux/fortify-string.h:620:63: error: void value not ignored as it ought to be

Whoops! Thanks, I had only spot-checked padata.o :( I will fix this up
and send a v2.

-- 
Kees Cook
