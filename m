Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474ADC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Jun 2022 20:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354021AbiFUUbS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiFUUbR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Jun 2022 16:31:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A6F2DA9F
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 13:31:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 68so8699479pgb.10
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BLidNWg1htWBThKCVaZsohXxu3VXfGtNJQpRgp90tCU=;
        b=SjC/GmZXEuBOtbujrQRjpT4ZcAzlsnhtXAfer71aFK0Gx1DgKLW4LjndCvceGTwjZz
         yc/zizncz+QoTMqGPgr0hIfP5AIOerUxmJp5Cv8IEKXQLI/LMEe45csCVWUTmrqgTKz4
         +8QmGjvjEMvHqE7HXtNQyVQ2/IhvKYpvx15jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLidNWg1htWBThKCVaZsohXxu3VXfGtNJQpRgp90tCU=;
        b=qXkBEReXV9LOpx85z5mih7wZu77H8Qa8gm557kfFl00ptveR4DtSYve1guYtAer5bE
         aQBT9510iFGqhmwTxuwONkrVsZXD0vraqV9CAIrldIDGYkeSPNWOOFuSZpQ2vPTS15o3
         9d5PraaWbmwdA3qzc5U0IxwSTNT8YmCOaWL4UQOCeiKiN1oTmoWlGcCXstuoScbFqaRm
         UK/zHWK2jWX1KyxAR5WRleUeJMKy8BF+09vf4w1MHG4prZRP0j8HuLNDD8kFPQUkTisC
         kt3q2SVpRTs/9SZgpMgC73mGyPcrCvb/rlUBkcLnwiHCO/D4ZJDe3XipX8vKqfbnVmFv
         mFfg==
X-Gm-Message-State: AJIora+GmIjHvd2FwYenRZxwa1TkFUv2P5082yCmdz7dHVzclAWlFOLF
        MxYzUpNM4OFJLvBff/tmlA7JSA==
X-Google-Smtp-Source: AGRyM1uUQdL6lgBdFaWaahdfm9A1ZyPDbXH24COUdgzQzgJFoWMfXZuiRccgG2KoCgOGGqE7rdQxIQ==
X-Received: by 2002:a05:6a00:813:b0:51c:17b2:60cf with SMTP id m19-20020a056a00081300b0051c17b260cfmr31727971pfk.70.1655843474775;
        Tue, 21 Jun 2022 13:31:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902bb9200b0016a2a8cc4b4sm3966952pls.140.2022.06.21.13.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:31:14 -0700 (PDT)
Date:   Tue, 21 Jun 2022 13:31:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        linux-hardening@vger.kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: replacing memcpy() calls with direct assignment
Message-ID: <202206211327.F8936F0783@keescook>
References: <202206211109.A819E8118@keescook>
 <YrIWgNQkBXkMnKCz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrIWgNQkBXkMnKCz@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 21, 2022 at 09:05:36PM +0200, Greg KH wrote:
> On Tue, Jun 21, 2022 at 11:37:10AM -0700, Kees Cook wrote:
> > Hello Coccinelle gurus! :)
> > 
> > I recently spent way too long looking at a weird bug in Clang that I
> > eventually worked around by just replacing a memcpy() with a direct
> > assignment. It really was very mechanical, and seems like it might be a
> > common code pattern in the kernel. Swapping these would make the code
> > much more readable, I think. Here's the example:
> > 
> > 
> > https://lore.kernel.org/linux-hardening/20220616052312.292861-1-keescook@chromium.org/
> > 
> > -		memcpy(&host_image->image_section_info[i],
> > -		       &fw_image->fw_section_info[i],
> > -		       sizeof(struct fw_section_info_st));
> > +		host_image->image_section_info[i] = fw_image->fw_section_info[i];
> 
> Ick, that hids the fact that you are doing a potentially huge memory
> copy here.
> 
> And would it also prevent the compiler from using our optimized memcpy()
> function and replacing it with whatever it wanted to use instead?

What? Uh, quite the reverse, in fact. The compiler is MUCH better about
doing those kinds of optimizations. The commit log details that there's
no binary difference, in fact, with this change.

> What clang bug does this fix such that it warrants us hiding this
> information away from the developers?

Hiding? This makes the code significantly more clear. Doing an assignment
makes it clear they're the same type, etc, etc. Obscuring all that with
a memcpy() makes no sense.

As for the bug in Clang, it's triggered by a UBSAN_BOUNDS bug that is
still being investigated.

-- 
Kees Cook
