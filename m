Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453EC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 16:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiKQQ1a (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 11:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbiKQQ0g (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98511455
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 08:26:00 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y13so2247932pfp.7
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06mQQfpHkuTm/tCqMTFcqJFO6s0dCCzyZ8bIwSvwGDE=;
        b=vsN4SMqUx2mr7Ui4r2Xua+BzK0xBqwCwwm8ssyyDI0S86OKjQ0A2oSx+xXbjSYd8tH
         mfRlcGhPm8wHRZwyR07JiQ5NgQpGVcGDYzAu5zuY9+9Ezs32RNo1xEdwZA6VDD6iKpKn
         2iwfMHdvx0ssktVi9MLjtuARUdLZW8iVP+ZVBScdLypc5CnAXan7oGjHpGQcrHdYbn2y
         W6eKlowCIsQiGl5rqt9L6isgo21FQeu3STx7OURyep0BuidZlOEWiDfclR4DlevLTuA+
         qBM03oLO+ZuKYH+dXIfJsozRghKJe89SG8QQlMpekoJpTsJHpU/UPujSAW0gx0qlMJnX
         ApRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06mQQfpHkuTm/tCqMTFcqJFO6s0dCCzyZ8bIwSvwGDE=;
        b=U7cUKFQxXIU5IkSDTwLao+PAtbc5FzQfeeN3b1023+eccc018zSls3Ldickhwkkozl
         UJRDvTcriSKgSoBXxF9dCZv+Ul4UWqUQfBLLxvL8BT9btydCMr94nmoaDHnTmcz2BMOA
         49w31vM4BvKwurpJKq/FMbk5j74UtFcWYPL6/yPfPA8vbwNWJNz6OOY4+PSFsdUs9Vqh
         gFE0aO6iL3zsr64JpuAd0c34q9dwsNrqSzmglK+hLFvHSFiSD0oWDJ7H+meQPhDrUucg
         G5jtR1fhW2sm93NXheZ3JImWy26LnFR5rMT6b26Cgy7XrkJBxjdYtbGcFjJ2gx0EwcoV
         w01Q==
X-Gm-Message-State: ANoB5plm260AlqSMEfe75nPqmdIDwSAcDieecy3qUNwPul8jtb8LVXa7
        rhz+yySDXTTktp4V57TszBSq8A==
X-Google-Smtp-Source: AA0mqf6ysXbFGVaYOKAC80E8xeeUZ5eLqx4BYGfUeKNLw3vsx9dMT8V9W90ZOCMW7gx4fh0hml/jJg==
X-Received: by 2002:a63:f4b:0:b0:46f:98cf:3bb6 with SMTP id 11-20020a630f4b000000b0046f98cf3bb6mr2666847pgp.332.1668702359536;
        Thu, 17 Nov 2022 08:25:59 -0800 (PST)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b00186a6b63525sm1617308plh.120.2022.11.17.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:59 -0800 (PST)
Date:   Thu, 17 Nov 2022 08:25:56 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        David Ahern <dsahern@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2] netlink: split up copies in the ack
 construction
Message-ID: <20221117082556.37b8028f@hermes.local>
In-Reply-To: <20221116221306.5a4bd5f8@kernel.org>
References: <20221027212553.2640042-1-kuba@kernel.org>
        <20221114023927.GA685@u2004-local>
        <20221114090614.2bfeb81c@kernel.org>
        <202211161444.04F3EDEB@keescook>
        <202211161454.D5FA4ED44@keescook>
        <202211161502.142D146@keescook>
        <1e97660d-32ff-c0cc-951b-5beda6283571@embeddedor.com>
        <20221116170526.752c304b@kernel.org>
        <1b373b08-988d-b870-d363-814f8083157c@embeddedor.com>
        <20221116221306.5a4bd5f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 16 Nov 2022 22:13:06 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 16 Nov 2022 19:20:51 -0600 Gustavo A. R. Silva wrote:
> > On 11/16/22 19:05, Jakub Kicinski wrote:  
> > >> This seems to be a sensible change. In general, it's not a good idea
> > >> to have variable length objects (flex-array members) in structures used
> > >> as headers, and that we know will ultimately be followed by more objects
> > >> when embedded inside other structures.    
> > > 
> > > Meaning we should go back to zero-length arrays instead?    
> > 
> > No.  
> 
> I was asking based on your own commit 1e6e9d0f4859 ("uapi: revert
> flexible-array conversions"). This is uAPI as well.
 
Some of the flex-array conversions fixed build warnings that occur in
iproute2 when using Gcc 12 or later.
