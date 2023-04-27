Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0929CC77B73
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Apr 2023 23:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbjD0X1u (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjD0X1t (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Apr 2023 19:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B102D55
        for <linux-hardening@vger.kernel.org>; Thu, 27 Apr 2023 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682638021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YUCmvsqJPS8iPKOBONidgoWQBmu7QGqu7UvLPOsPhU=;
        b=LbHl92I/oLIbkwtS60sutzHNma4YQb9ybm5TBqW++MFBVgtSXD8YkzdtZSLoOYkmFohIvp
        IruoSxEa7/R1+LvtQ2fzlyq8nF0aE+OjATtK2aXpays0/lz7womVzYriQrHFmIX0UWm756
        07fCyOmgdPa4mjT1tLeoD0THM2uMaVg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-O2DjQ86CPNamBk3p9yLKtg-1; Thu, 27 Apr 2023 19:26:59 -0400
X-MC-Unique: O2DjQ86CPNamBk3p9yLKtg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f0a65d5a1dso63855531cf.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Apr 2023 16:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638019; x=1685230019;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YUCmvsqJPS8iPKOBONidgoWQBmu7QGqu7UvLPOsPhU=;
        b=cqzDz0JeylY0N9rsiorcwI2rQtALv6hKj0iU4Oe2T8todT0r4+dcAcOptpdUP2B2zF
         Mm1qZZN8Ak9dTvHg0ICRe+B/Lz4vYP9OOXnwpmppDauXZp/EJOe5P7JR5rs2lFGwKWVS
         uRvIvdmHzaw0ZUUtZIiILip/T5+5Tec+l+BDHQh7TkmIkmn1BWa8MGpzr9SgT2oVPion
         rpgDQNTQaM77ya3b7HJrb81yUdmfFqCN6QuUTXSnXgFEFKuvsL/3A7coeHzvA1yYEMaL
         CkF4hoqshEw3WmiANwcxdFtpN35XXOrjhGyEH5unb+8UC0SJUgQUo/YqrUYHll1AXgs7
         C/ZA==
X-Gm-Message-State: AC+VfDyWCDMO04N7IZEotuotbxgunAK1hcBL7ojagqtxH1l8z5j6N5mT
        yoL0SN+bFudpnAqmyDIHLpVqC4BXjYZ+w0Zp5POAteD7Fs0men5tdsvRfRoriIhxtxhBHSKUdem
        Xb6ONuq7aFcH/vmK6DHL5t9dG83dy
X-Received: by 2002:a05:622a:1d6:b0:3ef:46b0:80e8 with SMTP id t22-20020a05622a01d600b003ef46b080e8mr6713108qtw.19.1682638019354;
        Thu, 27 Apr 2023 16:26:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4WLY7MePNrZIMMUsjK6UA+mjTyZg+eBttohWOgYZkEa+fkOutQzPaWakLg3ihFe55dfWFwlw==
X-Received: by 2002:a05:622a:1d6:b0:3ef:46b0:80e8 with SMTP id t22-20020a05622a01d600b003ef46b080e8mr6713082qtw.19.1682638019080;
        Thu, 27 Apr 2023 16:26:59 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id cd15-20020a05622a418f00b003f1f26bbb50sm1131053qtb.35.2023.04.27.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:26:58 -0700 (PDT)
Message-ID: <c548bd562bdd3997ac7fb9287c67c54b56c77c3e.camel@redhat.com>
Subject: Re: Disabling -Warray-bounds for gcc-13 too
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org, linux-hardening@vger.kernel.org,
        gustavo@embeddedor.com, qing.zhao@oracle.com
Date:   Thu, 27 Apr 2023 19:26:57 -0400
In-Reply-To: <CACO55tvJE4UvsAY8yfY7j4gMRkk4kLUPedfL0Sw2B7OF=s-rEw@mail.gmail.com>
References: <CAHk-=whMiMqAv5ATKRkjrdgP2R7WgWmCS4hW2mPwBcL=gzdDNw@mail.gmail.com>
         <D57F9A07-AB77-4FF9-B0A6-C502DC60D093@kernel.org>
         <529e56c85732b0bfcf277de9c651f6c58f47b3b4.camel@redhat.com>
         <CACO55tvJE4UvsAY8yfY7j4gMRkk4kLUPedfL0Sw2B7OF=s-rEw@mail.gmail.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 2023-04-28 at 00:50 +0200, Karol Herbst wrote:
> On Fri, Apr 28, 2023 at 12:46=E2=80=AFAM Lyude Paul <lyude@redhat.com> wr=
ote:
> >=20
> > Hey Linus, Kees. Responses below
> >=20
> > On Sun, 2023-04-23 at 13:23 -0700, Kees Cook wrote:
> > > On April 23, 2023 10:36:24 AM PDT, Linus Torvalds <torvalds@linux-fou=
ndation.org> wrote:
> > > > Kees,
> > > >  I made the mistake of upgrading my M2 Macbook Air to Fedora-38, an=
d
> > > > in the process I got gcc-13 which is not WERROR-clean because we on=
ly
> > > > limited the 'array-bounds' warning to gcc-11 and gcc-12. But gcc-13
> > > > has all the same issues.
> > > >=20
> > > > And I want to be able to do my arm64 builds with WERROR on still...
> > > >=20
> > > > I guess it never made much sense to hope it was going to go away
> > > > without having a confirmation, so I just changed it to be gcc-11+.
> > >=20
> > > Yeah, that's fine. GCC 13 released without having a fix for at least =
one (hopefully last) known array-bounds vs jump threading bug:
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D109071
> > >=20
> > > > And one of them is from you.
> > > >=20
> > > > In particular, commit 4076ea2419cf ("drm/nouveau/disp: Fix
> > > > nvif_outp_acquire_dp() argument size") cannot possibly be right, It
> > > > changes
> > > >=20
> > > > nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[16],
> > > >=20
> > > > to
> > > >=20
> > > > nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CA=
P_SIZE],
> > > >=20
> > > > and then does
> > > >=20
> > > >        memcpy(args.dp.dpcd, dpcd, sizeof(args.dp.dpcd));
> > > >=20
> > > > where that 'args.dp.dpcd' is a 16-byte array, and DP_RECEIVER_CAP_S=
IZE is 15.
> > >=20
> > > Yeah, it was an incomplete fix. I sent the other half here, but it fe=
ll through the cracks:
> > > https://lore.kernel.org/lkml/20230204184307.never.825-kees@kernel.org=
/
> >=20
> > Thanks for bringing this to our attention, yeah this definitely just lo=
oks
> > like it got missed somewhere down the line. It looks like Karol respond=
ed
> > already so I assume the patch is in the pipeline now, but let me know i=
f
> > there's anything else you need.
> >=20
>=20
> uhm, I didn't push anything, but I can push it through drm-misct asap,
> just wanted to ask if somebody wants to pick a quicker route. But I
> guess not?

Ah whoops, I misunderstood! Yeah I would say we should just go ahead and pu=
sh
it since I don't see any indication here that anyone else has.

>=20
> > >=20
> > >=20
> > >=20
> > > >=20
> > >=20
> > > > I think it's all entirely harmless from a code generation standpoin=
t,
> > > > because the 15-byte field will be padded out to 16 bytes in the
> > > > structure that contains it, but it's most definitely buggy.
> > >=20
> > > Right; between this, that GCC 13 wasn't released yet, and I had no fe=
edback from NV folks, I didn't chase down landing that fix.
> > >=20
> > > >=20
> > > > So that warning does find real cases of wrong code. But when those
> > > > real cases are hidden by hundreds of lines of unfixable false
> > > > positives, we don't have much choice.
> > >=20
> > > Yup, totally agreed. The false positives I've looked at all seem to b=
e similar to the outstanding jump threading bug, so I'm hoping once that ge=
ts fixed we'll finally have a good signal with that warning enabled. :)
> > >=20
> > > -Kees
> > >=20
> > >=20
> >=20
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

