Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4CEC61DA4
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Feb 2023 19:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBBTKE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjBBTKD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Feb 2023 14:10:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E5B3525F
        for <linux-hardening@vger.kernel.org>; Thu,  2 Feb 2023 11:10:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so2741436pjb.5
        for <linux-hardening@vger.kernel.org>; Thu, 02 Feb 2023 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei84xjALj/qnZ251dtHcjT7fuwkFwrmIuOWdIaj3IB4=;
        b=ifBa3W+FjfUT/jALuyk7vSXJgPyrderSzeCqeUprNB2WEcZ5Cgu0jv05ook+3UnGvo
         RtCgWWWwBDb7dOQWyuCGRnin3PpUqmpGnFqv5jTK2qZ2wwaTL2B9DzAqWakctSuEbd68
         sv1+oh3wKsRHifknwXnc2pr4q1kxywhLR6pyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei84xjALj/qnZ251dtHcjT7fuwkFwrmIuOWdIaj3IB4=;
        b=oNHK+s5XkGj9NiWtwOy/sPIbLiebXlEq2h+6dexfpSHf8aPQChpk1FF3bU7+/4zojP
         DdbK8sv/22rRCWp4tYrgmT439J8vGffjK7RqZ5cmk0rlRbBur/ahEgwo2OI8BG1zwc30
         cO77bKuLqiR2DPf2JOHXMxp4nk6fwC8vfC2uiQ3A0nACu6TWhMR1tChE1wwglxic/itw
         xbdkp/3YNCoQQz31lzm/tIShTYYvV4zTTWuUhPH6nUARTw3qiF7DpCbKx/MYjyPqHDf6
         VzEO+4Q4ajP04vxXYBTjFTDt4pmOJM3YQpgqUGy1jtLlKxgq+chLY9c3YHow1/pR3kmu
         23qw==
X-Gm-Message-State: AO0yUKW8RYd444HyY43BjxIVKod9ZBFhyqaxBb61g5w/SevwtlmSwaq1
        s0huRRYH/c/X5x40/HXYiMO7YA==
X-Google-Smtp-Source: AK7set9p/VLscj8lYzuVH+QL97IgWbcWTtlAXemsvo5mM0a99DAyaG7vV23KHqvBlFv4YZ4XzS0krA==
X-Received: by 2002:a17:902:ce8f:b0:196:2d55:5b96 with SMTP id f15-20020a170902ce8f00b001962d555b96mr8751901plg.24.1675365001490;
        Thu, 02 Feb 2023 11:10:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902b19700b00186b3c3e2dasm14950plr.155.2023.02.02.11.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:10:01 -0800 (PST)
Message-ID: <63dc0a89.170a0220.49507.0091@mx.google.com>
X-Google-Original-Message-ID: <202302021904.@keescook>
Date:   Thu, 2 Feb 2023 19:10:00 +0000
From:   Kees Cook <keescook@chromium.org>
To:     John Stultz <jstultz@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
 <63dbf04a.630a0220.2608a.0149@mx.google.com>
 <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 02, 2023 at 10:56:29AM -0800, John Stultz wrote:
> That said, making sense of the error message isn't completely trivial
> either. I've been seeing a few cases recently of some of the new
> compiler tooling (I pinged you earlier on a CFI one) causing errors
> that developers aren't really sure how to address.  I know sometimes
> it's not easy to surface the errors with context to what was wrong,
> but at the risk of intense bike shedding, is there some way to provide
> something like "Likely array bounds error" instead of just "BRK
> handler: Fatal exception"?

Yeah, this is a result of the size trade-off that resulted in config
CONFIG_UBSAN_TRAP -- there ends up being no message about what went
wrong. I'd really like to have cleaner handling of this -- perhaps what
was done for KCFI could be applied to UBSAN as well, though this is an
area I don't know well myself. (i.e. encoding "this was a UBSAN trap"
in the trap itself.)

Sami or Ard, is this something that could be improved for arm64?

-- 
Kees Cook
