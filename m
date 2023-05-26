Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1674C77B7A
	for <linux-hardening@archiver.kernel.org>; Fri, 26 May 2023 17:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbjEZRny (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbjEZRnx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 13:43:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6BFD8
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 10:43:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2563c462e06so442389a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685123030; x=1687715030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hg9Y1Zeqm2LukQubiT8t4V/vqubtiFOiCTgTYUMaUVs=;
        b=lta3MXHxjS1c7AJAUPLUOeHcr5x4Zo3I0sh7vWvpASJEc8uOh/eMfflNOlqqurTpiC
         y1tn4GMr/aIo9mLeE/wroXnkfagYh0cxm5KsTTxf2BD+1Xlltby4ztTCm4k6kClJA5qo
         sIYWv8PJerV3mljMW1vWIqC1jQcttRocREL9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685123030; x=1687715030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg9Y1Zeqm2LukQubiT8t4V/vqubtiFOiCTgTYUMaUVs=;
        b=MiycjNUTOLUFvCKcQe9x7eUDSap6/zg8c5ztrvvlr+Fo0d38gj/aKqX/VOGgV/4FNZ
         d4sk8oBmL0vt2Si0D4lY6s9LzWPSe+EUhVwlrxFXI+DxC+Mv2Rd+UmoEdY1VGgTRvKj1
         nrKCvdwbq56LSbgUjF+KpgnacFWTJCZSCeLOa49Qks55AXKl4ZHlxQLSkcxhq5MEInyj
         gUwvPfE4f9fKP13rRfp81x6rvmF+iiyh6v2FEhTlWSMjXqQlhdye3vgUvvezdQgkuQ78
         rfFgpoLvn0U4+BvA8vlqkMLzWAxdqd7lsqln2NiyUfJSNdYAgFAl+nlt0GHeWeCXj+TN
         YnGA==
X-Gm-Message-State: AC+VfDyi3ZXwouhPhWuoH8rFV7U3l7vFzmQ3IU25NSHXGxxUf6XjwznQ
        KNNh9T0g6EK77dLfJldQkI3Y9w==
X-Google-Smtp-Source: ACHHUZ7/7bJzxKpXODcLcQHpGpV/j9si5r5SwPI1mqbMjnGFBZlzEi+VmgCEu3f6lGaHSTOA1ark4A==
X-Received: by 2002:a17:90a:55c9:b0:253:27b4:cd4d with SMTP id o9-20020a17090a55c900b0025327b4cd4dmr2849789pjm.27.1685123030618;
        Fri, 26 May 2023 10:43:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 127-20020a630385000000b0051b5d0fe708sm3074081pgd.43.2023.05.26.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:43:50 -0700 (PDT)
Date:   Fri, 26 May 2023 10:43:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: pci: cx18-av-vbi: Replace one-element array
 with flexible-array member
Message-ID: <202305261043.A86E75BD5B@keescook>
References: <ZG1YVji9thTLWeRm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG1YVji9thTLWeRm@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 23, 2023 at 06:20:38PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in struct vbi_anc_data.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
