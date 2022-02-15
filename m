Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC0C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Feb 2022 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiBOU6s (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:58:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiBOU6r (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Feb 2022 15:58:47 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C757927FDB
        for <linux-hardening@vger.kernel.org>; Tue, 15 Feb 2022 12:58:36 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so142201ooi.2
        for <linux-hardening@vger.kernel.org>; Tue, 15 Feb 2022 12:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5a/x3EJavPanZMZjjHQuhtSqRRw7tRmuA9y5WkmF/+k=;
        b=XA8VgW55ty5IpGeDK6Vzu8dPwy0r6ikLvR+GeTgZMQgjM6+GqLUSF27l+SDKbSiIjo
         vbmfyga7mb6xzawblwN/+KYsNKXsYT9YsCRhvGRoNYcoTT213kkkqZQN6Y0uAw4ByKlh
         o0/MfrY7EdPTzNtPh8acoiFtnfe/xqmNyG8Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5a/x3EJavPanZMZjjHQuhtSqRRw7tRmuA9y5WkmF/+k=;
        b=tDXQsws5HGImJoA+Knjy6cvC211ecVq5YXG5VswmN1xorO8suXJZDTQt0kWKAryBkm
         8Bw4Be8ZhcYDwv38f8zgAXLIdT/H044X3VhgHrnAPTQESZTqhfv4NeUDm+y3vgVX3XnU
         Bea/fGbynGa8XUulw0t90mKI5tHJXMLP+VUY0o9EhZF2l5iYg9TKE1n/lMp8OuOgFiA6
         1G1e+coJ19++yG4Wcogrj4rbJjz/ku2M61+wq3opNKYiBrrfe+5Vr0o3qye7PSfsgif7
         zmvxnBr5KfgPf4lD+5CskZchHyMtnfhlha5QJfTkpi/wPr0+M7A910uqCSD4MaI2XUcA
         SGhA==
X-Gm-Message-State: AOAM5337rz05frciE2EA6dAnR9wSwMe0/kdiEO/wOskqeUF/3uEchHcH
        3eDhW8ZWszouXqs/3sifu0+ql6fY5woEaS7a
X-Google-Smtp-Source: ABdhPJwAZKcNRIrTVH75KyUp18uzB/TIylfFk2VoBD8kUxZAJV2MNFjuPFxTFDIbk4Up7UwzslCi6w==
X-Received: by 2002:a05:6870:8c2f:: with SMTP id ec47mr339909oab.117.1644958716083;
        Tue, 15 Feb 2022 12:58:36 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id y1sm16998142oad.38.2022.02.15.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:58:35 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:58:33 -0600
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <YgwT+WEjZS3bfnS7@fedora64.linuxtx.org>
References: <20220213182443.4037039-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220213182443.4037039-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 13, 2022 at 10:24:43AM -0800, Kees Cook wrote:
> GCC 12 was correctly reporting a potential use-after-free condition in
> the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
> when size == 0:
> 
> In file included from help.c:12:
> In function 'xrealloc',
>     inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    56 |                 ret = realloc(ptr, size);
>       |                       ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
>    58 |                         ret = realloc(ptr, 1);
>       |                               ^~~~~~~~~~~~~~~
> subcmd-util.h:52:21: note: call to 'realloc' here
>    52 |         void *ret = realloc(ptr, size);
>       |                     ^~~~~~~~~~~~~~~~~~
> 
> Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
> Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested this patch with the Fedora rawhide builds, and this does indeed
fix the issue.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
