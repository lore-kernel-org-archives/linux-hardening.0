Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D264690;
	Thu, 23 Jan 2025 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594153; cv=none; b=W0C4bOH0ljh3D5k5KHCL0cvu67UWZvKLor+xZCWQDm2VN/MCOHjMfoT9vkSeoksBUMF9qCa2Z4avW3L9bS0vM+5+dEvHTdBZXMtgt6yz4nBXMElWG5EsYL5MsKHhkoaWhJnhyBLKX6XaPd4qkNRqv0+A84HrNdy/UJ1lG9lfkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594153; c=relaxed/simple;
	bh=qr9lhHLgJK7uC+8egibzqrHwFu5QVZ4kucW5t0aKolQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx7uijBvtEVIly8eb+3dkdir7oU0CPZOwfH+jfwm66HPG1IuXw8+TaeXPp7tdjT6nZgKMS9TjeMS4q/Lu3Vr64vwtN0GJ8hr95PObridAFBb1m3NhBcc+2ADyGvE3jMQ9FCB1NNX83cs1Pr4/LVJNTLX7w0nu2sI7YqUiufaDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdgWBhrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdgWBhrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F7DC4CED2;
	Thu, 23 Jan 2025 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737594153;
	bh=qr9lhHLgJK7uC+8egibzqrHwFu5QVZ4kucW5t0aKolQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdgWBhrsgzJwUjXz3X8U/i4idkxuv+zFrhQjC1q+qLX/06b55OWwuP3wzki2caKU9
	 PXKaZeSDaI5ELc4vDco3ylpBjMcBFDAMzGbpkupL2bpXRJWLxlULse+5iUY2vHpeqO
	 MCp1MtLkaIYtIhWdZloRnDT1tWZ1kqu5agO5shofAtxqFsVP7GfGxcKHaOZI+p//8R
	 rrFOllL7slvqFcbcvIn+rGQEpffjDujFwKiTXJtt5gvFm15+K7kPQtPpQ+k0eHjNz4
	 txXwfIY6uRlBeOAQ6kCJOrGmqJaSjWi238USnWIwi0qYZD0L/SaN+u2PlNI9IDZ+pQ
	 J6/ia32OSNang==
Date: Wed, 22 Jan 2025 17:02:29 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Allow default HARDENED_USERCOPY to be set at
 compile time
Message-ID: <202501221701.61D4E17@keescook>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122171925.25472-1-mgorman@techsingularity.net>

On Wed, Jan 22, 2025 at 05:19:21PM +0000, Mel Gorman wrote:
> on the exact CPU. While the benchmarks are somewhat synthetic, the overhead
> IO-intensive and network-intensive is easily detectable but the root cause
> may not be obvious (e.g. 2-14% overhead for netperf TCP_STREAM running
> over localhost with different ranges depending on the CPU).

I would be curious to see where this overhead is coming from. That seems
extraordinarily high, and makes me think there is something more we
should be fixing. :)

-- 
Kees Cook
