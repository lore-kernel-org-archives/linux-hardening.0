Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86388C83F14
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 00:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjHaAEs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 20:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbjHaAEs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 20:04:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD5CC9
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 17:04:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf6ea270b2so1637725ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693440285; x=1694045085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wclbGISi0DTsfnw2wuB5z2VMldigUtFlGGDgvrtyHY=;
        b=i5emslwmEfx6A6P3nRttHrDbA0mNyP9zy0qnWunRqBPf/DtfXT3l30rX2T0zHYQdEH
         yEpo5WUZDGCiaHEcSnCv5VWn+TCugNATZKKEZVmfZfz4gyVOyxfN5yendgfJzugV9cq+
         Add8CLfWPQFY0bT8j2R2pKd9Yw186y/oC3z34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440285; x=1694045085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wclbGISi0DTsfnw2wuB5z2VMldigUtFlGGDgvrtyHY=;
        b=UXOQkQ7shIbdo19ggmrc/Suj5QD6KFjFX5To3uelEgO0MnNiw3zcibaIMvMnfFRL56
         swkHhBKoWmfJAj+ydC62dUR6RD+wRlhQZ6wFa8u06N45rFlyXDCz+Z1DUPhlBd8cSaAJ
         fwrQTx71C2JkbEgu4tg4a90hQ7V10jnZt2ocFktYAyl1+G6b6oXjtyuIdC0xHy/lBZdo
         +1Qwjq+QkNYoLGHuBqcZSBE1NOPzR/K0ngHh3ZpYoTrdmIfSB5hg3uzV6FbofOxoiagy
         TuuS+zjlIkArr0TXL6/2qbpoNHiXaZaNqKx+jj/xbux1u6rgjGDYopkqdaWMBIvJYCzL
         JKJg==
X-Gm-Message-State: AOJu0YxrKvrREdNZuMYfbdKbGO8ByFcXRc5Cz8097+hIaJOmrWqsFVzZ
        oZ7z2R+Qk4Q74q7Y1KLH6qs8vQ==
X-Google-Smtp-Source: AGHT+IFGMTemHoGX0sBWxi5Tew5dUP8jSwJec6Ka+YeMhrkhHDOargCzGiUpjQ6Og16mC5nefUj++g==
X-Received: by 2002:a17:902:d34d:b0:1bf:5df2:8e97 with SMTP id l13-20020a170902d34d00b001bf5df28e97mr3592551plk.4.1693440285320;
        Wed, 30 Aug 2023 17:04:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902820d00b001c0cb2aa2easm67102pln.121.2023.08.30.17.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 17:04:44 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:04:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k/atari: Replace strlcpy with strscpy
Message-ID: <202308301704.7A3F0F9CBD@keescook>
References: <20230830185428.4109426-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830185428.4109426-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 30, 2023 at 06:54:28PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
