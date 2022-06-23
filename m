Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63BCC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Jun 2022 16:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiFWQ0J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiFWQ0H (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Jun 2022 12:26:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B343C4A1
        for <linux-hardening@vger.kernel.org>; Thu, 23 Jun 2022 09:26:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d14so59028pjs.3
        for <linux-hardening@vger.kernel.org>; Thu, 23 Jun 2022 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8uL4Cnos+tnqMRM/pR25DTlUlkkTtmxJhV6l+Yrd1g=;
        b=iq5Nofk2xDryk147dU/ZEzGYE5R3sJqvrdrhWA+r1L+t0r6bE6P+1TaIEdNkrJqCB/
         Wjjy8ratdufNJKZyfwQu4YmbE3RVOD87F75MQbXVPsiFKf+C2mB7atafn2LS6CtKH/Os
         lqgOU8ZsaX4aYxfQCfMzO5re9+IbiBu8wbYJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8uL4Cnos+tnqMRM/pR25DTlUlkkTtmxJhV6l+Yrd1g=;
        b=okU91PjlwcwYK0+afZpxxAIrpM6JxAMtN9Xgxcl6xgDKA69pbBxNc8n7WEAaOPGePn
         yKPKkDgHNuwH5wo+nACb8loJnTDfsH0KxUa78fpqBLl2dsi2KOEL84AsiS3nez4d0eR1
         cC5DEUcMzeid4uvJyPF6Fw1O1IDlPWfNlNn6aXN8xooLs4TXxvHExDRQ9ZOLz3fkRqsQ
         7J8XDg69B53oWhulJ84qJX/fc79UDlU4i/gKjLZtxExAhLXdT2T4IUS68ge9FmohZyWU
         Qlq7KcrYtV73SPrkS28LOVps4ybuDQZ5X9N9716iD+wC5bvsDI7xqj9DtPSTC/raJTqo
         qgbA==
X-Gm-Message-State: AJIora/27mi/6vuNk6EYLb8QMtb9riMe6grsOWzr2nE44PId69ICMUPX
        DiLDSFImCz/+JJmUCUPplpgoDA==
X-Google-Smtp-Source: AGRyM1vZYkVfdqhPecRvHa8SQIPJmMPxgpo/hrHswx5SewkcMf+oXPMK42iOKzJucOlu1xgGYsy1bQ==
X-Received: by 2002:a17:902:d905:b0:16a:2917:73dc with SMTP id c5-20020a170902d90500b0016a291773dcmr20464902plz.6.1656001561800;
        Thu, 23 Jun 2022 09:26:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b0016636256970sm12712658plb.167.2022.06.23.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:26:01 -0700 (PDT)
Date:   Thu, 23 Jun 2022 09:26:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/8] scsi: aacraid: Replace one-element arrays with
 flexible-array members
Message-ID: <202206230924.A8A4D005@keescook>
References: <cover.1645513670.git.gustavoars@kernel.org>
 <20220310040347.GA2295236@embeddedor>
 <yq1h77zdg37.fsf@ca-mkp.ca.oracle.com>
 <20220315042223.GA2385465@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315042223.GA2385465@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 14, 2022 at 11:22:23PM -0500, Gustavo A. R. Silva wrote:
> On Tue, Mar 15, 2022 at 12:02:13AM -0400, Martin K. Petersen wrote:
> > 
> > Gustavo,
> > 
> > > Friendly ping: who can review or comment on this series, please?
> > 
> > I'm afraid I don't have any hardware to test it on and the generated
> > output differs substantially from the original code.
> 
> Yeah; this series requires careful review from the people that
> knows the code better. 
> 
> It took me a day of work to go through all the places that needed
> to be changed due to the flexible array transformation. However,
> due to the kind of changes, it'd be great to have a second opinion
> or at least someone that could take a look at the changes.

If the int/size_t changes are separated from the array size change, it's
easier to see the array size change is a binary no-op. (i.e. diffoscope
shows no executable changes.)

I'd recommend splitting the int/size_t changes from the array size
changes.

-- 
Kees Cook
