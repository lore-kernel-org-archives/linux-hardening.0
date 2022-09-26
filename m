Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF918C07E9D
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 21:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiIZVL7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiIZVL6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 17:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB27CAA3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664226715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MESd3DxBrbMRDlzl5/5GQloLMmgAa02gA+ZLdmVzf4k=;
        b=BEcqpVN1femYcrZ7Q3K+JaDnoWMvm19QQRybnsR/0lS+jKip3g7SolXVeaOT/y9/jECGda
        Q+EmMTa/M3tevrkXrW0GPstG7VTGipLmaND4rgW6vyecCvEDB4c57eWVXIycq9piV6zntI
        FSWCt8t4jQ5kbb8tRlEZV75sp4w2Zu8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-mZwCOO_6OamSaFKIIjmK5w-1; Mon, 26 Sep 2022 17:11:54 -0400
X-MC-Unique: mZwCOO_6OamSaFKIIjmK5w-1
Received: by mail-qt1-f198.google.com with SMTP id u9-20020a05622a14c900b0035cc7e8cbaeso5558212qtx.19
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 14:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=MESd3DxBrbMRDlzl5/5GQloLMmgAa02gA+ZLdmVzf4k=;
        b=koJ+GeIQMNb8QkR4a6pL9H3lAYwwOD80ENtbyuWhnqCzgi4T+B8uNH4+GNYorbhUFA
         VnUaKaMiI/9N0fEj0RjS3vvq4JVuq2q9uWGQSPm59j9c3hRmKOfs2ZSLoDYe8zH8aUI1
         aKWVv5q8pHTt1/SIqdTWTa67lwbZvbJTAdjKaf2GEEGbOIIA84xHNxn4vLccBOaw1AEw
         fIa1xWei6oEIxEhjh+ezTXHIVHxN+fa2+H0QOb45jdDMtQ4B+IfbfEWpEnpbJrqSLK0Y
         JkLAdVsTq39HXAa/zgO7FcEI/0KPrkatO+bG+bCB+TL9ABTBSQOR6ONvAKSmeAclW2se
         1VVA==
X-Gm-Message-State: ACrzQf0Vl1+MQGGPPyScnjq7Zr/jv2HQfuNKEw0bgdJTMDcZYo2J3yrd
        ZqKLe3pWBzcyAxNmcfQUQwkeSV1Y1C1EkWDzaatQvOPynHhCw63stVtz/k91O/Y9VWAdAt4VfAa
        zYlm/HrsmIWHu7dWxRSUxnXIYYHOW
X-Received: by 2002:a05:6214:ca5:b0:4ac:b6b2:aab0 with SMTP id s5-20020a0562140ca500b004acb6b2aab0mr18921227qvs.31.1664226714004;
        Mon, 26 Sep 2022 14:11:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4CStSzbpkJefWa/PBu8ljHyxYnAAX05+S/KOdwCCi4VorTd3qp/vdqABAJ5qNZPW6+GgI9rg==
X-Received: by 2002:a05:6214:ca5:b0:4ac:b6b2:aab0 with SMTP id s5-20020a0562140ca500b004acb6b2aab0mr18921214qvs.31.1664226713778;
        Mon, 26 Sep 2022 14:11:53 -0700 (PDT)
Received: from t14s.localdomain (c-73-69-212-193.hsd1.nh.comcast.net. [73.69.212.193])
        by smtp.gmail.com with ESMTPSA id o29-20020a05620a0d5d00b006b60d5a7205sm11359231qkl.51.2022.09.26.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:11:52 -0700 (PDT)
Message-ID: <5d8934b017e102cf9d00c9e101bf54e4e9d93191.camel@redhat.com>
Subject: Re: -fanalyzer thoughts
From:   David Malcolm <dmalcolm@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, j.koschel@vu.nl
Date:   Mon, 26 Sep 2022 17:11:51 -0400
In-Reply-To: <202209140501.412181C969@keescook>
References: <202209140501.412181C969@keescook>
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 2022-09-14 at 05:43 -0700, Kees Cook wrote:
> Hi!
>=20
> Thanks for the talk today! I sent a patch for the aic79xx_osm.c issue
> you mentioned:
> https://lore.kernel.org/linux-hardening/20220914115953.3854029-1-keescook=
@chromium.org/

Thanks!

>=20
> I didn't have a chance to add some more comments and ask a question
> before the session ended, so here I am in email, CCing the kernel
> hardening list in case other folks want to chime in. :)

Sorry for the belated response (back-to-back conferences and travel).

>=20
> You asked, "Should I try to have GCC type-check __user vs __kernel,
> or leave it to sparse?" I would *love* to get this in the compiler
> proper. Not nearly enough people are running sparse, so its output
> has
> become quite noisy, which means more and more regressions are
> slipping
> into the kernel. I was surprised a while back to discover that
> kernel's
> use of the address_space and noderef attributes weren't supported by
> GCC. It does seems like it'd make a good attribute (for which there
> is existing precedent), rather than polluting the global namespace,
> as AVR does:
> https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html
>=20
> Clang seems to support the address_space and noderef attributes:
> https://clang.llvm.org/docs/LanguageExtensions.html#memory-references-to-=
specified-segments
> https://clang.llvm.org/docs/AttributeReference.html#noderef
> But when I tried a while back to make it work, it fell over:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=
=3Dclang/address_space&id=3Dbeff911c13390a71b3f7921fd82ec6a71ca75c02
> If these get implemented in GCC, it'd be good to coordinate with
> Clang
> too, to make sure it works sanely in the kernel.

I've been experimenting with implementing this in GCC.

It turned out that GCC's bugzilla had a bunch of existing RFE bugs for
sparse support filed back in 2014, so I've created a tracker bug to
make it easier to find them; see:
  https://gcc.gnu.org/bugzilla/showdependencytree.cgi?id=3Dsparse
and I'm hoping to get at least some of this done for GCC 13 (though
feature freeze is about 5 weeks away...)

>=20
>=20
> The question I had was if you had seen this LPC presentation:
> https://lpc.events/event/16/contributions/1211/
> "How I started chasing speculative type confusion bugs in the kernel
> and
> ended up with 'real' ones"
>=20
> The authors used Clang's "Data Flow Sanitizer" and built a working
> taint/sink system that seems like it could be used for MUCH more
> analysis
> than just what they were looking it (as they hint at too).
> https://clang.llvm.org/docs/DataFlowSanitizer.html
> https://github.com/vusec/kdfsan-linux/commit/45614ee1a3a0d7b98c5cecb1b747=
184279bc615c
>=20
> I wonder if DFSan could be ported to GCC? It seems to overlap
> logically
> with some of the -fanalyzer work, but I don't know the internals for
> either, so I likely have no idea what I'm talking about. ;)

Thanks for the links, both Kasper and DFSan look really interesting.

If I'm reading things right DFSan seems to be a run-time thing,
modifying the generated code to sanitize it, whereas GCC's -fanalyzer
is a compile-time thing, so I don't think it's directly compatible.

>=20
>=20
> Related, I wonder if LTO builds would help with -fanalyzer's control
> flow analysis? (DFSan requires LTO.)


>  Getting the kernel built with LTO
> under GCC seems to be an on-going project, but no pull requests have
> been sent lately:
> https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/log/?=
h=3Dlto
> Maybe poking them from your side might help that get landed? I think
> people are interested in having LTO for the kernel for the
> performance
> gains it can provide.

Unfortunately, building with LTO tends to break -fanalyzer by exploding
the complexity of the analysis: I have an implementation of call
summarization to try to tame this, but it's buggy.  So a fair amount of
work would need to happen at the -fanalyzer side in addition to getting
the kernel to just build with LTO, so it's not been a priority for me.

>=20
> The second-to-last slide in my presentation (in the "bonus slides"
> section) has slightly more context about LTO and the kernel:
> https://lpc.events/event/16/contributions/1173/
> https://outflux.net/slides/2022/lpc/features.pdf
>=20

Thanks; this is all very helpful
Dave

