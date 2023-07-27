Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A1DC0015E
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 13:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjG0NDK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjG0NDJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 09:03:09 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81471FFC;
        Thu, 27 Jul 2023 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690462988; x=1721998988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SibNWbJz1DVV6T/0yWdGP00h+XX+UlM1/oidfKMMDXs=;
  b=drkmFGVut4k6eJB/cWws+Qp2FG0T/vhIyB8HOxOR0kL/IeUjNvY1W+bJ
   N3tSlWdhcvpdjFLE7SDW8c1Op/yrTpa4sjLWgFikga8hddXrHfFCNoLAe
   iYJa7F6OcTtr7LjDVlNcZlOsdLlPlvZp9tU47LTuQ+vcLh+7OghWMlIg3
   NskIrU8PD4w+BHIEtvMWBeMBkjqFjzZ5pt+/WGw1EMz8JMKVjECS5j4e2
   Yme9gbWmYd8k7z0VODdiLrtgCmBPdM10b0Y8fwzODuV8kmHheC3+o6p1g
   EZT231PtVeQSptrd6y50yiOSiGBoC9EaxeEtVkVC5egciBGBWijdy9Dhm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="399235995"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399235995"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="900879746"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="900879746"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 06:02:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP0de-004y1C-2P;
        Thu, 27 Jul 2023 16:02:42 +0300
Date:   Thu, 27 Jul 2023 16:02:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_file: seq_show_option_n() is used for precise sizes
Message-ID: <ZMJq8nzPevdSon94@smile.fi.intel.com>
References: <20230726215957.never.619-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726215957.never.619-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 26, 2023 at 02:59:57PM -0700, Kees Cook wrote:
> When seq_show_option_n() is used, it is for non-string memory that
> happens to be printable bytes. As such, we must use memcpy() to copy the
> bytes and then explicitly NUL-terminate the result.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/seq_file.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index bd023dd38ae6..386ab580b839 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -249,18 +249,19 @@ static inline void seq_show_option(struct seq_file *m, const char *name,
>  
>  /**
>   * seq_show_option_n - display mount options with appropriate escapes
> - *		       where @value must be a specific length.
> + *		       where @value must be a specific length (i.e.
> + *		       not NUL-terminated).
>   * @m: the seq_file handle
>   * @name: the mount option name
>   * @value: the mount option name's value, cannot be NULL
> - * @length: the length of @value to display
> + * @length: the exact length of @value to display, must be constant expression
>   *
>   * This is a macro since this uses "length" to define the size of the
>   * stack buffer.
>   */
>  #define seq_show_option_n(m, name, value, length) {	\
>  	char val_buf[length + 1];			\
> -	strncpy(val_buf, value, length);		\
> +	memcpy(val_buf, value, length);			\
>  	val_buf[length] = '\0';				\
>  	seq_show_option(m, name, val_buf);		\
>  }
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


