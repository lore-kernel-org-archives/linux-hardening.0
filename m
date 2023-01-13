Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C284C3DA78
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 23:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAMXSo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAMXSn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 18:18:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7088A23
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:18:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so2241957pjb.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH6/aARHUNUhyFQHu9t9yEl6Nmo/HiToLqjqiJwfA98=;
        b=FK8KWLDkKMzQxAU4w06i36FksP91naWtT/GjskgM4ZTa3afu/yCa75h5VJVCR/UbwQ
         353vMXDT/J+ej0jz8Qk1CjAsJEw8vZ+cPYU/En2i1gbbpotOy+OiR32woEPltauq2I4I
         9tQJR1uKTmUabdbnK90TNLXGg5GvrUuBGTT4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH6/aARHUNUhyFQHu9t9yEl6Nmo/HiToLqjqiJwfA98=;
        b=crCEtDop5M7cMWcw8BLmmrJw4jnDDRRsaAbjY0C7H6qAMykyl3u6jrbEUeAbA3Lpky
         UQAjYnthlNSju5tLSXZ0u4TNmigG7ntEbB6Rfsbbt6aFIMAfTDwnEtXht9oCPWDPom2K
         ZEUU3d9QBaWdNbtjk5lFSl5/F8vI9GH2AmSg07uPPGwK0r5w9JFwa14mgriuAM/RtGrT
         fJ8JkuuG339/9bm78xfUnq8FlYB2XgRALsHmtAHX+VDd4ufzPCCFyqBImGLmatYALZSw
         +Mz+KxX/6JpdZetki1CrJyq3cfPzknce4ft2XzFNyU0x2iVsZroE05pd+kfGB10mIISa
         UOCA==
X-Gm-Message-State: AFqh2krwcUsP2NKLip3q6QR1xIs0hZwD3vpCXUQFJsGqVEFkBLS1uxsN
        OOqzuT1KisYzpOvUtEaLUibXgQ==
X-Google-Smtp-Source: AMrXdXuggMjjm+hq7HQmcERftDBLU/ITd8+ppErogkqm/zMy/PWzkUo5TeJqrxw8nKX/EmEj+wmFgA==
X-Received: by 2002:a05:6a21:3294:b0:9d:efbe:a122 with SMTP id yt20-20020a056a21329400b0009defbea122mr123564891pzb.50.1673651921400;
        Fri, 13 Jan 2023 15:18:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b0019117164732sm14610196pll.213.2023.01.13.15.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:18:40 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:18:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Message-ID: <202301131518.D19579178@keescook>
References: <20230113173033.4380-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113173033.4380-1-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 13, 2023 at 09:30:33AM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The upcoming GCC release has refactored the gimple plugin interface a
> bit and unless gimple-iterator.h is included before gimple-fold.h I end
> up with a bunch of missing declarations when building the stack
> protector plugin.
> 
> Link: https://inbox.sourceware.org/gcc-patches/CAFiYyc2q%2Bc-0uZb-zAskmR_U%2BM%2BxQfp-W00ZbLErfjx=j5qHGg@mail.gmail.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Eek, actually, I've unapplied this. It breaks on GCC 12.

-- 
Kees Cook
