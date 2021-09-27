Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5444AC4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC6960D42
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 16:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhI0QNm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhI0QNk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 27 Sep 2021 12:13:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4FC06176A
        for <linux-hardening@vger.kernel.org>; Mon, 27 Sep 2021 09:12:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so12117930pls.6
        for <linux-hardening@vger.kernel.org>; Mon, 27 Sep 2021 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dZUVcCIZqqH9I7LRk/phYbjjlmA2djPKMbDuIROT9R8=;
        b=oaxIsAK9zOzpKUSiVKESJOth0/QdV90wRE6gTXGA3rPbp6z5INoY2uz+yMrxz0jhaM
         bUleZ9IaoxK9UYV5upCU/tB+vLpULQl+tBhSCiUkPe/LGz71GrANQ4VZ0uf0hvPXiX7u
         t5ZFiGFywxoqVtKNXE5WcGRbwnhEy7PT53wy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dZUVcCIZqqH9I7LRk/phYbjjlmA2djPKMbDuIROT9R8=;
        b=VeL2zIxoBd65uVG4Q512l7tnUzz51ZOd5t9jQ3p6yYEcxdcUT0fL4fRxOYKJlbnX6H
         whovTrjVd1EEX1Vb6MtbDPQFQ5406y/NP4+4l8MqjZbgVYhaYGYQhnbEJOtBHlNmurV8
         ghPTSFrKm+xbvo9e6pJnRgQqZ+PHC+OY7LKeu5V4DEeGwa2CM0OJhl8gpuUccpiE4wxp
         +mLWAQysuV3FzmI1mRA5QKULpsf7ymgFj7DfsvUnrupQfHzurQurox+jA/Y1S4sf5WAP
         gl47/4KRZbw13gyJmN6PtsBX7KO0i541bcbu8x3mNQgZb4oyh/+31ku8qVv34a6tjbaw
         7rfA==
X-Gm-Message-State: AOAM530+nXP556fUK5/LNKqObD7q03RYrkwHCjVaSX4ibKhdWGLQZwqw
        4+cqKoqoC1cR6flZBrBnf6hDwQ==
X-Google-Smtp-Source: ABdhPJzHlTmz6F7QdsYomw9TE0osPYMgdtahGOyd9mAkkn/z5g9TRPwyxe71/E6M10ORmBKKqM2/WQ==
X-Received: by 2002:a17:902:ac96:b0:13d:f848:cbbe with SMTP id h22-20020a170902ac9600b0013df848cbbemr658962plr.9.1632759121721;
        Mon, 27 Sep 2021 09:12:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r29sm17786735pfq.74.2021.09.27.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:12:01 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:12:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ross Burton <Ross.Burton@arm.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
Message-ID: <202109270911.482CF085@keescook>
References: <20210923152811.406516-1-ross.burton@arm.com>
 <163243252379.3933826.2645114887075876479.b4-ty@chromium.org>
 <d2b6c3d1-45a6-5820-cedf-28390ffcc8cd@gmail.com>
 <DB9PR08MB6460E4643AB5AE8932C1AF94E8A79@DB9PR08MB6460.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB9PR08MB6460E4643AB5AE8932C1AF94E8A79@DB9PR08MB6460.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 27, 2021 at 03:25:19PM +0000, Ross Burton wrote:
> Hm, yes, I think I managed to misunderstand something and fixed one build=
 whilst breaking another.
>=20
> Kees, can you drop this?  I=E2=80=99ll come back with a v2.

Sure! Dropped from -next.

-Kees

>=20
> Ross
>=20
> From: Dmitry Osipenko <digetx@gmail.com>
> Date: Monday, 27 September 2021 at 16:10
> To: Kees Cook <keescook@chromium.org>, Ross Burton <Ross.Burton@arm.com>,=
 linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, linux-hardeni=
ng@vger.kernel.org <linux-hardening@vger.kernel.org>
> Subject: Re: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
> 24.09.2021 00:28, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, 23 Sep 2021 16:28:11 +0100, Ross Burton wrote:
> >> The GCC plugins are built using HOSTCC, but the path to the GCC plugins
> >> headers is obtained using CC.  This can lead to interesting failures if
> >> the host compiler and cross compiler are different versions, and the
> >> host compiler uses the cross headers.
> >
> > (I changed this from HOSTCC to HOSTCXX to match the other invocations.)
> >
> > Applied to for-next/gcc-plugins, thanks!
> >
> > [1/1] scripts/gcc-plugins: consistently use HOSTCC
> >       https://git.kernel.org/kees/c/ef5ecb129791
> >
>=20
> I'm getting these errors when compiling ARM32 kernel using today's -next:
>=20
> cc1: error: incompatible gcc/plugin versions
> cc1: error: failed to initialize plugin ./scripts/gcc-plugins/arm_ssp_per=
_task_plugin.so
>=20
> Both host and cross compiler are the same version:
>=20
> # gcc-config -l
>  [1] armv7a-hardfloat-linux-gnueabi-9.3.0
>  [2] armv7a-hardfloat-linux-gnueabi-10.3.0
>  [3] armv7a-hardfloat-linux-gnueabi-11.1.0 *
>=20
>  [4] x86_64-pc-linux-gnu-11.1.0 *
>=20
> # gcc -v
> =D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D1=8E=D1=82=D1=81=D1=8F =
=D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=BD=D0=BD=D0=B8=D0=B5 =D1=81=D0=BF=
=D0=B5=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=B8.
> COLLECT_GCC=3Dgcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-pc-linux-gnu/11.1.0/lto-wra=
pper
> =D0=A6=D0=B5=D0=BB=D0=B5=D0=B2=D0=B0=D1=8F =D0=B0=D1=80=D1=85=D0=B8=D1=82=
=D0=B5=D0=BA=D1=82=D1=83=D1=80=D0=B0: x86_64-pc-linux-gnu
> =D0=9F=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D1=8B =D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8: /var/tmp/portage/sy=
s-devel/gcc-11.1.0-r2/work/gcc-11.1.0/configure --host=3Dx86_64-pc-linux-gn=
u --build=3Dx86_64-pc-linux-gnu --prefix=3D/usr --bindir=3D/usr/x86_64-pc-l=
inux-gnu/gcc-bin/11.1.0 --includedir=3D/usr/lib/gcc/x86_64-pc-linux-gnu/11.=
1.0/include --datadir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/11.1.0 --ma=
ndir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/11.1.0/man --infodir=3D/usr/=
share/gcc-data/x86_64-pc-linux-gnu/11.1.0/info --with-gxx-include-dir=3D/us=
r/lib/gcc/x86_64-pc-linux-gnu/11.1.0/include/g++-v11 --with-python-dir=3D/s=
hare/gcc-data/x86_64-pc-linux-gnu/11.1.0/python --enable-languages=3Dc,c++,=
fortran --enable-obsolete --enable-secureplt --disable-werror --with-system=
-zlib --enable-nls --without-included-gettext --disable-libunwind-exception=
s --enable-checking=3Drelease --with-bugurl=3Dhttps://bugs.gentoo.org/ --wi=
th-pkgversion=3D'Gentoo 11.1.0-r2 p3' --disable-esp --enable-libstdcxx-time=
 --enable-shared --enable-threads=3Dposix --enable-__cxa_atexit --enable-cl=
ocale=3Dgnu --enable-multilib --with-multilib-list=3Dm32,m64 --disable-fixe=
d-point --enable-targets=3Dall --enable-libgomp --disable-libssp --disable-=
libada --disable-systemtap --disable-valgrind-annotations --disable-vtable-=
verify --disable-libvtv --without-zstd --enable-lto --with-isl --disable-is=
l-version-check --enable-default-pie --enable-default-ssp
> =D0=9C=D0=BE=D0=B4=D0=B5=D0=BB=D1=8C =D0=BC=D0=BD=D0=BE=D0=B3=D0=BE=D0=BF=
=D0=BE=D1=82=D0=BE=D1=87=D0=BD=D0=BE=D1=81=D1=82=D0=B8: posix
> Supported LTO compression algorithms: zlib
> gcc =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F 11.1.0 (Gentoo 11.1.0-r2 p3)
>=20
> # armv7a-hardfloat-linux-gnueabi-gcc -v
> =D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D1=8E=D1=82=D1=81=D1=8F =
=D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=BD=D0=BD=D0=B8=D0=B5 =D1=81=D0=BF=
=D0=B5=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=B8.
> COLLECT_GCC=3Darmv7a-hardfloat-linux-gnueabi-gcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/armv7a-hardfloat-linux-gnueabi/11.=
1.0/lto-wrapper
> =D0=A6=D0=B5=D0=BB=D0=B5=D0=B2=D0=B0=D1=8F =D0=B0=D1=80=D1=85=D0=B8=D1=82=
=D0=B5=D0=BA=D1=82=D1=83=D1=80=D0=B0: armv7a-hardfloat-linux-gnueabi
> =D0=9F=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D1=8B =D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8: /var/tmp/portage/cr=
oss-armv7a-hardfloat-linux-gnueabi/gcc-11.1.0-r2/work/gcc-11.1.0/configure =
--host=3Dx86_64-pc-linux-gnu --target=3Darmv7a-hardfloat-linux-gnueabi --bu=
ild=3Dx86_64-pc-linux-gnu --prefix=3D/usr --bindir=3D/usr/x86_64-pc-linux-g=
nu/armv7a-hardfloat-linux-gnueabi/gcc-bin/11.1.0 --includedir=3D/usr/lib/gc=
c/armv7a-hardfloat-linux-gnueabi/11.1.0/include --datadir=3D/usr/share/gcc-=
data/armv7a-hardfloat-linux-gnueabi/11.1.0 --mandir=3D/usr/share/gcc-data/a=
rmv7a-hardfloat-linux-gnueabi/11.1.0/man --infodir=3D/usr/share/gcc-data/ar=
mv7a-hardfloat-linux-gnueabi/11.1.0/info --with-gxx-include-dir=3D/usr/lib/=
gcc/armv7a-hardfloat-linux-gnueabi/11.1.0/include/g++-v11 --with-python-dir=
=3D/share/gcc-data/armv7a-hardfloat-linux-gnueabi/11.1.0/python --enable-la=
nguages=3Dc,c++ --enable-obsolete --enable-secureplt --disable-werror --wit=
h-system-zlib --enable-nls --without-included-gettext --disable-libunwind-e=
xceptions --enable-checking=3Drelease --with-bugurl=3Dhttps://bugs.gentoo.o=
rg/ --with-pkgversion=3D'Gentoo 11.1.0-r2 p3' --disable-esp --enable-libstd=
cxx-time --enable-poison-system-directories --with-sysroot=3D/usr/armv7a-ha=
rdfloat-linux-gnueabi --disable-bootstrap --enable-__cxa_atexit --enable-cl=
ocale=3Dgnu --disable-multilib --disable-fixed-point --with-float=3Dhard --=
with-arch=3Darmv7-a --with-float=3Dhard --with-fpu=3Dvfpv3-d16 --enable-lib=
gomp --disable-libssp --disable-libada --disable-systemtap --disable-valgri=
nd-annotations --disable-vtable-verify --disable-libvtv --without-zstd --en=
able-lto --with-isl --disable-isl-version-check --enable-default-pie --enab=
le-default-ssp
> =D0=9C=D0=BE=D0=B4=D0=B5=D0=BB=D1=8C =D0=BC=D0=BD=D0=BE=D0=B3=D0=BE=D0=BF=
=D0=BE=D1=82=D0=BE=D1=87=D0=BD=D0=BE=D1=81=D1=82=D0=B8: posix
> Supported LTO compression algorithms: zlib
> gcc =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F 11.1.0 (Gentoo 11.1.0-r2 p3)
>=20
>=20
> Please fix, thanks in advance.
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

--=20
Kees Cook
