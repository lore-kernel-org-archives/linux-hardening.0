Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C6C3DA78
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 23:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAMXrd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjAMXrc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 18:47:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7876C06F
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:47:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso2548307pjb.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2vzzTSH5S57Wrqyr1C9oVjx+on+484XTk68fOM/j/c=;
        b=giYpFdLflye1WI0EUrCinm2NviDsoDh/JcHzHt45N4mNHndm+d5s7Fu6GlJV9wpOI3
         vMzmtTx6riqK8nJpLRxKVnndouHKkq2pE4DG8rwVhQ8xTqX8vDMJJqiONeFlarM8FwfR
         gUUxFdQP9RcTJjLwtIrxhN9jRWOAw6ZjpUEsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2vzzTSH5S57Wrqyr1C9oVjx+on+484XTk68fOM/j/c=;
        b=TBaHU0WvoJrlEzKwjP5Ej3lrsz7/C2UyLRSCglY1PICBxX/qI+vEy48ZgZ+igKy9dv
         eLUi7aOajlYonuTS6B95sL1AguNkqzdvWqsd2mV634vOAbsO55V03Tt3Jles63067wb4
         PKTDJXJnT9PMrrUcIokKjnqCHrwVjWizsN0LNi1X5gvmb0waAxrPLizF19xYVbOkaUZj
         hSqyTS0isUUi2d+wd/pV8MYyHubxf/TT/y9XJD5AO7pPzlnb6ZW60PnW/WvyUHV1lwBQ
         641WTJX4jHOTT/HI7NtpGgrhLWF39rfmw59loWXbdOj5+xda0rAQUGZ4Iy9ScoVfH89E
         JJpQ==
X-Gm-Message-State: AFqh2kr6vgd8+0egEyLlBlJPBRn66y9MwFSvGvdlgt6tXr89i7mibd4x
        QpyUNiBvgOnFnMf0b9RKSJMsgQ==
X-Google-Smtp-Source: AMrXdXua3ahnJrXVTD6N185pH/PtMtbliyTXjbCxzwwcMR7xNlL7XXVlPaA6+SCByiegM8HiaDiCug==
X-Received: by 2002:a17:902:b414:b0:190:fe60:48c4 with SMTP id x20-20020a170902b41400b00190fe6048c4mr11465497plr.21.1673653650812;
        Fri, 13 Jan 2023 15:47:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00189422a6b8bsm14725368pln.91.2023.01.13.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:46:47 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 13 Jan 2023 15:46:27 -0800
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: console_prepend_dropped(): Memory - corruptions
Message-ID: <202301131544.D9E804CCD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20230113 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Jan 11 15:35:11 2023 +0100
    c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")

Coverity reported the following:

*** CID 1530570:  Memory - corruptions  (OVERRUN)
kernel/printk/printk.c:2738 in console_prepend_dropped()
2732     		/* Truncate the message, but keep it terminated. */
2733     		pmsg->outbuf_len = outbuf_sz - (len + 1);
2734     		outbuf[pmsg->outbuf_len] = 0;
2735     	}
2736
2737     	memmove(outbuf + len, outbuf, pmsg->outbuf_len + 1);
vvv     CID 1530570:  Memory - corruptions  (OVERRUN)
vvv     Overrunning buffer pointed to by "scratchbuf" of 1024 bytes by passing it to a function which accesses it at byte offset 1998 using argument "len" (which evaluates to 1999). [Note: The source code implementation of the function has been overridden by a builtin model.]
2738     	memcpy(outbuf, scratchbuf, len);
2739     	pmsg->outbuf_len += len;
2740     }
2741     #else
2742     #define console_prepend_dropped(pmsg, dropped)
2743     #endif /* CONFIG_PRINTK */

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530570 ("Memory - corruptions")
Fixes: c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")

Thanks for your attention!

Human notes from Kees:

I'm not sure how it got 1998, but I do see that snprintf() should
probably be scnprintf(), otherwise "len" might be a lie (i.e. it'll hold
what it WANTED to write, rather than what it actually wrote).

-- 
Coverity-bot
