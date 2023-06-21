Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7976CEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 21:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjFUV3t (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjFUV3q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 17:29:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436961BCA
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 14:29:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3083402b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687382985; x=1689974985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVtcBpBVguZA8qoqqhoUInWb/zY6DUWD1bjs2LWSb0I=;
        b=HVXsgsJ2YYMXYdInroPiqaqbGEH1WjW4jAMh+uUvV+Uw5eiEQ2T1cO3J24tu2UHtEC
         3/qMGW8RCfpt140xoltctrA2zl28kzVYi2S0Np2xPzOBl3Kj668sHAslYlppaiOa6Huv
         dIPfWyUQGWS0cdms7hGp/ovR66Ul7OKcNJqqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382985; x=1689974985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVtcBpBVguZA8qoqqhoUInWb/zY6DUWD1bjs2LWSb0I=;
        b=HeFbhcryAhc8ZL2I1yfGJfft6M3VWvLJahbFPKU43lMjSUYHCzKpTnUWsLXPeiocP3
         bJ3LjyB0EQXs0MfrWi03JNNnSyDtq9hyDaEp2ab88O0yg337kKcDfaRI5Rq8dPyAC+0T
         qQd2VTvXbmJ4MlaHMoGA0WzS5TbdWd+ojX7xSRbFcMkUmvIkjR0B8jmv88+5dHRMhuI5
         /VbwCjgmG6DXQD+/FZTHvffRw8nNkdSFJEsuRjhl7nla0U4wUY4e/fY+1u8u7IFbjYm2
         vocxhhBLJ/5aysJ8G846z0MkBQ6bM8rkH3vHDQ+AL3W8y0QSYDRHf3XoHEI/nx+BIF1q
         p6FQ==
X-Gm-Message-State: AC+VfDy7JeEZy7BiqZmKxqF0cbDz/f0DuHPTLhrQE29pQyqLCE6bLGYb
        uQC3/lmLAQKtg1VJTyr6Z1/IjQ==
X-Google-Smtp-Source: ACHHUZ7FddK1YoVB0as/jTCHRhdsySjJdOFSovi73J3mIp/EqwtFEAHJ+xDMzv/2QuWePq2bUK2WCQ==
X-Received: by 2002:a05:6a00:2484:b0:666:ecf4:ed6d with SMTP id c4-20020a056a00248400b00666ecf4ed6dmr12103959pfv.18.1687382984779;
        Wed, 21 Jun 2023 14:29:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b006689ecd0ff4sm3061860pfi.208.2023.06.21.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:29:44 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:29:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: Use struct_size() helper in
 ksmbd_negotiate_smb_dialect()
Message-ID: <202306211429.DA43E8D39D@keescook>
References: <ZJNrsjDEfe0iwQ92@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNrsjDEfe0iwQ92@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 03:29:22PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
