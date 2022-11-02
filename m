Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D8EC4332F
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Nov 2022 02:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKBCqy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiKBCqx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 22:46:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371062127A
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 19:46:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z26so2060930pff.1
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 19:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hoE+WEBAOsuiYt/PTXWjfiF1Vpl25jsrqLqs6qRhex4=;
        b=FFz8PZLezwTcUHm1/JjLbEJ2PnfcBuk9zIDzB0YVBEnTAhRk42awxAgarOcOOMh8aT
         9pp+ZPj0CfYtKB0vvrmRZr4SA77gpLecOAwApmOxVtHaTl5gG1VLj1D4vAMOnpfpzeLH
         Amx9nyUwx29SFBuhD7JySgA1xbA2inbMEm+DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoE+WEBAOsuiYt/PTXWjfiF1Vpl25jsrqLqs6qRhex4=;
        b=3qTbleCSUYQq1LbWz3fTuXHohzrp0of1NFCNDmHa04W5wUqeI1Q3XEUnD55dxo/7bz
         Hat4Uwc6Z1lA43a/Clr0ebEqaKQ95TlQX28FvAQxHITaFrmrolFA33FUy4dW0SSkoi3c
         ovCowl48UGMngmru1//Q24ku0Rq/3/Fy3bFHaHKcggNAj7kF7WEzOi3tcMDUO2rchK/+
         5ICw5LvqFhu8ngd719sIEB5c7fiXiCHQUw/hoHQRMErWSS/3xpduKYAp1UAJkhkR8OFY
         vidhfp7QnYk65//G6wGvgGr5aLUdV7Z0fOn4a5260rItL269dPbL72OklnSSX72UuzB4
         20WA==
X-Gm-Message-State: ACrzQf0DNOI3FfiBoJcbA8WOV2/bWTUYI5NwnvNJonyRSzOrwnbcejxc
        jl40pkT5T0feHlw5LP/xvjrqgOpv5fUvsg==
X-Google-Smtp-Source: AMsMyM5Vh5Z0D0PjNfR9wH0EUw0jjOjW4Cn4P6WLzHpTK2ejg+loeg3CeqSftHPu8g1fvEGeQu9vPQ==
X-Received: by 2002:a65:6d8a:0:b0:43c:9fcc:cb24 with SMTP id bc10-20020a656d8a000000b0043c9fcccb24mr19911349pgb.477.1667357212734;
        Tue, 01 Nov 2022 19:46:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jd21-20020a170903261500b001714e7608fdsm7000949plb.256.2022.11.01.19.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:46:52 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:46:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202211011946.F7B4C690@keescook>
References: <20221022182828.give.717-kees@kernel.org>
 <202211011915.02EDB6377@keescook>
 <Y2HWJUuir8E33GkP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2HWJUuir8E33GkP@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 02, 2022 at 03:29:57AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 01, 2022 at 07:15:43PM -0700, Kees Cook wrote:
> > On Sat, Oct 22, 2022 at 11:29:47AM -0700, Kees Cook wrote:
> > > This is so very long over-due. We just need to do this and put an end
> > > to this legacy operation.
> > 
> > thread ping. Should I carry this in my hardening tree instead?
> 
> I can take it in my tree, I have a bunch of tty/serial patches to go
> through this week, give me a few more days please.

Sounds good; thanks for the update!

-- 
Kees Cook
