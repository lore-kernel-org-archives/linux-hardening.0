Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF66C0015E
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 17:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjG0RBm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjG0RBk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 13:01:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430539E
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:01:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so507080b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690477299; x=1691082099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrdhbFq2TllUS3d1FOZRRA3ctMM7rEJWO6QWxhxN4X0=;
        b=gwKxjNrjlnXnzgiB40rgMiBl0/QtgC8VUcyszpZozy4dcwVgAWS2E8bfdp7c2YpL2f
         5K1p3ziPEsFBp9RabGxDWzD4SQH6S3e8EASPNAMSMVBUt0T7osetBpBmUJH8w16wFkCj
         LSWPtmArmmchxRrkcE2YLqO7umBc5u/VxmrX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477299; x=1691082099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrdhbFq2TllUS3d1FOZRRA3ctMM7rEJWO6QWxhxN4X0=;
        b=BRXMf9xb3LRtevAiv1PClh+YZSxf7xGEtkMP9ukYFN6iXS9SpNqM/fIbUFZSb5GcXk
         5G5makIHjtGyuDxke23HqQ7wjO6eUMIaqzSfGexRNjZLghRPBtuuINZT6pT9kkCoNTad
         Std3HwWvWUVNXCSHj5b0CgxGz4eGwjvdmfpseuFnedf6Sgj8Yc/JLIhA79f5CI4nWfMd
         UoIfnih23CNRUeJwrlLbI9qKwMhxmHg0oOF9DygD/ErC0YFz/6nzFKHknykiDCTCO9y8
         MrQSZEBRSUISQK99/n9PrU+4ILtb0tFIaGfl5FuUs5802b/k2pmVLT4wej86rEA3CbA9
         oRtg==
X-Gm-Message-State: ABy/qLZ3d5I4NYtf+IGtzqEf67BqTQ6NjBX2aZmVEJ+V4yNA8B5e2ktx
        Paa2OBf4AWfKlkVvrD9xk1zruQ==
X-Google-Smtp-Source: APBJJlFApVlNeR4dyVr69s6M57WJ+jQYcGl2/Dm1rae4njEHS0rUSMH2qUw00/brVLWB60QevPBe0A==
X-Received: by 2002:aa7:8894:0:b0:66c:2d4e:4772 with SMTP id z20-20020aa78894000000b0066c2d4e4772mr6049993pfe.13.1690477298723;
        Thu, 27 Jul 2023 10:01:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b006829b27f252sm1766012pfn.93.2023.07.27.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:01:37 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:01:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
Message-ID: <202307270959.900E3A345E@keescook>
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
 <169047317159.2400214.7882697833368890001.b4-ty@chromium.org>
 <87tttpz6ne.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tttpz6ne.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jul 27, 2023 at 07:00:21PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, 03 Jul 2023 18:12:56 +0000, Azeem Shaikh wrote:
> >> strlcpy() reads the entire source buffer first.
> >> This read may exceed the destination size limit.
> >> This is both inefficient and can lead to linear read
> >> overflows if a source string is not NUL-terminated [1].
> >> In an effort to remove strlcpy() completely [2], replace
> >> strlcpy() here with strscpy().
> >> 
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/1] wifi: mt76: Replace strlcpy with strscpy
> >       https://git.kernel.org/kees/c/535c78cbc0c4
> 
> Why did you take this? mt76 is in active development so risk of
> conflicts is high.

There didn't seem to be any further activity for 3 weeks, and it was a
relatively mechanical change. I can drop it from my tree. What's needed
for it to be picked up through wireless?

-Kees

-- 
Kees Cook
