Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A21C54EBD
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 20:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjAFUHv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbjAFUHp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 15:07:45 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71A831BC
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 12:07:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d15so2774894pls.6
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 12:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEktPCbwi5g+6SaYFym5tT8HZtL/drJKJLNAnRnPbfA=;
        b=Kz0ug4NYxM0YAF3Gp71kb56h8R+3qFjvl1GoW3QWodrazui6f91Afp6S1Pni8Ab+Ii
         Pl/HA8jylWCHPwnFW//wYDy5tOEdzZW0FdH+0yaVzbOpb8L1pmsC9efFb63737zygMCy
         gehYS3yBzOmeggZ58sDlRjw3fEr8uECX4xF58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEktPCbwi5g+6SaYFym5tT8HZtL/drJKJLNAnRnPbfA=;
        b=5pHBsaGRi4sHPx7n28GLoOCnJzzY7lcSTQStn4VcfNtWCZBrhIjAWQKHFcCROhPkEf
         6UMCR2zc9Pq392DziKQerL6ew2pxME5S2sUMUjQl6HmVsVqLg7n0d4roiW0xYOABIWYc
         2w2wGFoOIdVxlq42JOzIsBPTNixbzCTE18KD2V+Tw765i9zL5O/EpNx4UWEP7iP7ZZ5i
         7tSshIjuIIrtdJHM//6L0gSqVOfOJTMhEvF1FGTPqNoWK6oaySCg1Lu44Cotl+WJWaQ9
         ZaJRkEjm2pfzN9FplcngjpjMGCZ2Ee3qH5TbwqqK+cFt9JwsWNETEkbpd4Qkxt1uw6eb
         uEag==
X-Gm-Message-State: AFqh2krdTNRFNKdWe4XvXdeMMV8UweOWJKID68qkRJl02U38TMH7sbD9
        sy1dBl8BSZpEM2Pl5dWXaku+eQ==
X-Google-Smtp-Source: AMrXdXtZhrhGjfNJvviXJFQnedvNbPnzT8xjKZ6W1d0G43dRe7QOINfwq4zrhXpZJ3lo9mfI6ls9dQ==
X-Received: by 2002:a17:90a:d793:b0:219:1b52:859a with SMTP id z19-20020a17090ad79300b002191b52859amr59447957pju.10.1673035660555;
        Fri, 06 Jan 2023 12:07:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090a00c200b00223ed94759csm3141757pjd.39.2023.01.06.12.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:07:40 -0800 (PST)
Date:   Fri, 6 Jan 2023 12:07:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] ethtool: Replace 0-length array with flexible array
Message-ID: <202301061206.30BA940F83@keescook>
References: <20230106042844.give.885-kees@kernel.org>
 <CAMZ6RqKyvGwh7iOVvtONGYA21==Lj6p9JECstCBFSWRRCPAVZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKyvGwh7iOVvtONGYA21==Lj6p9JECstCBFSWRRCPAVZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 06, 2023 at 02:38:18PM +0900, Vincent MAILHOL wrote:
> On Fri. 6 Jan 2023 at 13:28, Kees Cook <keescook@chromium.org> wrote:
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Side comment, this link does not mention the __DECLARE_FLEX_ARRAY().
> It could be good to add a reference to the helper here. But of course,
> this is not a criticism of this patch.

Good point! I've sent a patch for this now.

> You may want to double check your other patches as well. At least this
> one is also using the helper when not needed:
> 
>   https://lore.kernel.org/netdev/20230105223642.never.980-kees@kernel.org/T/#u

That one does, actually, need it since otherwise the flex array would be
"alone in a struct" which is the other case that C99 irrationally
disallows.

-Kees

-- 
Kees Cook
