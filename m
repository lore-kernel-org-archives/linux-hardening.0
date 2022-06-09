Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93195C43334
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Jun 2022 22:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbiFIWGS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Jun 2022 18:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345198AbiFIWGR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Jun 2022 18:06:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182061F129F
        for <linux-hardening@vger.kernel.org>; Thu,  9 Jun 2022 15:06:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me5so49553384ejb.2
        for <linux-hardening@vger.kernel.org>; Thu, 09 Jun 2022 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UoMg7XAdZhjLF3+TuyFXMPmzf7hGCGFPyI+PbeCZf8=;
        b=bg+vgE40WdCztmrYjVSM/YJF9ZXtLor8NrvacxWrs8tmReVOyatbyF3+bwL2eQ+QeM
         h+OM4NPlRuZy2i1/Ro6kdbLrzQGd7SZNUFH7OSOKsX6tGe3TeNeXQa/eGc0tnjd1Yy2D
         IwGPT6SLiwVu0vhgUhkqA+ubHnvIUAQpO7X4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UoMg7XAdZhjLF3+TuyFXMPmzf7hGCGFPyI+PbeCZf8=;
        b=Gxktm27ne8HPfMGgKismLcbUvcqVTQfRPCKaN1LE6FYeLoYj3CJahJWCFUV9uCsY3Y
         JoJlpZ2cRtTX3VhbuiVDbIaE6XihOKLsrrum9TxMpBJrA/SZ3Fg3sqzQW26KwTHxilHb
         r04W5nl8kod5Qnf5kbza0VubgUNaGmf9G1B/cpfzafN9/9ZgMbrVowMWXO42x9K0PiIp
         Ju2mVCDnguKM+jhoLmexw/qChKX5tM/fkRE6pJqcpDxnKUqiFGk06zLVWSoiW2UkulbQ
         NsE6JogZ89nuGFSNkc8fjmrBuHNze2BAALaCEDcTVMhf13fTxrNv3Zwo1RmMA00lEJ2X
         qMUw==
X-Gm-Message-State: AOAM530UGBB5fD7oPjqmtMN8/c/SqMm+8NW/CT3uoL9UmiEsgS6nn7su
        KFgpP2u0ZnkhmEhW//pAEXjUyWLKbqFcyXFoAik=
X-Google-Smtp-Source: ABdhPJyvrIqNuFojijXysP+jYVz6Kix6HcN5jAuU8ajl04Qv8cq8XcxoieDBTQKXGcvIf8LsgweMzw==
X-Received: by 2002:a17:907:d29:b0:711:d215:5a5e with SMTP id gn41-20020a1709070d2900b00711d2155a5emr19899885ejc.697.1654812374398;
        Thu, 09 Jun 2022 15:06:14 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id l9-20020a50cbc9000000b0042ab87ea713sm9748089edi.22.2022.06.09.15.06.13
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 15:06:14 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so276091wmq.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 Jun 2022 15:06:13 -0700 (PDT)
X-Received: by 2002:a05:600c:42c6:b0:39c:4bfd:a4a9 with SMTP id
 j6-20020a05600c42c600b0039c4bfda4a9mr5442248wme.8.1654812362760; Thu, 09 Jun
 2022 15:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <40676.1654807564@warthog.procyon.org.uk> <CAHk-=wgkwKyNmNdKpQkqZ6DnmUL-x9hp0YBnUGjaPFEAdxDTbw@mail.gmail.com>
In-Reply-To: <CAHk-=wgkwKyNmNdKpQkqZ6DnmUL-x9hp0YBnUGjaPFEAdxDTbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 15:05:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGrrF20LshkNGJ41UmNN13MU6x0_npwaJQi9cr626GQQ@mail.gmail.com>
Message-ID: <CAHk-=whGrrF20LshkNGJ41UmNN13MU6x0_npwaJQi9cr626GQQ@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix gcc-12 warning by embedding vfs inode in netfs_i_context
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical@lists.samba.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 9, 2022 at 3:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, I think you really should do something like the attached on top
> of this all.

Just to clarify: I did apply your patch. It's an improvement on what
used to go on.

I just think it wasn't as much of an improvement that it should have
been, and that largely untested patch I attached is I think another
step in a better direction.

                      Linus
