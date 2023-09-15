Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE8DEE644B
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjIOJxi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjIOJxi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 05:53:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E82727;
        Fri, 15 Sep 2023 02:51:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF018C433C8;
        Fri, 15 Sep 2023 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694771517;
        bh=HzrhYbMbX0nF6Txa78jKopQDXazvQhqkMOm3sDgFktM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBLp35uVAIAxNF1SYKjADENGMkUkn5QlTgZaep6pr76zQl4XUIhLgg6ihK9NuytGg
         o18NLvmIAa+WeK5RL7n66x4TUwxorUbyU4qTLZf1O0oAwEvdjQ8k/zfWtib8ajOB4W
         sQoEINJYOdo8PAs43ElcmPXF6jLlApsczCelFtu4=
Date:   Fri, 15 Sep 2023 11:51:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Enlin Mu <enlin.mu@outlook.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, enlin.mu@unisoc.com,
        enlinmu@gmail.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
Message-ID: <2023091552-sanitizer-vertigo-8a75@gregkh>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 03:40:34PM +0800, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> Sometimes we want to print cpu id of printk() messages to consoles

This is rejected every few years.  What has changes from the previous
times this was sent?

And why can't you use trace_printk()?

thanks,

greg k-h
