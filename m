Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A077E105;
	Tue, 14 Jan 2025 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865367; cv=none; b=VEJY6T9fsP0xclotgQ4gE/ZdrQ4jsuuLiQkJxekWd4Mc0ykzrzuJjXDBIoHk/C3DDY/bxaS+KIU2PgoJJiLjAW3WULSD4V3/RVCCzHAFteIqHQy8WHh6pmnKD0LXCg/srAFq0kKVP1BcEo2rplhYaDoopRmDsNja0JQ8PoSQKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865367; c=relaxed/simple;
	bh=O+FVCGaYLGH4K7GTseci5UKWMtc95bitnPOamY441ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKHOnQjJmcpLaV/hrfCona7coFC+6aFix+BTCoRXGsCIxXD+p+m62eO4GPex9m/Z5dH8zcFeUWtGN2O26/TqUC5zJPtAVWzlFN1BQMP11uUNJ1f6XaX7pk9uKPlhDEC/L+VOsujTOCDtP3ZRLm57CkyffCevp//NovYlRgnl7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOCFD1uF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOCFD1uF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736865365; x=1768401365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O+FVCGaYLGH4K7GTseci5UKWMtc95bitnPOamY441ig=;
  b=DOCFD1uFc21WRvngy0D+6C/x8GBohFjUvk6UvgllHh7f8svFhDeboDjb
   snmw6cMUgrRrwSCBLeMnzovF24VSqzzkxcrSlma7vYInwY3koIwy3RrYZ
   Iu2WseFuEoShx84wri6Q23upWPoWEtg3D8dAszfA7ATGHH/UFlBwtuYe5
   ox4fW7kUg1giu/RYRPbGrMO533V4BZ2+FWM6UnRb97UmFvV0llnNto7by
   owVUyYFeryrsmU0xdtrHyQVNjNq99VcORgkitzQnHzsaKdM6mPInlMjPy
   l3XINB2kBBC6q59EVEfutx7vrMI3gdvUAUXqX9Wg9z/tnaBDiY+pMTD9w
   Q==;
X-CSE-ConnectionGUID: wZseXWBAToC85bJfd3hCNg==
X-CSE-MsgGUID: JB4znTfvR1SF72eO3MlaVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37275554"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37275554"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 06:36:05 -0800
X-CSE-ConnectionGUID: HKwes1AZRB+LkkJc1cJGSw==
X-CSE-MsgGUID: lOFDQY+YTxmS78LMnAMOkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128068671"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 06:36:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXi1O-00000000s7c-15Tm;
	Tue, 14 Jan 2025 16:35:58 +0200
Date: Tue, 14 Jan 2025 16:35:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [DISCUSSION] vsprintf: the current state of restricted pointers
 (%pK)
Message-ID: <Z4Z2TW_HaANvT4VH@smile.fi.intel.com>
References: <20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 13, 2025 at 05:46:44PM +0100, Thomas Weißschuh wrote:
> Hi everybody,
> 
> as you know, leaking raw kernel pointers to the user is problematic as
> they can be used to break KASLR.
> Therefore back in 2011 the %pK format specifier was added [0], printing
> certain pointers zeroed out or raw depending on the usage context.
> Then in 2017 even the default %p format was changed to hash the pointers [1].
> 
> Both mechanisms are similar in their intention but have different,
> cross-interacting effects and configuration knobs.
> The end result is not always obvious. For example:
> * "no_hash_pointers" does not work for %pK if kernel.kptr_restrict>=1
> * If kernel.kptr_restrict=1, "restricted" pointers are effectively
>   less restricted than "normal" pointers.
> * For other values of kernel.kptr_restrict %p and %pK have the same
>   security properties, but still different string representations.
> 
> Additionally the current usage of %pK is incorrect in many cases.
> As %pK relies on the current task context for its permission check, it
> was only ever meant to be used from procfs/sysfs/debugfs handlers [2].
> In reality many callers use it through printk(), leaking addresses
> into dmesg. While restricted_pointer() tries to detect some of such
> situations at runtime, this check is not and can not be always complete.
> 
> File handlers which could use %pK correctly today, often use
> kallsyms_show_value() instead. This is similar, but checks explicitly
> against the credentials from an opened file instead of the implicit task
> credentials. This behavior was the goal for %pK all along [3].

> Is it time to inspect the users of %pK and migrate them to either
> %p/%px, kallsyms_show_value() or some similar new API?
> Then alias %pK to %p, maybe removing it at some point.

To me this paragraph sounds like a good plan, which I agree on!

> A different, but slightly related issue occurs with PREEMPT_RT.
> Calling printk("%pK") while holding a raw spinlock will trigger an
> invalid wait context and latency spikes if an LSM using sleeping
> spinlocks is enabled.
> As printk() should be callable from any context this is an issue.
> Removing the implicit group check would also avoid this.

> [0] 455cd5ab305c ("kptr_restrict for hiding kernel pointers from unprivileged users"),
> [1] ad67b74d2469 ("printk: hash addresses printed with %p")
> [2] Documentation/core-api/printk-formats.rst:
> 	This modifier is *only* intended when producing content of a file read by
> 	userspace from e.g. procfs or sysfs, not for dmesg. Please refer to the
> 	section about %p above for discussion about how to manage hashing pointers
> 	in printk().
> [3] Documentation/admin-guide/sysctl/kernel.rst:
> 	"The correct long-term solution is to do the permission checks at open() time."
> [4] https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/

-- 
With Best Regards,
Andy Shevchenko


