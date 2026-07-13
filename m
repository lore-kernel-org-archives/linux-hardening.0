Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752F394794;
	Mon, 13 Jul 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944832; cv=none; b=Xq2x/vL7HOTVfWnvtKTOwSocI5pdd9C023xTBgnvcLmrkuJPEpUXCJ6S80Mv+NRRdjtyDq0pZ4T7FG0IsKtNiflbfCB4FPZOzO37iIhAIH2FlMxVK0GUr3I9nODxRduPZvEGuVaawjQeg5BJt5JclziXD94LKnxbLu9qG/bFz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944832; c=relaxed/simple;
	bh=nY0OYwgOQUAMKfW9Zr0F+ZmnaU3DELlx8He8MjLLVbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py9iAYoRcPqV2wJt10ZqSOnimzEsJcRR/o/uLVCMDVzfim3uqe0QhBDUIxY/KSUaHpIlapGEoAn8vUsEbL5B3Kh4KoehKbvy9BHlsAxDPTYgvq2f02HsMn9awi6ICZTwLPp2vXYDBPI4JMikwIGkANb0i0qBNdzKKf9bN8z+7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jI50DH2Z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI50DH2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783944830; x=1815480830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nY0OYwgOQUAMKfW9Zr0F+ZmnaU3DELlx8He8MjLLVbo=;
  b=jI50DH2Zouq84jcjvMo8xKLPaaRmsj7tAh4Ql6VxxFsnnAdGuUrPkngu
   RtknLv15eLHdRzbPyPMSUI8PuwylAHDyQ+65ORxBgtrIrPboBQrBtnkIF
   gx9IVUgY4Dnv+AtejpQGR7ibyZYiwkmu6QW/paVE4Xh6+2NgGo0l9PzYA
   9nTcgXOuyg9vR6fjWoVN1Fzu1LAfMh5eciPpi2TyH5/pNIJ5IOgMP0n/s
   gCL5/+HP4ImG4M1okTdAghvEo3r56tWCMiPpqLC1OYg812a5rPvZpYU1d
   AEB+EwzbyNpJGXHpuhArJZg15M+vctmmrV/rojt8PW90MyaPAgGv7+OFD
   g==;
X-CSE-ConnectionGUID: 7bMUFpO7TAaP5WG5nPvYrQ==
X-CSE-MsgGUID: 9W6ELUZXT4WI9PvxmRMWbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95920265"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95920265"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 05:13:49 -0700
X-CSE-ConnectionGUID: vPG3+0lAQT2L3apHj8cffg==
X-CSE-MsgGUID: PwQgcmeYSXK0wW1hHnLPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278797517"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 05:13:47 -0700
Date: Mon, 13 Jul 2026 15:13:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] dmaengine: idma64: use sg_nents_for_dma to respect
 hardware descriptor length limit
Message-ID: <alTWedDJfU2QPIF6@ashevche-desk.local>
References: <20260712220039.924958-1-rosenp@gmail.com>
 <20260712220039.924958-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712220039.924958-3-rosenp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 12, 2026 at 03:00:39PM -0700, Rosen Penev wrote:
> The iDMA 64-bit hardware has a 17-bit block transfer size field in the
> CTL_HI register (IDMA64C_CTLH_BLOCK_TS_MASK = 0x1ffff). When a
> scatterlist entry exceeds this limit, the driver would silently
> truncate the length, transferring fewer bytes than intended.
> 
> Use sg_nents_for_dma() to compute the number of hardware descriptors
> needed after splitting large SG entries into chunks that fit within
> the hardware limit. Split the loop to iterate over each chunk.

I appreciate the intention, but... I have issues with the implementation.

> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/idma64.c | 44 ++++++++++++++++++++++++++++++--------------
>  drivers/dma/idma64.h |  3 ++-
>  2 files changed, 32 insertions(+), 15 deletions(-)

First of all, the statistics and code readability. Next is the requirement
for drivers to do that. This should be done on the DMAengine core level
for all, this is software resplit and we just need a driver agreement of
getting a such to be done before handing over to the driver's callback.

OTOH, there is an API to get DMA maximum segment size (note, that your split
is incorrect since the BLOCK_TS is in "bus width" units, it may be up to 4
or 8 bytes and it depends on the alignment: so, in this form this patch is
no go). The consumer drivers should actually call it before preparing SG
list to make sure that resplit is not needed and the SG list is compatible
with what HW capable of.

See dma_set_max_seg_size() and dma_get_max_seg_size().

...

>  #ifndef __DMA_IDMA64_H__
>  #define __DMA_IDMA64_H__
>  
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/spinlock.h>

Yeah, the inclusions should be revisit as many changes happened after the
driver introduction in the area of how we split headers.

...

>  /* Bitfields in CTL_HI */
> -#define IDMA64C_CTLH_BLOCK_TS_MASK	((1 << 17) - 1)
> +#define IDMA64C_CTLH_BLOCK_TS_MASK	GENMASK_U32(16, 0)

Why? I think this becomes inconsistent. If you want to switch to bits.h, make
it in a separate patch for all eligible definitions.

-- 
With Best Regards,
Andy Shevchenko


