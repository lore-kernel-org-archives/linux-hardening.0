Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25410253B4D;
	Fri, 14 Feb 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527077; cv=none; b=NosQOKV/K2oU4DMmvpEBXcfxD5QEurgBOFTCyoRlkoQPlv5Kkh/DLrBzTQbCXsIn8kCDfIJ7MGtpLNlROibeWB7JtvyHIIqOxdvTNz4y5T9T74iMR4RGw4Pm1tE2JWrdjFRFWuS3xEFBKBkJoYNQj0WVrkntsyIHk3V2bErMfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527077; c=relaxed/simple;
	bh=RQNOBH3l7we1Vka5/0Fvam+q7Tzy13kxo1xrCnChN1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNikaZAp/hUuSOSUsLJ3a+dAt7ii7yGSpO+U4WeK+/9cji/2V4y34vs3/bpYeDaRAm5uVe3q280YYBOUd4cy7tfjQ22tYAX6jS1u+w2xoHdanHQdxoDgL2IxzBF+4Mu1iI3G+aNVCiLMxcfQV6V43yqWrerc4nDTnSsNSrzGGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XTbIu/zI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XTbIu/zI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RQNOBH3l7we1Vka5/0Fvam+q7Tzy13kxo1xrCnChN1U=; b=XTbIu/zIEcuuq7lrXTxwE7Kz7c
	k8Dx/SguwXLsk1cgTQ3FXj8GWz3n/JYOCy7MiZfcw9onceOJWxB0/qQeTwAoJrBKrSGcoKz9yZI8J
	2/w+k2Q5KTr2rUkBOqqQYQUSPgxMfmB67w7HyQrSYjvKCN3uOK52grTkTJAjE83YacXab60Fp+hRY
	lcSdX0CZYjIuna1pfAAOmLT1pMRH3ab0NKw+DApMTenkux5HtTVISF9JY//w5ofiktdVpaKntsc4h
	Ebn2IL8+hUHKO301jF+XAwRV3f7EP9NVUr136oXtrVPeElQZN87lnritSNX+67psMBbJXXUVrT22T
	KUeSB1SQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tisSG-0000000Avjq-3ESw;
	Fri, 14 Feb 2025 09:57:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0DC030050D; Fri, 14 Feb 2025 10:57:51 +0100 (CET)
Date: Fri, 14 Feb 2025 10:57:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, jannh@google.com,
	jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250214095751.GF21726@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
 <202502131248.B6CC333@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502131248.B6CC333@keescook>

On Thu, Feb 13, 2025 at 12:53:28PM -0800, Kees Cook wrote:

> Right, the "if they can control a function pointer" is the part I'm
> focusing on. This attack depends on making an indirect call with a
> controlled pointer. Non-FineIBT CFI will protect against that step,
> so I think this is only an issue for IBT-only and FineIBT, but not CFI
> nor CFI+IBT.

Yes, the whole caller side validation should stop this.

