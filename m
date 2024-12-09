Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FD133F9;
	Mon,  9 Dec 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739887; cv=none; b=I+MNYK8YfUPGyNcI7QvyET3oPK30f5yJdKyxeBmvQvg9wJShdVNTXn/yTluzvjq52/H4CqIID50aPej273oQkRbMyeC1RSic4PZM8o4gT1tZIrnRblNqdyTG+olgFEjjH8zNB2ZrENpSIEoS36LEuzyWhEdjarlMjhz5oaudxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739887; c=relaxed/simple;
	bh=Gl6IUifIXW690iqqQdvvNKJ2BVP9fEIdA/6Us9tP2Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwDCje8yL1JaEGJulNgHXhhYzEX24AMyZtG9/Bnm47RX3rrWRDqUdYr6cDGLwhX9um2Fm58eUNzBs0qnyVENjR2MdpwohgZeqhCqPdDPy0xBu7J772Z/w+HXKP8B+8AQ5+N4p7Yd0Rdbkl6z+8KOo9+DuXkQNDRl/ZX4G7nm6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pcnhI720; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pcnhI720"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j5b/SzXNKy2u89kOS6863gKBjjhCX3NwQcbqPHiM23k=; b=pcnhI720VIIC4iKguwPtrXJIUP
	dcGVWxU5YQ9we2HgCEAG+o+Hn52tCwhG13DslCECqrt1O37IIsdo5FbxZo/C2nG4OJYQaVAWn1ptj
	aIOTLCfTctvN1zGboZcDLDHoqbhNQzHjhhr5TmQVtb68YogacokkV1EIcYIRlNyCx7r6+IIX/IG+X
	Ls3+5n3P8RvHu0NB1lmCE0DMCeSVvjo7Sbl12iCsdsjrXWSFcXkVvsICKXs9dZAYGX2B/c1CtTANL
	es0zQobuvV2vlOPFUNs9yaVuLE0HaWjKO+XpQE9+H+B+6+5eUwXNxAjB2NHWClluO7bwnXYemZBr8
	0ykOcbQw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKawS-00000003WeE-3gW6;
	Mon, 09 Dec 2024 10:24:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 331983003FF; Mon,  9 Dec 2024 11:24:40 +0100 (CET)
Date: Mon, 9 Dec 2024 11:24:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	aruna.ramakrishna@oracle.com, broonie@kernel.org,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	jannh@google.com, jeffxu@chromium.org, joey.gouly@arm.com,
	kees@kernel.org, maz@kernel.org, pierre.langlois@arm.com,
	qperret@google.com, ryan.roberts@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [RFC PATCH 12/16] arm64: mm: Map p4d/pgd with privileged pkey
Message-ID: <20241209102440.GI21636@noisy.programming.kicks-ass.net>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-13-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206101110.1646108-13-kevin.brodsky@arm.com>

On Fri, Dec 06, 2024 at 10:11:06AM +0000, Kevin Brodsky wrote:
> If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map p4d/pgd pages
> using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that they can
> only be written under guard(kpkeys_hardened_pgtables).
> 
> The case where pgd is not page-sized is not currently handled -
> this is pending support for pkeys in kmem_cache.
> 
> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
> (default).

Should not this live in pagetable_*_[cd]tor() in generic code?
