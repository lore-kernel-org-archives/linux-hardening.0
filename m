Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16B2989BF
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970218; cv=none; b=jpy6kxJKhjpud6ZbRQyiU3ZO5ZpltstVsETbAvZ1VJnJEK75vFTWCMoyI1bhdkzwVXMI053nRHPt39EY5g03qebeqjdzlwohRej9jeQm7CZMUxBdVVQxrfVqp/x914t7i42FazCQ/zL41CTL9S2NfwnqDGq8IWDUQIB450gDlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970218; c=relaxed/simple;
	bh=uEBHi1/Nd65Yk4JFgavPfr8/x27vb+2qDDKICNi5kEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmYuv4HGx7ACiax1oIg7PIFFa5t26vhF5nbc8KIn/VEEUon6F6nSvveSXdlvpvnKQ/Vcxtj+yiYgptFE4Xm8gh+a7KAZx5EVn+SCp2GtbtATnBeVzISBiqP5EdjRMtUxYAqxBcj7gpbFRaITBNvB0W/teL7H7s+mg8uqyxQAuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5RhG76Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5RhG76Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r+cq9OIorS2Vp446+qAYxSS1XwSePxOY9/oPX5Y9FWw=; b=g5RhG76QLX1w514gH6I1xnwfKw
	iPocXPc2LzuKS+edFGh/FaWaYk2Mox2MewR76/dEWgKcZTzwzi7PZ6pEqXQf4vps6ATBGnZBvqG4k
	QhS2RlmSDL4uEVbVERjhl6OrbkxD8MP2NjOZsT7G6mQGmMJdLEShlnBhI/xxJSMNCzLUrq/GZY6Av
	/My2W/z47am7OY5ZqsVtn2BZuZCaPJaxaBUFGrr0WwcrheKcUn5+9HPAaq7sZi19kNbTmf6IBO6Fo
	AAQa3ndjIRXB7Ro3YEBgAxZ+yBXwrEF34iNtp7sLCuIxmCKzdeb306MwXNjDXTC+y+Yjf0M9Fo419
	sli4f5ig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu4CP-0000000Ehdp-3iWo;
	Thu, 04 Sep 2025 07:16:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3FA7C3002BF; Thu, 04 Sep 2025 09:16:01 +0200 (CEST)
Date: Thu, 4 Sep 2025 09:16:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <20250904071601.GY4067720@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <84E03295-212C-4A89-8F8E-C5B1BA74C7EB@oracle.com>
 <202509032057.34FA2F6AEC@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509032057.34FA2F6AEC@keescook>

On Wed, Sep 03, 2025 at 09:24:22PM -0700, Kees Cook wrote:

> > If the hacker knows these, it should be quite easy for them to come up with a
> > matched typeid, is it? 
> 
> The hashes aren't considered secret -- they need to be known/match between
> compilation units, and even across languages (Rust). The KCFI mitigation
> is fundamentally an "exploit surface reduction" measure in the sense
> that it limits an attacker's set of callable functions to only matching
> typeids (instead of all functions or all executable memory). I discuss
> this a big more here:
> https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693059.html

Also note that the kernel with re-hash all the values at boot time once
more -- further increasing the difficulty of an attack.
