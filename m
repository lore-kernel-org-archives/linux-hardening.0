Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494DFC41513
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 20:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346190AbjHPUjr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346194AbjHPUje (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 16:39:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A182701
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2681223aaacso181114a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218372; x=1692823172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/VlrpLaLonWwvLdMHTbKBLWS+0ZwHTAviVzHTRR32g=;
        b=b8C7A3fSaauDeX1Uma32OORq+lCiJhxdLrG3qjzQPV4bzX8r9TZ+BlQLwV8DkRl7g8
         rOwidredzXHeJ/K7i7plM3yCqTPibNGdAO+aWx7ICPfAOm0vx/l2oGhIgC+QWVD9/mzy
         XPyTkIHMldPIr/2pJWGhBYBVOcf2ZxZCPFUV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218372; x=1692823172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/VlrpLaLonWwvLdMHTbKBLWS+0ZwHTAviVzHTRR32g=;
        b=N56va2ewWnOzxfgJFuGaQsVa2nXFiyr9qdk1oMCedhLIVvE25QdF8U1PKTxBqM0ADs
         0Vh16+Pq1r0k2pbTUCm0eSFu1hC3saDXaMdTvOMJem+MIGF35jNXXQrvYjMBtc+ygxZW
         aysjBLh2dD+Qx4kVRxWBG9TQxqH2tBZlKuhKstKl+UJ4JZ6X3R9A4Ar5W+94Ubl09WnD
         6zMA4LuU0Ns5lf2abImi9BFW7rU0okBUGcHHBaR43gIKSmGL6e1ulAh602JYNxVHvCyX
         QerivSg0970jRmsss6gpR6Q3FzSB/z0X7KF42QkP7H5WztWHczdrOqd2xE2kev6vQ0ZF
         G0WA==
X-Gm-Message-State: AOJu0YyC3ajTN3Q9mjUSoVYc5XnZx2AYj0ji1NcYYvmeaWLxaEw+tXDM
        4YF8VG+Xs91SFiAYHDQduiheHw==
X-Google-Smtp-Source: AGHT+IFH3p8cu/k6sO/6dJ0jNC4lS5Gy9QpuuFjew2rQXbw+Jnrz4Trg8GNoh8Zj8AEI5qs6r8bbSg==
X-Received: by 2002:a17:90a:e7c1:b0:268:808:8e82 with SMTP id kb1-20020a17090ae7c100b0026808088e82mr863439pjb.1.1692218372471;
        Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090acb8400b0025bd4db25f0sm142476pju.53.2023.08.16.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:39:32 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:39:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bfa: Replace one-element array with
 flexible-array member in struct fc_rscn_pl_s
Message-ID: <202308161339.C68DC815C@keescook>
References: <ZN0VTpDBOSVHGayb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN0VTpDBOSVHGayb@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 16, 2023 at 12:28:30PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct fc_rscn_pl_s with flexible-array member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/339
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
