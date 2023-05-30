Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A7C7EE33
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjE3XRf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjE3XRe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:17:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A92AA
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b04706c85fso22389745ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488652; x=1688080652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cI5RWWDaCtzDppmiGoeA662GR/0rxVkDI+/Xp1CjfFE=;
        b=mnlm+bH6/fI+ZtXDTL9Lrmbx7ViXjTU7huF80OGn3FPSp8sLaGgLeMI/tbG51iToyf
         mHejWE7I8q4WGv1OLqXPEGPc2Sr9cyq04o4I5lYUkiMp+gXSQAX+P/Z32VBAzM9xpOe8
         TJlReIhaYPOcD9qAo6SrRLJQGDxkHsAZw9l3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488652; x=1688080652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI5RWWDaCtzDppmiGoeA662GR/0rxVkDI+/Xp1CjfFE=;
        b=iL9uEI6RQXMUVz6gpR8zP3sVhVggEPHzExBbcwZce0Jd4vdoVSH25v5vo5twMPweou
         NfLHAEFo4BttNM6BlQFD5zmRBfCALmvoWeJoInw2BugCOBQwbHxf1cAGC78OZWbvZty5
         1cnAFrR7aUVX3OXmvqCM8X586Iawd7mRUCY+cXBw/kf4X96NI6hS9KnOth3qeot4sOdN
         8HQlG2w3cLnZbTdPVFFUKL7EBj2FkF4LCYeB9rDBGScRVc+wzy1gQkVegm9AL1lfR487
         nz/Xldq7hT34Vk3TqZ2PdhIH9HeMTMd5Y/LSuAwLMnsLGEAdoxojp+ciO9/7GVFfSUq7
         NiwA==
X-Gm-Message-State: AC+VfDyDB8WDvwGKIp81xDEgTmE7cqAH1TwPNX14OGZ8sYdmWNwZbp4p
        xL3XQKwdWpjLYEU5fC/HveK0NA==
X-Google-Smtp-Source: ACHHUZ4rzSiRcHEqELCHFhfbmEP90GAMJuKp2xmVuatTGNDqQav21vDNIxEXT/nfHYEkIEh+wIJLXg==
X-Received: by 2002:a17:902:b696:b0:1af:beae:c0b with SMTP id c22-20020a170902b69600b001afbeae0c0bmr2991202pls.22.1685488652497;
        Tue, 30 May 2023 16:17:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bf5-20020a170902b90500b001b0772fe3fdsm649636plb.265.2023.05.30.16.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:31 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-hardening@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] bpf: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301617.EEB6B76B5B@keescook>
References: <20230530155659.309657-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155659.309657-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 03:56:59PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
