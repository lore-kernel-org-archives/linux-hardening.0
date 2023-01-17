Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AECC38142
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Jan 2023 22:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAQWq7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjAQWqA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Jan 2023 17:46:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5BC171;
        Tue, 17 Jan 2023 13:49:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673992151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EySvKf7KDIdxXLtAWjoJUjTf/tsFhH8nu8922rYbz4=;
        b=zlhaEqb4TYh2ZRuBkbkaFUODzaJzybzmp94wrNZ2DHgN3LcfnjQwxzMVr0K0pQuCafVpwt
        0gcfgOfsw042jRYHA7Gsv1zcIYQU24zntAiBeFj83PPNAU7juwuMfg7xj4SDVl3+m0OkZ8
        Jrkq2iyAZh9Zn6UthxWqpfwswXoXULsL1lHVSPQrYc+AyupkKB1Ep0Pd4pZpng2DdTd1Yp
        c13bWY8n/h89FHupOwCiSiFBY1wZwMB0ZdApku7YMvAewUrOD+ztr1MAaBnF3ej/1DBEzC
        r/rtcoo9Nse+0nyLvYpXr5waDphf+Q1yB9HmZoAQobnZ4laAKbdWTmHvuT1aMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673992151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EySvKf7KDIdxXLtAWjoJUjTf/tsFhH8nu8922rYbz4=;
        b=YnRV+X6yqAJ6pyt3ZIY4niaQaGvNztmiXlWVgf6Ql8uakG1IC9gh+YResQ8mxBagzHX6oR
        2CgS9YvOqsstl/Cw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        coverity-bot <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] printk: Use scnprintf() to print the message about the
 dropped messages on a console
In-Reply-To: <20230117161031.15499-1-pmladek@suse.com>
References: <20230117161031.15499-1-pmladek@suse.com>
Date:   Tue, 17 Jan 2023 22:54:21 +0106
Message-ID: <87r0vsq1cq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2023-01-17, Petr Mladek <pmladek@suse.com> wrote:
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1530570 ("Memory - corruptions")
> Fixes: c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")
> Link: https://lore.kernel.org/r/202301131544.D9E804CCD@keescook
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
