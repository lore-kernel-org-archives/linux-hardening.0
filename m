Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE8C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Oct 2022 18:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJSSdt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Oct 2022 14:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJSSds (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Oct 2022 14:33:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD161D1E2F
        for <linux-hardening@vger.kernel.org>; Wed, 19 Oct 2022 11:33:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f9-20020a17090a654900b00210928389f8so934404pjs.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Oct 2022 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PluJNC/fw1ja+vSikAWciLlJudd2H9uq25K8L6bfLo=;
        b=JVbVN/M0Fs2iSpMzO8pxTylybZgs1ftEadUEBTex5hgbM9JU/8s8n6n2JYgjHxZ3oJ
         CyZ+U29uY9g2I1wwPJfmTspcn/u/rqgqHXljyZElyrahCuij5ApCn7rfqXasJyESsA0J
         PiCQvnJswac6hiC6Qyy3/NHr8MO8pFq3aIMIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PluJNC/fw1ja+vSikAWciLlJudd2H9uq25K8L6bfLo=;
        b=eUnm4Y1CWJdTNTRIfc16XQdIVzzOeFv4TkTHNSuvVS6qqeH+/CvCx52izkmT3/AJlv
         59P17tm68Rz/W8xVCF6JsDNhgo0EiP938eAb4p4kEtjnyGjbSPBQFYEaeL80ZbzTcAxt
         hJoje03c0jgMeHo/NEYqVIYnzlnjZCZNcbXmOAtagpQbhOXN3BDJmulVJQUrjploLpFH
         zPmOjXjAJfx9xqAFM5GIe/nftg4TipIZvaxL40hPIPEQNjZlb0dvZRHha+a1WjYiLdJT
         0WmUDeq5yTdfNQJ3gbwmWfBFZhb50NNsTRah0xZlEkXDx0pIGWdEFX4m7dBFJQ+FcwkD
         yJSA==
X-Gm-Message-State: ACrzQf3AK6BkjVu3eKfyQI+dkxSS81jm0UhLo8whls4rkv+KYDdjTiSE
        3cwx5WX5GOlaUXArmXdAJoGkyw==
X-Google-Smtp-Source: AMsMyM67W2Yn8Am1Y+VGKJgWqTslcaqvPI3VRf0IkD4gH2fvYM9IwcHId/YBYl3dAfMBGHuS9YMnDA==
X-Received: by 2002:a17:902:e545:b0:184:2f27:b34 with SMTP id n5-20020a170902e54500b001842f270b34mr9543201plf.15.1666204420516;
        Wed, 19 Oct 2022 11:33:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k33-20020a635621000000b00460a5c6304dsm1967827pgb.67.2022.10.19.11.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:33:39 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:33:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Message-ID: <202210191129.BFBF8035@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
 <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
 <202210141050.A8DF7D10@keescook>
 <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 17, 2022 at 11:26:44AM +0200, Mickaël Salaün wrote:
> 
> On 14/10/2022 19:59, Kees Cook wrote:
> > On Fri, Oct 14, 2022 at 04:40:01PM +0200, Mickaël Salaün wrote:
> > > This is not backward compatible
> > 
> > Why? Nothing will be running LSM hooks until init finishes, at which
> > point the integrity inode cache will be allocated. And ima and evm don't
> > start up until lateinit.
> > 
> > > , but can easily be fixed thanks to
> > > DEFINE_LSM().order
> > 
> > That forces the LSM to be enabled, which may not be desired?
> 
> This is not backward compatible because currently IMA is enabled
> independently of the "lsm=" cmdline, which means that for all installed
> systems using IMA and also with a custom "lsm=" cmdline, updating the kernel
> with this patch will (silently) disable IMA. Using ".order =
> LSM_ORDER_FIRST," should keep this behavior.

This isn't true. If "integrity" is removed from the lsm= line today, IMA
will immediately panic:

process_measurement():
  integrity_inode_get():
        if (!iint_cache)
                panic("%s: lsm=integrity required.\n", __func__);

and before v5.12 (where the panic was added), it would immediately NULL
deref. (And it took 3 years to even notice.)

-- 
Kees Cook
