Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C22325494
	for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136908; cv=none; b=dNTV9ACoMFjaG97svSe+dfY2Z0YevZmySuUJrumDviHC/LudDRO8z5V/SqqytwK5yqz2NwadP/fG9hAnWvktAlq4abiwubpkJY23EP8qNtaKu+Jn++5FjAwI64b8PSo+Wi5zxUAXIzTqzMoz8We0RxodNLElsUpQDnbpqcMS5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136908; c=relaxed/simple;
	bh=cdP+mVz3wzeJb8i6rc2+VIT7nAC5WdXD6lKv0ZSGh+U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ib7icpTsQeyLfYJtwglHRSsfm8XPML073dI7c/a7XgKHOJTsjwQEQa3n198T8ZHQBbDdAG9vE/nYwCgDzaop0X1rRUrsWACHl3ZBlSARdPEFBY+kk7jYh5khS2q1HlYtrrcp0QbLQuGCqsJBVgDZppLM+v9xDjcRK3oGPWKBCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NJEVN19j; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NJEVN19j"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763136905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdP+mVz3wzeJb8i6rc2+VIT7nAC5WdXD6lKv0ZSGh+U=;
	b=NJEVN19jigGT1vREWH8FWJ+HUQCRGiLoF7N08ciybnr4V02V9g1COoq6Oj/kUlzplIgq99
	X4jORsfyQT7q2wkCl13izRXdOtAkuMsslbcQ+OV628N1mTL0owoQik7rA+axltFIgBGcwE
	4JMSlCRDw4hauHknbC01HCP244TGTa0=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251114104952.045805af@gandalf.local.home>
Date: Fri, 14 Nov 2025 17:15:01 +0100
Cc: David Laight <david.laight.linux@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0EC77204-065B-442E-AD0A-B86B5CB3ABB2@linux.dev>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
 <20251114084346.6469edc0@gandalf.local.home>
 <20251114143104.0d1aead3@pumpkin>
 <20251114095644.116a767d@gandalf.local.home>
 <20251114104952.045805af@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

On 14. Nov 2025, at 16:49, Steven Rostedt wrote:
> Which comment would you feel is more obvious that entries is not bound by
> nr_entries and prevent this patch from being sent again?

Both seem fine to me.

