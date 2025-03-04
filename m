Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722771FDE1E
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078718; cv=none; b=ZRWaBCTvFqekw2x1Gbaa58Bdra8QUaHkaXwmZPmd+KQagxx5KuuN/iNyBHHitgzY0t87ojkyffnDtwfolMljDUq7JHIpRHCB9LhFZ1+s/VQQu9Y2/hFe4aitCAbVnHmbY71KoLD6UUHBRw+POg5nBcCjMz+Q4dmGAUFTQh3nH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078718; c=relaxed/simple;
	bh=nUmHrfzNp6jmDbZwNWVM32a5wL7mYYMwSCZDj8Gheo0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GJwjR68Er3FbC3/sLXfP7EoP66eC5IkuhqevLZ+WoN1v2PHrujhP+uV+xuB/WsVBzqHQr0bHfJq2tBlfwylcTqx2yszFRFqHq8VRmC4pdL9YHiO5Dwig7YNv/sLqQIN/6fLlIn7JmkY6ufIDeF17hLLqW4LetmZZLYnZGyPg7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fgdednzU; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fgdednzU"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741078714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/01Bti/qdBFlvVEApIrVpIxZmx2rAPTHByTEu+IQIFo=;
	b=fgdednzUcOniM5YeoiPiAdMMWv2f+kdYhdy7EFrkoNBbgHGQop+auflWqTvhBgwDY6JK9F
	hIawFE4YhARDHi0335OWnkNXMxpS70uI9gx3KxgDixg61XTSHpKaJgCUwjf3/q5td4/X8e
	I/r70Ebom6VgKEi6G829c3Rh08wslrE=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202503031040.223DEF2781@keescook>
Date: Tue, 4 Mar 2025 09:58:21 +0100
Cc: Peter Rosin <peda@axentia.se>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <20A47316-D274-45DD-BA15-F66139654D44@linux.dev>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 3. Mar 2025, at 19:44, Kees Cook wrote:
> On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
>> Convert mux_control_ops to a flexible array member at the end of the
>> mux_chip struct and add the __counted_by() compiler attribute to
>> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> 
>> Use struct_size() to calculate the number of bytes to allocate for a new
>> mux chip and to remove the following Coccinelle/coccicheck warning:
>> 
>> WARNING: Use struct_size
>> 
>> Use size_add() to safely add any extra bytes.
>> 
>> Compile-tested only.
> 
> I believe this will fail at runtime. Note that sizeof_priv follows the
> allocation, so at the very least, you'd need to update:
> 
> static inline void *mux_chip_priv(struct mux_chip *mux_chip)
> {
>       return &mux_chip->mux[mux_chip->controllers];
> }
> 
> to not use the mux array itself as a location reference because it will
> be seen as out of bounds.

Getting the address doesn't fail at runtime, does it? For this example
it works, but maybe I'm missing some compiler flag?

https://godbolt.org/z/qTEdqn9WW

Thanks,
Thorsten

