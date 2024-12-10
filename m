Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0241A2846;
	Tue, 10 Dec 2024 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833443; cv=none; b=FwiebFyWmElL6a+BWg/HKqRJdZE7U3s0XbFnylLTpICuanqNL1BMHsNEmPeoA4IMYooT9jnx0wVkoSKgaL04oiCan0KRNnWzY3O3AiK03m/AZLzUiR90j7+MEwjDi7vsIXz5flgJKsHs9V0NqwA9P7YisdenPf/aTDe33fZ7I5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833443; c=relaxed/simple;
	bh=JnmlQrXNx7ybWi0rdK9ms0RbPeanflyjYHtDBbX/2bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFNlRkTgf9By1u8pXE/cAwMSn+syBvkowIqZVoDvBqI2EnB3if6rwehBf6FXvqmKvDEH6O1LF7o9Byw3AqO/xBvALgKjRyeLeX2JCWzj+y9bh6yfKoVb9Qcmy+Hg81kvF5D3/Rt/lp/bhO+oU2P4i/Tq/Rx69RyE8k6QRtZa1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qdfGUwAv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdfGUwAv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f/eUtBAHx6MS1dX7eeAudCi0CALBCFNE6mgKA9s28LY=; b=qdfGUwAvEEQV2wUx348q6k4+P9
	VCkjJ7pobieCqHDS74H/oP4A6dG3+QbaIJB7hrqGzA8iynjLbRkjSrMSVu3U6YeTsH+LJFo0b8XMe
	7wSDCiuHwKTcIZEstwTFf/2dX7bnDTeQ6tsdGnxpAAP+4YrguPKw9vi1RANyIPzpqi8YyfZWXDOXi
	nYz68Gi833sXAbtAYn8DHqTr6b02NpKIy+aeX2r2e7G/oZjdUn6XQ4zQXpmnHNvOO/mbeAmIMi6qz
	McIYLZeit79p2zVsxFhWP6Gyk7DxAyUrSBPmPks9wuocCjvCEqN7W8BEGfLzb2dYwvGfpFYnAYCsC
	R+7uT24Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzHQ-00000003fnB-0fBo;
	Tue, 10 Dec 2024 12:23:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB96230035F; Tue, 10 Dec 2024 13:23:55 +0100 (CET)
Date: Tue, 10 Dec 2024 13:23:55 +0100
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
Message-ID: <20241210122355.GN8562@noisy.programming.kicks-ass.net>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-13-kevin.brodsky@arm.com>
 <20241209102440.GI21636@noisy.programming.kicks-ass.net>
 <75a345d4-78ea-4434-a4cd-3f2095ce2b31@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a345d4-78ea-4434-a4cd-3f2095ce2b31@arm.com>

On Tue, Dec 10, 2024 at 10:27:56AM +0100, Kevin Brodsky wrote:
> On 09/12/2024 11:24, Peter Zijlstra wrote:
> > On Fri, Dec 06, 2024 at 10:11:06AM +0000, Kevin Brodsky wrote:
> >> If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map p4d/pgd pages
> >> using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that they can
> >> only be written under guard(kpkeys_hardened_pgtables).
> >>
> >> The case where pgd is not page-sized is not currently handled -
> >> this is pending support for pkeys in kmem_cache.
> >>
> >> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
> >> (default).
> > Should not this live in pagetable_*_[cd]tor() in generic code?
> 
> This would certainly be preferable but it doesn't look like such helpers
> exist for p4d/pgd. For p4d, we could potentially handle this in the
> generic __p4d_alloc(), but I'm not sure we can assume that
> p4d_alloc_one() won't be called from somewhere else. pgd_alloc() is
> entirely arch-specific so not much we can do there.

Can't we add the missing pagetable_{p4d,pgd}_[cd]tor() functions. Yes,
it will mean touching a bunch of arch code, but it shouldn't be hard.
