Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D4311C2A;
	Fri,  9 Jan 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971803; cv=none; b=D8mxFTjv/9opVmSoRKFqUvaV301W8+zfBkazE4Tv94GW+NVU71tozogE5B1bJtxf+n8Bb74hV7PumLzwZ5l31OPQGpp8gOchX3IKqNqu2Aobl+GHhB/bkds8BlynanLQjLzkmwauGaHdTC6nccT3EDJhP5JkfAttPdM83c4Ahw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971803; c=relaxed/simple;
	bh=TwCIHc4FDKyAmychWf6wK9UKfVVSINwm2NA+GwALIUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fudEYO3rzOSFyqKblWKx40X9wHLvNBl7w3O6EDmehYY44q/JsNM7x+7D6paImN+GAvi3nymStr31iJYmJ0hNn0y0Bly7Nf16kjVpsGzvg8/OSVaVuLhoC5iD0RXzSUo0vF1aHcmP1ATi2NbHi+vUBFAsLd3BZARO8TeDfoz8UmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUfxyBIV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUfxyBIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767971802; x=1799507802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TwCIHc4FDKyAmychWf6wK9UKfVVSINwm2NA+GwALIUQ=;
  b=AUfxyBIVlEBTW69zTXeLMrRVhUWdrgClQQQmYO0d0jCjH2All6g4O6sB
   hgmhCj5WGU1N2td9Y57gxFxr0+3bR/o0asoYst10siSpN7CVTFnuQ5n+A
   /7HkO3M8LtSde7Y9D3+eKS0nn0P/5TSPsKf9piXl42MH43jwiMKrztjQj
   RiX48gZ25ggHcH9hBekFmE2zfbmrgH2osj4qmnbjKjTfFnep75lm498QE
   N/yEA3C9+loFvDN7UdqON32axiO7IpF+cQledYDRg633yGiBDXIG8X/kL
   lygJLo7FtqQRVBx8RmDFYn1vCl4Bxg/EDl0XRj2HY6T/WSZddmK3+yoes
   g==;
X-CSE-ConnectionGUID: ICvFJD9LR4esFOO1jL//Lw==
X-CSE-MsgGUID: RpSvfQ8xT7auzRez2YyOEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="68553657"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="68553657"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 07:16:41 -0800
X-CSE-ConnectionGUID: rAY08spDT1KBcZcWw1GZ7Q==
X-CSE-MsgGUID: 8ZEnHRCBRnGnY0nObmfolA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203778588"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 07:16:39 -0800
Date: Fri, 9 Jan 2026 16:16:36 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tomas Winkler <tomasw@gmail.com>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
Message-ID: <aWEb1BF786hX6gmo@black.igk.intel.com>
References: <aUZFLezigzZQVt55@kspp>
 <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
 <0c69b711-4c88-4e64-afe7-f7de147a490b@infradead.org>
 <aWDNNOoYTa0Mi7LM@black.igk.intel.com>
 <87a4ymyjxh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4ymyjxh.fsf@bootlin.com>

On Fri, Jan 09, 2026 at 02:50:18PM +0100, Miquel Raynal wrote:
> On 09/01/2026 at 10:41:08 +01, Raag Jadav <raag.jadav@intel.com> wrote:
> > On Wed, Jan 07, 2026 at 03:17:40PM -0800, Randy Dunlap wrote:
> >> Hi,
> >> 
> >> On 12/19/25 11:07 PM, Raag Jadav wrote:
> >> > On Sat, Dec 20, 2025 at 03:41:49PM +0900, Gustavo A. R. Silva wrote:
> >> >> Fix the UBSAN: array-index-out-of-bounds issue below by updating
> >> >> counter nvm->nregions before the first access to flexible-array
> >> >> member nvm->regions[].
> >> >>
> >> >> from kernel bugzilla:
> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=220823
> >> >>
> >> >> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in
> >> >> /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
> >> >>
> >> >> Notice that this flexible array is annotated with the counted_by()
> >> >> attribute, hence the counter must always be updated before the
> >> >> first access to the array.
> >> > 
> >> > Already fixed[1], but not sure if it's landed yet.
> >> > 
> >> > [1] https://lore.kernel.org/linux-mtd/20251111-mtd-nregions-v1-1-61db61e78c63@intel.com/
> >> 
> >> What's the status of this patch, please?
> >
> > I'm assuming it'll go through mtd tree? Miquel?
> 
> It should indeed. However only the mtd list has been included, so it
> won't appear in "my" todo list. Lucas can you please resend, and use a
> tool such as b4 to manage the series or at least run get_maintainers.pl?

Lucas is no longer with Intel. Sasha, would you be up for it?

Raag
