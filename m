Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04C4C4320A
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F036115A
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhHYQdf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:33:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:42301 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241680AbhHYQdZ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 12:33:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="214436722"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="214436722"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:32:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="684573153"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:32:35 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mIvpF-00DdMk-M1; Wed, 25 Aug 2021 19:32:29 +0300
Date:   Wed, 25 Aug 2021 19:32:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Andy Lavr <andy.lavr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][RFC] platform/x86: dell-smbios-wmi: Avoid false-positive
 memcpy() warning
Message-ID: <YSZwnXqIaIo+hG37@smile.fi.intel.com>
References: <20210825160749.3891090-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825160749.3891090-1-keescook@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 25, 2021 at 09:07:49AM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Since all the size checking has already happened, use input.pointer
> (void *) so memcpy() doesn't get confused about how much is being
> written.
> 
> Avoids this false-positive warning when run-time memcpy() strict
> bounds checking is enabled:
> 
> memcpy: detected field-spanning write (size 4096) of single field (size 36)
> WARNING: CPU: 0 PID: 357 at drivers/platform/x86/dell/dell-smbios-wmi.c:74 run_smbios_call+0x110/0x1e0 [dell_smbios]

> Note: is there a missed kfree() in the marked error path?

Seems so.

* Note: The caller should use acpi_os_free to free this
* buffer created via ACPI_ALLOCATE_BUFFER.


-- 
With Best Regards,
Andy Shevchenko


