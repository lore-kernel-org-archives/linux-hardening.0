Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5422422C;
	Wed, 16 Apr 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831939; cv=none; b=AL6TPx62NiV5h9BKUkQcMeNMX3UQnM3sjvUB3LjiRfzv6y21sENxNItgiXcZXV83YoUCSTW6hZqKjAlWFBAt/ntaMaUOrBVq6eMUHUV3nF0cpRTQ38soBG+fwrrJ+o1ABrq4ZJcXccefFSTeFifTw7cHZ7B3PeOIOr7chd4D/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831939; c=relaxed/simple;
	bh=wIyfmB2SiZT2uaYAoj/Kcs4AH555hJ5BbiMEFm1sCqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2n5XaFjWGDpYlHO8r/Jam6T221UFGfpa1s4/j2joEiEB3Qmyx9mO0U3KY+aBNki3pjw/VjbuB5M5N2wn4KcvqWHmGUyOb1D5JoFy89Qytnk3ZudJa3AG7Kby0Wyx87/ZZ73Ozfb58jiUA8rFalnYDjzPljpfk0a3e0FiN2fyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFe48IUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFe48IUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C739C4CEE2;
	Wed, 16 Apr 2025 19:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831937;
	bh=wIyfmB2SiZT2uaYAoj/Kcs4AH555hJ5BbiMEFm1sCqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFe48IUem3T1HWSWfHcAfUXJlyVjzJKf4nxAoCpsWtJF6JkcxMPZ7SngH2W0HCsyz
	 uM3Eni5npgxd9he+fmdKRZAmLQGej1vtiErj6c4DXhFrx4G8Gfk81iO9MJR1miA39b
	 vxPjelJpRONiaKFoJdwiElvQQ+oiNA38SsMyUYDqif1NgowxBz7Lc53wIFURRlSLy1
	 1kI3Pq7TszEZMuXnyEYp9O9CWCDpkGaIj5U+MOvptrTW9WFz0wSQKFqBxAdDew8oyU
	 phxsjw5c7cct4SpcQaW4W6i2WjV1sD92v5JIXXh1lDndjr0+10wKTpYs8ljjHOFY3w
	 kP2RE9T4l+ung==
Date: Wed, 16 Apr 2025 12:32:14 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Dinh Nguyen <dinguyen@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: Replace strcpy() with strscpy() and simplify
 setup_cpuinfo()
Message-ID: <202504161232.D4216051@keescook>
References: <20250416190908.15263-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416190908.15263-2-thorsten.blum@linux.dev>

On Wed, Apr 16, 2025 at 09:09:07PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Since the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the size argument is omitted.
> This makes the explicit size argument unnecessary - remove it.
> 
> Now, combine both if-else branches using strscpy() and the same buffer
> into a single statement to simplify the code.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
