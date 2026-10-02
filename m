Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F5425888;
	Fri,  2 Oct 2026 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925645; cv=none; b=K31YAAgGVPGEYjmGqa/CSwesLMxktpYWrdGOsns1Lz1rye790wjxAUcfNub+pD31ByO95iqqw0RFQBbq8xFE0VYDI1Cx41zV2/wWDEX+CJ40rH7VRv6IMbgUmL04XJmSZQfBJsQs1UArUrtnGlSXnVcWH7Kk0EkfDgpsaFj3SBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925645; c=relaxed/simple;
	bh=oeXDfzLBO0dEKey05UEa2Jcs4g9mSTOaUXGc+hukj00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK97JJC1BRvcawB3yuunuycjKhN94tjJmYse9DwFpEW5e9G2OnJC9M7YA8zyS8T0DlOETieSNUYv4B/eUSDnDa4X21cimdsfBmiXDNjb6pf0ys4k05Dne0i6rZx06rlXCm4Jds2zcabRVjDC5c/r+fFo9JFifgiOpQ99EKGSQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpL/zpis; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpL/zpis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790925644; x=1822461644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oeXDfzLBO0dEKey05UEa2Jcs4g9mSTOaUXGc+hukj00=;
  b=VpL/zpis7t1d5IJDSj/VAavOU8TMkcr0NBGDc7dqbUKJCVjMDboEpKy2
   bw1gaE920vVbGzmyjiGj3VgVBGeIgHWblWUoXyPkuAoUskqfYvqe5/ra+
   OV2vjwYS7i8dlOUgRxYSDDg0CiDqUIOFhhaEFSgQQrkSJf9tYSiDrT5N7
   qpxdZ+JymczQyfDCqQJH8KnFODFRmL/APNgvl16aKdQRqeAlhGgbOXMHy
   eKJc7jk9p8aJNV2dKCEBPX0rwRjFnlDGIBGCONZQnxEkkcaipiGCk3Cg8
   J/UG4UPMe1JVGI6St5pF/0bQ5xDMPvGuV4MM9+OPYmrkFAx8s2HjY7cQ0
   A==;
X-CSE-ConnectionGUID: 3bhsvXSET+2T2pga+9MG/A==
X-CSE-MsgGUID: y+KXhVFpRE6qmy6pFbNkCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94572616"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="94572616"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:20:44 -0700
X-CSE-ConnectionGUID: AkIf1mMLQ5e6G1u3Le+PKw==
X-CSE-MsgGUID: GzKmoao0QvKe0mKv8lwlFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279479519"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:20:41 -0700
Date: Fri, 2 Oct 2026 10:20:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 08/11] seq_buf: Add seq_buf_init_append()
Message-ID: <ar9bRGk_TpWq9-zl@ashevche-desk.local>
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-8-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930235247.157921-8-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 04:52:36PM -0700, Kees Cook wrote:

> Several strlcat() call sites being converted to seq_buf need behavior
> seq_buf doesn't currently provide. The normal seq_buf_init() always
> sets the new buffer size to 0 via seq_buf_clear(). Code migrating from
> strlcat(buf, ...), which appends to whatever buf already contains,
> can't use seq_buf_init() without discarding that existing content. Add
> seq_buf_init_append(), which preserves the existing contents and positions
> the seq_buf to append after it. Add KUnit tests for behavior coverage.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Yep, makes sense!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
But one Q below.

...

> +static inline void
> +seq_buf_init_append(struct seq_buf *s, char *buf, unsigned int size)
> +{
> +	s->buffer = buf;
> +	s->size = size;
> +	s->len = strnlen(buf, size);

Hmm... And if this becomes a size? Shouldn't we set the overflow immediately
if the existing buffer contains a garbage or has non-NUL-terminated content?

> +}

-- 
With Best Regards,
Andy Shevchenko


