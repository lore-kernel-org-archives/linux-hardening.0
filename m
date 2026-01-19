Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB698389E0A
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835918; cv=none; b=MOS31Ufs+H9JPDX/TMc3E/NSRBjRE8eS+plA0fPHo/pD1c3wRSPLWlUCokc95Jq242vzGLbFr/Y8kme/XAsPvo8lXXvfQIzmjPCpFHTGqvZwoQlwfhyV6QX+Dl4QJOpiP+OeE1rlEJqzB0rukFkMVvZkNYTIRPJv9+spa0RgSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835918; c=relaxed/simple;
	bh=benepdXqNFJJEGYtUD5CAZxKsTPdNw8vQHTJ883YUNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCGZQmmrI2BvvKbENdkdeBJ/XCcp+1nsOZdIMmx7KcS7K8ydP5sauMVMBwKc6lFivCV/HwEuJZS1MKOsAbCSa79tbDLOcGT81FNnu5ueJxbHuI5Zn0zczkJNp2S4cQdwgJ1l5kx5BFKmrIAHJ30La2js+lyOYJeZ8L70h0bjLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhYb55Lg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhYb55Lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E447FC116C6;
	Mon, 19 Jan 2026 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768835917;
	bh=benepdXqNFJJEGYtUD5CAZxKsTPdNw8vQHTJ883YUNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhYb55LgL1oZEx4gsNlbv798YZOwcEyMN16YeS1tf4ZXEiU/A6sdcoYrHTAgV/oUz
	 vRU085H0zS++xpxfUFKpmYaPkV219IXvTbEthZLmPIMHbFr0nchYytnsng9aoy1fpU
	 Tvt4rHlVYvfB7jcj9UxYlIohH4dQgPW8pwicuZTRNck9VLlW7p/cn9GadLvvLijGEc
	 bUiPgpvd9PShBJDbw5SGPuE+pRFEZy77kW3n9zQMR8Nha2MctCpX5QNeTYBFBTXmsm
	 L1IhHI0T95vQ6ts4+IMrs3seviNs7JGiqExbwjt4gfEjxNTdHmJHfke6Un5QBY9EN+
	 O4uSv0Uigo9gw==
Date: Mon, 19 Jan 2026 15:18:32 +0000
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
	mark.rutland@arm.com, catalin.marinas@arm.com, kees@kernel.org,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>
Subject: Re: [RFC PATCH] arm64: Bring back linear map randomization using
 PArange override
Message-ID: <aW5LSNqClja6MUo2@willie-the-truck>
References: <20251211040935.1288349-2-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211040935.1288349-2-ardb@kernel.org>

On Thu, Dec 11, 2025 at 05:09:36AM +0100, Ard Biesheuvel wrote:
> Commit
> 
>   1db780bafa4ce ("arm64/mm: Remove randomization of the linear map")
> 
> removed linear map randomization from the arm64 port, on the basis that
> a prior change to the logic rendered it non-functional on the majority
> of relevant CPU implementations.
> 
> As has been reported numerous times now, the upshot of this is that the
> virtual addresses of statically allocated kernel data structures are
> highly predictable if the kernel is loaded at a known physical address.
> Any bootloader that still adheres to the original arm64 boot protocol,
> which stipulated that the kernel should be loaded at the lowest
> available physical address, is affected by this.
> 
> So bring back the most recent version of linear map randomization, which
> is based on the CPU's physical address range, but this time, allow this
> PA range to be overridden on the kernel command line.
> 
> E.g., by passing
> 
>   id_aa64mmfr0.parange=1 # 36 bits
>   id_aa64mmfr0.parange=2 # 40 bits
> 
> the CPU's supported physical range can be reduced to the point where
> linear map randomization becomes feasible again. It also means that
> nothing else is permitted to appear in that physical window, i.e.,
> hotplug memory but also non-memory peripherals, or stage-2 mappings on
> behalf of KVM guests.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Cc: Liz Prucka <lizprucka@google.com>
> Cc: Seth Jenkins <sethjenkins@google.com>
> 
> This is posted as an RFC because there are obvious shortcomings to this
> approach. However, before I spend more time on this, I'd like to gauge
> if there is any consensus that bringing this back is a good idea.

I'm a bit worried about knock-on effects of restricting the parange,
especially for guests, although I admittedly haven't had a chance to
investigate it properly.

If we instead made the cmdline option specific to memory hotplug (e.g.
by providing a ceiling for the maximum physical address of memory that
can appear dynamically), would that give us what we need? For Android,
we could then pass a value of '0' in the default cmdline (effectively
disabling memory hotplug) and the onus would be on the few platforms
that care about hotplug to set the value correctly.

We already have "mem=", so maybe it's just a question of special-casing
0 for that (assuming that memory hotplug respects the memory limit).

Will
