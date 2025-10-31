Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC163318157
	for <linux-hardening@vger.kernel.org>; Fri, 31 Oct 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915069; cv=none; b=Yi8oSKrU2raMvYk4TMzSjPMYp8VqgLR5RZ2NABBl/XBMJ2y9Zgv814ygTnp2MEjpxdxH83GbpHZESEXFb34F5c6JHJeYgDDbuIbsL50R0DTd4npYUbj1357oQI6tbg8z/PCbblINDGbFUO2BkWK63vsBih9+jAN1NZCH+3iuA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915069; c=relaxed/simple;
	bh=VjOeT4bzitG9cHTP1kuLqVSJbPFRmkPoxBQOK0kkMCw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sSHSlumcBimAYGUtrGK6m9WsalpQXzLLvR/V9x7dUThprznhYwuQprDDXNUy2ZCVz2DQW7UhubhNkNLmesoO9LR8nCIkQmQKL/Im26vvYhKZw38OhSZQIxeeTSLUWHEuUH7yfTa9Nc6t1Vfwe9cXYEBpLDXVkE7QWnWTvzr6tRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e+lt+9t/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e+lt+9t/"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761915061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1OzYz6jsSqyMk2PXMcRsst8hSVBzHs5N4nuDrzstmU=;
	b=e+lt+9t/4XU2Sro/bZjWuQl8IH/FmbYDwvgezwSq24jjqZ2FxKZAdBtpQ8WjZTwxWs326h
	mplkcSxTZswJGq+7fbE3F4CV9q6H7AmjjBf1HJeEtxtFy+t3u0fvJwuUiMeaCfwRSimyGQ
	rQzBJHipO99neIibUZhBmcmXpIiGdJ8=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] platform: Replace deprecated strcpy in
 platform_device_alloc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2025103140-plant-sprig-bdda@gregkh>
Date: Fri, 31 Oct 2025 13:50:28 +0100
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4AB5FFA3-EFF9-41FA-8204-FA66FA9D33FF@linux.dev>
References: <20251031121858.156686-2-thorsten.blum@linux.dev>
 <2025103140-plant-sprig-bdda@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 31. Oct 2025, at 13:24, Greg Kroah-Hartman wrote:
> On Fri, Oct 31, 2025 at 01:18:58PM +0100, Thorsten Blum wrote:
>> First, use struct_size(), which provides additional compile-time checks
>> for structures with flexible array members (e.g., __must_be_array()), to
>> calculate the number of bytes to allocate for a new 'platform_object'.
>> 
>> Then, since we know the length of 'name' and that it is guaranteed to be
>> NUL-terminated, replace the deprecated strcpy() with a simple memcpy().
> 
> This makes no sense.  You are saying we know the length, and we know it
> is NULL terminated, so let's be complex and do a strlen() and memcpy()
> instead of a normal strcpy().

The current version already calculates strlen(name), and then strcpy()
does another strlen() internally, which we can safely skip by using
memcpy() directly.

The current code is correct, but by removing the deprecated strcpy(), we
also remove a redundant call to strlen() without any functional changes.

