Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA6C27C40
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Aug 2023 22:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjHWWuk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbjHWWuF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Aug 2023 18:50:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EFE172B
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 15:49:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso7971031a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692830986; x=1693435786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/EeXNKhqBXO7IPVESWoT55KNwrsbj/tEh9Y+87WaBI=;
        b=gzs5mAEkGXUytWxFZz+pyR1/fjSpNvv4HMVzAgXv8H2ztNWoZVd9SbFRKfaxcjmuq5
         HFBWxO0cBGxVHHr4lvvGZUNHxzh0jsUU4hA6mCYn/P6KRO+L6FxsasOhPiRG2/tPFqWS
         0PPQbgZegAIO5QQ2dvpPAxrkA4pnch3J9MmUkQ8Oq+xZIZ/2tTIDt77fSnnRWC9vpwHa
         VtDfVzYq9x1gh4R685WMTVWbDCT4eU9UTgMX+iCFo1pIwhc8T51xqiXFNefzQ4QR8o/O
         FEIcwiYr2NooF5pkIhX12BSs+n6eBqUyxzmG/Pq/ndoqabGPBiV2YGfAl1JRGqPWgVzN
         4XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830986; x=1693435786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/EeXNKhqBXO7IPVESWoT55KNwrsbj/tEh9Y+87WaBI=;
        b=YNsyzoU83srZkcxx+QuCrAaoxFhQFy+WNWaWSYeVaTpmO6RKsleY3F1rLFAukgkI4T
         t6P3czDv25jUypztFMf1fYB+FSG5HdLORuW94KpUPydjVb20FlJNChNFyvcgQ3D+damn
         Q8lylDkJBtK/h5pPAjrrmSFJFsTtIBsjX0bCAWkEVVXHRhW7+qDkzor9U/VRqT1YE8YJ
         EB9SePQfuiYItpQIgwjaWHkWulPeWfWoPumMjwXGVUI+hFEL4CM+V7yp7IFtlS/uZQgw
         2VMpnFT7AA6oQ+ZyertSte9cu4mBSi78tOpIKgLZ3MBh27OhnIsP+Cdb5xPXba2iy7XG
         TDaA==
X-Gm-Message-State: AOJu0YzV4kAuRfogI1FtSQUhEZa5GVB/4eylXUZ58WF89AKwCDPPXyme
        ODoHOIx8N2zn4hLQbYAiXkKQ+0K1HvMOteZC0XueZg==
X-Google-Smtp-Source: AGHT+IH1DnSQglWmGj/1IEV7HE6yfaPV+1QyCpDQxCUHrVClp8GIKbfXHBJSoofYisi17IB9RgBgEsQoVzexc1Fy7Lk=
X-Received: by 2002:a05:6402:1610:b0:525:469a:fc38 with SMTP id
 f16-20020a056402161000b00525469afc38mr10357985edv.31.1692830985915; Wed, 23
 Aug 2023 15:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com>
 <CAHp75VeieNZ3+-2oq2yx36mJ0ERBkuF=f_uhAh8o0sFnHY6Wsg@mail.gmail.com>
In-Reply-To: <CAHp75VeieNZ3+-2oq2yx36mJ0ERBkuF=f_uhAh8o0sFnHY6Wsg@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 23 Aug 2023 15:49:34 -0700
Message-ID: <CAFhGd8q1UeaUC-Wm9+Jr=7KZLk-VUn+EsOPP0uc1sFk+cv_yoQ@mail.gmail.com>
Subject: Re: [PATCH] x86/platform/uv: refactor deprecated strcpy and strncpy
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 23, 2023 at 1:32=E2=80=AFAM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> > destination strings [1].
> >
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy` or `strcpy`!
> >
> > In this case, we can drop both the forced NUL-termination and the `... =
-1` from:
> > |       strncpy(arg, val, ACTION_LEN - 1);
> > as `strscpy` implicitly has this behavior.
>
> ...
>
> >         char arg[ACTION_LEN], *p;
> >
> >         /* (remove possible '\n') */
> > -       strncpy(arg, val, ACTION_LEN - 1);
> > -       arg[ACTION_LEN - 1] =3D '\0';
> > +       strscpy(arg, val, ACTION_LEN);
> >         p =3D strchr(arg, '\n');
> >         if (p)
> >                 *p =3D '\0';
>
> https://lore.kernel.org/all/202212091545310085328@zte.com.cn/
>
> ...
>
> > +               strscpy(uv_nmi_action, arg, strlen(uv_nmi_action));
>
> strlen() on the destination?!
>
> ...
>
> > -                       strncpy(uv_nmi_action, "dump", strlen(uv_nmi_ac=
tion));
> > +                       strscpy(uv_nmi_action, "dump", strlen(uv_nmi_ac=
tion));
>
> Again, this is weird.

This is a common pattern with `strxcpy` and `sizeof` if you `$ rg
"strncpy\(.*sizeof"`. Do you recommend I switch the strlen(dest) to
strlen(src)? I only kept as-is because that's what was there
originally and I assumed some greater purpose of it.

>
> --
> With Best Regards,
> Andy Shevchenko
