Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D400C43217
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Mar 2022 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbiCDSQm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiCDSQm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Mar 2022 13:16:42 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDEE1D21D8
        for <linux-hardening@vger.kernel.org>; Fri,  4 Mar 2022 10:15:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j13so482260plx.4
        for <linux-hardening@vger.kernel.org>; Fri, 04 Mar 2022 10:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jvAXwlb5bVb2T9TLfFlU2BSWSxn7Gy6/q8ot7YQoIq8=;
        b=cI5sCguGUpRRz8wGQ44HrMkYObqyDauy/dJlFEciw1zR4Nvl0qCrNVXs3BpZ6NekuC
         Mdsn/aVh3A6VmZ+GcJq70BT5skeqQDYT4NAqYVGrdK9o4xE+M8Bc15DjfOIJLp33KRLD
         qnh5XjRZ68YufFeHKJhQwVVWL1pozRcm/NIMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jvAXwlb5bVb2T9TLfFlU2BSWSxn7Gy6/q8ot7YQoIq8=;
        b=sV8eD0w+tt9HbC96vLlbMN3eM4Wg4e5AJQtLC9ENPBI4LsUk8XAY/mubQKUNtD+zwY
         tuvzhKictE8SAe2HqvYqNRLGLpeNsOA6bq2MHP1SS2T6YVleG6RGXiqq8OW4hqqi8tJz
         R1Ai7DhqqPiRYXsLB8HREMEHJcMm3mwCuNwLokwXHFofe0So61WyZTOciSJn9IJnntnm
         L09F/BicGl/YOyquOs2rNty9qNU5z59K46zsrMTLdxqwOnb0IxAaCEma/5f4hic0dt/k
         5VV7HoiDf4t3T86Yu3XiITHLkHRm7/9SnyCKFXLoIp3GQ7S4/lUrlWizc5Xk2BNUzfj7
         KFwg==
X-Gm-Message-State: AOAM533ENylcdv5qlf58x4j+pp5RZLtKefpQkEpZaXUVotEqtkXaJXyB
        fw8QOpKrvPj4lAvvJKIJD8H/pg==
X-Google-Smtp-Source: ABdhPJyfzH8FANRr4IGU/Oo0oYfv59kkOOWMAekGz4QKwlnTOEpaw1y2+9xExkx96GciJmV4IcrI5g==
X-Received: by 2002:a17:902:d705:b0:14e:e5a2:1b34 with SMTP id w5-20020a170902d70500b0014ee5a21b34mr41732722ply.88.1646417753537;
        Fri, 04 Mar 2022 10:15:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm6908547pfh.143.2022.03.04.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:15:53 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:15:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
Message-ID: <202203041014.12E6F25@keescook>
References: <20220224001403.1307377-1-keescook@chromium.org>
 <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
 <202202251044.F509C7F3@keescook>
 <871qzhhc39.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qzhhc39.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 04, 2022 at 10:16:58AM -0700, Jonathan Corbet wrote:
> Sorry, been a bit distracted...when we were working on this I was more
> focused on the text than the location.  My own feeling is that
> Documentation/process is a better place for this - that's where we tell
> the world how to work with the kernel community, after all.  I'm not
> going to dig in my heels and fight about it, but that's my sense.

I had no strong preference. I've moved it to /process now.

> Otherwise, it kind of seems like this is ready to go in. I'd like to
> apply it before the merge window; lemme know where you want it in the
> end and we can get it done.

Agreed. v2 had v1's feedback addressed, and v2 was not further commented
on. v3 now here:

  https://lore.kernel.org/lkml/20220304181418.1692016-1-keescook@chromium.org

-- 
Kees Cook
