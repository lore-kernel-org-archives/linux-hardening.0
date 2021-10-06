Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F28C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A1D6101B
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhJFDdp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237168AbhJFDdp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 23:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633491113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klvfB+c7Wo6KIpJwCuQq3+3jeJR2aoZYpNscnzsRBpk=;
        b=CxBGNty914ANORZcDTYbqi0u3g8niNobm0a9t5x2l++UwICmyYj+njuNzhSksDThMK/Yk3
        Nyhg/3INF4KfKrRBC4YSYUO87PaZpIWuAoHSwtvO5YxFoyVuVcKunBTlyS5Tk0nvZc7AQ6
        3LmAAARQYPe9KRDU7ZUFp40VSuBhs4c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-R9v3M_DYPyWQFy0DzV0laQ-1; Tue, 05 Oct 2021 23:31:49 -0400
X-MC-Unique: R9v3M_DYPyWQFy0DzV0laQ-1
Received: by mail-qk1-f199.google.com with SMTP id m1-20020a05620a290100b0045e5e0b11e6so1136119qkp.23
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 20:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=klvfB+c7Wo6KIpJwCuQq3+3jeJR2aoZYpNscnzsRBpk=;
        b=1ZqzWpp43XiXuadMC+whsrx6SORBATsBfbuFtD3VZgS5DM/OFmNtvdIckdkyWgvk0M
         d2TEfSOQUUVL9k+8LNFZbE8uDXaQOjjXvFDQozCHkIox774FXUesVgvgGWxGfmUbihzE
         C81H18F+XN1aki4TuF/oE6yitH+U4qUVLanNUA3DWIGw+9Fz0Gp59FGXsiHs1upa1T9Z
         JpKCsG6aE1sqDPbz86wPS/jK1y6knwzYegBgqQXM4te3VHbBr7GElREFoyqxaRFCIk1T
         nUdZiLjNOZIoYujc8FdzvvWpY8dFrGk7ztvssbaAQpO+JytqzYfCKOItSs5mIHwoyafZ
         ZzGg==
X-Gm-Message-State: AOAM5300ociQwZmipAYhvXDWt9tgzOztl6AysimuU1CpNlwGmuqCEYRJ
        vN4MQsh3tPP1Y1eZ4tpZsUGxUnmvILlXvaqTRssB9ckY2kngC8RJN1xTZy8+bi+tWlrYBlSY1g7
        M2WHL88T1pNo5AeVxq6aJhHIf83yM
X-Received: by 2002:a05:6214:226c:: with SMTP id gs12mr27130779qvb.58.1633491109034;
        Tue, 05 Oct 2021 20:31:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ51LcW+PGg8/N2ibZ65de7tUVyCn7EJP78U0da/Hdc+K9Wr4qZ3/pkogDkVkmVCVNtTWrAw==
X-Received: by 2002:a05:6214:226c:: with SMTP id gs12mr27130763qvb.58.1633491108843;
        Tue, 05 Oct 2021 20:31:48 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id b14sm11013513qkl.81.2021.10.05.20.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:31:48 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:31:45 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 11/15] x86, relocs: Ignore __typeid__ relocations
Message-ID: <20211006033145.vcj3ohkekv5rexpo@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-12-samitolvanen@google.com>
MIME-Version: 1.0
In-Reply-To: <20210930180531.1190642-12-samitolvanen@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:27AM -0700, Sami Tolvanen wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> The __typeid__* symbols aren't actually relocations, so they can be
> ignored during relocation generation.

Then what are they?  It would be good to add that information here.

-- 
Josh

