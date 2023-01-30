Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F529C54EAA
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Jan 2023 12:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjA3Mw0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Jan 2023 07:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjA3MwZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Jan 2023 07:52:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FE82C65A;
        Mon, 30 Jan 2023 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675083145; x=1706619145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6yXhHuKPgHD9iTZG19qRUi1WGjHIxNA1+Q7ilB5r4Dg=;
  b=XF90PRgwT0So5a63h1GForjrenwOB2W2rlLE9oywApQ0pcZ+3lLqEDrN
   VGZUVtUl6/J4cVxrsWffeknp7xXCH5TdRyTYwPO5qA4cevl6T/KaTXyKs
   aROWhGZ4nHgHbasf66EMr5b9skUihwRFFOPk+VzmD4qoW5JELSsoTEHZk
   Q1Jswi/x8IdjdGR0wW+F+82GY5rZeEfIuHZdqA8CIYkK5xqrGIAMGyQjR
   /DfjVaXdHkB7erDe17ycWyWiqCXO/makEN7jnOVvTGMAMUo1DaRLZ0MaQ
   lH+XYPLFhdn0jFb/wU4M4bBsDQGYDHC59A5/vmFizPSEztd/alvnGy4x+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="315507295"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="315507295"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:52:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="657441327"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="657441327"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 04:52:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMTe0-00HLzV-0R;
        Mon, 30 Jan 2023 14:52:20 +0200
Date:   Mon, 30 Jan 2023 14:52:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Do not dereference NULL structure
Message-ID: <Y9e9gyARKf1nrmgG@smile.fi.intel.com>
References: <20230127223623.never.507-kees@kernel.org>
 <Y9egAuMYM+JyBZ3O@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9egAuMYM+JyBZ3O@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 30, 2023 at 12:46:26PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 27, 2023 at 02:36:27PM -0800, Kees Cook wrote:

...

> If you want to fix it properly, the code should be modified like
> 
> 	status = dma_cookie_status(dchan, cookie, txstate);
> 	if (status == DMA_COMPLETE || !txstate) {
> 		if (txstate)
> 			goto out;
> 		return status;
> 	}
> 
> 	...
> 
> out:
> 	dma_set_residue(txstate, bytes);
> 
> 	return status;
> 
> to be in accordance with the Documentation.
> 
> **OR**
> 
> the Documentation should be fixed to tell that if status is DMA_COMPLETE,
> residue is undefined and assumed to be 0.
> 
> Vinod?

Disregard my message. The dma_cookie_status() makes sure it's 0.
Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko


