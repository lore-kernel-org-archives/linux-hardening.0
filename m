Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE6414433;
	Fri,  2 Oct 2026 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926347; cv=none; b=WpwCvcPuu2csjaJ8DD98qMS1EQilxopfz8aEHcvI+osoF5/f4d+a8xboimMYIA89gQSwzYzbNGJZZA/ZGL8/ylyIZRjACNqJ/2ignMVw3g/aQGDndftL8/85THoVX//EeFbuvkWkQb2G1Bc60Ok2Ycm8zobGUUHGC2/kVS+O18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926347; c=relaxed/simple;
	bh=btldWsCbqHoNxvjzFOJI/17XbxQYFuRlpBMjx6jPdgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGVFggUjckhqi5+WTqO/zsOL/Xfg7sRC8YHnqeCfUxbAdd1rAVMrt55DtpgainLxccLLnQjD0LXTaYshXsNMi88BrUkHSNbB0I3G3jmrEwYEoHhth9OfWxYnLPd1sDr4mocC79rZLvIdKBaGE1ApUue5HwBX5bUTYEusnOlr6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvbBaWIF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvbBaWIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790926341; x=1822462341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=btldWsCbqHoNxvjzFOJI/17XbxQYFuRlpBMjx6jPdgs=;
  b=FvbBaWIFlzjr76liCQb6RzC21tuUQSeIjlJ8455BIL007feDQvQu0o/6
   /w6ySZXD6JMIrjrmMVa7up8wSf4bXXm2n7haNPzIuiLHOMjlaTP2kx7IO
   yBxMBXJQKJDX5/Q0mn5m97k9QsSsgzKCblvwa7bn668B5oS3+2CnXSxgK
   bUh2sp80VEb2Tvja23rXR3WX+srviMUEV3yjXYWBCC2tIT9C7gNZC0WaT
   iZGmrdoYSFsJoQWpMasT+TTpzf0r62XCtW7eyrXTt/MDpoVvkMLLCDoL9
   UFoeCrlvPr97Z5FWdeKaB2s5/ideEsK8FNaeTp7Im/BifOxAHQBMYpFba
   w==;
X-CSE-ConnectionGUID: HWhq5O4pQ5GXPTd0wWc9uA==
X-CSE-MsgGUID: WZ9S/kgTTROPKWVuk/0/YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94573134"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="94573134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:32:09 -0700
X-CSE-ConnectionGUID: uwyVdmBISRqYoZMJFYuzAQ==
X-CSE-MsgGUID: ya4CTRq4R42UO27nTex8pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="276301895"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:32:06 -0700
Date: Fri, 2 Oct 2026 10:32:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 01/11] seq_buf: Do not print an empty line from an
 overflowed seq_buf_do_printk()
Message-ID: <ar9d9ChvEvBDX9j0@ashevche-desk.local>
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930235247.157921-1-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 04:52:29PM -0700, Kees Cook wrote:
> seq_buf_do_printk() prints a buffer line by line, then prints whatever
> follows the last newline. When a string has overflowed at exactly a
> newline, an empty line is printed since the pointer hasn't reached the
> overflow mark of the seq_buf. Switch to just check if the string is
> already empty and only print if not.
> 
> The only caller is the memory cgroup OOM report, so this could only ever
> add a blank line to a report whose statistics already did not fit.
> 
> Add a test that registers a console to count the records that
> seq_buf_do_printk() emits. It counts the records carrying the test's
> marker, and the records holding nothing but a line feed that arrive
> after one, so that unrelated kernel messages do not disturb it. Both
> states that reach the flaw are covered: exactly full, and overflowed.
> 
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

...

>  	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
>  }
>  
> +

I believe a single blank line is enough.

> +/*
> + * Counters for the console that seq_buf_do_printk_test() registers while it
> + * runs. Only records carrying the marker are counted, so unrelated kernel
> + * messages do not disturb them.
> + *
> + * An empty record carries nothing to recognize it by, so count one only
> + * where the flaw puts it: directly after a record of ours, with nothing in
> + * between. That still misreads a bare line feed printed by another CPU in
> + * exactly that gap, but no longer counts one printed at any point while the
> + * console happens to be registered.
> + */

...

> +static void seq_buf_printk_capture(struct console *con, const char *s,
> +				   unsigned int count)

I would re-split to have it wrapped on logical boundary:

static void seq_buf_printk_capture(struct console *con,
				   const char *s, unsigned int count)

Or having the whole on a single line.

-- 
With Best Regards,
Andy Shevchenko


