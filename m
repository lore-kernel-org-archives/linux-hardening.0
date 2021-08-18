Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E884DC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2316610CF
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhHRRtv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:49:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58897 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232375AbhHRRtu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 13:49:50 -0400
Received: (qmail 202749 invoked by uid 1000); 18 Aug 2021 13:49:13 -0400
Date:   Wed, 18 Aug 2021 13:49:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] USB: EHCI: Add register array bounds to HCS ports
Message-ID: <20210818174913.GB197200@rowland.harvard.edu>
References: <20210818173018.2259231-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818173018.2259231-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 10:30:16AM -0700, Kees Cook wrote:
> Hi,
> 
> This is cleaning up some of the remaining things to be able to apply
> -Warray-bounds and -Wzero-length-bounds globally. Only after doing my
> own version of the port_status patch did I find Arnd's earlier
> patches, including for the weird Broadcom stuff[1].
> 
> No binary differences.
> 
> v2:
> - use 0x80 as base for brcm registers (stern)
> - switch HCS_N_PORTS_MAX to decimal (stern)
> - update various comments (stern)
> v1: https://lore.kernel.org/lkml/20210818043035.1308062-1-keescook@chromium.org
> 
> Thanks!
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20200527134320.869042-1-arnd@arndb.de/#t
> 
> Kees Cook (2):
>   USB: EHCI: Add register array bounds to HCS ports
>   USB: EHCI: Add alias for Broadcom INSNREG
> 
>  drivers/usb/host/ehci-brcm.c | 11 ++++-------
>  include/linux/usb/ehci_def.h | 33 +++++++++++++++++++++------------
>  2 files changed, 25 insertions(+), 19 deletions(-)

For both patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

