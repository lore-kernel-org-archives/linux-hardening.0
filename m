Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4521BC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Mar 2022 06:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiCXGuX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXGuW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Mar 2022 02:50:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6B1B7BA;
        Wed, 23 Mar 2022 23:48:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D480368B05; Thu, 24 Mar 2022 07:48:46 +0100 (CET)
Date:   Thu, 24 Mar 2022 07:48:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <20220324064846.GA12961@lst.de>
References: <20220320143453.GD6208@xsang-OptiPlex-9020> <20220323071409.GA25480@lst.de> <202203230809.D63BF9511@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203230809.D63BF9511@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 23, 2022 at 08:40:30AM -0700, Kees Cook wrote:
> This series removes it:
> https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/

If HARDENED_USERCOPY_PAGESPAN is so broken we really should remove it
ASAP independent of the other patches in the series.

