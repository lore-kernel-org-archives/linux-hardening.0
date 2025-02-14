Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140B24166C;
	Fri, 14 Feb 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527550; cv=none; b=AIhrY7dqal/9A6qjiL3cCFRgzmXSpc5dD+94PcxtAcol72GBYyRkjPSD0wU2U7Prflm5mbGkgW6iMxUfcRdHnUfwCwhlNe+ar7QvdvtEAXfKF1qmLLFEfbmj+PFs1NQbkOKQd7K8ZlSp8G3TpZKsIDb0vOyO6Y5iChECv73sxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527550; c=relaxed/simple;
	bh=hEXV7yfCSHFzsOP4HMvf4zh9MsM4ube2N74I3JPqssE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJT66GvdgAlpIpajINnqc5t4JGwudn+r6CvXakQ5FcjIitbpLNoD3F7msLRi9PIqZ2DIA+jNFsQv7YJ4BVE62tmX3cYwf20CAXP1dvephBguix9ZANUwU+qnZ9+9JQcPpyEMerPO5n1sZkQA0YM4IuO0TIF9qQ5UHbMAOJ5aqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nMGjjVI1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMGjjVI1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hEXV7yfCSHFzsOP4HMvf4zh9MsM4ube2N74I3JPqssE=; b=nMGjjVI1H2TwZJKNmdf35JE8Vv
	000AmU9Jaq0zGxW6lDXMT/kvftMXTdEihJNgYiFiS43HDy1HpyHZU8FM4zT+9psLF/6KAIOw94dlX
	zzV+R+bxi3NkNjHgQh7NtmL6ea1TxSONeZQs5fMZw/V+SF1wfJnj4scOiHmpCfb+vKVq3Lx4zzJgS
	RqSlZq8F7NnSNWN3UtV1ZgNBLgT3lpf9QYZJBFH2PAMAYpYGVrk1s7R/YZ+UZAZTMuOIZ9VnrzqpU
	vD7sMfLBjprEHtOyUq80imHQvoGX8co9DYpDgXgsE9mEhfBbX7hr23e0PRsRIRCkcX0CvNVPgtM1I
	8a8L9CLA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tisZu-0000000AwUc-1RaT;
	Fri, 14 Feb 2025 10:05:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E77E830050D; Fri, 14 Feb 2025 11:05:45 +0100 (CET)
Date: Fri, 14 Feb 2025 11:05:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Kees Cook <kees@kernel.org>, jannh@google.com, jmill@asu.edu,
	joao@overdrivepizza.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, luto@kernel.org,
	samitolvanen@google.com
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250214100545.GG21726@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>

On Thu, Feb 13, 2025 at 08:41:16PM +0000, Andrew Cooper wrote:

> The problem is that SYSCALL entry/exit is a toxic operating mode,
> because you only have to think about sneezing and another user->kernel
> priv-esc appears.

For a very brief moment I thought we could leave out the ENDBR there and
eat the #CP, but 1) slow, and 2) then #CP needs to be an IST and ARGHH.

So yeah, I didn't just suggest anything at all.

I hate all this.
