Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D58C38142
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 19:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjA0T63 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjA0T6J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 14:58:09 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D81BAF1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 11:56:09 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id s4so4998090qtx.6
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCbWVDeCBmv0tLQetS3EwIRtSgUEsqrpXNIcWwZitCE=;
        b=Oq2KyBNFkKCXFSiv7V8jYK5N7BWEm+bEaPdyaX7pikQru8J5TXsKu7vUcBAug4HHGl
         wqfILDWXVPjBz2g10jTsfA7RHNmqeO8+n9fL6BvMP5T2d6yR1Fd0NeScYNFNExZmRiPp
         FG7Qf0o52jSY4m401DXdfWpolnC9HTglszHWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCbWVDeCBmv0tLQetS3EwIRtSgUEsqrpXNIcWwZitCE=;
        b=CYc0Nwxj79hSZnxYsSExB6bDbazL6DANSzGyCd4S4TV/5nD36QlQ62RiZf1Wqilza3
         n/sOoDRr97aYEdGqVpiobGP4EY2TOOqr4V5UbSITW1NSgx1ll5J0Av0gbfZGEB6pEBoP
         6aB85frph4VexyGagP96MBJbjhZV6xy9JbmCD9PqFPARl4IfS/6QQBRphOVMvB5f3bZe
         95JMy3u01BRt+qEBcGq1H3qDolZ/R+Go/AEhItOOxvKIWJn47K+JBvRcEcvePfmuQOZC
         Ju9hkuq23/Cs5C6ixifPYW14h/0P228w51CiRo43hE6DI7VI25GQeHpelaEf96o4pL/h
         PVWg==
X-Gm-Message-State: AFqh2kpx+PjR5fXiJz47E440/foySunBvKvBY4c07Tzebvq/Y0g3HdWA
        4TGoSIC52/4Rdwzad6rnjHhPbhEPTenwrhU3
X-Google-Smtp-Source: AK7set9701lFYJloTnasN/YHIzeLJ41Q0Ii7zI4q0jj6SS2KU0q1aZohz1YubDz5Xez2Pa2deR4L+g==
X-Received: by 2002:a17:903:2345:b0:196:5d8d:2d6f with SMTP id c5-20020a170903234500b001965d8d2d6fmr2292522plh.13.1674848860829;
        Fri, 27 Jan 2023 11:47:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1-20020aa79461000000b0058da7e58008sm3016917pfq.36.2023.01.27.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:47:40 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:47:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible
 array members
Message-ID: <202301271146.7DC8CAE113@keescook>
References: <20230127191621.gonna.262-kees@kernel.org>
 <CAJZ5v0iV5wK4gsoadmWOyof_vzaAOx8oX0DJu+1-bCQNdNJtBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iV5wK4gsoadmWOyof_vzaAOx8oX0DJu+1-bCQNdNJtBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 27, 2023 at 08:43:05PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 27, 2023 at 8:16 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > One-element arrays (and multi-element arrays being treated as
> > dynamically sized) are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> >
> > Replace one-element array with flexible-array member in struct
> > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > padding in a union with a flexible-array member in struct
> > acpi_pci_routing_table.
> >
> > This results in no differences in binary output.
> >
> > Link: https://github.com/acpica/acpica/pull/813
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > v2: include stddef.h and switch to __DECLARE_FLEX_ARRAY()
> > v1: https://lore.kernel.org/lkml/20221118181538.never.225-kees@kernel.org/
> > ---
> >  include/acpi/acrestyp.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> > index a7fb8ddb3dc6..250046a7c870 100644
> > --- a/include/acpi/acrestyp.h
> > +++ b/include/acpi/acrestyp.h
> > @@ -10,6 +10,8 @@
> >  #ifndef __ACRESTYP_H__
> >  #define __ACRESTYP_H__
> >
> > +#include <linux/stddef.h>
> > +
> >  /*
> >   * Definitions for Resource Attributes
> >   */
> > @@ -332,7 +334,7 @@ struct acpi_resource_extended_irq {
> >         u8 wake_capable;
> >         u8 interrupt_count;
> >         struct acpi_resource_source resource_source;
> > -       u32 interrupts[1];
> > +       u32 interrupts[];
> >  };
> >
> >  struct acpi_resource_generic_register {
> > @@ -679,7 +681,10 @@ struct acpi_pci_routing_table {
> >         u32 pin;
> >         u64 address;            /* here for 64-bit alignment */
> >         u32 source_index;
> > -       char source[4];         /* pad to 64 bits so sizeof() works in all cases */
> > +       union {
> > +               char pad[4];    /* pad to 64 bits so sizeof() works in all cases */
> > +               __DECLARE_FLEX_ARRAY(char, source);
> > +       };
> >  };
> >
> >  #endif                         /* __ACRESTYP_H__ */
> > --
> 
> With this applied I get:
> 
> rafael@gratch:~/work/linux-pm/tools/power/acpi> make
>  DESCEND tools/acpidbg
>  MKDIR    include
>  CP       include
>  CC       tools/acpidbg/acpidbg.o
> In file included from
> /scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acpi.h:27:0,
>                 from acpidbg.c:9:
> /scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acrestyp.h:686:3:
> error: expected specif
> ier-qualifier-list before ‘__DECLARE_FLEX_ARRAY’
>   __DECLARE_FLEX_ARRAY(char, source);
>   ^~~~~~~~~~~~~~~~~~~~
> make[1]: *** [../../Makefile.rules:25:
> /scratch/rafael/work/linux-pm/tools/power/acpi/tools/acpidbg/
> acpidbg.o] Error 1
> make: *** [Makefile:18: acpidbg] Error 2
> 
> The tools build successfully without it.

I think a "make clean" is needed first? It builds for me...

-- 
Kees Cook
