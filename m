Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C9137C35;
	Mon, 17 Feb 2025 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818491; cv=none; b=Xmjh6F2+XSGdJargr+UsOo1X4YJEoinwS+zfm/jfJ4DduD7ad18f/D8d3rTCxmvdJvelL2n6nmOsoXrtNZpQZCTEE6xiajxKHZ1qhGSmRggmexlsF+1GhmJozqwmtxxERMhyk5cD8ctLc0iX737JRxNLxW3+iXLH8+NjvmkGsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818491; c=relaxed/simple;
	bh=g4TJnvUD87KafZ/mZZfTJAtPLuW10pIjfOfX0DLb/U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN/vzjxM2CSHLl8FZQvfYIl94GVHmZqw2wq36UKKhtHyk9+m42lvfatKKrLqmPS11mCEQVQrUTjDXZPYax9os7hQMyhd32N+MZVZFYqaJVzJKw04gUZCzfMZIZDltOQxBAQyMNwt1UXM5WTMlWkyOd2FMcK1sCRgXOLueTibh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vHR7fnDl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vHR7fnDl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g4TJnvUD87KafZ/mZZfTJAtPLuW10pIjfOfX0DLb/U8=; b=vHR7fnDl1Lp3OVr6TSz/vzzRPX
	ioW3vkuyFjMJ2wYe/FQ02rUNfrd93fmAJ/3OLXhBJ88G6pdplv1z2gtlR5nks+2TVw6/pRdSmoac/
	R4HJzAyGTNxs2Wz+4hZ8KF80PqWXmVvZ9GfUIOn+8GO+6vy0JYPdgkYe+d9ouW3/j5HUcGiLw1OOo
	DS5aaWefM99LS8Xq2qrmz2WyHQaL/IFU9GB7awJ/tatkWOeXiiHWSb2QC9NSIb9W3Eyit5mqD2nEr
	ivOH11PjWLj+AlwSUdPg6UfNfIyMEtkijRRRW8ltSftQqTuRp0J6AT3Rey4hra0AyI3sY0wu8AhVO
	0xyMuraA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6GS-00000001oC1-47BQ;
	Mon, 17 Feb 2025 18:54:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A532300756; Mon, 17 Feb 2025 19:54:44 +0100 (CET)
Date: Mon, 17 Feb 2025 19:54:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
	jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com,
	scott.d.constable@intel.com, x86@kernel.org
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250217185444.GB7304@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
 <202502131248.B6CC333@keescook>
 <20250214095751.GF21726@noisy.programming.kicks-ass.net>
 <20250215210729.GA25168@noisy.programming.kicks-ass.net>
 <20250217130629.37f556b0@pumpkin>
 <20250217131321.GO14028@noisy.programming.kicks-ass.net>
 <20250217183827.41da5f52@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217183827.41da5f52@pumpkin>

On Mon, Feb 17, 2025 at 06:38:27PM +0000, David Laight wrote:

> I may not have retpolines enabled, a typical call site is (from vmlinux.o):

Make sure CONFIG_FINEIBT=y, otherwise there is no point in talking about
this. This requires KERNEL_IBT=y RETPOLINE=y CALL_PADDING=y CFI_CLANG=y.

Then look at arch/x86/include/asm/cfi.h and make sure to read the
comment, and then read arch/x86/kernel/alternative.c:__apply_fineibt().

Which ever way around you're going to turn this, you'll never find the
fineibt code in the object files.


