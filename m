Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA5EB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 20:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjF1ULW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjF1UK4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 16:10:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F00A1FF6
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:10:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66872d4a141so159969b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687983054; x=1690575054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPuF9yHugeE7qGYrhgIx3HdvRmEnZj5SYVSQZwrTnzs=;
        b=LyIozwLW6BJ8L75SPZ5k62iYFqwM829PwYYxM61K8xVbNXWv2PrkvZYtrPI0pe1oHU
         JoOzrQ0n7LDK6NKYmNPpcq9BPSahVoRq0h/np4dAmsco3AunvPKeBxE19KLyGuA5rtZ/
         zwkwzVLXll8+gKuzvlV4h1kHibndHGc7oAdsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983054; x=1690575054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPuF9yHugeE7qGYrhgIx3HdvRmEnZj5SYVSQZwrTnzs=;
        b=hxpuyFdbIczqRpdzATkGZNkO2Zs03LMoStXHnZ44ML0DE4UmCzmY1TB4a2DntgFIAx
         Nzpclkn5NNHdBz9uBPrdxMJjH01zR/HQYQ/jk65DiWHzSZw/B0cyoSvkeaLXJJIq1cac
         mtOUXaX/qqSKByL77WyRqpTy3obH12YR3kqW+u1EmtKGtx9pVgPUMqPaFApwedAuqZ+F
         8Q5roi8BgPv3KooygCul3KH50P+aLNlCMB1ABC9X7KRrMG6cgJuM0OMmNllEXxF2PnT8
         OUzRfTAOZv1hQ+z9eEkT5wlRhE8TLyvPQssE5U1vYBKgab7IkpN9/uIc9X86MZrIu9TX
         Q3MA==
X-Gm-Message-State: AC+VfDxzM3jA7dWDgia9AVRsD2tCmiB3OinL97XfLWMI+VAVMzHYM/Mi
        vc7JyTgJlOptclkiOCl8LTBEGA==
X-Google-Smtp-Source: ACHHUZ55jdjN5EWitI5f7ABp6SmlMK0NO4JcVOamLfeFTSEqKRFsrILQSCkGHc4APhbxSZFt3e/G1w==
X-Received: by 2002:a05:6a00:14c1:b0:681:4726:2975 with SMTP id w1-20020a056a0014c100b0068147262975mr3170493pfu.7.1687983054649;
        Wed, 28 Jun 2023 13:10:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b0062bc045bf4fsm6881611pff.19.2023.06.28.13.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:10:53 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:10:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 07/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct user_sgmap64
Message-ID: <202306281310.6CC48E4D@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <bf0845f7cbe2a507a54b9d5bb35a22a1ca265178.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0845f7cbe2a507a54b9d5bb35a22a1ca265178.1687974498.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 28, 2023 at 11:56:52AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> user_sgmap64.
> 
> This results in no differences in binary output.

Confirmed.

> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
