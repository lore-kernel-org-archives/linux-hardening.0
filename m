Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F6C77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 22:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjE3Wzl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjE3Wzk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 18:55:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8893
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 15:55:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3719485b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487339; x=1688079339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkBhxE3ytz2kF3tpYV9IN2L47NlunYx7yD1fvIugVDg=;
        b=JkL4TkmaBIayj5OCIMW991JmgQnj/gOpmqu0Jw8iYq3PMtBsrylqK5iciUUO1fhYgS
         2o7CARmlg2bDXlKcJclJ9S/L2d10IK4UribgkAI3rT5ddfJwfkzp232e3xf8cjAq3sQt
         imoZlKZvz+c0GKoP6pL6IeBJqKSiae+R/iNng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487339; x=1688079339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkBhxE3ytz2kF3tpYV9IN2L47NlunYx7yD1fvIugVDg=;
        b=EmXt33HDAUFJ6afmPZigCpX8gGqEhOUGhV+pfvCnpi2TZkTPgpuTsthvfeKd9/VnZO
         wLZ81vpjMfQ63Vmh4KWMtQLYj805P0uQ3N4Z5zW4EtMyPbK0rLHaRYLo6mZvX3t5oX2v
         ziSz15abf5a44mDiz7bQ7CYMLN6ABInygMU9LPi3pjigPusGLDTtNRRAjjmcThYS9XCG
         +xDvFLAOPld7kRwpuafx/RRtYX+7OLZURxrJPmTpuOj9H6HXZiBS6IWptFrNFBblt3xO
         W+xISdX7MV9eVUPSNJJukizrtXz3nXV4TTtMt3LJiUi6AhIBOU5VHZIkjTkoqC0GPa/H
         Vs2g==
X-Gm-Message-State: AC+VfDyntKENjXgJ0TXkUfL3XuQ2GtDFoGSoWK/J2K58nWDf4Ke+pXKb
        dqXmZC7IVATN05zHiYT4f45JCg==
X-Google-Smtp-Source: ACHHUZ4QeCYlGPt+yRrQ988Mpa4bp68BlE3Y+Yn/n1L6hGlqQLXCt+xE8FWGrglyjI0IqtiDNi9FTQ==
X-Received: by 2002:a05:6a00:2e12:b0:640:defd:a6d5 with SMTP id fc18-20020a056a002e1200b00640defda6d5mr4441213pfb.12.1685487338720;
        Tue, 30 May 2023 15:55:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s22-20020a63dc16000000b005344b30d449sm9336232pgg.86.2023.05.30.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:55:38 -0700 (PDT)
Date:   Tue, 30 May 2023 15:55:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Message-ID: <202305301555.102E1890@keescook>
References: <20230511213441.never.401-kees@kernel.org>
 <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 11, 2023 at 02:48:29PM -0700, John Johansen wrote:
> On 5/11/23 14:34, Kees Cook wrote:
> > In the ongoing effort to convert all fake flexible arrays to proper
> > flexible arrays, replace aa_buffer's 1-element "buffer" member with a
> > flexible array.
> > 
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: apparmor@lists.ubuntu.com
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I have pulled this into my tree.

Just a quick ping: I haven't seen this show up in -next yet...

-- 
Kees Cook
