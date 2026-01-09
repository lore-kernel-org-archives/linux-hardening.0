Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55876358D38;
	Fri,  9 Jan 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951675; cv=none; b=avtlQ5nTesVR0OdFQGtCD+Ap/ABm3t4z43LTWHlphpy1VtC/6d6IskPwXY2W0eQFMljLHzH9kOKyDesX9eSRyLw8gfSWoed127Fm+KiujxzP+iXh2eTFUAYP4mlD8mqGCdmXU2uPDPk5TiJiT42QSQQr2OEmiiBWqwYFBpAtTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951675; c=relaxed/simple;
	bh=O9MruM0fwwjauRsMoHWSXGet6CfPAq6e5XybIlgAVUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3usd8JNKqqrBmREFAQ5oIfef3ILiTEXLCgASvbhb0h987zAoSSwrNMcH42ypm9JcfiZx8XTLPNtqNPVPG9i46yee5zp6Sv/pWxlcCnhIKnj/rZYkONmjTdlMXo7A2IB2Pq1KU8HeuCIW39jqVIbmZveAdfXE8yrf55XRvGbM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=euZsNwAp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euZsNwAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767951674; x=1799487674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O9MruM0fwwjauRsMoHWSXGet6CfPAq6e5XybIlgAVUY=;
  b=euZsNwAps3xeOKA8sZuvFvKdgss5TiXGA9NiXsoCbXOc2UzP1g1u3AkC
   Oj+YadbqJ6L2i23n65Yxa9gP/OTrST2pUrWfJCUB+e34AaouK06q+WPVd
   fW9h65GmO6oe8ciTRDUm+E9ymlsMlSGp6ejuZUM2BM7aTXSt/akqAWtf2
   HqR3dWcfZwNSdKqqqRw9yVBtPEJy9nflDz9aCaXzwz+udM4NF80mcdnMh
   23meomtdyQFYRSa1C68N6ZJ5k9O6JQJX3joBdlDIJEHQNd/XExD8+PPQS
   w/u+9i5zHr5vrPvzR9EDBVPTM4Wipkxze2OjIRlV8qJet1Al3WmJ7Ya5b
   w==;
X-CSE-ConnectionGUID: Yzxx8KzPRSeR+zi/DrCMRQ==
X-CSE-MsgGUID: ED/7cxvPTDiPYPoM/GD17A==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79628927"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="79628927"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 01:41:13 -0800
X-CSE-ConnectionGUID: oLprbKeGRhmwqBa2x2BRjg==
X-CSE-MsgGUID: Vv4xSCnMRVe/7PXwM/ZMHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="207581160"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 01:41:11 -0800
Date: Fri, 9 Jan 2026 10:41:08 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tomas Winkler <tomasw@gmail.com>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
Message-ID: <aWDNNOoYTa0Mi7LM@black.igk.intel.com>
References: <aUZFLezigzZQVt55@kspp>
 <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
 <0c69b711-4c88-4e64-afe7-f7de147a490b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c69b711-4c88-4e64-afe7-f7de147a490b@infradead.org>

On Wed, Jan 07, 2026 at 03:17:40PM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 12/19/25 11:07 PM, Raag Jadav wrote:
> > On Sat, Dec 20, 2025 at 03:41:49PM +0900, Gustavo A. R. Silva wrote:
> >> Fix the UBSAN: array-index-out-of-bounds issue below by updating
> >> counter nvm->nregions before the first access to flexible-array
> >> member nvm->regions[].
> >>
> >> from kernel bugzilla:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=220823
> >>
> >> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
> >>
> >> Notice that this flexible array is annotated with the counted_by()
> >> attribute, hence the counter must always be updated before the
> >> first access to the array.
> > 
> > Already fixed[1], but not sure if it's landed yet.
> > 
> > [1] https://lore.kernel.org/linux-mtd/20251111-mtd-nregions-v1-1-61db61e78c63@intel.com/
> 
> What's the status of this patch, please?

I'm assuming it'll go through mtd tree? Miquel?

Raag
