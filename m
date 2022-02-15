Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D49C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Feb 2022 22:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiBOWOn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:14:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbiBOWOl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Feb 2022 17:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6BAA27CCB
        for <linux-hardening@vger.kernel.org>; Tue, 15 Feb 2022 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644963270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SgVDXV404yMNw+CNJPlab88lztIU+ojT1PQnfND6pg=;
        b=OPU1GRnHz/vgBuMfDRYaC9lUhreKMyn6ftzgCoGHIZV+h6xSZ2jbwirzRJHfyk4ei+HWYY
        rSJh/IsEk7BjJUV3YKMx4eX239ULOwv3UUc5DgEfXkaHDy3tsm8pNyYAtwLaqQ+Sx+ZyOa
        2ZUawPODtf9FIwZdDMrnbsb8GTjePH0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-cicOSxibNdqssqIeYJvVSw-1; Tue, 15 Feb 2022 17:14:28 -0500
X-MC-Unique: cicOSxibNdqssqIeYJvVSw-1
Received: by mail-oo1-f70.google.com with SMTP id s14-20020a4aa54e000000b002ea553d580eso157940oom.4
        for <linux-hardening@vger.kernel.org>; Tue, 15 Feb 2022 14:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0SgVDXV404yMNw+CNJPlab88lztIU+ojT1PQnfND6pg=;
        b=0rJAnHmuzBsbWMu63BWAO8bgoHC8LAg50svH5aMsgx3zpA86w3VVx6/z/7V0iEhlmS
         IlVJuWGxlmUpZRBuZNAArvhfRabj/sKLTvxeZMiInyuF+UtrtVVZxz6Cmg6wQO00iVGN
         sKaJvIaOq8B8a53n/Y5li5amb3G0iDyMFEZIxh5NTuyA7A+fNyA0TiWgS5/oE55s6rKD
         BUvo8lv+5NhpmlifOxXd/+2vg+jBRT/NvxFv1cCfJa/6Dnik6R6kIO7uAhwih08MOa74
         LC0xrg81g2VwJXTgFh/xyFo/02hi4Qq8CBvUcicLymyX81oNpD0GHlW3IrwA17GYvCp/
         PrXg==
X-Gm-Message-State: AOAM532MRhIId4LnlSP0ZlLABLZpaoMJVkDKlNtEuENa6oX+Bs81isrR
        OEB1bnXpVCMKoLo7QvavURGIiZ+yrKo4XuEsrwMtoOTiXKtq58pB+DH8T/jubgAk8MucpSOYI8P
        KleN1xg9fjgfj2if49mj4Go+PxCMk
X-Received: by 2002:a9d:634c:: with SMTP id y12mr426952otk.247.1644963267663;
        Tue, 15 Feb 2022 14:14:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVXfIWZdTFKoCWv5zBjTEK28rZYLt4d2ssRGQsRnGv5qqbZqev0beqgPvRqsVb8AYyrRoeMg==
X-Received: by 2002:a9d:634c:: with SMTP id y12mr426943otk.247.1644963267400;
        Tue, 15 Feb 2022 14:14:27 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id 8sm13835736oav.28.2022.02.15.14.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:14:26 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:14:24 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <20220215221424.hmnei74ar5gtqfy2@treble>
References: <20220213182443.4037039-1-keescook@chromium.org>
 <20220214200730.a3qz6ocy2ohwafrt@treble>
 <YgwQO1Z0UmV241vg@kernel.org>
MIME-Version: 1.0
In-Reply-To: <YgwQO1Z0UmV241vg@kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 15, 2022 at 05:42:35PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 14, 2022 at 12:07:30PM -0800, Josh Poimboeuf escreveu:
> > On Sun, Feb 13, 2022 at 10:24:43AM -0800, Kees Cook wrote:
> > > GCC 12 was correctly reporting a potential use-after-free condition in
> > > the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
> > > when size == 0:
> > > 
> > > In file included from help.c:12:
> > > In function 'xrealloc',
> > >     inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> > >    56 |                 ret = realloc(ptr, size);
> > >       |                       ^~~~~~~~~~~~~~~~~~
> > > subcmd-util.h:52:21: note: call to 'realloc' here
> > >    52 |         void *ret = realloc(ptr, size);
> > >       |                     ^~~~~~~~~~~~~~~~~~
> > > subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> > >    58 |                         ret = realloc(ptr, 1);
> > >       |                               ^~~~~~~~~~~~~~~
> > > subcmd-util.h:52:21: note: call to 'realloc' here
> > >    52 |         void *ret = realloc(ptr, size);
> > >       |                     ^~~~~~~~~~~~~~~~~~
> > > 
> > > Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
> > > Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > v1: https://lore.kernel.org/lkml/20220212181855.3460176-1-keescook@chromium.org/
> > > v2: simplify logic (josh)
> > 
> > Thanks, running through testing now.
> 
> I assume that testing went ok, may I add a Tested-by: you?

Yes, feel free to add:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

