Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3970C04E69
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 03:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbjHPDhT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Aug 2023 23:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbjHPDes (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Aug 2023 23:34:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6885E268F
        for <linux-hardening@vger.kernel.org>; Tue, 15 Aug 2023 20:34:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb84194bf3so37776135ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Aug 2023 20:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692156863; x=1692761663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E64xP/xgSDs+NpkKdH0D/gkdQzULRu7E4iozMrG/RLw=;
        b=Os14XUAU+blPxJYknm9CJrmbTJz4HXqM7gJh171g8wwauMErYzwoMLMWgrKpDNYhwR
         8ZJeofqT3GdTRb865CnWu0YvehWgxNANR+R+AnxE5TiEbiHNTmJ7YPnvp/MHz0OIAq6T
         yX06hzgGhDt/rSZMoGJzLx+rOyPf/ThmECnVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156863; x=1692761663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E64xP/xgSDs+NpkKdH0D/gkdQzULRu7E4iozMrG/RLw=;
        b=DVfuldy4jw3NRP9uN7x7wN7w7M7zVYlzifGxutUctBNw3iSoy6wIvaoSzYjqPPSDhW
         8LTJ6pDyWTMzAhNOiNnhepgi6tbevEMA+VpcDnm0jJBZ/YC8co1tMVwyxGDTOf7iQFf+
         CcnW7qB0FTxyb25pC7K04KAXqIiafsfqtFyRlCxQmaRFuyRQVbfm8PrYifXJc43p46XM
         p0tg+N4iU0FQqU7R8Cvt/V4Rusxoy6gmAbGso7ezgVSr9/DACqueKu7Hu5OB6WFmHJRV
         4HXDvx3OcFnGxF5K4qzecA6XzZyA96Isf3Zpqktje6REluYQsSUaPtxx4qOQBmFOsaPa
         gIHQ==
X-Gm-Message-State: AOJu0YxrFQl5GT2zeZowLTpS35JF83Ih+puR9oyndr0UNnjEEOiTXdwO
        Sixt9odGP+ld4CDvLKQ/NB+AvQ==
X-Google-Smtp-Source: AGHT+IEU5giKTTdU+rZ4DGXRPGd/wJxNpisZshlDZz4EFiLP5iVXhhC5rR9ENdKTCmf+uwyDxWkuuA==
X-Received: by 2002:a17:902:d4c3:b0:1bd:f314:7896 with SMTP id o3-20020a170902d4c300b001bdf3147896mr779224plg.25.1692156862903;
        Tue, 15 Aug 2023 20:34:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1601:f73d:719a:8de1])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001bc6536051bsm11743683pll.184.2023.08.15.20.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:34:22 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:34:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hexdump: add a new dump prefix DUMP_PREFIX_CUSTOM
Message-ID: <20230816033418.GD681074@google.com>
References: <20230811074922.1388-1-thunder.leizhen@huaweicloud.com>
 <20230811074922.1388-3-thunder.leizhen@huaweicloud.com>
 <ZNuMGyJ2x21RpVyR@alley>
 <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On (23/08/16 11:20), Leizhen (ThunderTown) wrote:
> > IMHO, this is pretty bad interface.
> > 
> >   + From the user POV:
> > 
> >     It is far from clear what values will be passed for the given
> >     printf format. It can be docummented but...
> > 
> > 
> >   + From the security POV:
> > 
> >     The compiler could not check if the printk() parameters
> >     match the format. I mean if the number of types of
> >     the parameters are correct.
> 
> Yes, it has these problems. So, back to v2, how about add DUMP_PREFIX_ADDRESS_LOW16?
> Or named DUMP_PREFIX_ADDR16 or others. Or change the format of DUMP_PREFIX_ADDRESS
> from "%p" to "%px"，Or add DUMP_PREFIX_RAWADDR. Or keep the status quo.

Linus quite likely will dislike (with passion) the idea of using %px.
