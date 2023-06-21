Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39DEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 17:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjFURwX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFURwL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 13:52:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584571FE0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 10:50:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-54fdf8c79a3so3206745a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687369856; x=1689961856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul91Gz+yGEhmaOXTQJ2di/sLFzTVDLLuzrW8OhsrW9o=;
        b=PN88XqpGSql5ti6zvT6MUvr9iRN8qejKRO5qMqIuXMl4qKT/uKG4P1FmNIemZkRScj
         KsudeTVuvXIjTPV/yKqEfzwR1i99um4nsgTQ0U0KpdcF/BxGhOsbrldKHFhAe1mViIHK
         JWPqzFj8jkO0Mk5C1pG3VeABn0XA9qWSNdi9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369856; x=1689961856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul91Gz+yGEhmaOXTQJ2di/sLFzTVDLLuzrW8OhsrW9o=;
        b=PnPkW9fZi1iqi3yPBYV62f1d42nykNVJqRiYZby9me/wYYTWfdeU/2UXTOjCIB/fdC
         gxu2K1pKleqSgiFu8c/HEsng9yUy1kB/57FC6SlR113Nl6sfs4W9EMuh52kRLExny59I
         PNRNGA7I4MIGI7CZRdtmmc0Qihwidu4CPc4FDG9S7P3xWMZiwc3hJ1vfUEE7hen7MNZn
         4MJc9cumLn2f1dJtAUf770IAaxfq+0tTAsp0x/KvkH95cQjqqimuxfSYixgiHY/MV5tF
         AHTC5GzE7xmWzR/WcntYXf1tzCgtrIb3Dc8OaRpZnKBLqJ8P+i/jwt2krFDJWR1qfIAr
         DTRw==
X-Gm-Message-State: AC+VfDyaviXB6O2LeIjYRvfviMcv+4DgjmzRipIwYyjLwbyMyJGgga0X
        gjR0yXUYJZFfUjSBP1TZkF0+4Q==
X-Google-Smtp-Source: ACHHUZ7ylAOPxm0ae9kRQYk6NPxzV0WTtVMQNcAedwT2Ag86/ZawLLXcJ65lEiAZwo2vPHOjAsR1Cw==
X-Received: by 2002:a17:90a:d908:b0:260:afef:7b6d with SMTP id c8-20020a17090ad90800b00260afef7b6dmr5982996pjv.39.1687369856294;
        Wed, 21 Jun 2023 10:50:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a6b4600b0025bda194e5esm9179619pjl.31.2023.06.21.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:50:55 -0700 (PDT)
Date:   Wed, 21 Jun 2023 10:50:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 56/79] pstore: switch to new ctime accessors
Message-ID: <202306211050.969F935BB8@keescook>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-55-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-55-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 10:46:09AM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
