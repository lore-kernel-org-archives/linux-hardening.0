Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2094C77B7A
	for <linux-hardening@archiver.kernel.org>; Fri, 26 May 2023 18:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbjEZS46 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZS45 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 14:56:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1083D13D
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 11:56:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b011cffef2so9018305ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685127415; x=1687719415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSj23Ygy/LeYNL160hb36OKyVMmbtWslUUZxoLYre8k=;
        b=WV6iS7vdC0UyPONyu3GoVHaX/teq0aAOLnDLc+HEfVRIqo2rwUOqFmyu8lYG+LEDp+
         miDg5XiFHrFiQhKLHYOcDDEXAK8nC1kgJCnPN+6gR8NM0kgXbiHLvy7dSHZo8znmSUpz
         3vOP/Eka5f9wGc0ieRzLs6SstQEZDpzEEhfJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127415; x=1687719415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSj23Ygy/LeYNL160hb36OKyVMmbtWslUUZxoLYre8k=;
        b=KpvXf3wWzEibeYf0cmBNGuJszU+mS3+hhvSDELOAprpzM8VhqB1n/0trZeXMy5ficm
         cEw95CTP9VgMK7UUomlnMglTuIIGAZZ5EMlj7FJED59nx4NCyKWl+aexPxkAzYe3Th2A
         AF0Tgwe0M52nkuEJFcXBF236q78MUIRIKPxOcRJEW22htjCCpiX+6RMB+0rISfhmZ6yg
         bT0pX7CvO23i/xhq/mhhdpevoEkEDcFf3Ao5phHrA0jnf0KJPUBlxf7QfHeLw6Wb1QrX
         L/2mS3/XIuItqYWRSYHNUjEH62v5KKaTv1rHLp7Eo+/glKa1T3jnU5G5Am0xY+nJpwtf
         ZFDQ==
X-Gm-Message-State: AC+VfDx+0pOMIbqKc70jcOoaeo0jFVRJo2xk9Ibcr22eCPFTwkiZJwz4
        AvuCl6bUX98d9TuTEv3A9NIGBQ==
X-Google-Smtp-Source: ACHHUZ4pa9oCfs3Tr2WIutfaZtF57hm+Ea83Uk/wzE0Jj+t+Z+a87Gy1lY5t1tm19stAI9Hngey7OQ==
X-Received: by 2002:a17:902:e806:b0:1af:d00c:7f04 with SMTP id u6-20020a170902e80600b001afd00c7f04mr4614891plg.12.1685127415577;
        Fri, 26 May 2023 11:56:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b001ac5896e96esm3565658pln.207.2023.05.26.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:56:55 -0700 (PDT)
Date:   Fri, 26 May 2023 11:56:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, qing.zhao@oracle.com, morbo@google.com,
        llvm@lists.linux.dev, trix@redhat.com,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Message-ID: <202305261156.67CDEE933D@keescook>
References: <20230517190841.gonna.796-kees@kernel.org>
 <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
 <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 26, 2023 at 07:47:03PM +0200, Miguel Ojeda wrote:
> On Fri, May 26, 2023 at 7:16 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > FYI, applied to for-next/hardening:
> >
> > [1/1] Compiler Attributes: Add __counted_by macro
> >       https://git.kernel.org/kees/c/86a76e91cbab
> 
> Sorry, I was going to apply it soon -- in case you want it:
> 
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

> And thanks Nathan for resubmitting the `Reviewed-by` from v1!

Yes, apologies for missing this in my v2 submission!

-- 
Kees Cook
