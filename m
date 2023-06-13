Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C27EB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 19:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjFMTYQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFMTYE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 15:24:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423A1FC2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:24:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b3c4c1fbd7so18516455ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684241; x=1689276241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTjIPDpkQa3VuoP57lMJ7BntaNSVpd5s/6n5Z5BophI=;
        b=BFk+KLo8AyFTwl75dvJrkMUiU5O0zBWVIuH3k1X/cMgHY+owCkN+GbwZQm98xJlt6d
         Eg6pHt468GyNfzv2T3adVh2PhUhofAjkRdB2N2I1Nz2lYJwZtNtROyN6Whx4xrMUTxaE
         bnPQigDrbnYNXENBT6muXhyfb6bwSDjoEZGWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684241; x=1689276241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTjIPDpkQa3VuoP57lMJ7BntaNSVpd5s/6n5Z5BophI=;
        b=VtFLDVQy2XZDn3gOtzrzz5fXMGP3qbLBFGaEF1ciIQZTGkNFWR1jet1qBoEHfl7IAO
         8AvBsMh8RfDwWctyLmRZJsDY+AddhLACmpktPoy/W7ylWILRx8aBduF9jwvVCIsfb8FN
         6fGTMcGrK8aLXIAScYxl5c5l7I0kEhXDNfXpSmi/Nhra3G7fbLfPuu1BbL2lkMlgmhb8
         rzfs3x7V4MIgQxz2v31LOx5Zz0lO9AiJHVVKylUWts8bTSVv9vd27UgqC7U8z99tz9wH
         K7pg+s4hlyTrbI5ZT83i10+7En+KXhg3QJyyP3OqDS15KN1FwvCAIKmFCOKUJdf9RW24
         uz6w==
X-Gm-Message-State: AC+VfDz6ju5AFasGcNuZxydboe16I96JXfzQ/1hDSqnltV+W2gS+NsN5
        ezTPyG+vKGhd9s1TIJtxz6YJXg==
X-Google-Smtp-Source: ACHHUZ5Xio21b+oMrhdUH1aEbO1e1KiOm+5dj7FNMCh/97l936Jqv0lrNd7Ra4B1IM3emNt/o72jiw==
X-Received: by 2002:a17:902:e74c:b0:1b0:e0a:b7ab with SMTP id p12-20020a170902e74c00b001b00e0ab7abmr9998246plf.31.1686684241406;
        Tue, 13 Jun 2023 12:24:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001ab09f5ca61sm10631831plg.55.2023.06.13.12.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:24:00 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:23:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net/mediatek: strlcpy withreturn
Message-ID: <202306131223.F8F403D386@keescook>
References: <20230613003458.3538812-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003458.3538812-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 12:34:57AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since DEV_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Yup double-checked the users of the macros. Looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
