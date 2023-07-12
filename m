Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03145EB64DD
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 18:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjGLSqE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjGLSqD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 14:46:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3431BF6
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 11:46:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66c729f5618so6524978b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689187561; x=1691779561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ESgLwwjyOgaa7waZDqp6ISyFEWOGjH/PD1F91g9f6M=;
        b=n8q8XOrclQbUsMCUl9XXfoma3EycOkjIuuAyNm3h6BnRAM1DT7ozfr4Q6fM2lag2DB
         a0Sn48SD4RRkziGSWehZ6yadUBxIV/9wMniScIatsg2oCjS4Q6SJt/kcWxGcL4Y6netE
         HxYBPr8BNF7yq49FB+JRj9SmNKfoQxUF97+xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689187561; x=1691779561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ESgLwwjyOgaa7waZDqp6ISyFEWOGjH/PD1F91g9f6M=;
        b=WpZOXJ0tp2AmAeHr1ckDc6qpyKlKGIavoF11W84IA+pisemska4qiPZeXlMrqKFtqH
         7WE7LK5KRfPJFyzRZ9OpjYxSv6mBdTZARvv+OGf+D6U2+2LjuOx9YBDTtartRB06wbTV
         r5ezl4iaNnum1W3pVBBVTmddsjhN1WEnZ4SzDddAkDjuul6jWpmVSlAYr0hw+nSAj9ap
         2tNPRv3abGueu+dWPlEx04PU/NRScEpKUINb8pfRiQOxNtb3rdd8Px5gPs3y4EHOZ7gn
         CLWGLQJ/JkB0VWma3JL45PzyvUGGy5IinLMubOSAL+LAG1Qj50gfFKaWOlpYjlF/KeeZ
         7RaA==
X-Gm-Message-State: ABy/qLYWdkZiQ85rz4xoIFYS8sFDa5UCJMN8FQoBAKNL+EBIovEmNKEt
        7jUt1v0YrdaLEEIgz8IFzwGHUw==
X-Google-Smtp-Source: APBJJlFzvJdaSCmR1hmoQv6bxltILaByXVBtKtyLjmWvOnnQmZj4URhBWGHlRBRKVFP6y0ghhl/Y0g==
X-Received: by 2002:a05:6a00:b93:b0:668:82fe:16f1 with SMTP id g19-20020a056a000b9300b0066882fe16f1mr24780472pfj.1.1689187560994;
        Wed, 12 Jul 2023 11:46:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a639545000000b0054ff36967f7sm3957121pgn.54.2023.07.12.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 11:46:00 -0700 (PDT)
Date:   Wed, 12 Jul 2023 11:45:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Carlos Maiolino <cem@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libxfs: Redefine 1-element arrays as flexible arrays
Message-ID: <202307121144.855A9D9@keescook>
References: <20230711222025.never.220-kees@kernel.org>
 <20230712053738.GD108251@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712053738.GD108251@frogsfrogsfrogs>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jul 11, 2023 at 10:37:38PM -0700, Darrick J. Wong wrote:
> Here's my version, where I go for a straight a[1] -> a[] conversion and
> let downstream attrlist ioctl users eat their lumps.  What do you think
> of the excess-documentation approach?

This is fine by me, and I think it's much cleaner. Thanks for running
with this!

-Kees

-- 
Kees Cook
