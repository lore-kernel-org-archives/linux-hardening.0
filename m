Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF32C41513
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Aug 2023 07:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjHNHle (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Aug 2023 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjHNHlK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Aug 2023 03:41:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C3010D1
        for <linux-hardening@vger.kernel.org>; Mon, 14 Aug 2023 00:41:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc7e65ea44so26875655ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 14 Aug 2023 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691998865; x=1692603665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osUjcaEHtBFUKHlMgydGCW0+LXDmW2BKWDOjMgrl0H4=;
        b=gYElgx4Y9XpD+x4CIpjkhq1bSiJGmw+awZyz2AmlDe9X4vT6PAI2iQUwqtPfe8zi83
         pvDVGp8ijRjc1l1skHpiyisdBKMoRdQe824oVY48DrMfzCTi8qguLt58prjnuWSNDJ0B
         ZDa3alWhOkSQjrQkoMm7k5Pajfa4/E5jhFikE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998865; x=1692603665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osUjcaEHtBFUKHlMgydGCW0+LXDmW2BKWDOjMgrl0H4=;
        b=D7UFeksuWxkBt/KtiuY6wZw0j9iVL2iBhtgmjNZrN86Yl37KEMlPfYXwK8Wb+9HyOb
         ENSixx99tW9gjsXIOdNCka15sSCW/EfHZsqquPdK5HKtFgKJ+gk0yxnrpWRjmYYK5cjx
         qC6rQPKgoKJOOq/g4X8PX+1kAOUwhRDZNm/XLYNFkjM5s60ttUvAsJLt6wFAJPN7GqHy
         2es+78NG0VcotTcX/P1P4Dw2ejOI73kC+0zDF+bPbtInwQ0SfXHapjkoQjeDvOxsKy18
         qdx+r2VlD5s3CMev1VqLVsuMOVossuCJHCtu2Z27b+85XFEBtgXf11GDbfdwu6H2NDkR
         3R4w==
X-Gm-Message-State: AOJu0Yw0JWHhEZsMmTv+C/Bg4EP9CBFPoru5x9u/IbotL3IYfsQcJ+dp
        9eN6CYI2Cy1q5xXPCh5oYW7br/Az7VGPoUFU7EI=
X-Google-Smtp-Source: AGHT+IGzAzUfBdp29beWjVa3J5Q0XpfJkc7H0CgGQ+XJNgLDognagfaqgl+ZzbOysdJfBVX6PH+nPQ==
X-Received: by 2002:a17:903:1cb:b0:1bc:40ce:e1ec with SMTP id e11-20020a17090301cb00b001bc40cee1ecmr10624727plh.30.1691998865050;
        Mon, 14 Aug 2023 00:41:05 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id jf7-20020a170903268700b001b9f032bb3dsm8732882plb.3.2023.08.14.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 00:41:04 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:40:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Message-ID: <20230814074059.GA907749@google.com>
References: <20230811054528.never.165-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811054528.never.165-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On (23/08/10 22:45), Kees Cook wrote:
> If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
> copy_data() was causing writes to truncate. This manifested as output
> bytes being skipped, seen as %NUL bytes in pstore dumps when the available
> record size was larger than 65536. Fix the cast to no longer truncate
> the calculation.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Reported-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Closes: https://lore.kernel.org/lkml/d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com/
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks a lot!

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
