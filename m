Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE801EB64D9
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 02:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjF1Csv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jun 2023 22:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjF1Csu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jun 2023 22:48:50 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219A21715
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 19:48:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401e38e203dso16935921cf.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687920528; x=1690512528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVok7rzReJkeEE0XESE8noQp0aQi4RQQpEfbsHD9BtY=;
        b=mzGmJi6lVfSsOj7545pCntro7v3QarhrsIt+fs8v7HEBmtHW4nslN/9QUPmXfks8FK
         AIEaM393mwGtNY/kvI7av2GrIzhPWfUXFSgIO//osLPg7sUuqxTHlZtcfJrHZANNEXV4
         KQ8LSrVzYRB4dQOWW9VQLL55LG1t8hyIwBMGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687920528; x=1690512528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVok7rzReJkeEE0XESE8noQp0aQi4RQQpEfbsHD9BtY=;
        b=Um+tSFYM/M4ua4SDIOuLgNv5cSlC2IsJoQWLwbyy9EXBGtdWhgspq/EN16V7PHiFRa
         o4BfkiNsyXRHRkheY3pO0mMDG8XQIiIhUyYV6Rrq3gztENXGB7K93dR3agXJrepfToDO
         NKks8ifjvUdP3qTTI24QxShlov/2EdWsQ+nTy4AK5GHge8TMtonXdL/XaecSC+Rt3Byc
         N/H63c7Xet6ATboFQMceAqKi1jfBfcCuYXdtbCw9Ek7ufPcoEUtfMlYWZ92+hLhKFQet
         oscc771zVIiqaEKsXoH4ZbzqREdXbsvntO9hKz1wTndYttBq6JTe1s7gXyCy8DuKolVb
         UYxA==
X-Gm-Message-State: AC+VfDxw7tj60cZ4etZD+i8zkVsFnkTwFHa/lFcIBaGph2VGierVo5vr
        QF1ovTCFhMI31xHQbYhcYqkejdj35etMpi504NY=
X-Google-Smtp-Source: ACHHUZ4LfA7Jds2Vd+EGmePW5lr5cWPorl/s8Xl9oAMCHfZ3GYdimTmA4yh7MXDmvsXUKDG28RMlxQ==
X-Received: by 2002:a05:622a:178b:b0:3ff:33d6:da9f with SMTP id s11-20020a05622a178b00b003ff33d6da9fmr27306908qtk.49.1687920528214;
        Tue, 27 Jun 2023 19:48:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s17-20020a632c11000000b0053f2037d639sm6390668pgs.81.2023.06.27.19.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 19:48:46 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:48:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202306271944.E80E1D0@keescook>
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625155625.s4kvy7m2vw74ow4i@begin>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jun 25, 2023 at 05:56:25PM +0200, Samuel Thibault wrote:
> > Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon would
> > be able to use? We could even make it only allow TIOCSTI on the linux
> > console (tty->ops == con_ops).

Does brltty run with CAP_SYS_ADMIN? That seems a sensible exception to
be made.

> *Please* comment on this so we can progress. ATM people are
> advising each other to set dev.tty.legacy_tiocsti=1, which is just
> counter-productive in terms of security...

So is there really no solution for brltty and TIOCSTI being disabled?
What is FreeBSD doing? I imagine it's the same situation there too,
though maybe there is just no support?

https://www.mail-archive.com/brltty@brltty.app/msg02892.html

> Really, this a serious regression for the people affected by this.

Can you send a patch adding a CAP_SYS_ADMIN exception?

-Kees

-- 
Kees Cook
