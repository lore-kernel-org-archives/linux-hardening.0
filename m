Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3859EB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFUSgL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFUSgK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 14:36:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C538185
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 11:36:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b539d2f969so37904175ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687372568; x=1689964568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv4JB0gu1t46wWDKme5hHKYn4mQ7fMkSefR1sSHYzzk=;
        b=fkAW0goZqDfFKzRrsSAey60tXh4zE3Pc14WQuukj6IXTzjSF1fd8mUFdYeNU9hraZM
         FXEQQWuMHkrnDFa5I+D5sNl75A11zv0D/WNWWdta/C53Yo5NnrDKFbfH+oeLPJiR4Krv
         NEz45vRYfhmjXGoG44yrpiQ5Kp34wYFsYt5HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687372568; x=1689964568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv4JB0gu1t46wWDKme5hHKYn4mQ7fMkSefR1sSHYzzk=;
        b=GqsBnjwTc0sf3O+PQ7a983Da0mt0XF/4l+HVy5/z5e6ZCCTUCcSYs2Jxf2I1qs5XQH
         i3INuSdLhOEL+kPPNV1M2Npz3S2iBltEo5JIoLmR5FL49b+7FYu/889+LGQGamenXNpD
         Z/GSJe0X4xuUvj8dBsQzhfzpBGck9K15nNDZitSRQN++7nVgqnz5NA/6qVmtTAeT9j7o
         YnruIrbzKAFCOo5XwemS7BGIsrXiHrCSOHEpm3eWaznN8Zs2dqkaP90kLcxY7p3LYWCd
         3MtjCx3griXf5WVGUsEo9aI7IzPbCre1NrPF5ybc8EFxKtYl+xjl6poE6E96sO1JPPUs
         4/hQ==
X-Gm-Message-State: AC+VfDxUDuPc8A7uD1arueujolC+6daGPBWSGsCKb+SYAco8CV4Mt5Tq
        zslk6EWd2Kgynlf7pUrlOHLbwg==
X-Google-Smtp-Source: ACHHUZ6v9phQPqndguNv62PIby34GSSO1dsIssQyRdukILqo90/KIybQ23xd2PomQ8aU5EURTpY5Ng==
X-Received: by 2002:a17:902:f683:b0:1b4:5699:aac1 with SMTP id l3-20020a170902f68300b001b45699aac1mr22886759plg.12.1687372568099;
        Wed, 21 Jun 2023 11:36:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170903055100b001b539640aa3sm3801612plb.283.2023.06.21.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:36:07 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:36:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Manthey, Norbert" <nmanthey@amazon.de>
Cc:     "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Stieger, Andreas" <astieger@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: Linux kernel Coverity model file
Message-ID: <202306211134.C301FEB6@keescook>
References: <ccca1437bf0885924619271a3f3ddd17af018149.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccca1437bf0885924619271a3f3ddd17af018149.camel@amazon.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jun 16, 2023 at 01:44:01PM +0000, Manthey, Norbert wrote:
> some time ago you pointed me at the github copy of the Coverity model
> that is used for the Linux kernel analysis [1].

Hi!

> I investigated the effect of using this model, and compared defects
> reported with and without the model. Before I deep dive into
> modifications, I wanted to understand whether there is a more recent
> version (the current one is about 4 years old). I currently have no
> access to the public linux dashboard to directly check the effect
> there.
> 
> In case there is a more recent model file, can you please update the
> github repository?

This model file is current -- we haven't changed it in quite some time.

> In case I find additions, is the following a good procedure to share
> model updates? I would run an analysis on a defined Linux commit with
> the current model and the proposed additions, and would report the
> effect on the reported defects. Is there anything else I am missing?

Yes please! Either send a patch to the linux-hardening@vger.kernel.org
mailing list or send a PR to the github repo.

-Kees

> [1] https://github.com/kees/coverity-linux

-- 
Kees Cook
