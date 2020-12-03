Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B216C433FE
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Dec 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14583206F0
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Dec 2020 17:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgLCRnh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLCRng (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Dec 2020 12:43:36 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E3C061A4F
        for <linux-hardening@vger.kernel.org>; Thu,  3 Dec 2020 09:42:56 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so1558845plo.0
        for <linux-hardening@vger.kernel.org>; Thu, 03 Dec 2020 09:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ewjsiW9xOOWwJ7Vn/ikJbHYwHfnQIPjHGmHGP7oi6BE=;
        b=O5IvV2/Vubx9BfUcRWT56D/4/JIWhi2M8/1ywP+fGkSzRHslO0wfwe5e4AJ20Fh8o2
         ZA2L7P1NHqA9iifsGKNv9sCbPp1F8AstH9lDyxvpAR1A5yyA8wnjVphnmkjfrkCLGoss
         gaU7CyuMjRpNB6n727nzPwwvdMJ/8ysb9w4X2H7kY+mjl4D3NcDTQ1FgQY2xRKkTYUle
         KIHSm8/RIpmAJTPsNZE2wXzuzgpkgowncocmXUFidgDul2mI5+Mj9Z2g1fXa2FjAGyPH
         kSfsJh5orSF+cvzkyIuSWOLcYWAkPpUEdJCWwP6mAqgeTwXUzrjumKm0iCHDkePCxP/U
         AtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ewjsiW9xOOWwJ7Vn/ikJbHYwHfnQIPjHGmHGP7oi6BE=;
        b=gohuiNHiXABC0dqbjN/YL4J5LVvWsW3rg/SsWQ2tDcbqSp/SiIf/NQYOfbwTLMJu6j
         ShtBMgHb4r9692jK4i9Sykd/ZXZF+kAmOG4pMiICOfExE/G7oKt0CiRPRCCQH+qIFWeS
         32plzTcevqfENjjSjGPCOwALT0U1Vy7zAlKifXL0wcN6C9FV662pl9ynkSQ3krNSvdee
         puJteshMM+TdVaX/BeVFnIV/yAus0UV4teQNZdTK4isVHNNglO+XjCwRo3LFUOuviCW4
         fxMMkRFpqzt5YzVAbtdK17a1xl8x8mvHElDloVIMUGHbQ6ng4BLwOSXuytrqMtUTSMbP
         ylZA==
X-Gm-Message-State: AOAM530Z+GF7m7F/b6uwochQOCcWApxXF3DlStt6GPy6LqPGagoKt6wc
        vi3pefaNLpNnRII+3WvBd6ecdQ==
X-Google-Smtp-Source: ABdhPJzTpCbbRfGOWHG7m+mZZhYM+XYEslxM55n+IwQtflCINDXZDUjStV6j4JnVJwJcZsivKclnxQ==
X-Received: by 2002:a17:90b:50e:: with SMTP id r14mr237250pjz.90.1607017376213;
        Thu, 03 Dec 2020 09:42:56 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:8949:f4fe:cc16:86da? ([2601:646:c200:1ef2:8949:f4fe:cc16:86da])
        by smtp.gmail.com with ESMTPSA id j11sm1655038pgp.82.2020.12.03.09.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:42:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso and stack
Date:   Thu, 3 Dec 2020 09:42:54 -0800
Message-Id: <1CB9B4D1-1E32-42DC-A4E9-6E53C85365BF@amacapital.net>
References: <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


> On Dec 3, 2020, at 9:29 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> =EF=BB=BF* Andy Lutomirski:
>=20
>> If you want a 4GB allocation to succeed, you can only divide the
>> address space into 32k fragments.  Or, a little more precisely, if you
>> want a randomly selected 4GB region to be empty, any other allocation
>> has a 1/32k chance of being in the way.  (Rough numbers =E2=80=94 I=E2=80=
=99m ignoring
>> effects of the beginning and end of the address space, and I=E2=80=99m
>> ignoring the size of a potential conflicting allocation.).
>=20
> I think the probability distribution is way more advantageous than that
> because it is unlikely that 32K allocations are all exactly spaced 4 GB
> apart.  (And with 32K allocations, you are close to the VMA limit anyway.)=


I=E2=80=99m assuming the naive algorithm of choosing an address and trying i=
t.  Actually looking for a big enough gap would be more reliable.

I suspect that something much more clever could be done in which the heap is=
 divided up into a few independently randomized sections and heap pages are r=
andomized within the sections might do much better. There should certainly b=
e a lot of room for something between what we have now and a fully randomize=
d scheme.

It might also be worth looking at what other OSes do.=
