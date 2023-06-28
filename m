Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC45EB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjF1ULi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjF1ULN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 16:11:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D12134
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:11:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b84c7a2716so2351695ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687983069; x=1690575069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5K4gcsgfu5VdAQZmgsxJjZsYjNzsysi7aJ/FIr0V2kA=;
        b=de0X15c22x4phdM0BKgrnCVftBlKRbqym+5tXlx3mmoYm2yv2sZUv7lssa3ypa5liF
         494z/vLNcOuupUwxI6KNzv5kLS+IerDQhhxtsdWSzbITrutMyGQUCw64p6Dr5N7CiE3i
         wJqJM/v/Lvx77uHrLUotpWbiKbgPFumcU2xB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983069; x=1690575069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K4gcsgfu5VdAQZmgsxJjZsYjNzsysi7aJ/FIr0V2kA=;
        b=TrQjuOfBesyRd0B9CyUMADCBBJBW+YPZ7z91x1njM2G8cudJCHMX0ZhkocY1NW5hPX
         2zeQIywHizVWCPkxwTjBliq2280xvmT4Kz3C4zcFny2kfboqnOEHZHYI3mZXd26if26D
         D2NgdwyZ7+ljWrFVUlOcUccLdO1hwpMcd95a4rhBf0SKJ119FU0ph1DnZA/d65/hoiZT
         1VyhHk03hNc9h4iGlapokdFYgGurGaIeBY1ebiWzQ6av3bdovercTGp+Zn6sft5LWhaO
         v3Cz+5fGWedlblSX7jJaUsFvN3ql75F5VUXmJ8GNsfj+60QxCiyVIxG/oCxRH/X9kQHc
         YMHw==
X-Gm-Message-State: AC+VfDy9yCywup6uJDepz9ZC2Xl5067D9CYRbE9tQI6j59ufCYUWALXC
        VAoubhv/5GuxGOTMtvYuzmUQMA==
X-Google-Smtp-Source: ACHHUZ4PcHsrof2rSh4ypgQ4TC9TefxxeJCtnWJr6LVXVz2BjqfkCNVlKErJZ2LW9jafeiNxTeHaIA==
X-Received: by 2002:a17:902:9a09:b0:1b3:e003:be8e with SMTP id v9-20020a1709029a0900b001b3e003be8emr9732346plp.7.1687983069715;
        Wed, 28 Jun 2023 13:11:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001b53029fef1sm1950809plb.172.2023.06.28.13.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:11:09 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 10/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct user_sgmap
Message-ID: <202306281311.8AE923473@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <2ebb702f25c4764fb36ab29f4f40728e12b0e42b.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ebb702f25c4764fb36ab29f4f40728e12b0e42b.1687974498.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 28, 2023 at 11:57:48AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> user_sgmap and refactor the rest of the code, accordingly.
> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.
> 
> This results in no differences in binary output.

Confirmed.

> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
