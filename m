Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91CFC433FE
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Nov 2022 17:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKDRvt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiKDRvs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Nov 2022 13:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24043AE2
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667584252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCtW6Z0aIHoHYYkUcnKPD24UVWnFrm8fe3F2Ogq9ddY=;
        b=EsYgzNcr1G81/jXwxUltdCUK7Ehelzm+xuL/ZsHyCykJ1eEmxM4Ju5unZPBdbXY0Y/y0B8
        wvvSjSqY8XV14wjCrLdwBSKAH1TJ4MWtMeNvgUq9sy9P6HVCG+P45JsTEDrqax0yyBb70b
        fxj9LrKldP1SsW38ZIfO8YzsUr0+xNg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-Y21Ov9diO5SRDOYSkiDl7g-1; Fri, 04 Nov 2022 13:50:51 -0400
X-MC-Unique: Y21Ov9diO5SRDOYSkiDl7g-1
Received: by mail-ej1-f69.google.com with SMTP id he6-20020a1709073d8600b0078e20190301so3843964ejc.22
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 10:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCtW6Z0aIHoHYYkUcnKPD24UVWnFrm8fe3F2Ogq9ddY=;
        b=hwk6TLiA0TsdCXg6IkW5ydH/Kw49JiGXz5PJ4hyqyxOAyAUFW2wYRdL6IyhFlP9DWF
         CnipJ5X+IWaU9X1mWW8aXxocrdFm1wiyJ2B6SAB46JPYIrbmKtDlGhJAXSB+mtgLGBnr
         MNr3kWc8RvQu+T7pwO7oCPRxoBPNhimw77HGUOdCq5cMd268C5wqrBaUjYtQg08fq5sx
         ZD+CH5vboTklirz4OjxIzVpqhileTReE6Xk0vdfB23tWHcm56ziXxTLiSZwCZPkV9S4Q
         /LGuiAFHFpODLxNL0wC0GEjmtfOq/w+SMDXlczwe3F+aZ5ciyu+D928NPffe7jXwD+gP
         +WLQ==
X-Gm-Message-State: ACrzQf02q3tl+G/xXhwNwksDAoU5em+O/YDSxsCk6KgtubJrXCpDbmeT
        uW797I47kRcAmZIAZk68N2kqdfJYeGXCve7K3uI6uWEj60hlVYCm1cp0ILn8U4Ji9O4+JeHr6ea
        UWkNQ4Rg+33EX/Fu39EfXVuJVAveDBiqENmEkDzTmyqS1
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id ev9-20020a056402540900b0044f1e0501e8mr37092971edb.373.1667584249902;
        Fri, 04 Nov 2022 10:50:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7PyQYtc1pZF9HFgpahtxyPNMIaDnM0gYNhb8bkIf8av1uiWhRAbIvVtBduhQj1LzYg429/mQQkHsACEIwKVNE=
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id
 ev9-20020a056402540900b0044f1e0501e8mr37092959edb.373.1667584249716; Fri, 04
 Nov 2022 10:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <202210111305.743F591@keescook> <Y0XQsqdRzlrSpgOh@mail.google.com> <Y2ScZqWnJKe7J6NR@mail.google.com>
In-Reply-To: <Y2ScZqWnJKe7J6NR@mail.google.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 4 Nov 2022 13:50:38 -0400
Message-ID: <CAK-6q+g37Ycmn5Etbj9Pk9iZXGCdyYc9pH18jowiS1DtTqp_EA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v5] [next] dlm: replace one-element array
 with fixed size array
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Fri, Nov 4, 2022 at 1:00 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> On Wed, Oct 12, 2022 at 09:23:14AM +1300, Paulo Miguel Almeida wrote:
> > One-element arrays are deprecated. So, replace one-element array with
> > fixed size array member in struct dlm_ls, and refactor the rest of the
> > code, accordingly.
> >
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/228
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> > Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> >
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> > Changelog:
> >
> > v5: use preferred sizeof style. Req: Gustavo Silva
> > v4: resend patch using the right version number. Req: Gustavo Silva
> > v3: replace one-element array with a fixed size array. Req: Kees Cook
> > v2: patch resent as I had an issue with a <CRLF> char in my mail client
> > v1: https://lore.kernel.org/lkml/Y0ICbf8tCtXMn+W0@mail.google.com/
> > ---
> >
> >  fs/dlm/dlm_internal.h | 2 +-
> >  fs/dlm/lockspace.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> > index e34c3d2639a5..94fadb619ba0 100644
> > --- a/fs/dlm/dlm_internal.h
> > +++ b/fs/dlm/dlm_internal.h
> > @@ -670,7 +670,7 @@ struct dlm_ls {
> >       void                    *ls_ops_arg;
> >
> >       int                     ls_namelen;
> > -     char                    ls_name[1];
> > +     char                    ls_name[DLM_LOCKSPACE_LEN + 1];
> >  };
> >
> >  /*
> > diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> > index bae050df7abf..9479c8110979 100644
> > --- a/fs/dlm/lockspace.c
> > +++ b/fs/dlm/lockspace.c
> > @@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
> >
> >       error = -ENOMEM;
> >
> > -     ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> > +     ls = kzalloc(sizeof(*ls), GFP_NOFS);
> >       if (!ls)
> >               goto out;
> >       memcpy(ls->ls_name, name, namelen);
> > --
> > 2.37.3
> >
>
> Christine, David,
>
> Just following up on this patch. Is there anything that either of you
> want me change for this patch to be merged?
>

I think it's fine. I am working on DLM and the current upstream
process is more per release where I resend a huge patch-series to get
it upstream into dlm/next based on a recent rc... It just takes time.
Then your patch will of course be applied on.

- Alex

