Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D915E88;
	Mon,  3 Jun 2024 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444217; cv=none; b=kIkpf6aj/t0zstBro6L0ozdWVzjIfSAgXnE/yGOyXwYMhPQ6yRZz0CWX3FZtJwL9/Byq3+Mdg8eVkmh/ClUoAyXaf+Cy4HVLL2yk2+U5GP4nmSXjwMABrrvOC7oD3vIOU/4y/AAtjuaw3SpwFRbO/NQ+nnFTMv2AaPbZf4EOP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444217; c=relaxed/simple;
	bh=JLCnBDX9E8BbMMfYDbpRW4ZyFGLrd1rjJXYlIEmqAlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgW581OF0hYgV/36yrtZbE3nb+yFah98SY647JmKPZjVN9lTgucp+eDrLWcPrir3t3euUv7dfZbu5gJu8oXQxa6d7lEeFI1NhRDZjQp8pVg/hHV/JmLz8UCYRsspb7I6LnYzL0lMT5OMjgQ/drIS/ULyS/hCeeB9A5NDZi2/LVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: fU3RGfkZRZKQ+N/lb7Qi6Q==
X-CSE-MsgGUID: fSMCbNxJT26CKurgzZ2cOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14143182"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="14143182"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:50:16 -0700
X-CSE-ConnectionGUID: WKZybg/ES1iAnDYVtGu8Ig==
X-CSE-MsgGUID: uLCcqS2/SlaA1gddz7WkFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="60162013"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:50:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sEDh5-0000000DNHk-1OC3;
	Mon, 03 Jun 2024 22:50:11 +0300
Date: Mon, 3 Jun 2024 22:50:11 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH] auxdisplay: Use sizeof(*pointer) instead of sizeof(type)
Message-ID: <Zl4ec7IUyKNFSn53@smile.fi.intel.com>
References: <AS8PR02MB7237B94B9A9F4580E79BAC0C8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <CAMuHMdWnbAPN4rSsquF4GA=i1anay2+y5y46of255a5Y9O1qnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWnbAPN4rSsquF4GA=i1anay2+y5y46of255a5Y9O1qnw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 03, 2024 at 09:52:57AM +0200, Geert Uytterhoeven wrote:
> On Sun, Jun 2, 2024 at 10:49 AM Erick Archer <erick.archer@outlook.com> wrote:
> > It is preferred to use sizeof(*pointer) instead of sizeof(type)
> > due to the type of the variable can change and one needs not
> > change the former (unlike the latter). This patch has no effect
> > on runtime behavior.
> >
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


