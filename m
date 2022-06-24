Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3281DCCA473
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 17:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiFXRso (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiFXRsn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 13:48:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C543EF4
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 10:48:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jb13so2701640plb.9
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zliD2Qsx7OubU1h4LVAM9OejLzFcsBaCjZJRdpEsKrg=;
        b=Pz4gqJjlBZdH2FUZf+LZ3Zk2c4Q5PjoLHgSJvUIfFCXLQ3s0DQzl2M7apET6Zy18l+
         gg0BY+PsbRil96ZfM2R0pnbNH0l4VO7BByOsiIJRLMuVeDsIjk5zBu5mdXPAuoNx6L7B
         hNj9RV6ELW7Ls1GQSQx6AOxZK02AhyVXkIwbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zliD2Qsx7OubU1h4LVAM9OejLzFcsBaCjZJRdpEsKrg=;
        b=TKTGDMnEqh6fSSOkH0vHoQu00VBKHYV5Z7Gl9V9zCo/k9a80jViXqPVl544k84o2K8
         iIQriTOrHxkMmGIW46TfzsG0TaoIGGgJTQBZDFgZBHaqAl58o0ke4q357ufyE6SRvelG
         0tmBerCUXJ5lKFiclmX1F81iSanBvVvabEIa6N4GPKJ3ConjXJzBUacF+SnXxmjaDFmz
         4tjFQ4oqGtg1sS6wZCVX2pjmj1fiaAYi4YltJtNcSP4RIgrdwH74dZ/64v2nmgQY47vY
         IAqbKB/CHyFNGB0ZUgcqvXayMffRKQQfqCaBDn0drE9LHjTuDGjjqDNXf4VOo+x25s+G
         laFg==
X-Gm-Message-State: AJIora+LgJdmfp0mOeHM8lWaBBk7JqRB9uPiz/+445tFOVRK/9wrG4pX
        RMZ47T9oyVS4OKWoH6BLvt9LEA==
X-Google-Smtp-Source: AGRyM1uURdhPI99lDJvqkOTCp86a8zulQKgFl/xro0YHHIZMRm4Fw3TKtsoXL4ek9b2CUpM+7eruIw==
X-Received: by 2002:a17:903:2443:b0:16a:2b65:7edd with SMTP id l3-20020a170903244300b0016a2b657eddmr332318pls.20.1656092921012;
        Fri, 24 Jun 2022 10:48:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902e9c200b00168ba5ac8adsm2111628plk.163.2022.06.24.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:48:40 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:48:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/4][next] scsi: megaraid_sas: Replace one-element
 array with flexible-array member in MR_DRV_RAID_MAP
Message-ID: <202206241047.903049ED@keescook>
References: <cover.1628136510.git.gustavoars@kernel.org>
 <b43d4083d9788bb746dc0b2205d6a67ebb609b0d.1628136510.git.gustavoars@kernel.org>
 <202206221457.1A12D768EF@keescook>
 <20220623014533.GA7132@embeddedor>
 <20220623031401.GA8896@embeddedor>
 <202206230816.1383511C@keescook>
 <20220623153825.GA6458@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623153825.GA6458@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 23, 2022 at 05:38:25PM +0200, Gustavo A. R. Silva wrote:
> Which object files are you comparing here? because I don't see the zero
> change when comparing the before and after of megaraid_sas_fp.o with
> the change you propose.

Hm, maybe I did something wrong. But I was looking at megaraid_sas_fp.o

-- 
Kees Cook
